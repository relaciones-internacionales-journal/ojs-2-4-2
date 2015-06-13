# ojs-2-4-2
This is our current published Open Journal System installation. It's a fully modified OJS. 

<b>Features:</b><br>
- OJS 2.4.2 modifications (OJS GitHub https://github.com/pkp/ojs):
  - Custom front-end and back-end templates.
  - Custom icons & images.
  - Custom CSS, added some CSS3.
  - Responsive theme.
  - Apple touch icons & Windows Phone Tile.
  - Google structured data markups added.
  - Lot's of weird .htaccess rules due to our hosting configuration, outside our control. But they do work.

- Third-party code/libraries/framework added:
  - Jasny extension of Bootstrap 2.3.1. Source: https://github.com/jasny/bootstrap
  - PHP & JS Style switcher.  Source: http://code.tutsplus.com/tutorials/jquery-style-switcher--net-532
  - Google Fonts: 
    - Roboto: Source:  http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700,300
    - Open Sans. Source: http://fonts.googleapis.com/css?family=Open+Sans:300,600,700
  - JS Circular Content Carousel. Source: http://tympanus.net/codrops/2011/08/16/circular-content-carousel/
  - Minified CSS & JS via PHP. Source: https://github.com/mrclay/minify

# Notes & Recommendations
- OJS folders /cache/ /public/ and /files/ not provided. Neither config.inc.php for security reasons. So most images will not be available.
- This OJS is installed in a subfolder.
- Modified OJS files are marked with {* MODIFICADO OJS V.2.X.X / MM-YYYY*} 206 changed, aprox.
- No plugins created. 
- Our hosting configuration forced us to hard code most OJS internal links and create lot's of weird .htaccess rules. USUALLY YOU WILL NOT HAVE TO CHANGE OR ADD THIS.
