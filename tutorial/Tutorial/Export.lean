import Export
open Lean

def exportDeclsFromEnv (env : Lean.Environment) (constants : Array Name) : IO Unit := do
  initSearchPath (← findSysroot)
  M.run env do
    initState env
    dumpMetadata
    for c in constants do
      modify (fun st => { st with noMDataExprs := {} })
      let _ ← dumpConstant c
