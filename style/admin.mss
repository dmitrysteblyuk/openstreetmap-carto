@admin-boundaries: #8d618b; // Lch(47,30,327)
@admin-boundaries-narrow: #845283; // Lch(42,35,327)
@admin-boundaries-wide: #a37da1; // Lch(57,25,327)

/* For performance reasons, the admin border layers are split into three groups
for low, middle and high zoom levels.
Three attachments are used, with minor borders before major ones, and the thin centerline last, to handle
overlapping borders correctly and allow each type to have a different level of opacity.
Overlapping borders are hidden by a white background line, rendered before each line.
Then all three layers are added to the rendering with comp-op: darken, so that the white lines will not show
*/

#admin-low-zoom[zoom < 8],
#admin-mid-zoom[zoom >= 8][zoom < 13],
#admin-high-zoom[zoom >= 13] {
}

#admin-text[zoom >= 11][way_pixels >= 196000] {
  [admin_level = '1'][way_pixels >= 360000],
  [admin_level = '2'][way_pixels >= 360000],
  [zoom >= 11][admin_level = '3'],
  [zoom >= 11][admin_level = '4'],
  [zoom >= 11][admin_level = '5'],
  [zoom >= 12][admin_level = '6'],
  [zoom >= 13][admin_level = '7'],
  [zoom >= 14][admin_level = '8'],
  [zoom >= 15][admin_level = '9'],
  [zoom >= 16] {
    text-name: "[name]";
    text-face-name: @book-fonts;
    text-fill: @state-labels;
    [admin_level = '6'] { text-fill: @county-labels; }
    text-halo-radius: @standard-halo-radius;
    text-halo-fill: @standard-halo-fill;
    text-largest-bbox-only: false;
    text-placement: line;
    text-spacing: 750;
    text-repeat-distance: 250;
    text-margin: 10;
    text-clip: true;
    text-vertical-alignment: middle;
    text-dy: -10;
  }
}

#protected-areas-text[zoom >= 13][way_pixels > 192000] {
  text-name: "[name]";
  text-face-name: @book-fonts;
  text-fill: @protected-area;
  [boundary='aboriginal_lands'] {
    text-fill: @aboriginal;
  }
  text-halo-radius: @standard-halo-radius;
  text-halo-fill: @standard-halo-fill;
  text-largest-bbox-only: false;
  text-placement: line;
  text-spacing: 750;
  text-repeat-distance: 250;
  text-margin: 10;
  text-clip: true;
  text-vertical-alignment: middle;
  text-dy: -10;
}

#protected-areas {
  [way_pixels > 750] {
    [zoom >= 8][zoom < 10] {
      opacity: 0.25;
      line-width: 1.2;
      line-color: @protected-area;
      [boundary = 'aboriginal_lands'] {
        line-color: @aboriginal;
      }
      [zoom >= 9] {
        line-width: 1.5;
      }
    }
    [zoom >= 10] {
      // inner line
      ::wideline {
        opacity: 0.15;
        line-width: 3.6;
        // Unlike planet_osm_line, planet_osm_polygon does not preserves the
        // original direction of the OSM way: Following OGS at
        // https://www.opengeospatial.org/standards/sfa always at the left
        // is the interior and at the right the exterior of the polygon.(This
        // also applies to inner rings of multipolygons.) So a negative
        // line-offset is always an offset to the inner side of the polygon.
        line-offset: -0.9;
        line-color: @protected-area;
        [boundary = 'aboriginal_lands'] {
          line-color: @aboriginal;
        }
        line-join: round;
        line-cap: round;
        [zoom >= 12] {
          line-width: 4;
          line-offset: -1;
        }
        [zoom >= 14] {
          line-width: 6;
          line-offset: -2;
        }
      }
      // outer line
      ::narrowline {
        opacity: 0.15;
        line-width: 1.8;
        line-color: @protected-area;
        [boundary = 'aboriginal_lands'] {
          line-color: @aboriginal;
        }
        line-join: round;
        line-cap: round;
        [zoom >= 12] {
            line-width: 2;
        }
      }
    }
  }
}
