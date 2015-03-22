From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Sun, 22 Mar 2015 23:11:44 +0000
Subject: [PATCH 03/13] staging: sm750: move '{' to previous line
Message-Id: <20150322231144.GA17103@x230-arch.club.entropia.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fix checkpatch.pl error:
"ERROR: that open brace { should be on the previous line"

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 50 +++++++++++++----------------------------
 1 file changed, 16 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 83c81d2..24e7b68 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -171,8 +171,7 @@ static int lynxfb_ops_cursor(struct fb_info* info, struct fb_cursor* fbcursor)
 	}
 
 
-	if(fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE))
-	{
+	if(fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
 		cursor->setData(cursor,
 				fbcursor->rop,
 				fbcursor->image.data,
@@ -258,13 +257,10 @@ static void lynxfb_ops_imageblit(struct fb_info*info, const struct fb_image* ima
 
 	if(image->depth = 1){
 		if(info->fix.visual = FB_VISUAL_TRUECOLOR ||
-				info->fix.visual = FB_VISUAL_DIRECTCOLOR)
-		{
+				info->fix.visual = FB_VISUAL_DIRECTCOLOR) {
 			fgcol = ((u32*)info->pseudo_palette)[image->fg_color];
 			bgcol = ((u32*)info->pseudo_palette)[image->bg_color];
-		}
-		else
-		{
+		} else {
 			fgcol = image->fg_color;
 			bgcol = image->bg_color;
 		}
@@ -626,8 +622,7 @@ static int lynxfb_ops_setcolreg(unsigned regno, unsigned red,
 	if(info->var.grayscale)
 		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
 
-	if(var->bits_per_pixel = 8 && info->fix.visual = FB_VISUAL_PSEUDOCOLOR)
-	{
+	if(var->bits_per_pixel = 8 && info->fix.visual = FB_VISUAL_PSEUDOCOLOR) {
 		red >>= 8;
 		green >>= 8;
 		blue >>= 8;
@@ -636,13 +631,11 @@ static int lynxfb_ops_setcolreg(unsigned regno, unsigned red,
 	}
 
 
-	if(info->fix.visual = FB_VISUAL_TRUECOLOR && regno < 256 )
-	{
+	if(info->fix.visual = FB_VISUAL_TRUECOLOR && regno < 256 ) {
 		u32 val;
 		if(var->bits_per_pixel = 16 ||
 				var->bits_per_pixel = 32 ||
-				var->bits_per_pixel = 24)
-		{
+				var->bits_per_pixel = 24) {
 			val = chan_to_field(red, &var->red);
 			val |= chan_to_field(green, &var->green);
 			val |= chan_to_field(blue, &var->blue);
@@ -705,8 +698,7 @@ static int sm750fb_set_drv(struct lynxfb_par * par)
 	output->clear = hw_sm750_output_clear;
 	/* chip specific phase */
 	share->accel.de_wait = (share->revid = SM750LE_REVISION_ID)?hw_sm750le_deWait: hw_sm750_deWait;
-	switch (spec_share->state.dataflow)
-	{
+	switch (spec_share->state.dataflow) {
 	case sm750_simul_pri:
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_primary;
@@ -790,8 +782,7 @@ static int lynxfb_set_fbinfo(struct fb_info* info, int index)
 	};
 
 
-	static const char * fixId[2]-	{
+	static const char * fixId[2] = {
 		"sm750_fb1", "sm750_fb2",
 	};
 
@@ -931,8 +922,7 @@ static int lynxfb_set_fbinfo(struct fb_info* info, int index)
 	pr_info("fix->mmio_start = %lx\n", fix->mmio_start);
 	fix->mmio_len = share->vidreg_size;
 	pr_info("fix->mmio_len = %x\n", fix->mmio_len);
-	switch(var->bits_per_pixel)
-	{
+	switch(var->bits_per_pixel) {
 	case 8:
 		fix->visual = FB_VISUAL_PSEUDOCOLOR;
 		break;
@@ -1024,8 +1014,7 @@ static void sm750fb_setup(struct lynx_share * share, char * src)
 			g_hwcursor &= ~0x2;
 		else if(!strncmp(opt, "nohwc", strlen("nohwc")))
 			g_hwcursor = 0;
-		else
-		{
+		else {
 			if(!g_fbmode[0]){
 				g_fbmode[0] = opt;
 				pr_info("find fbmode0 : %s\n", g_fbmode[0]);
@@ -1038,8 +1027,7 @@ static void sm750fb_setup(struct lynx_share * share, char * src)
 		}
 	}
 #ifdef CAP_EXPANSION
-	if(getExpRes(exp_res, &spec_share->state.xLCD, &spec_share->state.yLCD))
-	{
+	if(getExpRes(exp_res, &spec_share->state.xLCD, &spec_share->state.yLCD)) {
 		/* seems exp_res is not valid*/
 		spec_share->state.xLCD = spec_share->state.yLCD = 0;
 	}
@@ -1047,8 +1035,7 @@ static void sm750fb_setup(struct lynx_share * share, char * src)
 
 NO_PARAM:
 	if(share->revid != SM750LE_REVISION_ID){
-		if(share->dual)
-		{
+		if(share->dual) {
 			if(swap)
 				spec_share->state.dataflow = sm750_dual_swap;
 			else
@@ -1164,16 +1151,13 @@ static int lynxfb_pci_probe(struct pci_dev * pdev,
 	fbidx = 0;
 ALLOC_FB:
 	info[fbidx] = framebuffer_alloc(sizeof(struct lynxfb_par), &pdev->dev);
-	if(!info[fbidx])
-	{
+	if(!info[fbidx]) {
 		pr_err("Could not allocate framebuffer #%d.\n", fbidx);
 		if(fbidx = 0)
 			goto err_info0_alloc;
 		else
 			goto err_info1_alloc;
-	}
-	else
-	{
+	} else {
 		struct lynxfb_par * par;
 		int errno;
 		pr_info("framebuffer #%d alloc okay\n", fbidx);
@@ -1292,8 +1276,7 @@ static int __init lynxfb_setup(char * options)
 		strsep() updates @options to pointer after the first found token
 		it also returns the pointer ahead the token.
 		*/
-	while((opt = strsep(&options, ":"))!=NULL)
-	{
+	while((opt = strsep(&options, ":"))!=NULL) {
 		/* options that mean for any lynx chips are configured here */
 		if(!strncmp(opt, "noaccel", strlen("noaccel")))
 			g_noaccel = 1;
@@ -1303,8 +1286,7 @@ static int __init lynxfb_setup(char * options)
 #endif
 		else if(!strncmp(opt, "dual", strlen("dual")))
 			g_dualview = 1;
-		else
-		{
+		else {
 			strcat(tmp, opt);
 			tmp += strlen(opt);
 			if(options != NULL)
-- 
2.3.3

