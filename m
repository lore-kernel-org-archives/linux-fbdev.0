From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/2] intelfb: Fix oops when changing video mode
Date: Mon, 19 Dec 2005 15:11:49 +0800
Message-ID: <43A65D35.80809@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoFCs-0000Bm-1d
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 18 Dec 2005 23:13:14 -0800
Received: from zproxy.gmail.com ([64.233.162.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EoFCr-00066j-Hx
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 18 Dec 2005 23:13:13 -0800
Received: by zproxy.gmail.com with SMTP id z3so1046480nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 18 Dec 2005 23:13:10 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Reported by: janis huang (Bugzilla Bug 5747)

Fix the following in intelfb. Not sure what's happening, looks like
dinfo->name pointer is invalidated after initialization.  Remove
intelfb_get_fix, it's not needed and move the majority of the code
to the initialization routine.

c03a25b2
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c03a25b2>]    Not tainted VLI
EFLAGS: 00010246   (2.6.15-rc5-gcov)
EIP is at intelfb_get_fix+0x35/0x9f
eax: 00000000   ebx: df4fb0a8   ecx: 00000000   edx: df4fb23c
esi: 00000000   edi: df4fb0a8   ebp: df4fb23c   esp: df787cbc
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 4, threadinfo=df786000 task=c1524a30)
Stack: dd711824 df4fb23c df4fb008 dd711958 c03a23d9 df4fb0a8 df4fb000 df4fb008
dd711000 df4fb008 c03a2d49 df4fb23c df4fb008 00000000 00000000 df787e44
df4fb008 df787e45 df4fb000 c030217b df4fb000 df787e44 000000a0 00002700
Call Trace:
[<c03a23d9>] update_dinfo+0x6b/0x20f
[<c03a2d49>] intelfb_set_par+0x145/0x30c
[<c030217b>] fb_set_var+0x34e/0x3cf
[<c0169297>] __do_IRQ+0x145/0x1d0
[<c03a340a>] intelfb_imageblit+0x106/0x14b
[<c030109e>] soft_cursor+0x21e/0x2b4
[<c02f5def>] display_to_var+0x2a/0xbf
[<c02fb246>] fbcon_switch+0x1cc/0xd3f
[<c0379887>] redraw_screen+0x1d2/0x3d1
[<c03712e6>] complete_change_console+0x3c/0x1bf
[<c037e169>] console_callback+0x1b0/0x1da
[<c037dfb9>] console_callback+0x0/0x1da
[<c014b898>] worker_thread+0x2c5/0x3c9
[<c0127b1a>] default_wake_function+0x0/0x23
[<c0127b1a>] default_wake_function+0x0/0x23
[<c014b5d3>] worker_thread+0x0/0x3c9
[<c0153200>] kthread+0x12e/0x190
[<c01530d2>] kthread+0x0/0x190
[<c0101dc1>] kernel_thread_helper+0x5/0xb
Code: 8c c0 01 8b 44 24 18 8b 5c 24 14 83 15 8c ea 8c c0 00 8b 90 34 02 00 00
31 c0 b9 11 00
00 00 89 df f3 ab 8b b2 28 0a 00 00 89 df <ac> aa 84 c0 75 fa 8b 82 8c 09 00
00 89 43 10 8b 82 98 09 00 00

Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 intelfbdrv.c |   42 +++++++++++++-----------------------------
 1 files changed, 13 insertions(+), 29 deletions(-)


diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
index ac8d661..0090544 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -135,9 +135,6 @@
 static void __devinit get_initial_mode(struct intelfb_info *dinfo);
 static void update_dinfo(struct intelfb_info *dinfo,
 			 struct fb_var_screeninfo *var);
-static int intelfb_get_fix(struct fb_fix_screeninfo *fix,
-			   struct fb_info *info);
-
 static int intelfb_check_var(struct fb_var_screeninfo *var,
 			     struct fb_info *info);
 static int intelfb_set_par(struct fb_info *info);
@@ -1096,7 +1093,17 @@ intelfb_set_fbinfo(struct intelfb_info *
 		return 1;
 
 	info->pixmap.scan_align = 1;
-
+	strcpy(info->fix.id, dinfo->name);
+	info->fix.smem_start = dinfo->fb.physical;
+	info->fix.smem_len = dinfo->fb.size;
+	info->fix.type = FB_TYPE_PACKED_PIXELS;
+	info->fix.type_aux = 0;
+	info->fix.xpanstep = 8;
+	info->fix.ypanstep = 1;
+	info->fix.ywrapstep = 0;
+	info->fix.mmio_start = dinfo->mmio_base_phys;
+	info->fix.mmio_len = INTEL_REG_SIZE;
+	info->fix.accel = FB_ACCEL_I830;
 	update_dinfo(dinfo, &info->var);
 
 	return 0;
@@ -1114,7 +1121,8 @@ update_dinfo(struct intelfb_info *dinfo,
 	dinfo->yres = var->xres;
 	dinfo->pixclock = var->pixclock;
 
-	intelfb_get_fix(&dinfo->info->fix, dinfo->info);
+	dinfo->info->fix.visual = dinfo->visual;
+	dinfo->info->fix.line_length = dinfo->pitch;
 
 	switch (dinfo->bpp) {
 	case 8:
@@ -1144,30 +1152,6 @@ update_dinfo(struct intelfb_info *dinfo,
 
 /* fbops functions */
 
-static int
-intelfb_get_fix(struct fb_fix_screeninfo *fix, struct fb_info *info)
-{
-	struct intelfb_info *dinfo = GET_DINFO(info);
-
-	DBG_MSG("intelfb_get_fix\n");
-
-	memset(fix, 0, sizeof(*fix));
-	strcpy(fix->id, dinfo->name);
-	fix->smem_start = dinfo->fb.physical;
-	fix->smem_len = dinfo->fb.size;
-	fix->type = FB_TYPE_PACKED_PIXELS;
-	fix->type_aux = 0;
-	fix->visual = dinfo->visual;
-	fix->xpanstep = 8;
-	fix->ypanstep = 1;
-	fix->ywrapstep = 0;
-	fix->line_length = dinfo->pitch;
-	fix->mmio_start = dinfo->mmio_base_phys;
-	fix->mmio_len = INTEL_REG_SIZE;
-	fix->accel = FB_ACCEL_I830;
-	return 0;
-}
-
 /***************************************************************
  *                       fbdev interface                       *
  ***************************************************************/



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
