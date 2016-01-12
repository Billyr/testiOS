
//: MiniGame
// Guillermo Rangel

import UIKit

for k in 0...100 {
    
    if k%5 == 0 {
        print("\(k) Bingo!!!" )
    }
    
    if k%2 == 0 {
        print("\(k) Par!!!" )
    }

    if k%2 != 0 {
        print("\(k) Impar!!!" )
    }
    
    if k >= 30 && k <= 40 {
        print("\(k) Viva Swift!!!" )
    }

    
}
