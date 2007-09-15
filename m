From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 05/12] ps3fb: Fix spurious mode change
	failures
Date: Sat, 15 Sep 2007 08:03:15 +0800
Message-ID: <46EB2143.9000307@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IWLEf-0007lz-7z for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:10:09 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IWLEe-0003jU-Tj
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:10:09 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3286302rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 14 Sep 2007 17:10:08 -0700 (PDT)
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
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Geoff Levand <geoffrey.levand@am.sony.com>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

ps3fb: Add a `mode' parameter to ps3fb_get_res_table(), as in some cases it
should check the full-screen flag of the _new_ video mode instead of the
current video mode.

This bug caused spurious mode change failures when switching between fullscreen
and non-fullscreen modes using fbset, while ps3-video-mode worked fine.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
CC: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/ps3fb.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index e0beb97..c9037e9 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -303,13 +303,13 @@ module_param(ps3fb_mode, int, 0);
 
 static char *mode_option __devinitdata;
 
-static int ps3fb_get_res_table(u32 xres, u32 yres)
+static int ps3fb_get_res_table(u32 xres, u32 yres, int mode)
 {
 	int full_mode;
 	unsigned int i;
 	u32 x, y, f;
 
-	full_mode = (ps3fb_mode & PS3FB_FULL_MODE_BIT) ? PS3FB_RES_FULL : 0;
+	full_mode = (mode & PS3FB_FULL_MODE_BIT) ? PS3FB_RES_FULL : 0;
 	for (i = 0;; i++) {
 		x = ps3fb_res[i].xres;
 		y = ps3fb_res[i].yres;
@@ -527,7 +527,7 @@ static int ps3fb_check_var(struct fb_var
 	}
 
 	/* Memory limit */
-	i = ps3fb_get_res_table(var->xres, var->yres);
+	i = ps3fb_get_res_table(var->xres, var->yres, mode);
 	if (ps3fb_res[i].xres*ps3fb_res[i].yres*BPP > ps3fb_videomemory.size) {
 		DPRINTK("Not enough memory\n");
 		return -ENOMEM;
@@ -553,13 +553,14 @@ static int ps3fb_set_par(struct fb_info 
 	DPRINTK("xres:%d xv:%d yres:%d yv:%d clock:%d\n",
 		info->var.xres, info->var.xres_virtual,
 		info->var.yres, info->var.yres_virtual, info->var.pixclock);
-	i = ps3fb_get_res_table(info->var.xres, info->var.yres);
-	ps3fb.res_index = i;
 
 	mode = ps3fb_find_mode(&info->var, &info->fix.line_length);
 	if (!mode)
 		return -EINVAL;
 
+	i = ps3fb_get_res_table(info->var.xres, info->var.yres, mode);
+	ps3fb.res_index = i;
+
 	offset = FB_OFF(i) + VP_OFF(i);
 	info->fix.smem_len = ps3fb_videomemory.size - offset;
 	info->screen_base = (char __iomem *)ps3fb.xdr_ea + offset;
@@ -610,7 +611,7 @@ static int ps3fb_mmap(struct fb_info *in
 	unsigned long size, offset;
 	int i;
 
-	i = ps3fb_get_res_table(info->var.xres, info->var.yres);
+	i = ps3fb_get_res_table(info->var.xres, info->var.yres, ps3fb_mode);
 	if (i == -1)
 		return -EINVAL;
 
@@ -999,7 +1000,7 @@ static int __devinit ps3fb_probe(struct 
 
 	if (ps3fb_mode > 0 &&
 	    !ps3av_video_mode2res(ps3fb_mode, &xres, &yres)) {
-		ps3fb.res_index = ps3fb_get_res_table(xres, yres);
+		ps3fb.res_index = ps3fb_get_res_table(xres, yres, ps3fb_mode);
 		DPRINTK("res_index:%d\n", ps3fb.res_index);
 	} else
 		ps3fb.res_index = GPU_RES_INDEX;


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
