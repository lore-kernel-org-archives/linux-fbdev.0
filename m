From: "Shah, Yash (Y.)" <yshah1@visteon.com>
Date: Fri, 14 Aug 2015 06:06:13 +0000
Subject: [PATCH] Staging: sm750fb: Fix "foo* bar" should be "foo *bar" errors
Message-Id: <20150814060512.GA671@ubuntu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "teddy.wang@siliconmotion.com" <teddy.wang@siliconmotion.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Babu, Viswanathan (V.)" <vbabu3@visteon.com>

From: Yash Shah <yshah1@visteon.com>

Fix "foo* bar" should be "foo *bar" errors as detected by
checkpatch.pl

Signed-off-by: Yash Shah <yshah1@visteon.com>
---
 drivers/staging/sm750fb/sm750.h        | 14 +++++++-------
 drivers/staging/sm750fb/sm750_cursor.c |  4 ++--
 drivers/staging/sm750fb/sm750_cursor.h |  4 ++--
 drivers/staging/sm750fb/sm750_hw.h     |  6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 9b101a9..5bc4455 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -16,9 +16,9 @@ extern int smi_indent;
 
 struct lynx_accel {
 	/* base virtual address of DPR registers */
-	volatile unsigned char __iomem * dprBase;
+	volatile unsigned char __iomem *dprBase;
 	/* base virtual address of de data port */
-	volatile unsigned char __iomem * dpPortBase;
+	volatile unsigned char __iomem *dpPortBase;
 
 	/* function fointers */
 	void (*de_init)(struct lynx_accel *);
@@ -64,8 +64,8 @@ struct lynx_share {
 	/* locks*/
 	spinlock_t slock;
 	/* function pointers */
-	void (*suspend)(struct lynx_share*);
-	void (*resume)(struct lynx_share*);
+	void (*suspend)(struct lynx_share *);
+	void (*resume)(struct lynx_share *);
 };
 
 struct lynx_cursor {
@@ -80,7 +80,7 @@ struct lynx_cursor {
 	char __iomem *vstart;
 	int offset;
 	/* mmio addr of hw cursor */
-	volatile char __iomem * mmio;
+	volatile char __iomem *mmio;
 	/* the lynx_share of this adaptor */
 	struct lynx_share *share;
 	/* proc_routines */
@@ -114,7 +114,7 @@ struct lynxfb_crtc {
 
 	int (*proc_checkMode)(struct lynxfb_crtc*, struct fb_var_screeninfo*);
 	int (*proc_setColReg)(struct lynxfb_crtc*, ushort, ushort, ushort, ushort);
-	void (*clear)(struct lynxfb_crtc*);
+	void (*clear)(struct lynxfb_crtc *);
 	/* pan display */
 	int (*proc_panDisplay)(struct lynxfb_crtc *,
 			       const struct fb_var_screeninfo *,
@@ -146,7 +146,7 @@ struct lynxfb_output {
 
 	int (*proc_checkMode)(struct lynxfb_output*, struct fb_var_screeninfo*);
 	int (*proc_setBLANK)(struct lynxfb_output*, int);
-	void  (*clear)(struct lynxfb_output*);
+	void  (*clear)(struct lynxfb_output *);
 };
 
 struct lynxfb_par {
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 2400c6c..a94a4bb 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -95,7 +95,7 @@ void hw_cursor_setColor(struct lynx_cursor *cursor,
 }
 
 void hw_cursor_setData(struct lynx_cursor *cursor,
-			u16 rop, const u8* pcol, const u8* pmsk)
+			u16 rop, const u8 *pcol, const u8 *pmsk)
 {
 	int i, j, count, pitch, offset;
 	u8 color, mask, opr;
@@ -184,7 +184,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 
 
 void hw_cursor_setData2(struct lynx_cursor *cursor,
-			u16 rop, const u8* pcol, const u8* pmsk)
+			u16 rop, const u8 *pcol, const u8 *pmsk)
 {
 	int i, j, count, pitch, offset;
 	u8 color, mask;
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index e1716a6..6c4fc9b 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -11,7 +11,7 @@ void hw_cursor_setPos(struct lynx_cursor *cursor,
 void hw_cursor_setColor(struct lynx_cursor *cursor,
 						u32 fg, u32 bg);
 void hw_cursor_setData(struct lynx_cursor *cursor,
-			u16 rop, const u8* data, const u8* mask);
+			u16 rop, const u8 *data, const u8 *mask);
 void hw_cursor_setData2(struct lynx_cursor *cursor,
-			u16 rop, const u8* data, const u8* mask);
+			u16 rop, const u8 *data, const u8 *mask);
 #endif
diff --git a/drivers/staging/sm750fb/sm750_hw.h b/drivers/staging/sm750fb/sm750_hw.h
index ef0a16f..3781a1a 100644
--- a/drivers/staging/sm750fb/sm750_hw.h
+++ b/drivers/staging/sm750fb/sm750_hw.h
@@ -78,7 +78,7 @@ struct sm750_share {
 	*/
 };
 
-int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev);
+int hw_sm750_map(struct lynx_share *share, struct pci_dev *pdev);
 int hw_sm750_inithw(struct lynx_share*, struct pci_dev *);
 void hw_sm750_initAccel(struct lynx_share *);
 int hw_sm750_deWait(void);
@@ -92,8 +92,8 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc*, struct fb_var_screeninfo*, struct
 int hw_sm750_setColReg(struct lynxfb_crtc*, ushort, ushort, ushort, ushort);
 int hw_sm750_setBLANK(struct lynxfb_output*, int);
 int hw_sm750le_setBLANK(struct lynxfb_output*, int);
-void hw_sm750_crtc_clear(struct lynxfb_crtc*);
-void hw_sm750_output_clear(struct lynxfb_output*);
+void hw_sm750_crtc_clear(struct lynxfb_crtc *);
+void hw_sm750_output_clear(struct lynxfb_output *);
 int hw_sm750_pan_display(struct lynxfb_crtc *crtc,
 			 const struct fb_var_screeninfo *var,
 			 const struct fb_info *info);
-- 
1.9.1
