var extractor = require('css-color-extractor');

var options = {
  withoutGrey: false, // set to true to remove rules that only have grey colors
  withoutMonochrome: false, // set to true to remove rules that only have grey, black, or white colors
  colorFormat: 'rgbString', // transform colors to one of the following formats: hexString, hexaString, rgbString, percentString, hslString, hwbString, or keyword
  allColors: false, // set to true to get all colors instead of unique colors
  sort: null, // set to "hue" to sort colors in order of hue, or to "frequency" to sort colors by how many times they appear in the css
};

// extract from a full stylesheet
extractor.fromCss('palette/palette.css', options);


--gray: hsl(0, 0%, 95%);
--darkgray: hsl(0, 0%, 80%);
--lightgray: hsl(0, 0%, 97.5%);
--aquagray: hsl(0, 0%, 98.5%);
--blackgray: hsl(0, 0%, 40%);
--fontblack: hsl(210, 11%, 15%);
--red: hsl(350, 100%, 40%);
--darkred: hsl(350, 100%, 30%);
--lightred: hsl(350, 70%, 60%);
--aquared: hsl(350, 75%, 85%);
--orange: hsl(25, 100%, 40%);
--darkorange: hsl(25, 100%, 25%);
--lightorange: hsl(25, 70%, 60%);
--aquaorange: hsl(25, 80%, 85%);
--yellow: hsl(47, 100%, 45%);
--darkyellow: hsl(47, 100%, 30%);
--lightyellow: hsl(47, 90%, 70%);
--aquayellow: hsl(47, 85%, 85%);
--green: hsl(163, 100%, 25%);
--darkgreen: hsl(163, 100%, 15%);
--lightgreen: hsl(163, 70%, 45%);
--aquagreen:    hsl(163, 75%, 80%);
--blue:         hsl(185, 100%, 30%);
--darkblue:     hsl(185, 100%, 15%);
--lightblue:    hsl(185, 60%, 50%);
--aquablue:     hsl(185, 75%, 80%);