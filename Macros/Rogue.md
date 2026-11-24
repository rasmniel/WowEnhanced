# Rogue

## Non-dagget Ambush

Equip a dagger, then Ambush and equip a non-dagger.
Useful for casting Ambush when not usually carrying a dagger.
NOTE: Must tap once to equip dagger, then once again to Ambush and equip non-dagger.
Will re-equip non-dagger, even if not Ambush did not cast.
```
#showtooltip Ambush
/equipslot 16 <Dagger>
/cast Ambush
/equipslot 16 <Non-Dagger>
```


## Pick Pocket

Easy and convenient Pick Pocket.
Automatically picks the nearest target to avoid mistargeted saps.
```
#showtooltip
/targetnearest
/cast Pick Pocket
```

Sap and Pick Pocket at the same time.
Also target nearest target, avoiding the necessity for tabbing between targets.
NOTE: Pick Pocket requires standing still and has only 5 yards range vs Sap with 10 yards.
```
#showtooltip
/targetnearest
/cast Sap
/cast Pick Pocket
```


## Poison

Apply poison to main-hand weapon (16) or off-hand weapon (17)

```
#showtooltip
/use <Poison>
/use <16/17>
```


## Non-dagger Ambush

Equip a dagger, then Ambush and equip a non-dagger.
Useful for casting Ambush when not usually carrying a dagger.
NOTE: Must tap once to equip dagger, then once again to Ambush and equip non-dagger.
Will re-equip non-dagger, even if not Ambush did not cast.
```
#showtooltip Ambush
/equipslot 16 <Dagger>
/cast Ambush
/equipslot 16 <Non-Dagger>
```

## Cooldowns

Cast Blade Flurry followed by Adrenaline Rush.
Useful for spamming CDs.
Can be mixed with cooldowns without GCD such as Blood Fury.
NOTE: Prefer to order CDs from lowest to highest cooldown.
Upon reset, earlier CDs in the sequence will block later, unused CDs.
```
/castsequence reset=2 Blade Flurry, Adrenaline Rush
/cast Blood Fury
```

