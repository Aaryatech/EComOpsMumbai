var hljs=new function(){function F(a){return a.replace(/&/gm,"&amp;").replace(/</gm,"&lt;").replace(/>/gm,"&gt;")}function w(a){return a.nodeName.toLowerCase()}function H(b,a){var c=b&&b.exec(a);return c&&c.index==0}function M(a){return Array.prototype.map.call(a.childNodes,function(b){if(b.nodeType==3){return O.useBR?b.nodeValue.replace(/\n/g,""):b.nodeValue}if(w(b)=="br"){return"\n"}return M(b)}).join("")}function y(a){var b=(a.className+" "+(a.parentNode?a.parentNode.className:"")).split(/\s+/);b=b.map(function(c){return c.replace(/^language-/,"")});return b.filter(function(c){return G(c)||c=="no-highlight"})[0]}function B(a,d){var c={};for(var b in a){c[b]=a[b]}if(d){for(var b in d){c[b]=d[b]}}return c}function v(a){var c=[];(function b(f,e){for(var d=f.firstChild;d;d=d.nextSibling){if(d.nodeType==3){e+=d.nodeValue.length}else{if(w(d)=="br"){e+=1}else{if(d.nodeType==1){c.push({event:"start",offset:e,node:d});e=b(d,e);c.push({event:"stop",offset:e,node:d})}}}}return e})(a,0);return c}function z(h,f,b){var g=0;var j="";var e=[];function c(){if(!h.length||!f.length){return h.length?h:f}if(h[0].offset!=f[0].offset){return(h[0].offset<f[0].offset)?h:f}return f[0].event=="start"?h:f}function d(l){function m(n){return" "+n.nodeName+'="'+F(n.value)+'"'}j+="<"+w(l)+Array.prototype.map.call(l.attributes,m).join("")+">"}function k(l){j+="</"+w(l)+">"}function i(l){(l.event=="start"?d:k)(l.node)}while(h.length||f.length){var a=c();j+=F(b.substr(g,a[0].offset-g));g=a[0].offset;if(a==h){e.reverse().forEach(k);do{i(a.splice(0,1)[0]);a=c()}while(a==h&&a.length&&a[0].offset==g);e.reverse().forEach(d)}else{if(a[0].event=="start"){e.push(a[0].node)}else{e.pop()}i(a.splice(0,1)[0])}}return j+F(b.substr(g))}function D(d){function c(e){return(e&&e.source)||e}function b(e,f){return RegExp(c(e),"m"+(d.cI?"i":"")+(f?"g":""))}function a(g,i){if(g.compiled){return}g.compiled=true;g.k=g.k||g.bK;if(g.k){var h={};function f(k,l){if(d.cI){l=l.toLowerCase()}l.split(" ").forEach(function(n){var m=n.split("|");h[m[0]]=[k,m[1]?Number(m[1]):1]})}if(typeof g.k=="string"){f("keyword",g.k)}else{Object.keys(g.k).forEach(function(k){f(k,g.k[k])})}g.k=h}g.lR=b(g.l||/\b[A-Za-z0-9_]+\b/,true);if(i){if(g.bK){g.b=g.bK.split(" ").join("|")}if(!g.b){g.b=/\B|\b/}g.bR=b(g.b);if(!g.e&&!g.eW){g.e=/\B|\b/}if(g.e){g.eR=b(g.e)}g.tE=c(g.e)||"";if(g.eW&&i.tE){g.tE+=(g.e?"|":"")+i.tE}}if(g.i){g.iR=b(g.i)}if(g.r===undefined){g.r=1}if(!g.c){g.c=[]}var j=[];g.c.forEach(function(k){if(k.v){k.v.forEach(function(l){j.push(B(k,l))})}else{j.push(k=="self"?g:k)}});g.c=j;g.c.forEach(function(k){a(k,g)});if(g.starts){a(g.starts,i)}var e=g.c.map(function(k){return k.bK?"\\.?\\b("+k.b+")\\b\\.?":k.b}).concat([g.tE]).concat([g.i]).map(c).filter(Boolean);g.t=e.length?b(e.join("|"),true):{exec:function(k){return null}};g.continuation={}}a(d)}function N(a,h,l,b){function r(R,Q){for(var S=0;S<Q.c.length;S++){if(H(Q.c[S].bR,R)){return Q.c[S]}}}function j(Q,R){if(H(Q.eR,R)){return Q}if(Q.eW){return j(Q.parent,R)}}function V(R,Q){return !l&&H(Q.iR,R)}function t(Q,S){var R=g.cI?S[0].toLowerCase():S[0];return Q.k.hasOwnProperty(R)&&Q.k[R]}function p(ab,ad,Q,R){var aa=R?"":O.classPrefix,S='<span class="'+aa,ac=Q?"":"</span>";S+=ab+'">';return S+ad+ac}function f(){var S=F(T);if(!n.k){return S}var Y="";var Z=0;n.lR.lastIndex=0;var R=n.lR.exec(S);while(R){Y+=S.substr(Z,R.index-Z);var Q=t(n,R);if(Q){o+=Q[1];Y+=p(Q[0],R[0])}else{Y+=R[0]}Z=n.lR.lastIndex;R=n.lR.exec(S)}return Y+S.substr(Z)}function s(){if(n.sL&&!K[n.sL]){return F(T)}var Q=n.sL?N(n.sL,T,true,n.continuation.top):J(T);if(n.r>0){o+=Q.r}if(n.subLanguageMode=="continuous"){n.continuation.top=Q.top}return p(Q.language,Q.value,false,true)}function c(){return n.sL!==undefined?s():f()}function d(Q,R){var S=Q.cN?p(Q.cN,"",true):"";if(Q.rB){u+=S;T=""}else{if(Q.eB){u+=F(R)+S;T=""}else{u+=S;T=R}}n=Object.create(Q,{parent:{value:n}})}function q(Y,Z){T+=Y;if(Z===undefined){u+=c();return 0}var R=r(Z,n);if(R){u+=c();d(R,Z);return R.rB?0:Z.length}var Q=j(n,Z);if(Q){var S=n;if(!(S.rE||S.eE)){T+=Z}u+=c();do{if(n.cN){u+="</span>"}o+=n.r;n=n.parent}while(n!=Q.parent);if(S.eE){u+=F(Z)}T="";if(Q.starts){d(Q.starts,"")}return S.rE?0:Z.length}if(V(Z,n)){throw new Error('Illegal lexeme "'+Z+'" for mode "'+(n.cN||"<unnamed>")+'"')}T+=Z;return Z.length||1}var g=G(a);if(!g){throw new Error('Unknown language: "'+a+'"')}D(g);var n=b||g;var u="";for(var i=n;i!=g;i=i.parent){if(i.cN){u=p(i.cN,u,true)}}var T="";var o=0;try{var U,k,m=0;while(true){n.t.lastIndex=m;U=n.t.exec(h);if(!U){break}k=q(h.substr(m,U.index-m),U[0]);m=U.index+k}q(h.substr(m));for(var i=n;i.parent;i=i.parent){if(i.cN){u+="</span>"}}return{r:o,value:u,language:a,top:n}}catch(e){if(e.message.indexOf("Illegal")!=-1){return{r:0,value:F(h)}}else{throw e}}}function J(d,a){a=a||O.languages||Object.keys(K);var c={r:0,value:F(d)};var b=c;a.forEach(function(f){if(!G(f)){return}var e=N(f,d,false);e.language=f;if(e.r>b.r){b=e}if(e.r>c.r){b=c;c=e}});if(b.language){c.second_best=b}return c}function I(a){if(O.tabReplace){a=a.replace(/^((<[^>]+>|\t)+)/gm,function(c,d,e,b){return d.replace(/\t/g,O.tabReplace)})}if(O.useBR){a=a.replace(/\n/g,"<br>")}return a}function A(e){var f=M(e);var b=y(e);if(b=="no-highlight"){return}var d=b?N(b,f,true):J(f);var c=v(e);if(c.length){var a=document.createElementNS("http://www.w3.org/1999/xhtml","pre");a.innerHTML=d.value;d.value=z(c,v(a),f)}d.value=I(d.value);e.innerHTML=d.value;e.className+=" hljs "+(!b&&d.language||"");e.result={language:d.language,re:d.r};if(d.second_best){e.second_best={language:d.second_best.language,re:d.second_best.r}}}var O={classPrefix:"hljs-",tabReplace:null,useBR:false,languages:undefined};function x(a){O=B(O,a)}function E(){if(E.called){return}E.called=true;var a=document.querySelectorAll("pre code");Array.prototype.forEach.call(a,A)}function P(){addEventListener("DOMContentLoaded",E,false);addEventListener("load",E,false)}var K={};var C={};function L(c,a){var b=K[c]=a(this);if(b.aliases){b.aliases.forEach(function(d){C[d]=c})}}function G(a){return K[a]||K[C[a]]}this.highlight=N;this.highlightAuto=J;this.fixMarkup=I;this.highlightBlock=A;this.configure=x;this.initHighlighting=E;this.initHighlightingOnLoad=P;this.registerLanguage=L;this.getLanguage=G;this.inherit=B;this.IR="[a-zA-Z][a-zA-Z0-9_]*";this.UIR="[a-zA-Z_][a-zA-Z0-9_]*";this.NR="\\b\\d+(\\.\\d+)?";this.CNR="(\\b0[xX][a-fA-F0-9]+|(\\b\\d+(\\.\\d*)?|\\.\\d+)([eE][-+]?\\d+)?)";this.BNR="\\b(0b[01]+)";this.RSR="!|!=|!==|%|%=|&|&&|&=|\\*|\\*=|\\+|\\+=|,|-|-=|/=|/|:|;|<<|<<=|<=|<|===|==|=|>>>=|>>=|>=|>>>|>>|>|\\?|\\[|\\{|\\(|\\^|\\^=|\\||\\|=|\\|\\||~";this.BE={b:"\\\\[\\s\\S]",r:0};this.ASM={cN:"string",b:"'",e:"'",i:"\\n",c:[this.BE]};this.QSM={cN:"string",b:'"',e:'"',i:"\\n",c:[this.BE]};this.CLCM={cN:"comment",b:"//",e:"$"};this.CBLCLM={cN:"comment",b:"/\\*",e:"\\*/"};this.HCM={cN:"comment",b:"#",e:"$"};this.NM={cN:"number",b:this.NR,r:0};this.CNM={cN:"number",b:this.CNR,r:0};this.BNM={cN:"number",b:this.BNR,r:0};this.REGEXP_MODE={cN:"regexp",b:/\//,e:/\/[gim]*/,i:/\n/,c:[this.BE,{b:/\[/,e:/\]/,r:0,c:[this.BE]}]};this.TM={cN:"title",b:this.IR,r:0};this.UTM={cN:"title",b:this.UIR,r:0}}();hljs.registerLanguage("bash",function(e){var f={cN:"variable",v:[{b:/\$[\w\d#@][\w\d_]*/},{b:/\$\{(.*?)\}/}]};var g={cN:"string",b:/"/,e:/"/,c:[e.BE,f,{cN:"variable",b:/\$\(/,e:/\)/,c:[e.BE]}]};var h={cN:"string",b:/'/,e:/'/};return{l:/-?[a-z\.]+/,k:{keyword:"if then else elif fi for break continue while in do done exit return set declare case esac export exec",literal:"true false",built_in:"printf echo read cd pwd pushd popd dirs let eval unset typeset readonly getopts source shopt caller type hash bind help sudo",operator:"-ne -eq -lt -gt -f -d -e -s -l -a"},c:[{cN:"shebang",b:/^#![^\n]+sh\s*$/,r:10},{cN:"function",b:/\w[\w\d_]*\s*\(\s*\)\s*\{/,rB:true,c:[e.inherit(e.TM,{b:/\w[\w\d_]*/})],r:0},e.HCM,e.NM,g,h,f]}});hljs.registerLanguage("cs",function(c){var d="abstract as base bool break byte case catch char checked const continue decimal default delegate do double else enum event explicit extern false finally fixed float for foreach goto if implicit in int interface internal is lock long new null object operator out override params private protected public readonly ref return sbyte sealed short sizeof stackalloc static string struct switch this throw true try typeof uint ulong unchecked unsafe ushort using virtual volatile void while async await ascending descending from get group into join let orderby partial select set value var where yield";return{k:d,c:[{cN:"comment",b:"///",e:"$",rB:true,c:[{cN:"xmlDocTag",b:"///|<!--|-->"},{cN:"xmlDocTag",b:"</?",e:">"}]},c.CLCM,c.CBLCLM,{cN:"preprocessor",b:"#",e:"$",k:"if else elif endif define undef warning error line region endregion pragma checksum"},{cN:"string",b:'@"',e:'"',c:[{b:'""'}]},c.ASM,c.QSM,c.CNM,{bK:"protected public private internal",e:/[{;=]/,k:d,c:[{bK:"class namespace interface",starts:{c:[c.TM]}},{b:c.IR+"\\s*\\(",rB:true,c:[c.TM]}]}]}});hljs.registerLanguage("ruby",function(n){var k="[a-zA-Z_]\\w*[!?=]?|[-+~]\\@|<<|>>|=~|===?|<=>|[<>]=?|\\*\\*|[-/+%^&*~`|]|\\[\\]=?";var l="and false then defined module in return redo if BEGIN retry end for true self when next until do begin unless END rescue nil else break undef not super class case require yield alias while ensure elsif or include attr_reader attr_writer attr_accessor";var r={cN:"yardoctag",b:"@[A-Za-z]+"};var j={cN:"comment",v:[{b:"#",e:"$",c:[r]},{b:"^\\=begin",e:"^\\=end",c:[r],r:10},{b:"^__END__",e:"\\n$"}]};var p={cN:"subst",b:"#\\{",e:"}",k:l};var o={cN:"string",c:[n.BE,p],v:[{b:/'/,e:/'/},{b:/"/,e:/"/},{b:"%[qw]?\\(",e:"\\)"},{b:"%[qw]?\\[",e:"\\]"},{b:"%[qw]?{",e:"}"},{b:"%[qw]?<",e:">",r:10},{b:"%[qw]?/",e:"/",r:10},{b:"%[qw]?%",e:"%",r:10},{b:"%[qw]?-",e:"-",r:10},{b:"%[qw]?\\|",e:"\\|",r:10},{b:/\B\?(\\\d{1,3}|\\x[A-Fa-f0-9]{1,2}|\\u[A-Fa-f0-9]{4}|\\?\S)\b/}]};var q={cN:"params",b:"\\(",e:"\\)",k:l};var m=[o,j,{cN:"class",bK:"class module",e:"$|;",i:/=/,c:[n.inherit(n.TM,{b:"[A-Za-z_]\\w*(::\\w+)*(\\?|\\!)?"}),{cN:"inheritance",b:"<\\s*",c:[{cN:"parent",b:"("+n.IR+"::)?"+n.IR}]},j]},{cN:"function",bK:"def",e:" |$|;",r:0,c:[n.inherit(n.TM,{b:k}),q,j]},{cN:"constant",b:"(::)?(\\b[A-Z]\\w*(::)?)+",r:0},{cN:"symbol",b:":",c:[o,{b:k}],r:0},{cN:"symbol",b:n.UIR+"(\\!|\\?)?:",r:0},{cN:"number",b:"(\\b0[0-7_]+)|(\\b0x[0-9a-fA-F_]+)|(\\b[1-9][0-9_]*(\\.[0-9_]+)?)|[0_]\\b",r:0},{cN:"variable",b:"(\\$\\W)|((\\$|\\@\\@?)(\\w+))"},{b:"("+n.RSR+")\\s*",c:[j,{cN:"regexp",c:[n.BE,p],i:/\n/,v:[{b:"/",e:"/[a-z]*"},{b:"%r{",e:"}[a-z]*"},{b:"%r\\(",e:"\\)[a-z]*"},{b:"%r!",e:"![a-z]*"},{b:"%r\\[",e:"\\][a-z]*"}]}],r:0}];p.c=m;q.c=m;return{k:l,c:m}});hljs.registerLanguage("diff",function(b){return{c:[{cN:"chunk",r:10,v:[{b:/^\@\@ +\-\d+,\d+ +\+\d+,\d+ +\@\@$/},{b:/^\*\*\* +\d+,\d+ +\*\*\*\*$/},{b:/^\-\-\- +\d+,\d+ +\-\-\-\-$/}]},{cN:"header",v:[{b:/Index: /,e:/$/},{b:/=====/,e:/=====$/},{b:/^\-\-\-/,e:/$/},{b:/^\*{3} /,e:/$/},{b:/^\+\+\+/,e:/$/},{b:/\*{5}/,e:/\*{5}$/}]},{cN:"addition",b:"^\\+",e:"$"},{cN:"deletion",b:"^\\-",e:"$"},{cN:"change",b:"^\\!",e:"$"}]}});hljs.registerLanguage("javascript",function(b){return{aliases:["js"],k:{keyword:"in if for while finally var new function do return void else break catch instanceof with throw case default try this switch continue typeof delete let yield const class",literal:"true false null undefined NaN Infinity",built_in:"eval isFinite isNaN parseFloat parseInt decodeURI decodeURIComponent encodeURI encodeURIComponent escape unescape Object Function Boolean Error EvalError InternalError RangeError ReferenceError StopIteration SyntaxError TypeError URIError Number Math Date String RegExp Array Float32Array Float64Array Int16Array Int32Array Int8Array Uint16Array Uint32Array Uint8Array Uint8ClampedArray ArrayBuffer DataView JSON Intl arguments require"},c:[{cN:"pi",b:/^\s*('|")use strict('|")/,r:10},b.ASM,b.QSM,b.CLCM,b.CBLCLM,b.CNM,{b:"("+b.RSR+"|\\b(case|return|throw)\\b)\\s*",k:"return throw case",c:[b.CLCM,b.CBLCLM,b.REGEXP_MODE,{b:/</,e:/>;/,r:0,sL:"xml"}],r:0},{cN:"function",bK:"function",e:/\{/,c:[b.inherit(b.TM,{b:/[A-Za-z$_][0-9A-Za-z$_]*/}),{cN:"params",b:/\(/,e:/\)/,c:[b.CLCM,b.CBLCLM],i:/["'\(]/}],i:/\[|%/},{b:/\$[(.]/},{b:"\\."+b.IR,r:0}]}});hljs.registerLanguage("xml",function(f){var h="[A-Za-z0-9\\._:-]+";var g={b:/<\?(php)?(?!\w)/,e:/\?>/,sL:"php",subLanguageMode:"continuous"};var e={eW:true,i:/</,r:0,c:[g,{cN:"attribute",b:h,r:0},{b:"=",r:0,c:[{cN:"value",v:[{b:/"/,e:/"/},{b:/'/,e:/'/},{b:/[^\s\/>]+/}]}]}]};return{aliases:["html"],cI:true,c:[{cN:"doctype",b:"<!DOCTYPE",e:">",r:10,c:[{b:"\\[",e:"\\]"}]},{cN:"comment",b:"<!--",e:"-->",r:10},{cN:"cdata",b:"<\\!\\[CDATA\\[",e:"\\]\\]>",r:10},{cN:"tag",b:"<style(?=\\s|>|$)",e:">",k:{title:"style"},c:[e],starts:{e:"</style>",rE:true,sL:"css"}},{cN:"tag",b:"<script(?=\\s|>|$)",e:">",k:{title:"script"},c:[e],starts:{e:"<\/script>",rE:true,sL:"javascript"}},{b:"<%",e:"%>",sL:"vbscript"},g,{cN:"pi",b:/<\?\w+/,e:/\?>/,r:10},{cN:"tag",b:"</?",e:"/?>",c:[{cN:"title",b:"[^ /><]+",r:0},e]}]}});hljs.registerLanguage("markdown",function(b){return{c:[{cN:"header",v:[{b:"^#{1,6}",e:"$"},{b:"^.+?\\n[=-]{2,}$"}]},{b:"<",e:">",sL:"xml",r:0},{cN:"bullet",b:"^([*+-]|(\\d+\\.))\\s+"},{cN:"strong",b:"[*_]{2}.+?[*_]{2}"},{cN:"emphasis",v:[{b:"\\*.+?\\*"},{b:"_.+?_",r:0}]},{cN:"blockquote",b:"^>\\s+",e:"$"},{cN:"code",v:[{b:"`.+?`"},{b:"^( {4}|\t)",e:"$",r:0}]},{cN:"horizontal_rule",b:"^[-\\*]{3,}",e:"$"},{b:"\\[.+?\\][\\(\\[].+?[\\)\\]]",rB:true,c:[{cN:"link_label",b:"\\[",e:"\\]",eB:true,rE:true,r:0},{cN:"link_url",b:"\\]\\(",e:"\\)",eB:true,eE:true},{cN:"link_reference",b:"\\]\\[",e:"\\]",eB:true,eE:true,}],r:10},{b:"^\\[.+\\]:",e:"$",rB:true,c:[{cN:"link_reference",b:"\\[",e:"\\]",eB:true,eE:true},{cN:"link_url",b:"\\s",e:"$"}]}]}});hljs.registerLanguage("css",function(e){var d="[a-zA-Z-][a-zA-Z0-9_-]*";var f={cN:"function",b:d+"\\(",e:"\\)",c:["self",e.NM,e.ASM,e.QSM]};return{cI:true,i:"[=/|']",c:[e.CBLCLM,{cN:"id",b:"\\#[A-Za-z0-9_-]+"},{cN:"class",b:"\\.[A-Za-z0-9_-]+",r:0},{cN:"attr_selector",b:"\\[",e:"\\]",i:"$"},{cN:"pseudo",b:":(:)?[a-zA-Z0-9\\_\\-\\+\\(\\)\\\"\\']+"},{cN:"at_rule",b:"@(font-face|page)",l:"[a-z-]+",k:"font-face page"},{cN:"at_rule",b:"@",e:"[{;]",c:[{cN:"keyword",b:/\S+/},{b:/\s/,eW:true,eE:true,r:0,c:[f,e.ASM,e.QSM,e.NM]}]},{cN:"tag",b:d,r:0},{cN:"rules",b:"{",e:"}",i:"[^\\s]",r:0,c:[e.CBLCLM,{cN:"rule",b:"[^\\s]",rB:true,e:";",eW:true,c:[{cN:"attribute",b:"[A-Z\\_\\.\\-]+",e:":",eE:true,i:"[^\\s]",starts:{cN:"value",eW:true,eE:true,c:[f,e.NM,e.QSM,e.ASM,e.CBLCLM,{cN:"hexcolor",b:"#[0-9A-Fa-f]+"},{cN:"important",b:"!important"}]}}]}]}]}});hljs.registerLanguage("http",function(b){return{i:"\\S",c:[{cN:"status",b:"^HTTP/[0-9\\.]+",e:"$",c:[{cN:"number",b:"\\b\\d{3}\\b"}]},{cN:"request",b:"^[A-Z]+ (.*?) HTTP/[0-9\\.]+$",rB:true,e:"$",c:[{cN:"string",b:" ",e:" ",eB:true,eE:true}]},{cN:"attribute",b:"^\\w",e:": ",eE:true,i:"\\n|\\s|=",starts:{cN:"string",e:"$"}},{b:"\\n\\n",starts:{sL:"",eW:true}}]}});hljs.registerLanguage("java",function(c){var d="false synchronized int abstract float private char boolean static null if const for true while long throw strictfp finally protected import native final return void enum else break transient new catch instanceof byte super volatile case assert short package default double public try this switch continue throws";return{k:d,i:/<\//,c:[{cN:"javadoc",b:"/\\*\\*",e:"\\*/",c:[{cN:"javadoctag",b:"(^|\\s)@[A-Za-z]+"}],r:10},c.CLCM,c.CBLCLM,c.ASM,c.QSM,{bK:"protected public private",e:/[{;=]/,k:d,c:[{cN:"class",bK:"class interface",eW:true,i:/[:"<>]/,c:[{bK:"extends implements",r:10},c.UTM]},{b:c.UIR+"\\s*\\(",rB:true,c:[c.UTM]}]},c.CNM,{cN:"annotation",b:"@[A-Za-z]+"}]}});hljs.registerLanguage("php",function(f){var h={cN:"variable",b:"\\$+[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*"};var g={cN:"preprocessor",b:/<\?(php)?|\?>/};var j={cN:"string",c:[f.BE,g],v:[{b:'b"',e:'"'},{b:"b'",e:"'"},f.inherit(f.ASM,{i:null}),f.inherit(f.QSM,{i:null})]};var i={v:[f.BNM,f.CNM]};return{cI:true,k:"and include_once list abstract global private echo interface as static endswitch array null if endwhile or const for endforeach self var while isset public protected exit foreach throw elseif include __FILE__ empty require_once do xor return parent clone use __CLASS__ __LINE__ else break print eval new catch __METHOD__ case exception default die require __FUNCTION__ enddeclare final try switch continue endfor endif declare unset true false trait goto instanceof insteadof __DIR__ __NAMESPACE__ yield finally",c:[f.CLCM,f.HCM,{cN:"comment",b:"/\\*",e:"\\*/",c:[{cN:"phpdoc",b:"\\s@[A-Za-z]+"},g]},{cN:"comment",b:"__halt_compiler.+?;",eW:true,k:"__halt_compiler",l:f.UIR},{cN:"string",b:"<<<['\"]?\\w+['\"]?$",e:"^\\w+;",c:[f.BE]},g,h,{cN:"function",bK:"function",e:/[;{]/,i:"\\$|\\[|%",c:[f.UTM,{cN:"params",b:"\\(",e:"\\)",c:["self",h,f.CBLCLM,j,i]}]},{cN:"class",bK:"class interface",e:"{",i:/[:\(\$"]/,c:[{bK:"extends implements",r:10},f.UTM]},{bK:"namespace",e:";",i:/[\.']/,c:[f.UTM]},{bK:"use",e:";",c:[f.UTM]},{b:"=>"},j,i]}});hljs.registerLanguage("python",function(h){var i={cN:"prompt",b:/^(>>>|\.\.\.) /};var g={cN:"string",c:[h.BE],v:[{b:/(u|b)?r?'''/,e:/'''/,c:[i],r:10},{b:/(u|b)?r?"""/,e:/"""/,c:[i],r:10},{b:/(u|r|ur)'/,e:/'/,r:10},{b:/(u|r|ur)"/,e:/"/,r:10},{b:/(b|br)'/,e:/'/,},{b:/(b|br)"/,e:/"/,},h.ASM,h.QSM]};var k={cN:"number",r:0,v:[{b:h.BNR+"[lLjJ]?"},{b:"\\b(0o[0-7]+)[lLjJ]?"},{b:h.CNR+"[lLjJ]?"}]};var j={cN:"params",b:/\(/,e:/\)/,c:["self",i,k,g]};var l={e:/:/,i:/[${=;\n]/,c:[h.UTM,j]};return{k:{keyword:"and elif is global as in if from raise for except finally print import pass return exec else break not with class assert yield try while continue del or def lambda nonlocal|10 None True False",built_in:"Ellipsis NotImplemented"},i:/(<\/|->|\?)/,c:[i,k,g,h.HCM,h.inherit(l,{cN:"function",bK:"def",r:10}),h.inherit(l,{cN:"class",bK:"class"}),{cN:"decorator",b:/@/,e:/$/},{b:/\b(print|exec)\(/}]}});hljs.registerLanguage("sql",function(b){return{cI:true,i:/[<>]/,c:[{cN:"operator",b:"\\b(begin|end|start|commit|rollback|savepoint|lock|alter|create|drop|rename|call|delete|do|handler|insert|load|replace|select|truncate|update|set|show|pragma|grant|merge)\\b(?!:)",e:";",eW:true,k:{keyword:"all partial global month current_timestamp using go revoke smallint indicator end-exec disconnect zone with character assertion to add current_user usage input local alter match collate real then rollback get read timestamp session_user not integer bit unique day minute desc insert execute like ilike|2 level decimal drop continue isolation found where constraints domain right national some module transaction relative second connect escape close system_user for deferred section cast current sqlstate allocate intersect deallocate numeric public preserve full goto initially asc no key output collation group by union session both last language constraint column of space foreign deferrable prior connection unknown action commit view or first into float year primary cascaded except restrict set references names table outer open select size are rows from prepare distinct leading create only next inner authorization schema corresponding option declare precision immediate else timezone_minute external varying translation true case exception join hour default double scroll value cursor descriptor values dec fetch procedure delete and false int is describe char as at in varchar null trailing any absolute current_time end grant privileges when cross check write current_date pad begin temporary exec time update catalog user sql date on identity timezone_hour natural whenever interval work order cascade diagnostics nchar having left call do handler load replace truncate start lock show pragma exists number trigger if before after each row merge matched database",aggregate:"count sum min max avg"},c:[{cN:"string",b:"'",e:"'",c:[b.BE,{b:"''"}]},{cN:"string",b:'"',e:'"',c:[b.BE,{b:'""'}]},{cN:"string",b:"`",e:"`",c:[b.BE]},b.CNM]},b.CBLCLM,{cN:"comment",b:"--",e:"$"}]}});hljs.registerLanguage("ini",function(b){return{cI:true,i:/\S/,c:[{cN:"comment",b:";",e:"$"},{cN:"title",b:"^\\[",e:"\\]"},{cN:"setting",b:"^[a-z0-9\\[\\]_-]+[ \\t]*=[ \\t]*",e:"$",c:[{cN:"value",eW:true,k:"on off true false yes no",c:[b.QSM,b.NM],r:0}]}]}});hljs.registerLanguage("perl",function(p){var o="getpwent getservent quotemeta msgrcv scalar kill dbmclose undef lc ma syswrite tr send umask sysopen shmwrite vec qx utime local oct semctl localtime readpipe do return format read sprintf dbmopen pop getpgrp not getpwnam rewinddir qqfileno qw endprotoent wait sethostent bless s|0 opendir continue each sleep endgrent shutdown dump chomp connect getsockname die socketpair close flock exists index shmgetsub for endpwent redo lstat msgctl setpgrp abs exit select print ref gethostbyaddr unshift fcntl syscall goto getnetbyaddr join gmtime symlink semget splice x|0 getpeername recv log setsockopt cos last reverse gethostbyname getgrnam study formline endhostent times chop length gethostent getnetent pack getprotoent getservbyname rand mkdir pos chmod y|0 substr endnetent printf next open msgsnd readdir use unlink getsockopt getpriority rindex wantarray hex system getservbyport endservent int chr untie rmdir prototype tell listen fork shmread ucfirst setprotoent else sysseek link getgrgid shmctl waitpid unpack getnetbyname reset chdir grep split require caller lcfirst until warn while values shift telldir getpwuid my getprotobynumber delete and sort uc defined srand accept package seekdir getprotobyname semop our rename seek if q|0 chroot sysread setpwent no crypt getc chown sqrt write setnetent setpriority foreach tie sin msgget map stat getlogin unless elsif truncate exec keys glob tied closedirioctl socket readlink eval xor readline binmode setservent eof ord bind alarm pipe atan2 getgrent exp time push setgrent gt lt or ne m|0 break given say state when";var m={cN:"subst",b:"[$@]\\{",e:"\\}",k:o};var l={b:"->{",e:"}"};var j={cN:"variable",v:[{b:/\$\d/},{b:/[\$\%\@\*](\^\w\b|#\w+(\:\:\w+)*|{\w+}|\w+(\:\:\w*)*)/},{b:/[\$\%\@\*][^\s\w{]/,r:0}]};var n={cN:"comment",b:"^(__END__|__DATA__)",e:"\\n$",r:5};var k=[p.BE,m,j];var i=[j,p.HCM,n,{cN:"comment",b:"^\\=\\w",e:"\\=cut",eW:true},l,{cN:"string",c:k,v:[{b:"q[qwxr]?\\s*\\(",e:"\\)",r:5},{b:"q[qwxr]?\\s*\\[",e:"\\]",r:5},{b:"q[qwxr]?\\s*\\{",e:"\\}",r:5},{b:"q[qwxr]?\\s*\\|",e:"\\|",r:5},{b:"q[qwxr]?\\s*\\<",e:"\\>",r:5},{b:"qw\\s+q",e:"q",r:5},{b:"'",e:"'",c:[p.BE]},{b:'"',e:'"'},{b:"`",e:"`",c:[p.BE]},{b:"{\\w+}",c:[],r:0},{b:"-?\\w+\\s*\\=\\>",c:[],r:0}]},{cN:"number",b:"(\\b0[0-7_]+)|(\\b0x[0-9a-fA-F_]+)|(\\b[1-9][0-9_]*(\\.[0-9_]+)?)|[0_]\\b",r:0},{b:"(\\/\\/|"+p.RSR+"|\\b(split|return|print|reverse|grep)\\b)\\s*",k:"split return print reverse grep",r:0,c:[p.HCM,n,{cN:"regexp",b:"(s|tr|y)/(\\\\.|[^/])*/(\\\\.|[^/])*/[a-z]*",r:10},{cN:"regexp",b:"(m|qr)?/",e:"/[a-z]*",c:[p.BE],r:0}]},{cN:"sub",bK:"sub",e:"(\\s*\\(.*?\\))?[;{]",r:5},{cN:"operator",b:"-\\w\\b",r:0}];m.c=i;l.c=i;return{k:o,c:i}});hljs.registerLanguage("objectivec",function(f){var g={keyword:"int float while char export sizeof typedef const struct for union unsigned long volatile static bool mutable if do return goto void enum else break extern asm case short default double register explicit signed typename this switch continue wchar_t inline readonly assign self synchronized id nonatomic super unichar IBOutlet IBAction strong weak @private @protected @public @try @property @end @throw @catch @finally @synthesize @dynamic @selector @optional @required",literal:"false true FALSE TRUE nil YES NO NULL",built_in:"NSString NSDictionary CGRect CGPoint UIButton UILabel UITextView UIWebView MKMapView UISegmentedControl NSObject UITableViewDelegate UITableViewDataSource NSThread UIActivityIndicator UITabbar UIToolBar UIBarButtonItem UIImageView NSAutoreleasePool UITableView BOOL NSInteger CGFloat NSException NSLog NSMutableString NSMutableArray NSMutableDictionary NSURL NSIndexPath CGSize UITableViewCell UIView UIViewController UINavigationBar UINavigationController UITabBarController UIPopoverController UIPopoverControllerDelegate UIImage NSNumber UISearchBar NSFetchedResultsController NSFetchedResultsChangeType UIScrollView UIScrollViewDelegate UIEdgeInsets UIColor UIFont UIApplication NSNotFound NSNotificationCenter NSNotification UILocalNotification NSBundle NSFileManager NSTimeInterval NSDate NSCalendar NSUserDefaults UIWindow NSRange NSArray NSError NSURLRequest NSURLConnection UIInterfaceOrientation MPMoviePlayerController dispatch_once_t dispatch_queue_t dispatch_sync dispatch_async dispatch_once"};var h=/[a-zA-Z@][a-zA-Z0-9_]*/;var e="@interface @class @protocol @implementation";return{k:g,l:h,i:"</",c:[f.CLCM,f.CBLCLM,f.CNM,f.QSM,{cN:"string",b:"'",e:"[^\\\\]'",i:"[^\\\\][^']"},{cN:"preprocessor",b:"#import",e:"$",c:[{cN:"title",b:'"',e:'"'},{cN:"title",b:"<",e:">"}]},{cN:"preprocessor",b:"#",e:"$"},{cN:"class",b:"("+e.split(" ").join("|")+")\\b",e:"({|$)",k:e,l:h,c:[f.UTM]},{cN:"variable",b:"\\."+f.UIR,r:0}]}});hljs.registerLanguage("coffeescript",function(l){var g={keyword:"in if for while finally new do return else break catch instanceof throw try this switch continue typeof delete debugger super then unless until loop of by when and or is isnt not",literal:"true false null undefined yes no on off",reserved:"case default function var void with const let enum export import native __hasProp __extends __slice __bind __indexOf",built_in:"npm require console print module exports global window document"};var h="[A-Za-z$_][0-9A-Za-z$_]*";var i=l.inherit(l.TM,{b:h});var j={cN:"subst",b:/#\{/,e:/}/,k:g};var k=[l.BNM,l.inherit(l.CNM,{starts:{e:"(\\s*/)?",r:0}}),{cN:"string",v:[{b:/'''/,e:/'''/,c:[l.BE]},{b:/'/,e:/'/,c:[l.BE]},{b:/"""/,e:/"""/,c:[l.BE,j]},{b:/"/,e:/"/,c:[l.BE,j]}]},{cN:"regexp",v:[{b:"///",e:"///",c:[j,l.HCM]},{b:"//[gim]*",r:0},{b:"/\\S(\\\\.|[^\\n])*?/[gim]*(?=\\s|\\W|$)"}]},{cN:"property",b:"@"+h},{b:"`",e:"`",eB:true,eE:true,sL:"javascript"}];j.c=k;return{k:g,c:k.concat([{cN:"comment",b:"###",e:"###"},l.HCM,{cN:"function",b:"("+h+"\\s*=\\s*)?(\\(.*\\))?\\s*\\B[-=]>",e:"[-=]>",rB:true,c:[i,{cN:"params",b:"\\(",rB:true,c:[{b:/\(/,e:/\)/,k:g,c:["self"].concat(k)}]}]},{cN:"class",bK:"class",e:"$",i:/[:="\[\]]/,c:[{bK:"extends",eW:true,i:/[:="\[\]]/,c:[i]},i]},{cN:"attribute",b:h+":",e:":",rB:true,eE:true,r:0}])}});hljs.registerLanguage("nginx",function(f){var d={cN:"variable",v:[{b:/\$\d+/},{b:/\$\{/,e:/}/},{b:"[\\$\\@]"+f.UIR}]};var e={eW:true,l:"[a-z/_]+",k:{built_in:"on off yes no true false none blocked debug info notice warn error crit select break last permanent redirect kqueue rtsig epoll poll /dev/poll"},r:0,i:"=>",c:[f.HCM,{cN:"string",c:[f.BE,d],v:[{b:/"/,e:/"/},{b:/'/,e:/'/}]},{cN:"url",b:"([a-z]+):/",e:"\\s",eW:true,eE:true},{cN:"regexp",c:[f.BE,d],v:[{b:"\\s\\^",e:"\\s|{|;",rE:true},{b:"~\\*?\\s+",e:"\\s|{|;",rE:true},{b:"\\*(\\.[a-z\\-]+)+"},{b:"([a-z\\-]+\\.)+\\*"}]},{cN:"number",b:"\\b\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}(:\\d{1,5})?\\b"},{cN:"number",b:"\\b\\d+[kKmMgGdshdwy]*\\b",r:0},d]};return{c:[f.HCM,{b:f.UIR+"\\s",e:";|{",rB:true,c:[f.inherit(f.UTM,{starts:e})],r:0}],i:"[^\\s\\}]"}});hljs.registerLanguage("json",function(h){var j={literal:"true false null"};var k=[h.QSM,h.CNM];var l={cN:"value",e:",",eW:true,eE:true,c:k,k:j};var g={b:"{",e:"}",c:[{cN:"attribute",b:'\\s*"',e:'"\\s*:\\s*',eB:true,eE:true,c:[h.BE],i:"\\n",starts:l}],i:"\\S"};var i={b:"\\[",e:"\\]",c:[h.inherit(l,{cN:null})],i:"\\S"};k.splice(k.length,0,g,i);return{c:k,k:j,i:"\\S"}});hljs.registerLanguage("apache",function(d){var c={cN:"number",b:"[\\$%]\\d+"};return{cI:true,c:[d.HCM,{cN:"tag",b:"</?",e:">"},{cN:"keyword",b:/\w+/,r:0,k:{common:"order deny allow setenv rewriterule rewriteengine rewritecond documentroot sethandler errordocument loadmodule options header listen serverroot servername"},starts:{e:/$/,r:0,k:{literal:"on off all"},c:[{cN:"sqbracket",b:"\\s\\[",e:"\\]$"},{cN:"cbracket",b:"[\\$%]\\{",e:"\\}",c:["self",c]},c,d.QSM]}}],i:/\S/}});hljs.registerLanguage("cpp",function(d){var c={keyword:"false int float while private char catch export virtual operator sizeof dynamic_cast|10 typedef const_cast|10 const struct for static_cast|10 union namespace unsigned long throw volatile static protected bool template mutable if public friend do return goto auto void enum else break new extern using true class asm case typeid short reinterpret_cast|10 default double register explicit signed typename try this switch continue wchar_t inline delete alignof char16_t char32_t constexpr decltype noexcept nullptr static_assert thread_local restrict _Bool complex _Complex _Imaginary",built_in:"std string cin cout cerr clog stringstream istringstream ostringstream auto_ptr deque list queue stack vector map set bitset multiset multimap unordered_set unordered_map unordered_multiset unordered_multimap array shared_ptr abort abs acos asin atan2 atan calloc ceil cosh cos exit exp fabs floor fmod fprintf fputs free frexp fscanf isalnum isalpha iscntrl isdigit isgraph islower isprint ispunct isspace isupper isxdigit tolower toupper labs ldexp log10 log malloc memchr memcmp memcpy memset modf pow printf putchar puts scanf sinh sin snprintf sprintf sqrt sscanf strcat strchr strcmp strcpy strcspn strlen strncat strncmp strncpy strpbrk strrchr strspn strstr tanh tan vfprintf vprintf vsprintf"};return{aliases:["c"],k:c,i:"</",c:[d.CLCM,d.CBLCLM,d.QSM,{cN:"string",b:"'\\\\?.",e:"'",i:"."},{cN:"number",b:"\\b(\\d+(\\.\\d*)?|\\.\\d+)(u|U|l|L|ul|UL|f|F)"},d.CNM,{cN:"preprocessor",b:"#",e:"$",c:[{b:"include\\s*<",e:">",i:"\\n"},d.CLCM]},{cN:"stl_container",b:"\\b(deque|list|queue|stack|vector|map|set|bitset|multiset|multimap|unordered_map|unordered_set|unordered_multiset|unordered_multimap|array)\\s*<",e:">",k:c,r:10,c:["self"]}]}});hljs.registerLanguage("makefile",function(d){var c={cN:"variable",b:/\$\(/,e:/\)/,c:[d.BE]};return{c:[d.HCM,{b:/^\w+\s*\W*=/,rB:true,r:0,starts:{cN:"constant",e:/\s*\W*=/,eE:true,starts:{e:/$/,r:0,c:[c],}}},{cN:"title",b:/^[\w]+:\s*$/},{cN:"phony",b:/^\.PHONY:/,e:/$/,k:".PHONY",l:/[\.\w]+/},{b:/^\t+/,e:/$/,c:[d.QSM,c]}]}});