#Copyright (c) 2010 [Marko Tunjić]
#marko.tunjic@gmail.com
#
#Permission is hereby granted, free of charge, to any person obtaining
#a copy of this software and associated documentation files (the
#"Software"), to deal in the Software without restriction, including
#without limitation the rights to use, copy, modify, merge, publish,
#distribute, sublicense, and/or sell copies of the Software, and to
#permit persons to whom the Software is furnished to do so, subject to
#the following conditions:
#
#The above copyright notice and this permission notice shall be
#included in all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
#OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
#WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
require 'rubygems'
#require 'ruby_debug'

module RailsMedia
  module Rmedix

  
    #Helper for FlexPaper
    def flex_paper( params = {}, flashvars = {}, attributes = {}, config = {})
      params                  = params.reverse_merge(FLEX_PARAMS)
      flashvars               = flashvars.reverse_merge(FLEX_VARS)
      attributes              = attributes.reverse_merge(FLEX_ATTR)
      config                  = config.reverse_merge(FLEX_CONFIG)
      content_tag('div', config[:message] , :id => config[:id], 
                        :class => config[:class]) << javascript_tag(build_js( params, flashvars, attributes))
    end
    
    
    #Helper for flowplayer
    def flowplayer(params = {}, playlist = [], config = {})
      #debugger
      params                  = params.reverse_merge(FLOW_PARAMS)
      #attr                    = attr.reverse_merge(FLOW_ATTR)
      #playlist                = playlist.reverse_merge(FLOW_ATTR)
      config                  = config.reverse_merge(FLOW_CONFIG)
      content_tag('a', nil, :id => config[:id], :class => config[:class], :href => config[:src]) << javascript_tag(build_flow_js(params, playlist))
    end

    
    protected

    def build_js( params, flashvars, attributes)

      %{
 
         var swfVersionStr = "10.0.0";
         var xiSwfUrlStr   = "playerProductInstall.swf";

         var flashvars     = { #{build_flashvars(flashvars)} };

         var params = {}
         #{build_params('params', params)}
         var attributes = {};
         #{build_params('attributes', attributes)}

         
        
        swfobject.embedSWF(
                  "/flexpaper/FlexPaperViewer.swf", "flex_paper",
                  "840", "480",
                  swfVersionStr, xiSwfUrlStr, 
                  flashvars, params, attributes);
        
        swfobject.createCSS("#flex_paper", "display:block;text-align:left;");
 
      }
    end
    
    
     def build_flow_js(params, playlist)       
      %{
        // wait for the DOM to load using jQuery
        $(function() {
          
          //setup player normally
           $f("flowplayer", "/flowplayer/flowplayer-3.2.5.swf", {
        
          
            // clip properties common to all playlist entries
            clip: {
                    baseUrl:  #{FLOW_PARAMS[:flashvars][:baseUrl]},
                    subTitle: #{FLOW_PARAMS[:flashvars][:subTitle]},
                    time:     #{FLOW_PARAMS[:flashvars][:time]}
            },
            
            //demo playlist
            playlist: [#{build_playlist(playlist)}],
            
            //show playlist buttons in controlbar
            plugins: {
              controls: {
                playlist: true
              }
            }
          });
          
          /*
            here comes the magic plugin. It uses first div.clips element as the 
            root for as playlist entries. loop parameter makes clips play
            from the beginning to the end.
          */
          $f("flowplayer").playlist("div.clips:first", {loop:false});
          
        });

       }
    end
    
    
    def build_flashvars(flashvars)
      flashvars.collect { |key,value| "#{key.to_s}: #{value.to_s}"}.join(', ') 
    end
    
    def build_params(type, params)
      params.collect { |key,value| "#{type}.#{key.to_s} = '#{value.to_s}'"}.join('; ')
    end
    
    def build_playlist(playlist)
      playlist.collect { |k, v| "{title: '#{v}', url: '#{k}'}"}.join(', ')
    end
    
    
    


                     
    FLEX_PARAMS = {
                        
                       :quality => "high",
                       :bgcolor => "#ffffff",
                       :allowscriptaccess => "sameDomain",
                       :allowfullscreen => "true",
                       :wmode => "opaque"
                     
                  } unless const_defined?("FLEX_PARAMS")
       
                                            
    FLEX_ATTR = {    
              
                       :id => "FlexPaperViewer",
                       :name => "FlexPaperViewer"                    
                  
                } unless const_defined?("FLEX_ATTR") 
                                            
    FLEX_VARS =   {       
                    
                      :SwfFile => 'escape("/flexpaper/xxg.swf")',
                      :Scale => '0.6', 
                      :ZoomTransition => '"easeOut"',
                      :ZoomTime     => '0.5',
                      :ZoomInterval => '0.1',
                      :FitPageOnLoad => 'false',
                      :FitWidthOnLoad => 'true',
                      :FullScreenAsMaxWindow => 'false',
                      :ProgressiveLoading => 'true',

                      :ViewModeToolsVisible => 'true',
                      :ZoomToolsVisible => 'true',
                      :FullScreenVisible => 'true',
                      :NavToolsVisible => 'true',
                      :CursorToolsVisible => 'true',
                      :SearchToolsVisible => 'true',
                      
                      :localeChain => '"zh_CN"'
                                          
                     } unless const_defined?("FLEX_VARS")
                     
      FLEX_CONFIG = {
                        :player_id => 'flex_paper',
                        :id => 'flex_paper',
                        :message => 'Loading...',
                        :class => 'flex_paper'
                     } unless const_defined?("FLEX_CONFIG")
                     
      FLOW_CONFIG = {
                        :player_id => 'flowplayer',
                        :id => 'flowplayer',
                        :message => 'Loading...',
                        :src => 'http://pseudo01.hddn.com/vod/demo.flowplayervod/flowplayer-700.flv',
                        :class => 'flowplayer'
                     } unless const_defined?("FLOW_CONFIG")
                     
      FLOW_PARAMS = {
                    :flashvars => {
                        :baseUrl => '\'http://blip.tv/file/get\'',
                        :subTitle => '\'from blib.tv video sharing site\'',
                        :time => '\'20 sec\''
                      }

      }
      FLOW_ATTR = {
                        
                        :playlist => ['KimAronson-TwentySeconds59483.flv', 'KimAronson-TwentySeconds58192.flv', 'KimAronson-TwentySeconds63617.flv']
      }
      FLOW_PLUGINS = {}
      


    
  
  end
end

