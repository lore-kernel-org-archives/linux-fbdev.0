From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 09 Sep 2016 21:25:29 +0000
Subject: [PATCH 0/6] Enable Nomadik NHK15 graphics
Message-Id: <1473456335-22767-1-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

As all other pieces have been merged into the PWM and fbdev
subsystems, we can turn on graphics on the Nomadik NHK15
board.

Tested and works like a charm with boot penguin, console if
desired and fbsplash. Even blanks the screen properly to save
energy.

The missing DT bindings should probably have been merged in
the fbdev tree, but it doesn't matter where they are merged
so I plan to send this whole series as a pull request to
ARM SoC. The only non-DT change is the Kconfig change to
select MFD_SYSCON.

Linus Walleij (6):
  ARM: dts: add STMPE PWM to the NHK15 device tree
  dt-bindings: add vendor TPO
  dt-bindings: Add TPO TPG110 binding
  ARM: nomadik: select MFD_SYSCON
  ARM: dts: add PMU to the NHK15 device tree
  ARM: dts: add the CLCD LCD display to the NHK15

 .../bindings/display/panel/tpo,tpg110.txt          | 47 +++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/boot/dts/ste-nomadik-nhk15.dts            | 68 ++++++++++++++++++++++
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         | 28 +++++++++
 arch/arm/mach-nomadik/Kconfig                      |  1 +
 5 files changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/tpo,tpg110.txt

-- 
2.7.4

