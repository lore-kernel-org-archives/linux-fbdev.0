From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 8/9] fbdev: Replace kmalloc with kzalloc
Date: Tue, 20 Dec 2005 20:50:56 +0800
Message-ID: <43A7FE30.4000606@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoyFj-0002EI-G2
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 23:19:11 -0800
Received: from zproxy.gmail.com ([64.233.162.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EoyFi-0005Kv-4D
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 23:19:11 -0800
Received: by zproxy.gmail.com with SMTP id z3so76970nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 Dec 2005 23:19:09 -0800 (PST)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Replace kmalloc with kzalloc
    
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/fbcvt.c    |    3 +--
 drivers/video/fbmon.c    |    3 +--
 drivers/video/fbsysfs.c  |    5 +++--
 drivers/video/vgastate.c |    5 +++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbcvt.c b/drivers/video/fbcvt.c
index 0b6af00..ac90883 100644
--- a/drivers/video/fbcvt.c
+++ b/drivers/video/fbcvt.c
@@ -214,12 +214,11 @@ static void fb_cvt_print_name(struct fb_
 {
 	u32 pixcount, pixcount_mod;
 	int cnt = 255, offset = 0, read = 0;
-	u8 *buf = kmalloc(256, GFP_KERNEL);
+	u8 *buf = kzalloc(256, GFP_KERNEL);
 
 	if (!buf)
 		return;
 
-	memset(buf, 0, 256);
 	pixcount = (cvt->xres * (cvt->yres/cvt->interlace))/1000000;
 	pixcount_mod = (cvt->xres * (cvt->yres/cvt->interlace)) % 1000000;
 	pixcount_mod /= 1000;
diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 0ef75a9..7c74e73 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -528,10 +528,9 @@ static struct fb_videomode *fb_create_mo
 	unsigned char *block;
 	int num = 0, i;
 
-	mode = kmalloc(50 * sizeof(struct fb_videomode), GFP_KERNEL);
+	mode = kzalloc(50 * sizeof(struct fb_videomode), GFP_KERNEL);
 	if (mode == NULL)
 		return NULL;
-	memset(mode, 0, 50 * sizeof(struct fb_videomode));
 
 	if (edid == NULL || !edid_checksum(edid) || 
 	    !edid_check_header(edid)) {
diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index 3514703..6d26057 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -43,10 +43,11 @@ struct fb_info *framebuffer_alloc(size_t
 	if (size)
 		fb_info_size += PADDING;
 
-	p = kmalloc(fb_info_size + size, GFP_KERNEL);
+	p = kzalloc(fb_info_size + size, GFP_KERNEL);
+
 	if (!p)
 		return NULL;
-	memset(p, 0, fb_info_size + size);
+
 	info = (struct fb_info *) p;
 
 	if (size)
diff --git a/drivers/video/vgastate.c b/drivers/video/vgastate.c
index d9e01da..15179ec 100644
--- a/drivers/video/vgastate.c
+++ b/drivers/video/vgastate.c
@@ -356,10 +356,11 @@ int save_vga(struct vgastate *state)
 {
 	struct regstate *saved;
 
-	saved = kmalloc(sizeof(struct regstate), GFP_KERNEL);
+	saved = kzalloc(sizeof(struct regstate), GFP_KERNEL);
+
 	if (saved == NULL)
 		return 1;
-	memset (saved, 0, sizeof(struct regstate));
+
 	state->vidstate = (void *)saved;
 		
 	if (state->flags & VGA_SAVE_CMAP) {




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
