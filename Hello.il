.assembly extern mscorlib {}  // we're using the mscorelib assembly, link it
.assembly Hello {} // give our program a new assembly name, hello
.module Hello.exe // giving our program an assembly name lets it be run, this is the output module declaration (maybe?)

.class Hello.Program // declare a class
extends [mscorlib]System.Object // it inherits from object
{
    .method static void Main(string[] args) // declare a method
    cil managed // declare that it is managed by the common intermediate language
    {
        .entrypoint // this declares where the program as a whole should begin execution
        ldstr "Hello World" // push/load this string to the execution stack
        call void [mscorlib]System.Console:: // invoke the method from mscorelib, it does not return anything to the stack
            WriteLine(string) // it pops one value from the stack, which should be a string
        
        // add two ints
        ldc.i4 0x01 // push/load a constant, i4 = 4 byte int32
        ldc.i4 0x02 // push/load a second int32
        add // pop 2 values and add them, pushing result to the stack
        call void [mscorlib]System.Console:: // call another void method in mscorlib
            WriteLine(int32) // pop the stack value, which should be int32 & give to the method arg
        
        // add two floats
        ldc.r4 0.1 // load/push a 4 byte float (r4)
        ldc.r4 0.2 
        add

        // local variables
        .locals init(float32 Total) // declare a float32 variable "Total"
            // init means the variable must be initialized b4 use
        stloc Total // pop value and store to the "Total" local var
                    // recall that the last popped value was the float sum
        ldloc Total // read the value from the "Total" var and push it to the stack

        call void [mscorlib]System.Console::
            WriteLine(float32) // pop and use the last value, which came from "Total"

        // unnamed local variables stuck in an array
        // note that it appears that the first local was implicitly put in index [0]
        .locals init([1] float32 Total2 )
        ldc.r4 0.3
        ldc.r4 0.4
        add
        stloc.1

        // different syntax to load the local variable
        ldloc.1
        call void [mscorlib]System.Console::WriteLine(float32)
        ldloc 1
        call void [mscorlib]System.Console::WriteLine(float32)
        ldloc Total2
        call void [mscorlib]System.Console::WriteLine(float32)

        ret // complete the method execution, ending the program
    }
}