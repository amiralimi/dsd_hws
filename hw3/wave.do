onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider inputs
add wave -noupdate -radix decimal /arraymultipliertb/data_w
add wave -noupdate -radix unsigned /arraymultipliertb/x_t
add wave -noupdate -radix unsigned /arraymultipliertb/y_t
add wave -noupdate -divider output
add wave -noupdate -color Blue -radix unsigned -childformat {{/arraymultipliertb/p_t(9) -radix binary} {/arraymultipliertb/p_t(8) -radix binary} {/arraymultipliertb/p_t(7) -radix binary} {/arraymultipliertb/p_t(6) -radix binary} {/arraymultipliertb/p_t(5) -radix binary} {/arraymultipliertb/p_t(4) -radix binary} {/arraymultipliertb/p_t(3) -radix binary} {/arraymultipliertb/p_t(2) -radix binary} {/arraymultipliertb/p_t(1) -radix binary} {/arraymultipliertb/p_t(0) -radix binary}} -subitemconfig {/arraymultipliertb/p_t(9) {-color Blue -radix binary} /arraymultipliertb/p_t(8) {-color Blue -radix binary} /arraymultipliertb/p_t(7) {-color Blue -radix binary} /arraymultipliertb/p_t(6) {-color Blue -radix binary} /arraymultipliertb/p_t(5) {-color Blue -radix binary} /arraymultipliertb/p_t(4) {-color Blue -radix binary} /arraymultipliertb/p_t(3) {-color Blue -radix binary} /arraymultipliertb/p_t(2) {-color Blue -radix binary} /arraymultipliertb/p_t(1) {-color Blue -radix binary} /arraymultipliertb/p_t(0) {-color Blue -radix binary}} /arraymultipliertb/p_t
add wave -noupdate -divider {inner signals}
add wave -noupdate -color {Medium Orchid} -radix binary -childformat {{/arraymultipliertb/U1/and_results(0) -radix binary} {/arraymultipliertb/U1/and_results(1) -radix binary} {/arraymultipliertb/U1/and_results(2) -radix binary} {/arraymultipliertb/U1/and_results(3) -radix binary} {/arraymultipliertb/U1/and_results(4) -radix binary}} -subitemconfig {/arraymultipliertb/U1/and_results(0) {-color {Medium Orchid} -radix binary} /arraymultipliertb/U1/and_results(1) {-color {Medium Orchid} -radix binary} /arraymultipliertb/U1/and_results(2) {-color {Medium Orchid} -radix binary} /arraymultipliertb/U1/and_results(3) {-color {Medium Orchid} -radix binary} /arraymultipliertb/U1/and_results(4) {-color {Medium Orchid} -radix binary}} /arraymultipliertb/U1/and_results
add wave -noupdate -color {Medium Orchid} -radix binary -childformat {{/arraymultipliertb/U1/as(0) -radix binary -childformat {{/arraymultipliertb/U1/as(0)(0) -radix binary} {/arraymultipliertb/U1/as(0)(1) -radix binary} {/arraymultipliertb/U1/as(0)(2) -radix binary} {/arraymultipliertb/U1/as(0)(3) -radix binary}}} {/arraymultipliertb/U1/as(1) -radix binary} {/arraymultipliertb/U1/as(2) -radix binary} {/arraymultipliertb/U1/as(3) -radix binary} {/arraymultipliertb/U1/as(4) -radix binary}} -subitemconfig {/arraymultipliertb/U1/as(0) {-color {Medium Orchid} -height 15 -radix binary -childformat {{/arraymultipliertb/U1/as(0)(0) -radix binary} {/arraymultipliertb/U1/as(0)(1) -radix binary} {/arraymultipliertb/U1/as(0)(2) -radix binary} {/arraymultipliertb/U1/as(0)(3) -radix binary}}} /arraymultipliertb/U1/as(0)(0) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/as(0)(1) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/as(0)(2) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/as(0)(3) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/as(1) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/as(2) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/as(3) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/as(4) {-color {Medium Orchid} -height 15 -radix binary}} /arraymultipliertb/U1/as
add wave -noupdate -color {Medium Orchid} -radix binary -childformat {{/arraymultipliertb/U1/bs(0) -radix binary} {/arraymultipliertb/U1/bs(1) -radix binary} {/arraymultipliertb/U1/bs(2) -radix binary} {/arraymultipliertb/U1/bs(3) -radix binary} {/arraymultipliertb/U1/bs(4) -radix binary}} -subitemconfig {/arraymultipliertb/U1/bs(0) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/bs(1) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/bs(2) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/bs(3) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/bs(4) {-color {Medium Orchid} -height 15 -radix binary}} /arraymultipliertb/U1/bs
add wave -noupdate -color {Medium Orchid} -radix binary -childformat {{/arraymultipliertb/U1/cins(0) -radix binary} {/arraymultipliertb/U1/cins(1) -radix binary} {/arraymultipliertb/U1/cins(2) -radix binary} {/arraymultipliertb/U1/cins(3) -radix binary} {/arraymultipliertb/U1/cins(4) -radix binary}} -subitemconfig {/arraymultipliertb/U1/cins(0) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/cins(1) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/cins(2) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/cins(3) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/cins(4) {-color {Medium Orchid} -height 15 -radix binary}} /arraymultipliertb/U1/cins
add wave -noupdate -color {Medium Orchid} -radix binary -childformat {{/arraymultipliertb/U1/couts(0) -radix binary} {/arraymultipliertb/U1/couts(1) -radix binary} {/arraymultipliertb/U1/couts(2) -radix binary} {/arraymultipliertb/U1/couts(3) -radix binary} {/arraymultipliertb/U1/couts(4) -radix binary}} -subitemconfig {/arraymultipliertb/U1/couts(0) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/couts(1) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/couts(2) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/couts(3) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/couts(4) {-color {Medium Orchid} -height 15 -radix binary}} /arraymultipliertb/U1/couts
add wave -noupdate -color {Medium Orchid} -radix binary -childformat {{/arraymultipliertb/U1/sums(0) -radix binary} {/arraymultipliertb/U1/sums(1) -radix binary} {/arraymultipliertb/U1/sums(2) -radix binary} {/arraymultipliertb/U1/sums(3) -radix binary} {/arraymultipliertb/U1/sums(4) -radix binary}} -subitemconfig {/arraymultipliertb/U1/sums(0) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/sums(1) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/sums(2) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/sums(3) {-color {Medium Orchid} -height 15 -radix binary} /arraymultipliertb/U1/sums(4) {-color {Medium Orchid} -height 15 -radix binary}} /arraymultipliertb/U1/sums
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {31 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 296
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {72 ns}