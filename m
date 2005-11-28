From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/16] i810fb: Driver cleanups
Date: Mon, 28 Nov 2005 23:16:31 +0800
Message-ID: <438B1F4F.1000802@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhGmz-00022j-PV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:29:41 -0800
Received: from zproxy.gmail.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhGmu-0002EI-8r
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:29:41 -0800
Received: by zproxy.gmail.com with SMTP id r28so881708nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Nov 2005 17:29:35 -0800 (PST)
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

- remove redundant casts

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/i810/i810-i2c.c   |    2 +-
 drivers/video/i810/i810_accel.c |   26 +++++++++++++-------------
 drivers/video/i810/i810_main.c  |   30 +++++++++++++++---------------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/video/i810/i810-i2c.c b/drivers/video/i810/i810-i2c.c
index 277b51a..bd410e0 100644
--- a/drivers/video/i810/i810-i2c.c
+++ b/drivers/video/i810/i810-i2c.c
@@ -43,7 +43,7 @@
 
 static void i810i2c_setscl(void *data, int state)
 {
-        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
+        struct i810fb_i2c_chan    *chan = data;
         struct i810fb_par         *par = chan->par;
 	u8                        __iomem *mmio = par->mmio_start_virtual;
 
diff --git a/drivers/video/i810/i810_accel.c b/drivers/video/i810/i810_accel.c
index 1ba6567..76764ea 100644
--- a/drivers/video/i810/i810_accel.c
+++ b/drivers/video/i810/i810_accel.c
@@ -58,7 +58,7 @@ static inline void i810_report_error(u8 
  */	
 static inline int wait_for_space(struct fb_info *info, u32 space)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 	u32 head, count = WAIT_COUNT, tail;
 	u8 __iomem *mmio = par->mmio_start_virtual;
 
@@ -89,7 +89,7 @@ static inline int wait_for_space(struct 
  */
 static inline int wait_for_engine_idle(struct fb_info *info)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 	u8 __iomem *mmio = par->mmio_start_virtual;
 	int count = WAIT_COUNT;
 
@@ -117,7 +117,7 @@ static inline int wait_for_engine_idle(s
  */ 
 static inline u32 begin_iring(struct fb_info *info, u32 space)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 
 	if (par->dev_flags & ALWAYS_SYNC) 
 		wait_for_engine_idle(info);
@@ -162,7 +162,7 @@ static inline void source_copy_blit(int 
 				    int xdir, int src, int dest, int rop, 
 				    int blit_bpp, struct fb_info *info)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 
 	if (begin_iring(info, 24 + IRING_PAD)) return;
 
@@ -196,7 +196,7 @@ static inline void color_blit(int width,
 			      int rop, int what, int blit_bpp, 
 			      struct fb_info *info)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 
 	if (begin_iring(info, 24 + IRING_PAD)) return;
 
@@ -237,7 +237,7 @@ static inline void mono_src_copy_imm_bli
 					  int dest, const u32 *src, int bg,
 					  int fg, struct fb_info *info)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 
 	if (begin_iring(info, 24 + (dsize << 2) + IRING_PAD)) return;
 
@@ -255,7 +255,7 @@ static inline void mono_src_copy_imm_bli
 
 static inline void load_front(int offset, struct fb_info *info)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 
 	if (begin_iring(info, 8 + IRING_PAD)) return;
 
@@ -297,7 +297,7 @@ static inline void i810fb_iring_enable(s
 
 void i810fb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 	u32 dx, dy, width, height, dest, rop = 0, color = 0;
 
 	if (!info->var.accel_flags || par->dev_flags & LOCKUP ||
@@ -323,7 +323,7 @@ void i810fb_fillrect(struct fb_info *inf
 	
 void i810fb_copyarea(struct fb_info *info, const struct fb_copyarea *region) 
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 	u32 sx, sy, dx, dy, pitch, width, height, src, dest, xdir;
 
 	if (!info->var.accel_flags || par->dev_flags & LOCKUP ||
@@ -362,7 +362,7 @@ void i810fb_copyarea(struct fb_info *inf
 
 void i810fb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 	u32 fg = 0, bg = 0, size, dst;
 	
 	if (!info->var.accel_flags || par->dev_flags & LOCKUP ||
@@ -398,7 +398,7 @@ void i810fb_imageblit(struct fb_info *in
 
 int i810fb_sync(struct fb_info *info)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 	
 	if (!info->var.accel_flags || par->dev_flags & LOCKUP)
 		return 0;
@@ -408,7 +408,7 @@ int i810fb_sync(struct fb_info *info)
 
 void i810fb_load_front(u32 offset, struct fb_info *info)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	if (!info->var.accel_flags || par->dev_flags & LOCKUP)
@@ -428,7 +428,7 @@ void i810fb_load_front(u32 offset, struc
  */
 void i810fb_init_ringbuffer(struct fb_info *info)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 	u32 tmp1, tmp2;
 	u8 __iomem *mmio = par->mmio_start_virtual;
 	
diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index 9310ae9..4954a8e 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -817,7 +817,7 @@ static void i810_load_cursor_image(int w
 
 static void i810_load_cursor_colors(int fg, int bg, struct fb_info *info)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 	u8 __iomem *mmio = par->mmio_start_virtual;
 	u8 red, green, blue, trans, temp;
 
@@ -990,7 +990,7 @@ static void set_color_bitfields(struct f
 static int i810_check_params(struct fb_var_screeninfo *var, 
 			     struct fb_info *info)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 	int line_length, vidmem, mode_valid = 0, retval = 0;
 	u32 vyres = var->yres_virtual, vxres = var->xres_virtual;
 	/*
@@ -1084,7 +1084,7 @@ static int i810_check_params(struct fb_v
  */
 static int encode_fix(struct fb_fix_screeninfo *fix, struct fb_info *info)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 
     	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
 
@@ -1195,7 +1195,7 @@ static void decode_var(const struct fb_v
 static int i810fb_getcolreg(u8 regno, u8 *red, u8 *green, u8 *blue, 
 			    u8 *transp, struct fb_info *info)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 	u8 __iomem *mmio = par->mmio_start_virtual;
 	u8 temp;
 
@@ -1234,7 +1234,7 @@ static int i810fb_getcolreg(u8 regno, u8
 
 static int i810fb_open(struct fb_info *info, int user)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 	u32 count = atomic_read(&par->use_count);
 	
 	if (count == 0) {
@@ -1253,7 +1253,7 @@ static int i810fb_open(struct fb_info *i
 
 static int i810fb_release(struct fb_info *info, int user)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 	u32 count;
 	
 	count = atomic_read(&par->use_count);
@@ -1275,7 +1275,7 @@ static int i810fb_setcolreg(unsigned reg
 			    unsigned blue, unsigned transp, 
 			    struct fb_info *info)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 	u8 __iomem *mmio = par->mmio_start_virtual;
 	u8 temp;
 	int i;
@@ -1369,7 +1369,7 @@ static int i810fb_setcolreg(unsigned reg
 static int i810fb_pan_display(struct fb_var_screeninfo *var, 
 			      struct fb_info *info)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 	u32 total;
 	
 	total = var->xoffset * par->depth + 
@@ -1381,7 +1381,7 @@ static int i810fb_pan_display(struct fb_
 
 static int i810fb_blank (int blank_mode, struct fb_info *info)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 	u8 __iomem *mmio = par->mmio_start_virtual;
 	int mode = 0, pwr, scr_off = 0;
 	
@@ -1426,7 +1426,7 @@ static int i810fb_blank (int blank_mode,
 
 static int i810fb_set_par(struct fb_info *info)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 
 	decode_var(&info->var, par);
 	i810_load_regs(par);
@@ -1470,7 +1470,7 @@ static int i810fb_check_var(struct fb_va
 
 static int i810fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
-	struct i810fb_par *par = (struct i810fb_par *)info->par;
+	struct i810fb_par *par = info->par;
 	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	if (!par->dev_flags & LOCKUP)
@@ -1557,7 +1557,7 @@ static struct fb_ops i810fb_ops __devini
 static int i810fb_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 	int blank = 0, prev_state = par->cur_state;
 
 	if (state.event == prev_state)
@@ -1594,7 +1594,7 @@ static int i810fb_suspend(struct pci_dev
 static int i810fb_resume(struct pci_dev *dev) 
 {
 	struct fb_info *info = pci_get_drvdata(dev);
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 
 	if (par->cur_state == 0)
 		return 0;
@@ -1651,7 +1651,7 @@ static void __devinit i810_fix_offsets(s
 
 static int __devinit i810_alloc_agp_mem(struct fb_info *info)
 {
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 	int size;
 	struct agp_bridge_data *bridge;
 	
@@ -2115,7 +2115,7 @@ static void i810fb_release_resource(stru
 static void __exit i810fb_remove_pci(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	struct i810fb_par *par = info->par;
 
 	unregister_framebuffer(info);  
 	i810fb_release_resource(info, par);



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
