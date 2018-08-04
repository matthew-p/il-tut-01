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

    .method public int32 AddTen(int32)
    {
        ldc.i4 10
        ldarg.1
        add
        ret
    }
}

.class Test.Program
extends [mscorlib]System.Object
{
    .method static void Main(string[] args)
    cil managed
    {
        .entrypoint // begin program execution
        .locals(class Arith myArith) // allocate heap memory for a local instance of Arith called myArith
        newobj instance void Arith::.ctor() // instantiate a Arith with default constructor
        stloc myArith // store the instance pointer, which pops it
        ldloc myArith // reload the instance pointer
        // recall that reference type instances are stored on the heap, and only pointers can be stored on the stack
        // thus why we have to keep pushing/popping the reference to an instance to work with it
        ldc.r4 0.1 // load a value
        ldc.r4 0.2
        call instance float32 // get the instance from the stack
        Arith::Add(float32, float32) // the instance is passed in as an implicit 0th arg as "this" for instance methods
                                         // calling this method pushes its return value to the stack
        call void [mscorlib]System.Console::WriteLine(float32)
        
        // add ten
        ldloc myArith // reload the instance from the local var to the stack
        // if you don't do this it will create a null reference exception
        // because it will pop nothing, and pass this as the "this" value 
        // for the method
        ldc.i4 3
        call instance int32 Arith::AddTen(int32)
        call void [mscorlib]System.Console::WriteLine(int32)
        
        ret
    }
}