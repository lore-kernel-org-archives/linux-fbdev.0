From: Afzal Mohammed <afzal@ti.com>
Date: Tue, 15 Jan 2013 13:49:57 +0000
Subject: [PATCH v2 0/5] ARM: dts: AM33XX: lcdc support
Message-Id: <cover.1358252955.git.afzal@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

This series add DT sources for AM335x SoC as well as AM335x based
boards.

As compared to previous version, in this version, comment has been
added in dt source file about pinmux details so that user can easily
correlate to that mentioned in TRM. Also author of one of the patch
was actually "Manjunathappa, Prakash", here in this series, authorship
has been made proper.

As pinmux is an SoC specific detail rather than IP specific one,
addition of pin control has been done in a separate patch from
the one in which display timings are added. Also it may aid in
debugging in case of any issues.

This has been tested on AM335x based boards like AM335x EVM and
AM335x EVM-SK.

This series is based on v3.8-rc3.

This series has a dependency on,
1. Series v16 "of: add display helper" by,
	Steffen Trumtrar <s.trumtrar@pengutronix.de>
2. Series v3 "video: da8xx-fb: runtime timing configuration" by,
	me (Afzal Mohammed <afzal@ti.com>)
3. Series v2 "video: da8xx-fb: DT support" by,
	me (Afzal Mohammed <afzal@ti.com>)

To test on AM335x, in addition to the above, following changes,
1. Patch "ARM: AM33XX: clock: SET_RATE_PARENT in lcd path" by,
	me (Afzal Mohammed <afzal@ti.com>)
2. Patch "da8xx: Allow use by am33xx based devices" by,
	Pantelis Antoniou <panto@antoniou-consulting.com>
3. Series "HWMOD fixes for AM33xx PWM submodules and device tree nodes" by,
	Philip, Avinash <avinashphilip@ti.com>
would be required

All above dependencies along with those required for testing is available
 @git://gitorious.org/x0148406-public/linux-kernel.git tags/da8xx-fb-dt-v3.8-rc3

Regards
Afzal

v2: add pinmux comment in dtsi files, correct authorship of one of the
    patch.

Afzal Mohammed (4):
  ARM: dts: AM33XX: Add lcdc node
  ARM: dts: AM33XX: Add am335x-evm lcdc panel timings
  ARM: dts: AM33XX: Add am335x-evmsk lcdc panel timings
  ARM: dts: AM33XX: Add am335x-evmsk lcdc pincontrol info

Manjunathappa, Prakash (1):
  ARM: dts: AM33XX: Add am335x-evm lcdc pincontrol info

 arch/arm/boot/dts/am335x-evm.dts   |   55 +++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/am335x-evmsk.dts |   55 +++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/am33xx.dtsi      |    8 ++++++
 3 files changed, 116 insertions(+), 2 deletions(-)

-- 
1.7.9.5

