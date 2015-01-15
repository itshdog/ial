module nat-division2 where

open import bool
open import bool-thms
open import eq
open import neq
open import nat
open import nat-thms
open import product
open import product-thms
open import sum

{- a div-result for dividend x and divisor d consists of the quotient q, remainder r, and a proof that q * d + r = x -}
div-result : ℕ → ℕ → Set 
div-result x d = Σ ℕ (λ q → Σ ℕ (λ r → q * d + r ≡ x))

divh : (n : ℕ) → (x : ℕ) → (y : ℕ) → x ≤ n ≡ tt → y =ℕ 0 ≡ ff → div-result x y
divh 0 0 y p1 p2 = 0 , 0 , refl
divh 0 (suc x) y () p2 
divh (suc n) x y p1 p2 with keep (x < y)
divh (suc n) x y p1 p2 | tt , pl = 0 , x , refl
divh (suc n) x y p1 p2 | ff , pl with divh n (x ∸ y) y (∸≤2 n x y p1 p2) p2
divh (suc n) x y p1 p2 | ff , pl | q , r , p = suc q , r , lem{q}{r} p
  where lem : ∀{q r} → q * y + r ≡ x ∸ y → y + q * y + r ≡ x
        lem{q}{r} p rewrite sym (+assoc y (q * y) r) | p | +comm y (x ∸ y) = ∸+2{x}{y} (<ff{x}{y} pl)

_÷_!_ : (x : ℕ) → (y : ℕ) → y =ℕ 0 ≡ ff → div-result x y 
x ÷ y ! p = divh x x y (≤-refl x) p 

