From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 12 Sep 2016 20:34:19 +0000
Subject: [GIT PULL] CLCD graphics for the Nomadik NHK15
Message-Id: <CACRpkdZH+aFe-PSR-vmEVNJgKZ5nTgiUJroyhdYfVweQFh0s9A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi ARM SoC folks,

this adds CLCD graphics to the Nomadik NHK15 following
Tomi's merge of the required FBDEV changes.

It is all device tree changes except for a oneliner selecting
MFD_SYSCON from the Nomadik Kconfig, as there are
no other Nomadik changes pending and nothing else
should be changing the Nomadik, and since it is pretty
much in context with the DTS changes, I chose to include
it here.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/clcd-nomadik

for you to fetch changes up to 17470b7da11c137267c74ff0d2d4cca56f595c60:

  ARM: dts: add the CLCD LCD display to the NHK15 (2016-09-09 23:16:07 +0200)

----------------------------------------------------------------
CLCD graphics on the Nomadik NHK15

----------------------------------------------------------------
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
 create mode 100644
Documentation/devicetree/bindings/display/panel/tpo,tpg110.txt
