.assembly extern mscorlib{} // using external assembly mscorlib
.assembly Arith{} // this is a new Arith assembly
.module Arith.exe // its output module will be Arith.exe

.class public Arith // define a new class
{
    // this is the default constructor "ctor" = constructor
    .method public specialname void .ctor()
    {
        ret
    }
    .method public float32 Add(float32, float32)
    {
        ldarg.1 // push/load argument by position, i'm guessing 0th is 'this'
        ldarg.2
        add // pop pop add push
        ret // pop return 
    }
}

.class Test.Program
extends [mscorlib]System.Object
{
    .method static void Main(string[] args)
    cil managed
    {
        .entrypoint // begin program execution
        newobj instance void Arith::.ctor() // instantiate a Arith with default constructor
        ldc.r4 0.1 // load a value
        ldc.r4 0.2
        call instance float32 // get the instance from the stack
        Arith::Add(float32, float32) // the instance is passed in as an implicit 0th arg as "this" for instance methods
                                     // calling this method pushes its return value to the stack
        call void [mscorlib]System.Console::WriteLine(float32)
        ret
    }
}