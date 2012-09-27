From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 27 Sep 2012 08:06:37 +0000
Subject: [PATCH 1/7] video: s3c-fb: clean the bit definition for WINCON register
Message-Id: <000901cd9c87$04ca7eb0$0e5f7c10$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch cleans the bit definition for WINCON register.
The bit definition for WINCON1 and WINCON2 is removed, because
it is not used.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 include/video/samsung_fimd.h |   76 +++++++----------------------------------
 1 files changed, 13 insertions(+), 63 deletions(-)

diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index 7ae6c07..bd0a04e 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -173,18 +173,27 @@
 
 /* WINCONx */
 
-
+#define WINCON(_win)				(0x20 + ((_win) * 4))
+#define WINCONx_CSCWIDTH_MASK			(0x3 << 26)
+#define WINCONx_CSCWIDTH_SHIFT			(26)
+#define WINCONx_CSCWIDTH_WIDE			(0x0 << 26)
+#define WINCONx_CSCWIDTH_NARROW			(0x3 << 26)
+#define WINCONx_ENLOCAL				(1 << 22)
+#define WINCONx_BUFSTATUS			(1 << 21)
+#define WINCONx_BUFSEL				(1 << 20)
+#define WINCONx_BUFAUTOEN			(1 << 19)
 #define WINCONx_BITSWP				(1 << 18)
 #define WINCONx_BYTSWP				(1 << 17)
 #define WINCONx_HAWSWP				(1 << 16)
 #define WINCONx_WSWP				(1 << 15)
+#define WINCONx_YCbCr				(1 << 13)
 #define WINCONx_BURSTLEN_MASK			(0x3 << 9)
 #define WINCONx_BURSTLEN_SHIFT			(9)
 #define WINCONx_BURSTLEN_16WORD			(0x0 << 9)
 #define WINCONx_BURSTLEN_8WORD			(0x1 << 9)
 #define WINCONx_BURSTLEN_4WORD			(0x2 << 9)
-
 #define WINCONx_ENWIN				(1 << 0)
+
 #define WINCON0_BPPMODE_MASK			(0xf << 2)
 #define WINCON0_BPPMODE_SHIFT			(2)
 #define WINCON0_BPPMODE_1BPP			(0x0 << 2)
@@ -196,9 +205,8 @@
 #define WINCON0_BPPMODE_18BPP_666		(0x8 << 2)
 #define WINCON0_BPPMODE_24BPP_888		(0xb << 2)
 
+#define WINCON1_LOCALSEL_CAMIF			(1 << 23)
 #define WINCON1_BLD_PIX				(1 << 6)
-
-#define WINCON1_ALPHA_SEL			(1 << 1)
 #define WINCON1_BPPMODE_MASK			(0xf << 2)
 #define WINCON1_BPPMODE_SHIFT			(2)
 #define WINCON1_BPPMODE_1BPP			(0x0 << 2)
@@ -216,6 +224,7 @@
 #define WINCON1_BPPMODE_24BPP_A1887		(0xc << 2)
 #define WINCON1_BPPMODE_25BPP_A1888		(0xd << 2)
 #define WINCON1_BPPMODE_28BPP_A4888		(0xd << 2)
+#define WINCON1_ALPHA_SEL			(1 << 1)
 
 /* S5PV210 */
 #define SHADOWCON				(0x34)
@@ -401,71 +410,12 @@
 #define VIDTCON1				(0x14)
 #define VIDTCON2				(0x18)
 
-/* Window position controls */
-
-#define WINCON(_win)				(0x20 + ((_win) * 4))
-
 /* OSD1 and OSD4 do not have register D */
 
 #define VIDOSD_BASE				(0x40)
 
 #define VIDINTCON0				(0x130)
 
-/* WINCONx */
-
-#define WINCONx_CSCWIDTH_MASK			(0x3 << 26)
-#define WINCONx_CSCWIDTH_SHIFT			(26)
-#define WINCONx_CSCWIDTH_WIDE			(0x0 << 26)
-#define WINCONx_CSCWIDTH_NARROW			(0x3 << 26)
-
-#define WINCONx_ENLOCAL				(1 << 22)
-#define WINCONx_BUFSTATUS			(1 << 21)
-#define WINCONx_BUFSEL				(1 << 20)
-#define WINCONx_BUFAUTOEN			(1 << 19)
-#define WINCONx_YCbCr				(1 << 13)
-
-#define WINCON1_LOCALSEL_CAMIF			(1 << 23)
-
-#define WINCON2_LOCALSEL_CAMIF			(1 << 23)
-#define WINCON2_BLD_PIX				(1 << 6)
-
-#define WINCON2_ALPHA_SEL			(1 << 1)
-#define WINCON2_BPPMODE_MASK			(0xf << 2)
-#define WINCON2_BPPMODE_SHIFT			(2)
-#define WINCON2_BPPMODE_1BPP			(0x0 << 2)
-#define WINCON2_BPPMODE_2BPP			(0x1 << 2)
-#define WINCON2_BPPMODE_4BPP			(0x2 << 2)
-#define WINCON2_BPPMODE_8BPP_1232		(0x4 << 2)
-#define WINCON2_BPPMODE_16BPP_565		(0x5 << 2)
-#define WINCON2_BPPMODE_16BPP_A1555		(0x6 << 2)
-#define WINCON2_BPPMODE_16BPP_I1555		(0x7 << 2)
-#define WINCON2_BPPMODE_18BPP_666		(0x8 << 2)
-#define WINCON2_BPPMODE_18BPP_A1665		(0x9 << 2)
-#define WINCON2_BPPMODE_19BPP_A1666		(0xa << 2)
-#define WINCON2_BPPMODE_24BPP_888		(0xb << 2)
-#define WINCON2_BPPMODE_24BPP_A1887		(0xc << 2)
-#define WINCON2_BPPMODE_25BPP_A1888		(0xd << 2)
-#define WINCON2_BPPMODE_28BPP_A4888		(0xd << 2)
-
-#define WINCON3_BLD_PIX				(1 << 6)
-
-#define WINCON3_ALPHA_SEL			(1 << 1)
-#define WINCON3_BPPMODE_MASK			(0xf << 2)
-#define WINCON3_BPPMODE_SHIFT			(2)
-#define WINCON3_BPPMODE_1BPP			(0x0 << 2)
-#define WINCON3_BPPMODE_2BPP			(0x1 << 2)
-#define WINCON3_BPPMODE_4BPP			(0x2 << 2)
-#define WINCON3_BPPMODE_16BPP_565		(0x5 << 2)
-#define WINCON3_BPPMODE_16BPP_A1555		(0x6 << 2)
-#define WINCON3_BPPMODE_16BPP_I1555		(0x7 << 2)
-#define WINCON3_BPPMODE_18BPP_666		(0x8 << 2)
-#define WINCON3_BPPMODE_18BPP_A1665		(0x9 << 2)
-#define WINCON3_BPPMODE_19BPP_A1666		(0xa << 2)
-#define WINCON3_BPPMODE_24BPP_888		(0xb << 2)
-#define WINCON3_BPPMODE_24BPP_A1887		(0xc << 2)
-#define WINCON3_BPPMODE_25BPP_A1888		(0xd << 2)
-#define WINCON3_BPPMODE_28BPP_A4888		(0xd << 2)
-
 #define VIDINTCON0_FIFIOSEL_WINDOW2		(0x10 << 5)
 #define VIDINTCON0_FIFIOSEL_WINDOW3		(0x20 << 5)
 #define VIDINTCON0_FIFIOSEL_WINDOW4		(0x40 << 5)
-- 
1.7.1


