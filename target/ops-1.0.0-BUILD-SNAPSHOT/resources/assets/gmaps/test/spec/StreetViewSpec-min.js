describe("Create a Street View Panorama",function(){var a,d,c,b;beforeEach(function(){a=a||new GMaps({el:"#map-with-streetview",lat:42.3455,lng:-71.0983,zoom:12})});describe("Standalone",function(){beforeEach(function(){c=c||GMaps.createPanorama({el:"#streetview-standalone-panorama",lat:42.3455,lng:-71.0983,pov:{heading:60,pitch:-10,zoom:1}})});it("should create a Street View panorama",function(){expect(c).toBeDefined()})});describe("Attached to the current map",function(){beforeEach(function(){d=d||a.createPanorama({el:"#streetview-panorama",pov:{heading:60,pitch:-10,zoom:1}})});it("should be equal to the current map Street View panorama",function(){expect(a.getStreetView()).toEqual(d)})});describe("With events",function(){var e;beforeEach(function(){e={onpovchanged:function(){console.log(this)}};spyOn(e,"onpovchanged").andCallThrough();b=b||GMaps.createPanorama({el:"#streetview-with-events",lat:42.3455,lng:-71.0983,pov:{heading:60,pitch:-10,zoom:1},pov_changed:e.onpovchanged})});it("should respond to pov_changed event",function(){b.setPov({heading:80,pitch:-10,zoom:1});expect(e.onpovchanged).toHaveBeenCalled()})})});