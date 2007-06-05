From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/5] vt8623fb.c: make code static
Date: Tue, 05 Jun 2007 19:24:45 +0800
Message-ID: <466547FD.4090502@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HvXDq-00008R-T7 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Jun 2007 04:29:11 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HvXDq-0005wq-F0
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Jun 2007 04:29:10 -0700
Received: by py-out-1112.google.com with SMTP id u77so2968809pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 05 Jun 2007 04:29:10 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Ondrej Zajicek <santiago@mail.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Adrian Bunk <bunk@stusta.de>

From: Adrian Bunk <bunk@stusta.de>

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/vt8623fb.c |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 30c0b94..4c3a633 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -68,26 +68,26 @@ static const struct svga_pll vt8623_pll 
 
 /* CRT timing register sets */
 
-struct vga_regset vt8623_h_total_regs[]       = {{0x00, 0, 7}, {0x36, 3, 3}, VGA_REGSET_END};
-struct vga_regset vt8623_h_display_regs[]     = {{0x01, 0, 7}, VGA_REGSET_END};
-struct vga_regset vt8623_h_blank_start_regs[] = {{0x02, 0, 7}, VGA_REGSET_END};
-struct vga_regset vt8623_h_blank_end_regs[]   = {{0x03, 0, 4}, {0x05, 7, 7}, {0x33, 5, 5}, VGA_REGSET_END};
-struct vga_regset vt8623_h_sync_start_regs[]  = {{0x04, 0, 7}, {0x33, 4, 4}, VGA_REGSET_END};
-struct vga_regset vt8623_h_sync_end_regs[]    = {{0x05, 0, 4}, VGA_REGSET_END};
-
-struct vga_regset vt8623_v_total_regs[]       = {{0x06, 0, 7}, {0x07, 0, 0}, {0x07, 5, 5}, {0x35, 0, 0}, VGA_REGSET_END};
-struct vga_regset vt8623_v_display_regs[]     = {{0x12, 0, 7}, {0x07, 1, 1}, {0x07, 6, 6}, {0x35, 2, 2}, VGA_REGSET_END};
-struct vga_regset vt8623_v_blank_start_regs[] = {{0x15, 0, 7}, {0x07, 3, 3}, {0x09, 5, 5}, {0x35, 3, 3}, VGA_REGSET_END};
-struct vga_regset vt8623_v_blank_end_regs[]   = {{0x16, 0, 7}, VGA_REGSET_END};
-struct vga_regset vt8623_v_sync_start_regs[]  = {{0x10, 0, 7}, {0x07, 2, 2}, {0x07, 7, 7}, {0x35, 1, 1}, VGA_REGSET_END};
-struct vga_regset vt8623_v_sync_end_regs[]    = {{0x11, 0, 3}, VGA_REGSET_END};
-
-struct vga_regset vt8623_offset_regs[]        = {{0x13, 0, 7}, {0x35, 5, 7}, VGA_REGSET_END};
-struct vga_regset vt8623_line_compare_regs[]  = {{0x18, 0, 7}, {0x07, 4, 4}, {0x09, 6, 6}, {0x33, 0, 2}, {0x35, 4, 4}, VGA_REGSET_END};
-struct vga_regset vt8623_fetch_count_regs[]   = {{0x1C, 0, 7}, {0x1D, 0, 1}, VGA_REGSET_END};
-struct vga_regset vt8623_start_address_regs[] = {{0x0d, 0, 7}, {0x0c, 0, 7}, {0x34, 0, 7}, {0x48, 0, 1}, VGA_REGSET_END};
-
-struct svga_timing_regs vt8623_timing_regs     = {
+static struct vga_regset vt8623_h_total_regs[]       = {{0x00, 0, 7}, {0x36, 3, 3}, VGA_REGSET_END};
+static struct vga_regset vt8623_h_display_regs[]     = {{0x01, 0, 7}, VGA_REGSET_END};
+static struct vga_regset vt8623_h_blank_start_regs[] = {{0x02, 0, 7}, VGA_REGSET_END};
+static struct vga_regset vt8623_h_blank_end_regs[]   = {{0x03, 0, 4}, {0x05, 7, 7}, {0x33, 5, 5}, VGA_REGSET_END};
+static struct vga_regset vt8623_h_sync_start_regs[]  = {{0x04, 0, 7}, {0x33, 4, 4}, VGA_REGSET_END};
+static struct vga_regset vt8623_h_sync_end_regs[]    = {{0x05, 0, 4}, VGA_REGSET_END};
+
+static struct vga_regset vt8623_v_total_regs[]       = {{0x06, 0, 7}, {0x07, 0, 0}, {0x07, 5, 5}, {0x35, 0, 0}, VGA_REGSET_END};
+static struct vga_regset vt8623_v_display_regs[]     = {{0x12, 0, 7}, {0x07, 1, 1}, {0x07, 6, 6}, {0x35, 2, 2}, VGA_REGSET_END};
+static struct vga_regset vt8623_v_blank_start_regs[] = {{0x15, 0, 7}, {0x07, 3, 3}, {0x09, 5, 5}, {0x35, 3, 3}, VGA_REGSET_END};
+static struct vga_regset vt8623_v_blank_end_regs[]   = {{0x16, 0, 7}, VGA_REGSET_END};
+static struct vga_regset vt8623_v_sync_start_regs[]  = {{0x10, 0, 7}, {0x07, 2, 2}, {0x07, 7, 7}, {0x35, 1, 1}, VGA_REGSET_END};
+static struct vga_regset vt8623_v_sync_end_regs[]    = {{0x11, 0, 3}, VGA_REGSET_END};
+
+static struct vga_regset vt8623_offset_regs[]        = {{0x13, 0, 7}, {0x35, 5, 7}, VGA_REGSET_END};
+static struct vga_regset vt8623_line_compare_regs[]  = {{0x18, 0, 7}, {0x07, 4, 4}, {0x09, 6, 6}, {0x33, 0, 2}, {0x35, 4, 4}, VGA_REGSET_END};
+static struct vga_regset vt8623_fetch_count_regs[]   = {{0x1C, 0, 7}, {0x1D, 0, 1}, VGA_REGSET_END};
+static struct vga_regset vt8623_start_address_regs[] = {{0x0d, 0, 7}, {0x0c, 0, 7}, {0x34, 0, 7}, {0x48, 0, 1}, VGA_REGSET_END};
+
+static struct svga_timing_regs vt8623_timing_regs     = {
 	vt8623_h_total_regs, vt8623_h_display_regs, vt8623_h_blank_start_regs,
 	vt8623_h_blank_end_regs, vt8623_h_sync_start_regs, vt8623_h_sync_end_regs,
 	vt8623_v_total_regs, vt8623_v_display_regs, vt8623_v_blank_start_regs,
@@ -903,7 +903,7 @@ static void __exit vt8623fb_cleanup(void
 
 /* Driver Initialisation */
 
-int __init vt8623fb_init(void)
+static int __init vt8623fb_init(void)
 {
 
 #ifndef MODULE


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
