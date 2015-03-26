From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Thu, 26 Mar 2015 22:26:52 +0000
Subject: [PATCH v2 10/12] staging: sm750: fix whitespace
Message-Id: <fbc6904180186bf4991c7b626f3156d562bfc472.1427406762.git.michel.von.czettritz@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes whitespace checkpatch.pl warnings and errors.
Mainly whitespaces around operators.

- ERROR: spaces required around that ':' (ctx:VxW)
- ERROR: space required after that ';' (ctx:VxV)
- ERROR: spaces required around that '<' (ctx:VxV)
- ERROR: spaces required around that '!=' (ctx:VxV)

And some small warnings around whitespace:

- ERROR: trailing whitespace
- WARNING: space prohibited before semicolon
- WARNING: unnecessary whitespace before a quoted newline

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index c72d9d6..ff2b26b 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -378,7 +378,7 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 		var->red.length = 8;
 		var->green.offset = 8;
 		var->green.length = 8;
-		var->blue.offset = 0 ;
+		var->blue.offset = 0;
 		var->blue.length = 8;
 		fix->visual = FB_VISUAL_TRUECOLOR;
 		break;
@@ -591,7 +591,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 		var->red.length = 8;
 		var->green.offset = 8;
 		var->green.length = 8;
-		var->blue.offset = 0 ;
+		var->blue.offset = 0;
 		var->blue.length = 8;
 		info->fix.visual = FB_VISUAL_TRUECOLOR;
 		break;
@@ -722,7 +722,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 	output->proc_setBLANK = (share->revid = SM750LE_REVISION_ID)?hw_sm750le_setBLANK:hw_sm750_setBLANK;
 	output->clear = hw_sm750_output_clear;
 	/* chip specific phase */
-	share->accel.de_wait = (share->revid = SM750LE_REVISION_ID)?hw_sm750le_deWait: hw_sm750_deWait;
+	share->accel.de_wait = (share->revid = SM750LE_REVISION_ID)?hw_sm750le_deWait : hw_sm750_deWait;
 	switch (spec_share->state.dataflow) {
 	case sm750_simul_pri:
 		output->paths = sm750_pnc;
@@ -772,7 +772,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 	return ret;
 }
 
-static struct fb_ops lynxfb_ops={
+static struct fb_ops lynxfb_ops = {
 	.owner = THIS_MODULE,
 	.fb_check_var =  lynxfb_ops_check_var,
 	.fb_set_par = lynxfb_ops_set_par,
@@ -800,7 +800,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		lynx750_ext, NULL, vesa_modes,
 	};
 	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
-	static const char *mdb_desc[] ={
+	static const char *mdb_desc[] = {
 		"driver prepared modes",
 		"kernel prepared default modedb",
 		"kernel HELPERS prepared vesa_modes",
@@ -869,7 +869,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	}
 
 
-	for (i=0;i<3;i++) {
+	for (i = 0; i < 3; i++) {
 
 		ret = fb_find_mode(var, info, g_fbmode[index],
 				   pdb[i], cdb[i], NULL, 8);
@@ -980,7 +980,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		goto exit;
 	}
 
-	pr_debug("#2 show info->cmap : \nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
+	pr_debug("#2 show info->cmap :\nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
 		 info->cmap.start, info->cmap.len,
 		 info->cmap.red, info->cmap.green, info->cmap.blue,
 		 info->cmap.transp);
@@ -1314,7 +1314,7 @@ static int __init lynxfb_setup(char *options)
 		strsep() updates @options to pointer after the first found token
 		it also returns the pointer ahead the token.
 		*/
-	while ((opt = strsep(&options, ":"))!=NULL) {
+	while ((opt = strsep(&options, ":")) != NULL) {
 		/* options that mean for any lynx chips are configured here */
 		if (!strncmp(opt, "noaccel", strlen("noaccel")))
 			g_noaccel = 1;
@@ -1360,7 +1360,7 @@ static struct pci_driver lynxfb_driver = {
 
 static int __init lynxfb_init(void)
 {
-	char *option ;
+	char *option;
 	int ret;
 
 #ifdef MODULE
-- 
2.3.3

