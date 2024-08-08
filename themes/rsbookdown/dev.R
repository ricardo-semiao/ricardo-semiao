library(devtools)

#create("themes/rsbookdown")

load_all("themes/rsbookdown")
document("themes/rsbookdown")
check("themes/rsbookdown")
install("themes/rsbookdown", upgrade = FALSE)
