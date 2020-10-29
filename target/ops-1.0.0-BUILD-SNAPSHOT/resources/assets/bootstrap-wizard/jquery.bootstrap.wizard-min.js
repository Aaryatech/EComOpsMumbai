/*!
 * jQuery twitter bootstrap wizard plugin
 * Examples and documentation at: http://github.com/VinceG/twitter-bootstrap-wizard
 * version 1.0
 * Requires jQuery v1.3.2 or later
 * Supports Bootstrap 2.2.x, 2.3.x, 3.0
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 * Authors: Vadim Vincent Gabriel (http://vadimg.com), Jason Gill (www.gilluminate.com)
 */
(function(b){var a=function(f,e){var f=b(f);var h=this;var c='li:has([data-toggle="tab"])';var d=b.extend({},b.fn.bootstrapWizard.defaults,e);var g=null;var i=null;this.rebindClick=function(j,k){j.unbind("click",k).bind("click",k)};this.fixNavigationButtons=function(){if(!g.length){i.find("a:first").tab("show");g=i.find(c+":first")}b(d.previousSelector,f).toggleClass("disabled",(h.firstIndex()>=h.currentIndex()));b(d.nextSelector,f).toggleClass("disabled",(h.currentIndex()>=h.navigationLength()));h.rebindClick(b(d.nextSelector,f),h.next);h.rebindClick(b(d.previousSelector,f),h.previous);h.rebindClick(b(d.lastSelector,f),h.last);h.rebindClick(b(d.firstSelector,f),h.first);if(d.onTabShow&&typeof d.onTabShow==="function"&&d.onTabShow(g,i,h.currentIndex())===false){return false}};this.next=function(j){if(f.hasClass("last")){return false}if(d.onNext&&typeof d.onNext==="function"&&d.onNext(g,i,h.nextIndex())===false){return false}$index=h.nextIndex();if($index>h.navigationLength()){}else{i.find(c+":eq("+$index+") a").tab("show")}};this.previous=function(j){if(f.hasClass("first")){return false}if(d.onPrevious&&typeof d.onPrevious==="function"&&d.onPrevious(g,i,h.previousIndex())===false){return false}$index=h.previousIndex();if($index<0){}else{i.find(c+":eq("+$index+") a").tab("show")}};this.first=function(j){if(d.onFirst&&typeof d.onFirst==="function"&&d.onFirst(g,i,h.firstIndex())===false){return false}if(f.hasClass("disabled")){return false}i.find(c+":eq(0) a").tab("show")};this.last=function(j){if(d.onLast&&typeof d.onLast==="function"&&d.onLast(g,i,h.lastIndex())===false){return false}if(f.hasClass("disabled")){return false}i.find(c+":eq("+h.navigationLength()+") a").tab("show")};this.currentIndex=function(){return i.find(c).index(g)};this.firstIndex=function(){return 0};this.lastIndex=function(){return h.navigationLength()};this.getIndex=function(j){return i.find(c).index(j)};this.nextIndex=function(){return i.find(c).index(g)+1};this.previousIndex=function(){return i.find(c).index(g)-1};this.navigationLength=function(){return i.find(c).length-1};this.activeTab=function(){return g};this.nextTab=function(){return i.find(c+":eq("+(h.currentIndex()+1)+")").length?i.find(c+":eq("+(h.currentIndex()+1)+")"):null};this.previousTab=function(){if(h.currentIndex()<=0){return null}return i.find(c+":eq("+parseInt(h.currentIndex()-1)+")")};this.show=function(j){return f.find(c+":eq("+j+") a").tab("show")};this.disable=function(j){i.find(c+":eq("+j+")").addClass("disabled")};this.enable=function(j){i.find(c+":eq("+j+")").removeClass("disabled")};this.hide=function(j){i.find(c+":eq("+j+")").hide()};this.display=function(j){i.find(c+":eq("+j+")").show()};this.remove=function(l){var j=l[0];var m=typeof l[1]!="undefined"?l[1]:false;var k=i.find(c+":eq("+j+")");if(m){var n=k.find("a").attr("href");b(n).remove()}k.remove()};i=f.find("ul:first",f);g=i.find(c+".active",f);if(!i.hasClass(d.tabClass)){i.addClass(d.tabClass)}if(d.onInit&&typeof d.onInit==="function"){d.onInit(g,i,0)}if(d.onShow&&typeof d.onShow==="function"){d.onShow(g,i,h.nextIndex())}h.fixNavigationButtons();b('a[data-toggle="tab"]',i).on("click",function(k){var j=i.find(c).index(b(k.currentTarget).parent(c));if(d.onTabClick&&typeof d.onTabClick==="function"&&d.onTabClick(g,i,h.currentIndex(),j)===false){return false}});b('a[data-toggle="tab"]',i).on("shown shown.bs.tab",function(k){$element=b(k.target).parent();var j=i.find(c).index($element);if($element.hasClass("disabled")){return false}if(d.onTabChange&&typeof d.onTabChange==="function"&&d.onTabChange(g,i,h.currentIndex(),j)===false){return false}g=$element;h.fixNavigationButtons()})};b.fn.bootstrapWizard=function(d){if(typeof d=="string"){var c=Array.prototype.slice.call(arguments,1);if(c.length===1){c.toString()}return this.data("bootstrapWizard")[d](c)}return this.each(function(e){var f=b(this);if(f.data("bootstrapWizard")){return}var g=new a(f,d);f.data("bootstrapWizard",g)})};b.fn.bootstrapWizard.defaults={tabClass:"nav nav-pills",nextSelector:".wizard li.next",previousSelector:".wizard li.previous",firstSelector:".wizard li.first",lastSelector:".wizard li.last",onShow:null,onInit:null,onNext:null,onPrevious:null,onLast:null,onFirst:null,onTabChange:null,onTabClick:null,onTabShow:null}})(jQuery);