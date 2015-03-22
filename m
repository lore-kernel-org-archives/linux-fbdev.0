From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Sun, 22 Mar 2015 23:12:48 +0000
Subject: [PATCH 05/13] staging: sm750: fix whitespaces around pointers
Message-Id: <20150322231248.GA17158@x230-arch.club.entropia.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes checkpatch.pl errors:
- ERROR: "foo * bar" should be "foo *bar"
- ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 162 ++++++++++++++++++++--------------------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8469746..ad0c663 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -50,24 +50,24 @@ static int g_noaccel;
 #ifdef CONFIG_MTRR
 static int g_nomtrr;
 #endif
-static const char * g_fbmode[] = {NULL, NULL};
-static const char * g_def_fbmode = "800x600-16@60";
-static char * g_settings = NULL;
+static const char *g_fbmode[] = {NULL, NULL};
+static const char *g_def_fbmode = "800x600-16@60";
+static char *g_settings = NULL;
 static int g_dualview;
-static char * g_option = NULL;
+static char *g_option = NULL;
 
 /* if not use spin_lock,system will die if user load driver
  * and immediatly unload driver frequently (dual)*/
-static inline void myspin_lock(spinlock_t * sl) {
-	struct lynx_share * share;
+static inline void myspin_lock(spinlock_t *sl) {
+	struct lynx_share *share;
 	share = container_of(sl, struct lynx_share, slock);
 	if (share->dual) {
 		spin_lock(sl);
 	}
 }
 
-static inline void myspin_unlock(spinlock_t * sl) {
-	struct lynx_share * share;
+static inline void myspin_unlock(spinlock_t *sl) {
+	struct lynx_share *share;
 	share = container_of(sl, struct lynx_share, slock);
 	if (share->dual) {
 		spin_unlock(sl);
@@ -130,11 +130,11 @@ static const struct fb_videomode lynx750_ext[] = {
 
 
 /* no hardware cursor supported under version 2.6.10, kernel bug */
-static int lynxfb_ops_cursor(struct fb_info* info, struct fb_cursor* fbcursor)
+static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 {
-	struct lynxfb_par * par;
-	struct lynxfb_crtc * crtc;
-	struct lynx_cursor * cursor;
+	struct lynxfb_par *par;
+	struct lynxfb_crtc *crtc;
+	struct lynx_cursor *cursor;
 
 	par = info->par;
 	crtc = &par->crtc;
@@ -185,10 +185,10 @@ static int lynxfb_ops_cursor(struct fb_info* info, struct fb_cursor* fbcursor)
 	return 0;
 }
 
-static void lynxfb_ops_fillrect(struct fb_info* info, const struct fb_fillrect* region)
+static void lynxfb_ops_fillrect(struct fb_info *info, const struct fb_fillrect *region)
 {
-	struct lynxfb_par * par;
-	struct lynx_share * share;
+	struct lynxfb_par *par;
+	struct lynx_share *share;
 	unsigned int base, pitch, Bpp, rop;
 	u32 color;
 
@@ -217,10 +217,10 @@ static void lynxfb_ops_fillrect(struct fb_info* info, const struct fb_fillrect*
 	myspin_unlock(&share->slock);
 }
 
-static void lynxfb_ops_copyarea(struct fb_info * info, const struct fb_copyarea * region)
+static void lynxfb_ops_copyarea(struct fb_info *info, const struct fb_copyarea *region)
 {
-	struct lynxfb_par * par;
-	struct lynx_share * share;
+	struct lynxfb_par *par;
+	struct lynx_share *share;
 	unsigned int base, pitch, Bpp;
 
 	par = info->par;
@@ -240,12 +240,12 @@ static void lynxfb_ops_copyarea(struct fb_info * info, const struct fb_copyarea
 	myspin_unlock(&share->slock);
 }
 
-static void lynxfb_ops_imageblit(struct fb_info*info, const struct fb_image* image)
+static void lynxfb_ops_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	unsigned int base, pitch, Bpp;
 	unsigned int fgcol, bgcol;
-	struct lynxfb_par * par;
-	struct lynx_share * share;
+	struct lynxfb_par *par;
+	struct lynx_share *share;
 
 	par = info->par;
 	share = par->share;
@@ -281,8 +281,8 @@ _do_work:
 static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,
 		struct fb_info *info)
 {
-	struct lynxfb_par * par;
-	struct lynxfb_crtc * crtc;
+	struct lynxfb_par *par;
+	struct lynxfb_crtc *crtc;
 	int ret;
 
 
@@ -297,14 +297,14 @@ static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,
 	return ret;
 }
 
-static int lynxfb_ops_set_par(struct fb_info * info)
+static int lynxfb_ops_set_par(struct fb_info *info)
 {
-	struct lynxfb_par * par;
-	struct lynx_share * share;
-	struct lynxfb_crtc * crtc;
-	struct lynxfb_output * output;
-	struct fb_var_screeninfo * var;
-	struct fb_fix_screeninfo * fix;
+	struct lynxfb_par *par;
+	struct lynx_share *share;
+	struct lynxfb_crtc *crtc;
+	struct lynxfb_output *output;
+	struct fb_var_screeninfo *var;
+	struct fb_fix_screeninfo *fix;
 	int ret;
 	unsigned int line_length;
 
@@ -379,7 +379,7 @@ static int lynxfb_ops_set_par(struct fb_info * info)
 	return ret;
 }
 
-static inline unsigned int chan_to_field(unsigned int chan, struct fb_bitfield * bf)
+static inline unsigned int chan_to_field(unsigned int chan, struct fb_bitfield *bf)
 {
 	chan &= 0xffff;
 	chan >>= 16 - bf->length;
@@ -439,14 +439,14 @@ static int lynxfb_suspend(struct pci_dev *pdev, pm_message_t mesg)
 	return ret;
 }
 
-static int lynxfb_resume(struct pci_dev* pdev)
+static int lynxfb_resume(struct pci_dev *pdev)
 {
-	struct fb_info * info;
-	struct lynx_share * share;
+	struct fb_info *info;
+	struct lynx_share *share;
 
-	struct lynxfb_par * par;
-	struct lynxfb_crtc * crtc;
-	struct lynx_cursor * cursor;
+	struct lynxfb_par *par;
+	struct lynxfb_crtc *crtc;
+	struct lynx_cursor *cursor;
 
 	int ret;
 
@@ -506,12 +506,12 @@ static int lynxfb_resume(struct pci_dev* pdev)
 }
 #endif
 
-static int lynxfb_ops_check_var(struct fb_var_screeninfo* var, struct fb_info* info)
+static int lynxfb_ops_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	struct lynxfb_par * par;
-	struct lynxfb_crtc * crtc;
-	struct lynxfb_output * output;
-	struct lynx_share * share;
+	struct lynxfb_par *par;
+	struct lynxfb_crtc *crtc;
+	struct lynxfb_output *output;
+	struct lynx_share *share;
 	int ret;
 	resource_size_t request;
 
@@ -601,11 +601,11 @@ exit:
 
 static int lynxfb_ops_setcolreg(unsigned regno, unsigned red,
 		unsigned green, unsigned blue,
-		unsigned transp, struct fb_info * info)
+		unsigned transp, struct fb_info *info)
 {
-	struct lynxfb_par * par;
-	struct lynxfb_crtc * crtc;
-	struct fb_var_screeninfo * var;
+	struct lynxfb_par *par;
+	struct lynxfb_crtc *crtc;
+	struct fb_var_screeninfo *var;
 	int ret;
 
 	par = info->par;
@@ -650,10 +650,10 @@ exit:
 	return ret;
 }
 
-static int lynxfb_ops_blank(int blank, struct fb_info* info)
+static int lynxfb_ops_blank(int blank, struct fb_info *info)
 {
-	struct lynxfb_par * par;
-	struct lynxfb_output * output;
+	struct lynxfb_par *par;
+	struct lynxfb_output *output;
 
 	pr_debug("blank = %d.\n", blank);
 	par = info->par;
@@ -661,13 +661,13 @@ static int lynxfb_ops_blank(int blank, struct fb_info* info)
 	return output->proc_setBLANK(output, blank);
 }
 
-static int sm750fb_set_drv(struct lynxfb_par * par)
+static int sm750fb_set_drv(struct lynxfb_par *par)
 {
 	int ret;
-	struct lynx_share * share;
-	struct sm750_share * spec_share;
-	struct lynxfb_output * output;
-	struct lynxfb_crtc * crtc;
+	struct lynx_share *share;
+	struct sm750_share *spec_share;
+	struct lynxfb_output *output;
+	struct lynxfb_crtc *crtc;
 
 	ret = 0;
 
@@ -761,28 +761,28 @@ static struct fb_ops lynxfb_ops={
 };
 
 
-static int lynxfb_set_fbinfo(struct fb_info* info, int index)
+static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 {
 	int i;
-	struct lynxfb_par * par;
-	struct lynx_share * share;
-	struct lynxfb_crtc * crtc;
-	struct lynxfb_output * output;
-	struct fb_var_screeninfo * var;
-	struct fb_fix_screeninfo * fix;
-
-	const struct fb_videomode * pdb[] = {
+	struct lynxfb_par *par;
+	struct lynx_share *share;
+	struct lynxfb_crtc *crtc;
+	struct lynxfb_output *output;
+	struct fb_var_screeninfo *var;
+	struct fb_fix_screeninfo *fix;
+
+	const struct fb_videomode *pdb[] = {
 		lynx750_ext, NULL, vesa_modes,
 	};
 	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
-	static const char * mdb_desc[] ={
+	static const char *mdb_desc[] ={
 		"driver prepared modes",
 		"kernel prepared default modedb",
 		"kernel HELPERS prepared vesa_modes",
 	};
 
 
-	static const char * fixId[2] = {
+	static const char *fixId[2] = {
 		"sm750_fb1", "sm750_fb2",
 	};
 
@@ -959,12 +959,12 @@ exit:
 }
 
 /* 	chip specific g_option configuration routine */
-static void sm750fb_setup(struct lynx_share * share, char * src)
+static void sm750fb_setup(struct lynx_share *share, char *src)
 {
-	struct sm750_share * spec_share;
-	char * opt;
+	struct sm750_share *spec_share;
+	char *opt;
 #ifdef CAP_EXPENSION
-	char * exp_res;
+	char *exp_res;
 #endif
 	int swap;
 
@@ -1054,11 +1054,11 @@ NO_PARAM:
 	}
 }
 
-static int lynxfb_pci_probe(struct pci_dev * pdev,
-		const struct pci_device_id * ent)
+static int lynxfb_pci_probe(struct pci_dev *pdev,
+		const struct pci_device_id *ent)
 {
-	struct fb_info * info[] = {NULL, NULL};
-	struct lynx_share * share = NULL;
+	struct fb_info *info[] = {NULL, NULL};
+	struct lynx_share *share = NULL;
 
 	struct sm750_share *spec_share = NULL;
 	size_t spec_offset = 0;
@@ -1158,7 +1158,7 @@ ALLOC_FB:
 		else
 			goto err_info1_alloc;
 	} else {
-		struct lynxfb_par * par;
+		struct lynxfb_par *par;
 		int errno;
 		pr_info("framebuffer #%d alloc okay\n", fbidx);
 		share->fbinfo[fbidx] = info[fbidx];
@@ -1210,12 +1210,12 @@ err_enable:
 	return -ENODEV;
 }
 
-static void __exit lynxfb_pci_remove(struct pci_dev * pdev)
+static void __exit lynxfb_pci_remove(struct pci_dev *pdev)
 {
-	struct fb_info * info;
-	struct lynx_share * share;
-	void * spec_share;
-	struct lynxfb_par * par;
+	struct fb_info *info;
+	struct lynx_share *share;
+	void *spec_share;
+	struct lynxfb_par *par;
 	int cnt;
 
 	cnt = 2;
@@ -1248,10 +1248,10 @@ static void __exit lynxfb_pci_remove(struct pci_dev * pdev)
 	pci_set_drvdata(pdev, NULL);
 }
 
-static int __init lynxfb_setup(char * options)
+static int __init lynxfb_setup(char *options)
 {
 	int len;
-	char * opt,*tmp;
+	char *opt, *tmp;
 
 
 	if (!options || !*options) {
-- 
2.3.3

