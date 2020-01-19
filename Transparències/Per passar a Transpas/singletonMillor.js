// Singleton JS millor manera

var Universe;

(
    function ()
    {
        var instance;
        
        Universe = function ()
        {
            if (instance) return instance;
 
            instance = this;
            
            // all the functionality
            this.start_time = 0;
            this.bang = "Big";
        };
    }
    ()
);

Universe.prototype.nothing = true;

var uni = new Universe();

Universe.prototype.everything = true;

var uni2 = new Universe();
