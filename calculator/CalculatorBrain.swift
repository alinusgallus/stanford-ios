//
//  CalculatorBrain.swift
//  calculator
//
//  Created by Alain Gall on 7/17/15.
//  Copyright (c) 2015 Alain Gall. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    enum Op: Printable
    {
        case Operand (Double)
        case UnaryOperation (String, Double -> Double)
        case BinaryOperation (String, (Double, Double) ->Double)
        
        var description: String{
            get {
                switch self{
                case .Operand(let operand):
                    return ("\(operand)")
                case .UnaryOperation(let symbol, _):
                    return ("\(symbol)")
                case .BinaryOperation(let symbol, _):
                    return ("\(symbol)")
                }
            }
        }
    }
    
    var opStack = [Op]()
    
    var knownOps = [String:Op]()
    
    init() {
        func learnOp(op: Op){
            knownOps[op.description] = op
        }
        
        learnOp(Op.BinaryOperation("+",+))
        learnOp(Op.BinaryOperation("×",*))
        learnOp(Op.BinaryOperation("÷",{$1 / $0}))
        learnOp(Op.BinaryOperation("−", {$1 - $0}))
        learnOp(Op.UnaryOperation("√",sqrt))
        learnOp(Op.UnaryOperation("sin", sin))
        learnOp(Op.UnaryOperation("cos", cos))
        
        
        //learnOp(Op.UnaryOperation("π",M_PI))
        
        
        //refactored
        //knownOps["÷"] = Op.BinaryOperation("÷"){$1 / $0}
        //knownOps["−"] = Op.BinaryOperation("−")
        //knownOps["√"] = Op.UnaryOperation("√" , sqrt)
        //knownOps["sin"] = Op.UnaryOperation("sin"){sin($0)}
        //knownOps["cos"] = Op.UnaryOperation("cos"){cos($0)}
    }
    
    func pushOnStack (operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation (symbol:String) -> Double?{
        if let operation = knownOps[symbol]{
        opStack.append(operation)
        }
        return evaluate()
        
    }
    
    func evaluate (ops: [Op]) -> (result: Double?,remainingOps: [Op]){
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            println("\(op)")
            switch op{
            case .Operand(let operand):
                return (operand,remainingOps)
            case .UnaryOperation( _ , let operation):
                var operandEvaluation = evaluate( remainingOps)
                if let operand = operandEvaluation.result{
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_,let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let op1 = op1Evaluation.result {
                    
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    
                    if let op2 = op2Evaluation.result {
                        println("\(op1) and \(op2)")
                        return (operation(op1,op2), op2Evaluation.remainingOps)
                        
                    }
                }
            }
          
        }
        return (nil,ops)
        
    }
    
    func empty(){
        opStack.removeAll(keepCapacity: false)
    }
    
    func evaluate() -> Double {
        let (result,remainder) = evaluate(opStack)
        if let returnValue = result{
            return returnValue
        }
        return 0
        
    }

}