From: Juston Li <juston.h.li@gmail.com>
Date: Wed, 24 Jun 2015 16:25:10 +0000
Subject: [PATCH v3 09/19] staging: sm750fb: add space after struct definition
Message-Id: <1435163120-3253-9-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F8Vgh93P5wmvDKcLCkiO2KkXQ14M1DXLhyeD6WTcH2RHg@mail.gmail.com>
In-Reply-To: <CAFow2F8Vgh93P5wmvDKcLCkiO2KkXQ14M1DXLhyeD6WTcH2RHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Cc: Juston Li <juston.h.li@gmail.com>

fixes checkpatch.pl warning:
WARNING: missing space after struct definition

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/sm750.h    | 12 ++++++------
 drivers/staging/sm750fb/sm750_hw.h |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 3785afc..124921e 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -14,7 +14,7 @@
 extern int smi_indent;
 
 
-struct lynx_accel{
+struct lynx_accel {
 	/* base virtual address of DPR registers */
 	volatile unsigned char __iomem * dprBase;
 	/* base virtual address of de data port */
@@ -41,7 +41,7 @@ struct lynx_accel{
 /* lynx_share stands for a presentation of two frame buffer
    that use one smi adaptor , it is similar to a basic class of C++
 */
-struct lynx_share{
+struct lynx_share {
 	/* common members */
 	u16 devid;
 	u8 revid;
@@ -68,7 +68,7 @@ struct lynx_share{
 	void (*resume)(struct lynx_share*);
 };
 
-struct lynx_cursor{
+struct lynx_cursor {
 	/* cursor width ,height and size */
 	int w;
 	int h;
@@ -92,7 +92,7 @@ struct lynx_cursor{
 	void (*setData)(struct lynx_cursor *, u16, const u8*, const u8*);
 };
 
-struct lynxfb_crtc{
+struct lynxfb_crtc {
 	unsigned char __iomem *vCursor; /* virtual address of cursor */
 	unsigned char __iomem *vScreen; /* virtual address of on_screen */
 	int oCursor; /* cursor address offset in vidmem */
@@ -123,7 +123,7 @@ struct lynxfb_crtc{
 	struct lynx_cursor cursor;
 };
 
-struct lynxfb_output{
+struct lynxfb_output {
 	int dpms;
 	int paths;
 	/* which paths(s) this output stands for,for sm750:
@@ -149,7 +149,7 @@ struct lynxfb_output{
 	void  (*clear)(struct lynxfb_output*);
 };
 
-struct lynxfb_par{
+struct lynxfb_par {
 	/* either 0 or 1 for dual head adaptor,0 is the older one registered */
 	int index;
 	unsigned int pseudo_palette[256];
diff --git a/drivers/staging/sm750fb/sm750_hw.h b/drivers/staging/sm750fb/sm750_hw.h
index af2db7c..ef0a16f 100644
--- a/drivers/staging/sm750fb/sm750_hw.h
+++ b/drivers/staging/sm750fb/sm750_hw.h
@@ -42,7 +42,7 @@ enum sm750_path {
 	sm750_pnc = 3,/* panel and crt */
 };
 
-struct init_status{
+struct init_status {
 	ushort powerMode;
 	/* below three clocks are in unit of MHZ*/
 	ushort chip_clk;
@@ -52,7 +52,7 @@ struct init_status{
 	ushort resetMemory;
 };
 
-struct sm750_state{
+struct sm750_state {
 	struct init_status initParm;
 	enum sm750_pnltype pnltype;
 	enum sm750_dataflow dataflow;
@@ -66,7 +66,7 @@ struct sm750_state{
    in C++
  */
 
-struct sm750_share{
+struct sm750_share {
 	/* it's better to put lynx_share struct to the first place of sm750_share */
 	struct lynx_share share;
 	struct sm750_state state;
-- 
2.4.4

