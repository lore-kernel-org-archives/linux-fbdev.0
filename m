From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 12/20] cirrusfb: remove typedefs
Date: Sun, 26 Aug 2007 22:05:45 +0800
Message-ID: <46D188B9.9070507@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPJ2A-0005HX-GH for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:24:10 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IPJ2A-0001kW-1Z
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:24:10 -0700
Received: by py-out-1112.google.com with SMTP id a25so368516pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 26 Aug 2007 07:24:09 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch replaces "typedef enum" with "enum type" constructs.
Using the typedef is error for the checkpatch.pl script.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/cirrusfb.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 4c97c1d..3f18452 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -110,7 +110,7 @@ #define MAX_NUM_BOARDS 7
  */
 
 /* board types */
-typedef enum {
+enum cirrus_board {
 	BT_NONE = 0,
 	BT_SD64,
 	BT_PICCOLO,
@@ -120,12 +120,12 @@ typedef enum {
 	BT_ALPINE,	/* GD543x/4x */
 	BT_GD5480,
 	BT_LAGUNA,	/* GD546x */
-} cirrusfb_board_t;
+};
 
 /*
  * per-board-type information, used for enumerating and abstracting
  * chip-specific information
- * NOTE: MUST be in the same order as cirrusfb_board_t in order to
+ * NOTE: MUST be in the same order as enum cirrus_board in order to
  * use direct indexing on this array
  * NOTE: '__initdata' cannot be used as some of this info
  * is required at runtime.  Maybe separate into an init-only and
@@ -361,10 +361,10 @@ struct cirrusfb_regs {
 };
 
 #ifdef CIRRUSFB_DEBUG
-typedef enum {
+enum cirrusfb_dbg_reg_class {
 	CRT,
 	SEQ
-} cirrusfb_dbg_reg_class_t;
+};
 #endif		/* CIRRUSFB_DEBUG */
 
 /* info about board */
@@ -375,7 +375,7 @@ struct cirrusfb_info {
 	u8 __iomem *regbase;
 	u8 __iomem *mem;
 	unsigned long size;
-	cirrusfb_board_t btype;
+	enum cirrus_board btype;
 	unsigned char SFR;	/* Shadow of special function register */
 
 	unsigned long fbmem_phys;
@@ -571,7 +571,7 @@ #ifdef CIRRUSFB_DEBUG
 static void cirrusfb_dump(void);
 static void cirrusfb_dbg_reg_dump(caddr_t regbase);
 static void cirrusfb_dbg_print_regs(caddr_t regbase,
-				    cirrusfb_dbg_reg_class_t reg_class, ...);
+				    enum cirrusfb_dbg_reg_class reg_class, ...);
 static void cirrusfb_dbg_print_byte(const char *name, unsigned char val);
 #endif /* CIRRUSFB_DEBUG */
 
@@ -2449,7 +2449,7 @@ static int cirrusfb_register(struct cirr
 {
 	struct fb_info *info;
 	int err;
-	cirrusfb_board_t btype;
+	enum cirrus_board btype;
 
 	DPRINTK("ENTER\n");
 
@@ -2517,7 +2517,7 @@ static int cirrusfb_pci_register(struct 
 {
 	struct cirrusfb_info *cinfo;
 	struct fb_info *info;
-	cirrusfb_board_t btype;
+	enum cirrus_board btype;
 	unsigned long board_addr, board_size;
 	int ret;
 
@@ -2537,11 +2537,11 @@ static int cirrusfb_pci_register(struct 
 	cinfo = info->par;
 	cinfo->info = info;
 	cinfo->pdev = pdev;
-	cinfo->btype = btype = (cirrusfb_board_t) ent->driver_data;
+	cinfo->btype = btype = (enum cirrus_board) ent->driver_data;
 
-	DPRINTK(" Found PCI device, base address 0 is 0x%lx, btype set to %d\n",
+	DPRINTK(" Found PCI device, base address 0 is 0x%x, btype set to %d\n",
 		pdev->resource[0].start, btype);
-	DPRINTK(" base address 1 is 0x%lx\n", pdev->resource[1].start);
+	DPRINTK(" base address 1 is 0x%x\n", pdev->resource[1].start);
 
 	if (isPReP) {
 		pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0, 0x00000000);
@@ -2647,7 +2647,7 @@ static int cirrusfb_zorro_register(struc
 {
 	struct cirrusfb_info *cinfo;
 	struct fb_info *info;
-	cirrusfb_board_t btype;
+	enum cirrus_board btype;
 	struct zorro_dev *z2 = NULL;
 	unsigned long board_addr, board_size, size;
 	int ret;
@@ -3353,7 +3353,7 @@ void cirrusfb_dbg_print_byte(const char 
 
 static
 void cirrusfb_dbg_print_regs(caddr_t regbase,
-			     cirrusfb_dbg_reg_class_t reg_class, ...)
+			     enum cirrusfb_dbg_reg_class reg_class, ...)
 {
 	va_list list;
 	unsigned char val = 0;


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
