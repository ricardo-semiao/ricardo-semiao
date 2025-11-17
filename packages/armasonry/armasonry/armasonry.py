# Setup ------------------------------------------------------------------------

# Numpy:
import numpy as np
import numpy.random as rd
from numpy.lib.stride_tricks import sliding_window_view
from numpy.typing import NDArray

# Preference operations:
from operator import eq, lt, gt, ne
def true(*args) -> NDArray:
    return np.full(args[0].shape, True, dtype = bool)
pref_ops_h = {"true": true, "eq": eq, "lt": lt, "gt": gt, "ne": ne}



# Packing Optimization ---------------------------------------------------------

def pack_discrete_ncols(
    rectangles: NDArray, ncols: int,
    pref_h: list[str] = ["true"], pref_w: list[int] = []
) -> dict[str, NDArray]:
    # Setup:
    rects = rectangles.copy()
    nrects = rects.shape[0]
    rects = np.hstack((rects, np.arange(1, nrects + 1).reshape(-1, 1))) # Add index column
    used_flag = np.iinfo(np.int8).max # Flag to mark rectangle as used

    ops_h = [pref_ops_h[p] for p in pref_h]
    excess_w = np.array([i for i in range(ncols) if i not in pref_w])

    # Initialize loop:
    grid = np.zeros((np.sum(rects[:, 1]), ncols), dtype = np.int8)
    rects_order = np.zeros(nrects, dtype = np.int8)
    i = 1

    # Main loop:
    while i <= nrects:
        # Find current location and available space:
        avail_grid = grid == 0
        cur_h = np.argmax(np.any(avail_grid, axis = 1))
        cur_w = np.argmax(avail_grid[cur_h, :])
        avail_w = np.sum(avail_grid[cur_h, :])
        avail_h = np.sum(np.sum(avail_grid[cur_h:, :], axis = 1) == avail_w)
        
        chosen_rect = -1
        for excess in excess_w:
            fits_w = avail_w - rects[:, 1] == excess
            if np.any(fits_w):
                avail_rects = rects[fits_w, :]
                for op in ops_h:
                    fits_h = op(avail_rects[:, 0], avail_h)
                    if np.any(fits_h): # Given h, choose randomly across w
                        chosen_rect = rd.choice(avail_rects[fits_h, 2])
            if chosen_rect != -1:
                break

        # Mark space as 'hole' (-i) or update the grid:
        if chosen_rect == -1:
            grid[cur_h:(cur_h + avail_h), cur_w:(cur_w + avail_w)] = -rects_order[i - 2]
        else:
            rects_order[i - 1] = chosen_rect
            chosen_h, chosen_w, _ = rects[chosen_rect - 1, :]
            grid[cur_h:(cur_h + chosen_h), cur_w:(cur_w + chosen_w)] = chosen_rect

            rects[chosen_rect - 1, 1] = used_flag # Mark as used
            i += 1

    # Mark extra space in last lines as holes:
    last_line = np.where(grid > 0)[0][-1]
    grid[:(last_line + 1), :][grid[:(last_line + 1), :] == 0] = np.iinfo(np.int8).min

    return {"order": rects_order, "grid": grid}


def get_shared_divides(grids: NDArray, axis: int) -> NDArray:
    # axis = 2 for horizontal divides, 1 for vertical divides
    axis_inv = 1 if axis == 2 else 2

    divides = np.diff(grids, axis = axis) != 0
    divides_consecutive = np.all(sliding_window_view(divides, 2, axis = axis_inv), axis = 3)

    different_rects = np.diff(grids, axis = axis_inv) != 0
    different_rects = different_rects[:, :, :-1] if axis == 2 else different_rects[:, :-1, :]

    return np.sum(divides_consecutive & different_rects, axis = (1, 2))


# Debug: `rectangles, ncols, ndraws, verbose = rects, args["ncols"], args.get("ndraws", 100), 1`
def best_pack_draw(
    rectangles: NDArray,
    ncols: int, ndraws: int,
    pref_h: list[str] = ["true"], pref_w: list[int] = [],
    verbose: int = 1
) -> dict[str, NDArray]:
    nrects = rectangles.shape[0]

    if verbose >= 1:
        print((
            f"  - Packing {nrects} rectangles into "
            f"{ncols} columns over {ndraws} draws ..."
        ))

    ords = np.zeros((nrects, ndraws), dtype = np.int8)
    grids = np.zeros((ndraws, np.sum(rectangles[:, 1]), ncols), dtype = np.int8)
    obj = np.zeros(ndraws, dtype = np.int8)

    for draw in range(ndraws):
        if verbose == 2 and (draw + 1) % 10 == 0:
            print(f"- Completed {draw + 1}/{ndraws}")
        res = pack_discrete_ncols(rectangles, ncols, pref_h, pref_w)
        ords[:, draw] = res["order"]
        grids[draw, :, :] = res["grid"]
        obj[draw] = np.sum(res["grid"] < 0)

    # Selecting only unique orders:
    ords_unique, idx_unique = np.unique(ords, return_index = True, axis = 1, sorted = False)
    obj_unique, grids_unique = obj[idx_unique], grids[idx_unique, :, :]

    # Selecting grids with less holes:
    nholes = np.min(obj_unique)
    contenders = obj_unique == nholes

    # Select grids with less shared divides:
    grids_contender = grids_unique[contenders, :, :]
    divides_shared = get_shared_divides(grids_contender, 1) + get_shared_divides(grids_contender, 2)
    contenders2 = divides_shared == np.min(divides_shared)
    
    # Selecting grids with biggest height diversity:
    ords_contenders2 = ords_unique[:, np.where(contenders)[0][contenders2]]
    width_diversity = np.sum(abs(np.diff(rectangles[ords_contenders2 - 1, 0], axis = 0)), axis = 0)
    bests = width_diversity == np.max(width_diversity)

    # Update extra space (0) to hole (-i) if line was 'started'
    # TODO: Not working properly yet. Last line can have multiple holes, maybe
    # 'adding an impossible rect' approach is better
    # last_line = np.where(grids_unique != 0)[0][-1]
    # hole_flag = -np.max(grids_unique[last_line, :])
    # grids_unique[last_line, grids_unique[last_line, :] == 0] = hole_flag

    # Save results:
    idx = np.where(contenders)[0][np.where(contenders2)[0]][bests]
    out = {
        "nholes": nholes,
        "orders": ords_unique[:, idx],
        "grids": grids_unique[idx, :, :]
    }
    return out
