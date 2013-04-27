ActiveAdmin::Editor.configure do |config|
  # config.s3_bucket = ''
  # config.aws_access_key_id = ''
  # config.aws_access_secret = ''
  # config.storage_dir = 'uploads'

  # Tag list
  #
  # The following options are available:
  #
  #    - add_class:        converts and deletes the given HTML4 attribute (align, clear, ...) via the given method to a css class
  #                        The following methods are implemented in wysihtml5.dom.parse:
  #                          - align_text:  converts align attribute values (right/left/center/justify) to their corresponding css class "wysiwyg-text-align-*")
  #                            <p align="center">foo</p> ... becomes ... <p> class="wysiwyg-text-align-center">foo</p>
  #                          - clear_br:    converts clear attribute values left/right/all/both to their corresponding css class "wysiwyg-clear-*"
  #                            <br clear="all"> ... becomes ... <br class="wysiwyg-clear-both">
  #                          - align_img:    converts align attribute values (right/left) on <img> to their corresponding css class "wysiwyg-float-*"
  #                          
  #    - remove:             removes the element and its content
  #
  #    - rename_tag:         renames the element to the given tag
  #
  #    - set_class:          adds the given class to the element (note: make sure that the class is in the "classes" white list above)
  #
  #    - set_attributes:     sets/overrides the given attributes
  #
  #    - check_attributes:   checks the given HTML attribute via the given method
  #                            - url:            allows only valid urls (starting with http:// or https://)
  #                            - src:            allows something like "/foobar.jpg", "http://google.com", ...
  #                            - href:           allows something like "mailto:bert@foo.com", "http://google.com", "/foobar.jpg"
  #                            - alt:            strips unwanted characters. if the attribute is not set, then it gets set (to ensure valid and compatible HTML)
  #                            - numbers:  ensures that the attribute only contains numeric characters
  config.parser_rules['classes'] = {}
  # config.parser_rules['tags'] = {
  #   'tr' => { },
  #   'strike' => {
  #     'remove' => 1
  #   },
  #   'form' => {
  #     'rename_tag' => 'div'
  #   },
  #   'rt' => {
  #     'rename_tag' => 'span'
  #   },
  #   'code' => {},
  #   'acronym' => {
  #     'rename_tag' => 'span'
  #   },
  #   'br' => { },
  #   'details' => {
  #     'rename_tag' => 'div'
  #   },
  #   'h4' => { },
  #   'em' => {},
  #   'title' => {
  #     'remove' => 1
  #   },
  #   'multicol' => {
  #     'rename_tag' => 'div'
  #   },
  #   'figure' => {
  #     'rename_tag' => 'div'
  #   },
  #   'xmp' => {
  #     'rename_tag' => 'span'
  #   },
  #   'small' => {
  #     'rename_tag' => 'span'
  #   },
  #   'area' => {
  #     'remove' => 1
  #   },
  #   'time' => {
  #     'rename_tag' => 'span'
  #   },
  #   'dir' => {
  #     'rename_tag' => 'ul'
  #   },
  #   'bdi' => {
  #     'rename_tag' => 'span'
  #   },
  #   'command' => {
  #     'remove' => 1
  #   },
  #   'ul' => {},
  #   'progress' => {
  #     'rename_tag' => 'span'
  #   },
  #   'dfn' => {
  #     'rename_tag' => 'span'
  #   },
  #   'iframe' => {
  #     'remove' => 1
  #   },
  #   'figcaption' => {
  #     'rename_tag' => 'div'
  #   },
  #   'a' => {
  #     'check_attributes' => {
  #       'href' => 'url' # if you compiled master manually then change this from 'url' to 'href'
  #     },
  #     'set_attributes' => {
  #       'target' => '_blank'
  #     }
  #   },
  #   'img' => {
  #     'check_attributes' => {
  #       'width' => 'numbers',
  #       'alt' => 'alt',
  #       'src' => 'url', # if you compiled master manually then change this from 'url' to 'src'
  #       'height' => 'numbers'
  #     }
  #   },
  #   'rb' => {
  #     'rename_tag' => 'span'
  #   },
  #   'footer' => {
  #     'rename_tag' => 'div'
  #   },
  #   'noframes' => {
  #     'remove' => 1
  #   },
  #   'abbr' => {
  #     'rename_tag' => 'span'
  #   },
  #   'u' => {},
  #   'bgsound' => {
  #     'remove' => 1
  #   },
  #   'sup' => {
  #     'rename_tag' => 'span'
  #   },
  #   'address' => {
  #     'rename_tag' => 'div'
  #   },
  #   'basefont' => {
  #     'remove' => 1
  #   },
  #   'nav' => {
  #     'rename_tag' => 'div'
  #   },
  #   'h1' => { },
  #   'head' => {
  #     'remove' => 1
  #   },
  #   'tbody' => { },
  #   'dd' => {
  #     'rename_tag' => 'div'
  #   },
  #   's' => {
  #     'rename_tag' => 'span'
  #   },
  #   'li' => {},
  #   'td' => {
  #     'check_attributes' => {
  #       'rowspan' => 'numbers',
  #       'colspan' => 'numbers'
  #     }
  #   },
  #   'object' => {
  #     'remove' => 1
  #   },
  #   'div' => { },
  #   'option' => {
  #     'rename_tag' => 'span'
  #   },
  #   'select' => {
  #     'rename_tag' => 'span'
  #   },
  #   'i' => {},
  #   'track' => {
  #     'remove' => 1
  #   },
  #   'wbr' => {
  #     'remove' => 1
  #   },
  #   'fieldset' => {
  #     'rename_tag' => 'div'
  #   },
  #   'big' => {
  #     'rename_tag' => 'span'
  #   },
  #   'button' => {
  #     'rename_tag' => 'span'
  #   },
  #   'noscript' => {
  #     'remove' => 1
  #   },
  #   'svg' => {
  #     'remove' => 1
  #   },
  #   'input' => {
  #     'remove' => 1
  #   },
  #   'table' => {},
  #   'keygen' => {
  #     'remove' => 1
  #   },
  #   'h5' => { },
  #   'meta' => {
  #     'remove' => 1
  #   },
  #   'map' => {
  #     'rename_tag' => 'div'
  #   },
  #   'isindex' => {
  #     'remove' => 1
  #   },
  #   'mark' => {
  #     'rename_tag' => 'span'
  #   },
  #   'caption' => { },
  #   'tfoot' => { },
  #   'base' => {
  #     'remove' => 1
  #   },
  #   'video' => {
  #     'remove' => 1
  #   },
  #   'strong' => {},
  #   'canvas' => {
  #     'remove' => 1
  #   },
  #   'output' => {
  #     'rename_tag' => 'span'
  #   },
  #   'marquee' => {
  #     'rename_tag' => 'span'
  #   },
  #   'b' => {},
  #   'q' => {
  #     'check_attributes' => {
  #       'cite' => 'url'
  #     }
  #   },
  #   'applet' => {
  #     'remove' => 1
  #   },
  #   'span' => {},
  #   'rp' => {
  #     'rename_tag' => 'span'
  #   },
  #   'spacer' => {
  #     'remove' => 1
  #   },
  #   'source' => {
  #     'remove' => 1
  #   },
  #   'aside' => {
  #     'rename_tag' => 'div'
  #   },
  #   'frame' => {
  #     'remove' => 1
  #   },
  #   'section' => {
  #     'rename_tag' => 'div'
  #   },
  #   'body' => {
  #     'rename_tag' => 'div'
  #   },
  #   'ol' => {},
  #   'nobr' => {
  #     'rename_tag' => 'span'
  #   },
  #   'html' => {
  #     'rename_tag' => 'div'
  #   },
  #   'summary' => {
  #     'rename_tag' => 'span'
  #   },
  #   'var' => {
  #     'rename_tag' => 'span'
  #   },
  #   'del' => {
  #     'remove' => 1
  #   },
  #   'blockquote' => {
  #     'check_attributes' => {
  #       'cite' => 'url'
  #     }
  #   },
  #   'style' => {
  #     'remove' => 1
  #   },
  #   'device' => {
  #     'remove' => 1
  #   },
  #   'meter' => {
  #     'rename_tag' => 'span'
  #   },
  #   'h3' => { },
  #   'textarea' => {
  #     'rename_tag' => 'span'
  #   },
  #   'embed' => {
  #     'remove' => 1
  #   },
  #   'hgroup' => {
  #     'rename_tag' => 'div'
  #   },
  #   'font' => {
  #     'rename_tag' => 'span'
  #   },
  #   'tt' => {
  #     'rename_tag' => 'span'
  #   },
  #   'noembed' => {
  #     'remove' => 1
  #   },
  #   'thead' => { },
  #   'blink' => {
  #     'rename_tag' => 'span'
  #   },
  #   'plaintext' => {
  #     'rename_tag' => 'span'
  #   },
  #   'xml' => {
  #     'remove' => 1
  #   },
  #   'h6' => { },
  #   'param' => {
  #     'remove' => 1
  #   },
  #   'th' => {
  #     'check_attributes' => {
  #       'rowspan' => 'numbers',
  #       'colspan' => 'numbers'
  #     }
  #   },
  #   'legend' => {
  #     'rename_tag' => 'span'
  #   },
  #   'hr' => {},
  #   'label' => {
  #     'rename_tag' => 'span'
  #   },
  #   'dl' => {
  #     'rename_tag' => 'div'
  #   },
  #   'kbd' => {
  #     'rename_tag' => 'span'
  #   },
  #   'listing' => {
  #     'rename_tag' => 'div'
  #   },
  #   'dt' => {
  #     'rename_tag' => 'span'
  #   },
  #   'nextid' => {
  #     'remove' => 1
  #   },
  #   'pre' => {},
  #   'center' => {
  #     'rename_tag' => 'div'
  #   },
  #   'audio' => {
  #     'remove' => 1
  #   },
  #   'datalist' => {
  #     'rename_tag' => 'span'
  #   },
  #   'samp' => {
  #     'rename_tag' => 'span'
  #   },
  #   'col' => {
  #     'remove' => 1
  #   },
  #   'article' => {
  #     'rename_tag' => 'div'
  #   },
  #   'cite' => {},
  #   'link' => {
  #     'remove' => 1
  #   },
  #   'script' => {
  #     'remove' => 1
  #   },
  #   'bdo' => {
  #     'rename_tag' => 'span'
  #   },
  #   'menu' => {
  #     'rename_tag' => 'ul'
  #   },
  #   'colgroup' => {
  #     'remove' => 1
  #   },
  #   'ruby' => {
  #     'rename_tag' => 'span'
  #   },
  #   'h2' => { },
  #   'ins' => {
  #     'rename_tag' => 'span'
  #   },
  #   'p' => { },
  #   'sub' => {
  #     'rename_tag' => 'span'
  #   },
  #   'comment' => {
  #     'remove' => 1
  #   },
  #   'frameset' => {
  #     'remove' => 1
  #   },
  #   'optgroup' => {
  #     'rename_tag' => 'span'
  #   },
  #   'header' => {
  #     'rename_tag' => 'div'
  #   }
  # }
end
