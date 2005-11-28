From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 10/16] neofb: Driver cleanups
Date: Mon, 28 Nov 2005 23:30:43 +0800
Message-ID: <438B22A3.40502@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhGp2-0002QX-2n
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:31:48 -0800
Received: from zproxy.gmail.com ([64.233.162.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhGp1-0002py-LX
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:31:48 -0800
Received: by zproxy.gmail.com with SMTP id r28so881935nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Nov 2005 17:31:46 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Denis Oliver Kropp <dok@directfb.org>

- remove unneeded casts
- move memory for pseudo_palette inside struct neofb_par

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/neofb.c    |   36 ++++++++++++++++++------------------
 include/video/neomagic.h |    1 +
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
index 8486e77..e18c9f9 100644
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -485,7 +485,7 @@ static void vgaHWRestore(const struct fb
  */
 static inline int neo2200_sync(struct fb_info *info)
 {
-	struct neofb_par *par = (struct neofb_par *) info->par;
+	struct neofb_par *par = info->par;
 	int waitcycles;
 
 	while (readl(&par->neo2200->bltStat) & 1)
@@ -525,7 +525,7 @@ static inline void neo2200_wait_fifo(str
 static inline void neo2200_accel_init(struct fb_info *info,
 				      struct fb_var_screeninfo *var)
 {
-	struct neofb_par *par = (struct neofb_par *) info->par;
+	struct neofb_par *par = info->par;
 	Neo2200 __iomem *neo2200 = par->neo2200;
 	u32 bltMod, pitch;
 
@@ -560,7 +560,7 @@ static inline void neo2200_accel_init(st
 static int
 neofb_open(struct fb_info *info, int user)
 {
-	struct neofb_par *par = (struct neofb_par *) info->par;
+	struct neofb_par *par = info->par;
 	int cnt = atomic_read(&par->ref_count);
 
 	if (!cnt) {
@@ -575,7 +575,7 @@ neofb_open(struct fb_info *info, int use
 static int
 neofb_release(struct fb_info *info, int user)
 {
-	struct neofb_par *par = (struct neofb_par *) info->par;
+	struct neofb_par *par = info->par;
 	int cnt = atomic_read(&par->ref_count);
 
 	if (!cnt)
@@ -590,7 +590,7 @@ neofb_release(struct fb_info *info, int 
 static int
 neofb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	struct neofb_par *par = (struct neofb_par *) info->par;
+	struct neofb_par *par = info->par;
 	unsigned int pixclock = var->pixclock;
 	struct xtimings timings;
 	int memlen, vramlen;
@@ -757,7 +757,7 @@ neofb_check_var(struct fb_var_screeninfo
 
 static int neofb_set_par(struct fb_info *info)
 {
-	struct neofb_par *par = (struct neofb_par *) info->par;
+	struct neofb_par *par = info->par;
 	struct xtimings timings;
 	unsigned char temp;
 	int i, clock_hi = 0;
@@ -1216,7 +1216,7 @@ static int neofb_set_par(struct fb_info 
 static void neofb_update_start(struct fb_info *info,
 			       struct fb_var_screeninfo *var)
 {
-	struct neofb_par *par = (struct neofb_par *) info->par;
+	struct neofb_par *par = info->par;
 	struct vgastate *state = &par->state;
 	int oldExtCRTDispAddr;
 	int Base;
@@ -1331,7 +1331,7 @@ static int neofb_blank(int blank_mode, s
 	 *  wms...Enable VESA DPMS compatible powerdown mode
 	 *  run "setterm -powersave powerdown" to take advantage
 	 */
-	struct neofb_par *par = (struct neofb_par *)info->par;
+	struct neofb_par *par = info->par;
 	int seqflags, lcdflags, dpmsflags, reg;
 
 	switch (blank_mode) {
@@ -1404,7 +1404,7 @@ static int neofb_blank(int blank_mode, s
 static void
 neo2200_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
-	struct neofb_par *par = (struct neofb_par *) info->par;
+	struct neofb_par *par = info->par;
 	u_long dst, rop;
 
 	dst = rect->dx + rect->dy * info->var.xres_virtual;
@@ -1440,7 +1440,7 @@ static void
 neo2200_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
 	u32 sx = area->sx, sy = area->sy, dx = area->dx, dy = area->dy;
-	struct neofb_par *par = (struct neofb_par *) info->par;
+	struct neofb_par *par = info->par;
 	u_long src, dst, bltCntl;
 
 	bltCntl = NEO_BC3_FIFO_EN | NEO_BC3_SKIP_MAPPING | 0x0C0000;
@@ -1472,7 +1472,7 @@ neo2200_copyarea(struct fb_info *info, c
 static void
 neo2200_imageblit(struct fb_info *info, const struct fb_image *image)
 {
-	struct neofb_par *par = (struct neofb_par *) info->par;
+	struct neofb_par *par = info->par;
 	int s_pitch = (image->width * image->depth + 7) >> 3;
 	int scan_align = info->pixmap.scan_align - 1;
 	int buf_align = info->pixmap.buf_align - 1;
@@ -1686,7 +1686,7 @@ static struct fb_videomode __devinitdata
 static int __devinit neo_map_mmio(struct fb_info *info,
 				  struct pci_dev *dev)
 {
-	struct neofb_par *par = (struct neofb_par *) info->par;
+	struct neofb_par *par = info->par;
 
 	DBG("neo_map_mmio");
 
@@ -1733,7 +1733,7 @@ static int __devinit neo_map_mmio(struct
 
 static void neo_unmap_mmio(struct fb_info *info)
 {
-	struct neofb_par *par = (struct neofb_par *) info->par;
+	struct neofb_par *par = info->par;
 
 	DBG("neo_unmap_mmio");
 
@@ -1796,7 +1796,7 @@ static void neo_unmap_video(struct fb_in
 
 #ifdef CONFIG_MTRR
 	{
-		struct neofb_par *par = (struct neofb_par *) info->par;
+		struct neofb_par *par = info->par;
 
 		mtrr_del(par->mtrr, info->fix.smem_start,
 			 info->fix.smem_len);
@@ -1811,7 +1811,7 @@ static void neo_unmap_video(struct fb_in
 
 static int __devinit neo_scan_monitor(struct fb_info *info)
 {
-	struct neofb_par *par = (struct neofb_par *) info->par;
+	struct neofb_par *par = info->par;
 	unsigned char type, display;
 	int w;
 
@@ -1890,7 +1890,7 @@ static int __devinit neo_scan_monitor(st
 
 static int __devinit neo_init_hw(struct fb_info *info)
 {
-	struct neofb_par *par = (struct neofb_par *) info->par;
+	struct neofb_par *par = info->par;
 	int videoRam = 896;
 	int maxClock = 65000;
 	int CursorMem = 1024;
@@ -2014,7 +2014,7 @@ static struct fb_info *__devinit neo_all
 	struct fb_info *info;
 	struct neofb_par *par;
 
-	info = framebuffer_alloc(sizeof(struct neofb_par) + sizeof(u32) * 256, &dev->dev);
+	info = framebuffer_alloc(sizeof(struct neofb_par), &dev->dev);
 
 	if (!info)
 		return NULL;
@@ -2081,7 +2081,7 @@ static struct fb_info *__devinit neo_all
 	info->fix.accel = id->driver_data;
 
 	info->fbops = &neofb_ops;
-	info->pseudo_palette = (void *) (par + 1);
+	info->pseudo_palette = par->palette;
 	return info;
 }
 
diff --git a/include/video/neomagic.h b/include/video/neomagic.h
index bdaee70..1d69049 100644
--- a/include/video/neomagic.h
+++ b/include/video/neomagic.h
@@ -196,6 +196,7 @@ struct neofb_par {
 	int internal_display;
 	int external_display;
 	int libretto;
+	u32 palette[16];
 };
 
 typedef struct {



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
