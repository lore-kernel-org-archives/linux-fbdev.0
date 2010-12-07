From: Heiko Schocher <hs@denx.de>
Date: Tue, 07 Dec 2010 06:59:20 +0000
Subject: [PATCH 2/2 v2] powerpc, video: add SM501 support for charon board.
Message-Id: <1291705160-26847-1-git-send-email-hs@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291451028-22532-2-git-send-email-hs@denx.de>
In-Reply-To: <1291451028-22532-2-git-send-email-hs-ynQEQJNshbs@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org

Signed-off-by: Heiko Schocher <hs@denx.de>
cc: linux-fbdev@vger.kernel.org
cc: devicetree-discuss@ozlabs.org
---
- based against 2.6.37-rc4

./scripts/checkpatch.pl 0003-powerpc-video-add-SM501-support-for-charon-board.patch
total: 0 errors, 0 warnings, 21 lines checked

0003-powerpc-video-add-SM501-support-for-charon-board.patch has no obvious style problems and is ready for submission.

- changes since v1:
  - no board specific defconfig file for mpc52xx based boards as suggested
    from Wolfram Sang

 arch/powerpc/boot/dts/charon.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/charon.dts b/arch/powerpc/boot/dts/charon.dts
index 9776889..d9af022 100644
--- a/arch/powerpc/boot/dts/charon.dts
+++ b/arch/powerpc/boot/dts/charon.dts
@@ -186,6 +186,7 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		ranges = <	0 0 0xfc000000 0x02000000
+				1 0 0xe0000000 0x04000000 // CS1 range, SM501
 				3 0 0xe8000000 0x00080000>;
 
 		flash@0,0 {
@@ -197,6 +198,14 @@
 			#address-cells = <1>;
 		};
 
+		display@1,0 {
+			compatible = "smi,sm501";
+			reg = <1 0x00000000 0x00800000
+			       1 0x03e00000 0x00200000>;
+			mode = "640x480-32@60";
+			interrupts = <1 1 3>;
+		};
+
 		mram0@3,0 {
 			compatible = "mtd-ram";
 			reg = <3 0x00000 0x80000>;
-- 
1.7.2.3

