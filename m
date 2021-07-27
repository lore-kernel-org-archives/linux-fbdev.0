Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D5CC4338F
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Jul 2021 19:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA76560F6E
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Jul 2021 19:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhG0TUQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 27 Jul 2021 15:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhG0TUN (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 27 Jul 2021 15:20:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE802C061757;
        Tue, 27 Jul 2021 12:20:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k1so17166676plt.12;
        Tue, 27 Jul 2021 12:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x9x0aDShf2INUU0OKarFoIEX44er3m0F5sKf0xI1PAs=;
        b=ZuTvLau6l/KP7hT9Eou1iBOzd0lkWv2v0/my4WmrtQVzjY2NU0QHpDCGOGEkvNew1H
         85r4FUxADYoAWQ90m//XT9t74mNnbulM8nlzhxdI4Ij1gjPklkCApa406DSkXvym4ROF
         gZWQfwlneMoBU4zuTvQOXdyBWMd8OOco4Co8GarT4o1iTj5W1p/HVUis91ORaBJW2ir+
         +lcFS/2/ILZdRXjCAQ0Tv6X21zQn+/b3XGc7K21PutfOCElGR2MZYegzu/+MRg3z2UBm
         QlkTH80mdIh805IvIYIPrNixQC+cvyXLH4WRLRHfpMaGXUspaHU5vKhy2BnOX2SWX94P
         9KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x9x0aDShf2INUU0OKarFoIEX44er3m0F5sKf0xI1PAs=;
        b=PDBZV4O/q1SYdX8AljQAsH3TkZtFUMrKdRkc5jeHF5ycGTT/Iu9UJdjWaZOzScA0Lr
         KutnNc7FZRawJSVyIwMK2A9SRV0ubs+1ymLvQixD9LJcWIsgR8Q3tFCCL3vf2BOzoeE4
         Erh8FEBC7w+JDf6GR3tpFkyZUBE5Xdfxlre8bdxsD7Jt6kSqLfi7KVuGisttqVjL+IAD
         wDg9ixxeqEWZRjaYMuS55TK2ACz/sMo45/X9o6YtfOVQxbUWwSCfDD+QCqL0M5LwbF6e
         Xy7vxiY10WkSej2BMPf30+C8+hP1zLw9Wzi15Du3BBJjGniibKdmqzJwe/1hDARiwDNg
         OQSQ==
X-Gm-Message-State: AOAM531piJaoLxpZztiU+XsvkOOEMadMO2LsLtLsjhvMEFwdBuv27YXJ
        gRZG5MOueUusBMMLDrbX+90=
X-Google-Smtp-Source: ABdhPJxeYLXMkgP/AmUac6Jiz6S8L9t9Z04HDEYgpbMrMJOOwzd+pNat1RXGXXsIX+7+5Sl4lTWUHg==
X-Received: by 2002:a63:3107:: with SMTP id x7mr25037738pgx.303.1627413611306;
        Tue, 27 Jul 2021 12:20:11 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2130:198:9b25:1cfb:9ff3:2a8f])
        by smtp.gmail.com with ESMTPSA id f7sm4317096pfc.111.2021.07.27.12.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 12:20:11 -0700 (PDT)
From:   Benjamin Philip <benjamin.philip495@gmail.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Benjamin Philip <benjamin.philip495@gmail.com>
Subject: [PATCH 1/4] staging: sm750fb: Rename oScreen to o_screen in lynxfb_crtc
Date:   Wed, 28 Jul 2021 00:49:50 +0530
Message-Id: <8d7c72027f7bc31a1c35a34f9909fa04f4cf8972.1627413010.git.benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627413010.git.benjamin.philip495@gmail.com>
References: <cover.1627413010.git.benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The struct lynxfb_crtc has a member named oScreen. This name is
CamelCase and is frowned upon. This commit renames it to o_screen
and makes the necessary changes for the module to build.

This change also fixes the following checkpatch CHECKs:

CHECK: Avoid CamelCase: <oScreen>
138: FILE: sm750.h:138:
+	int oScreen; /* onscreen address offset in vidmem */

CHECK: Avoid CamelCase: <oScreen>
178: FILE: sm750.c:178:
+	base = par->crtc.oScreen;

Signed-off-by: Benjamin Philip <benjamin.philip495@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 30 +++++++--------
 drivers/staging/sm750fb/sm750.h    |  2 +-
 drivers/staging/sm750fb/sm750_hw.c | 62 +++++++++++++++---------------
 3 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 4f5f68e6aa60..202d8f47365c 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -175,7 +175,7 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	 * each time 2d function begin to work,below three variable always need
 	 * be set, seems we can put them together in some place
 	 */
-	base = par->crtc.oScreen;
+	base = par->crtc.o_screen;
 	pitch = info->fix.line_length;
 	Bpp = info->var.bits_per_pixel >> 3;
 
@@ -213,7 +213,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 	 * each time 2d function begin to work,below three variable always need
 	 * be set, seems we can put them together in some place
 	 */
-	base = par->crtc.oScreen;
+	base = par->crtc.o_screen;
 	pitch = info->fix.line_length;
 	Bpp = info->var.bits_per_pixel >> 3;
 
@@ -247,7 +247,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	 * each time 2d function begin to work,below three variable always need
 	 * be set, seems we can put them together in some place
 	 */
-	base = par->crtc.oScreen;
+	base = par->crtc.o_screen;
 	pitch = info->fix.line_length;
 	Bpp = info->var.bits_per_pixel >> 3;
 
@@ -614,44 +614,44 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 	case sm750_simul_pri:
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_primary;
-		crtc->oScreen = 0;
+		crtc->o_screen = 0;
 		crtc->vScreen = sm750_dev->pvMem;
 		pr_info("use simul primary mode\n");
 		break;
 	case sm750_simul_sec:
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_secondary;
-		crtc->oScreen = 0;
+		crtc->o_screen = 0;
 		crtc->vScreen = sm750_dev->pvMem;
 		break;
 	case sm750_dual_normal:
 		if (par->index == 0) {
 			output->paths = sm750_panel;
 			crtc->channel = sm750_primary;
-			crtc->oScreen = 0;
+			crtc->o_screen = 0;
 			crtc->vScreen = sm750_dev->pvMem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_secondary;
-			/* not consider of padding stuffs for oScreen,need fix */
-			crtc->oScreen = sm750_dev->vidmem_size >> 1;
-			crtc->vScreen = sm750_dev->pvMem + crtc->oScreen;
+			/* not consider of padding stuffs for o_screen,need fix */
+			crtc->o_screen = sm750_dev->vidmem_size >> 1;
+			crtc->vScreen = sm750_dev->pvMem + crtc->o_screen;
 		}
 		break;
 	case sm750_dual_swap:
 		if (par->index == 0) {
 			output->paths = sm750_panel;
 			crtc->channel = sm750_secondary;
-			crtc->oScreen = 0;
+			crtc->o_screen = 0;
 			crtc->vScreen = sm750_dev->pvMem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_primary;
-			/* not consider of padding stuffs for oScreen,
+			/* not consider of padding stuffs for o_screen,
 			 * need fix
 			 */
-			crtc->oScreen = sm750_dev->vidmem_size >> 1;
-			crtc->vScreen = sm750_dev->pvMem + crtc->oScreen;
+			crtc->o_screen = sm750_dev->vidmem_size >> 1;
+			crtc->vScreen = sm750_dev->pvMem + crtc->o_screen;
 		}
 		break;
 	default:
@@ -718,7 +718,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * set current cursor variable and proc pointer,
 	 * must be set after crtc member initialized
 	 */
-	crtc->cursor.offset = crtc->oScreen + crtc->vidmem_size - 1024;
+	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
 	crtc->cursor.mmio = sm750_dev->pvReg +
 		0x800f0 + (int)crtc->channel * 0x140;
 
@@ -816,7 +816,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 
 	strscpy(fix->id, fixId[index], sizeof(fix->id));
 
-	fix->smem_start = crtc->oScreen + sm750_dev->vidmem_start;
+	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
 	pr_info("fix->smem_start = %lx\n", fix->smem_start);
 	/*
 	 * according to mmap experiment from user space application,
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 8271cf7c89f3..08c1048be541 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -135,7 +135,7 @@ struct lynxfb_crtc {
 	unsigned char __iomem *vCursor; /* virtual address of cursor */
 	unsigned char __iomem *vScreen; /* virtual address of on_screen */
 	int oCursor; /* cursor address offset in vidmem */
-	int oScreen; /* onscreen address offset in vidmem */
+	int o_screen; /* onscreen address offset in vidmem */
 	int channel;/* which channel this crtc stands for*/
 	resource_size_t vidmem_size;/* this view's video memory max size */
 
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 7136d751cff5..a7c6eb07b62e 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -32,7 +32,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 
 	ret = 0;
 
-	sm750_dev->vidreg_start  = pci_resource_start(pdev, 1);
+	sm750_dev->vidreg_start = pci_resource_start(pdev, 1);
 	sm750_dev->vidreg_size = SZ_2M;
 
 	pr_info("mmio phyAddr = %lx\n", sm750_dev->vidreg_start);
@@ -50,8 +50,8 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	}
 
 	/* now map mmio and vidmem */
-	sm750_dev->pvReg = ioremap(sm750_dev->vidreg_start,
-				   sm750_dev->vidreg_size);
+	sm750_dev->pvReg =
+		ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size);
 	if (!sm750_dev->pvReg) {
 		pr_err("mmio failed\n");
 		ret = -EFAULT;
@@ -78,8 +78,8 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		sm750_dev->vidmem_start, sm750_dev->vidmem_size);
 
 	/* reserve the vidmem space of smi adaptor */
-	sm750_dev->pvMem = ioremap_wc(sm750_dev->vidmem_start,
-				      sm750_dev->vidmem_size);
+	sm750_dev->pvMem =
+		ioremap_wc(sm750_dev->vidmem_start, sm750_dev->vidmem_size);
 	if (!sm750_dev->pvMem) {
 		pr_err("Map video memory failed\n");
 		ret = -EFAULT;
@@ -98,8 +98,8 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	parm = &sm750_dev->initParm;
 	if (parm->chip_clk == 0)
 		parm->chip_clk = (sm750_get_chip_type() == SM750LE) ?
-						DEFAULT_SM750LE_CHIP_CLOCK :
-						DEFAULT_SM750_CHIP_CLOCK;
+					       DEFAULT_SM750LE_CHIP_CLOCK :
+					       DEFAULT_SM750_CHIP_CLOCK;
 
 	if (parm->mem_clk == 0)
 		parm->mem_clk = parm->chip_clk;
@@ -133,8 +133,8 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		}
 
 		val = peek32(PANEL_DISPLAY_CTRL) &
-			~(PANEL_DISPLAY_CTRL_DUAL_DISPLAY |
-			  PANEL_DISPLAY_CTRL_DOUBLE_PIXEL);
+		      ~(PANEL_DISPLAY_CTRL_DUAL_DISPLAY |
+			PANEL_DISPLAY_CTRL_DOUBLE_PIXEL);
 		switch (sm750_dev->pnltype) {
 		case sm750_24TFT:
 			break;
@@ -281,12 +281,12 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 
 	/* set timing */
 	modparm.pixel_clock = ps_to_hz(var->pixclock);
-	modparm.vertical_sync_polarity = (var->sync & FB_SYNC_HOR_HIGH_ACT)
-					 ? POS : NEG;
-	modparm.horizontal_sync_polarity = (var->sync & FB_SYNC_VERT_HIGH_ACT)
-					   ? POS : NEG;
-	modparm.clock_phase_polarity = (var->sync & FB_SYNC_COMP_HIGH_ACT)
-				       ? POS : NEG;
+	modparm.vertical_sync_polarity =
+		(var->sync & FB_SYNC_HOR_HIGH_ACT) ? POS : NEG;
+	modparm.horizontal_sync_polarity =
+		(var->sync & FB_SYNC_VERT_HIGH_ACT) ? POS : NEG;
+	modparm.clock_phase_polarity =
+		(var->sync & FB_SYNC_COMP_HIGH_ACT) ? POS : NEG;
 	modparm.horizontal_display_end = var->xres;
 	modparm.horizontal_sync_width = var->hsync_len;
 	modparm.horizontal_sync_start = var->xres + var->right_margin;
@@ -314,7 +314,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 	if (crtc->channel != sm750_secondary) {
 		/* set pitch, offset, width, start address, etc... */
 		poke32(PANEL_FB_ADDRESS,
-		       crtc->oScreen & PANEL_FB_ADDRESS_ADDRESS_MASK);
+		       crtc->o_screen & PANEL_FB_ADDRESS_ADDRESS_MASK);
 
 		reg = var->xres * (var->bits_per_pixel >> 3);
 		/*
@@ -323,17 +323,17 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 		 */
 		reg = ALIGN(reg, crtc->line_pad);
 		reg = (reg << PANEL_FB_WIDTH_WIDTH_SHIFT) &
-		       PANEL_FB_WIDTH_WIDTH_MASK;
+		      PANEL_FB_WIDTH_WIDTH_MASK;
 		reg |= (fix->line_length & PANEL_FB_WIDTH_OFFSET_MASK);
 		poke32(PANEL_FB_WIDTH, reg);
 
 		reg = ((var->xres - 1) << PANEL_WINDOW_WIDTH_WIDTH_SHIFT) &
-		       PANEL_WINDOW_WIDTH_WIDTH_MASK;
+		      PANEL_WINDOW_WIDTH_WIDTH_MASK;
 		reg |= (var->xoffset & PANEL_WINDOW_WIDTH_X_MASK);
 		poke32(PANEL_WINDOW_WIDTH, reg);
 
-		reg = (var->yres_virtual - 1) <<
-		      PANEL_WINDOW_HEIGHT_HEIGHT_SHIFT;
+		reg = (var->yres_virtual - 1)
+		      << PANEL_WINDOW_HEIGHT_HEIGHT_SHIFT;
 		reg &= PANEL_WINDOW_HEIGHT_HEIGHT_MASK;
 		reg |= (var->yoffset & PANEL_WINDOW_HEIGHT_Y_MASK);
 		poke32(PANEL_WINDOW_HEIGHT, reg);
@@ -341,7 +341,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 		poke32(PANEL_PLANE_TL, 0);
 
 		reg = ((var->yres - 1) << PANEL_PLANE_BR_BOTTOM_SHIFT) &
-		       PANEL_PLANE_BR_BOTTOM_MASK;
+		      PANEL_PLANE_BR_BOTTOM_MASK;
 		reg |= ((var->xres - 1) & PANEL_PLANE_BR_RIGHT_MASK);
 		poke32(PANEL_PLANE_BR, reg);
 
@@ -350,7 +350,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 		poke32(PANEL_DISPLAY_CTRL, reg | (var->bits_per_pixel >> 4));
 	} else {
 		/* not implemented now */
-		poke32(CRT_FB_ADDRESS, crtc->oScreen);
+		poke32(CRT_FB_ADDRESS, crtc->o_screen);
 		reg = var->xres * (var->bits_per_pixel >> 3);
 		/*
 		 * crtc->channel is not equal to par->index on numeric,
@@ -372,10 +372,10 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 	return ret;
 }
 
-int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index,
-		       ushort red, ushort green, ushort blue)
+int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index, ushort red,
+		       ushort green, ushort blue)
 {
-	static unsigned int add[] = {PANEL_PALETTE_RAM, CRT_PALETTE_RAM};
+	static unsigned int add[] = { PANEL_PALETTE_RAM, CRT_PALETTE_RAM };
 
 	poke32(add[crtc->channel] + index * 4,
 	       (red << 16) | (green << 8) | blue);
@@ -510,7 +510,7 @@ int hw_sm750le_deWait(void)
 {
 	int i = 0x10000000;
 	unsigned int mask = DE_STATE2_DE_STATUS_BUSY | DE_STATE2_DE_FIFO_EMPTY |
-		DE_STATE2_DE_MEM_FIFO_EMPTY;
+			    DE_STATE2_DE_MEM_FIFO_EMPTY;
 
 	while (i--) {
 		unsigned int val = peek32(DE_STATE2);
@@ -527,8 +527,8 @@ int hw_sm750_deWait(void)
 {
 	int i = 0x10000000;
 	unsigned int mask = SYSTEM_CTRL_DE_STATUS_BUSY |
-		SYSTEM_CTRL_DE_FIFO_EMPTY |
-		SYSTEM_CTRL_DE_MEM_FIFO_EMPTY;
+			    SYSTEM_CTRL_DE_FIFO_EMPTY |
+			    SYSTEM_CTRL_DE_MEM_FIFO_EMPTY;
 
 	while (i--) {
 		unsigned int val = peek32(SYSTEM_CTRL);
@@ -554,15 +554,15 @@ int hw_sm750_pan_display(struct lynxfb_crtc *crtc,
 
 	total = var->yoffset * info->fix.line_length +
 		((var->xoffset * var->bits_per_pixel) >> 3);
-	total += crtc->oScreen;
+	total += crtc->o_screen;
 	if (crtc->channel == sm750_primary) {
 		poke32(PANEL_FB_ADDRESS,
 		       peek32(PANEL_FB_ADDRESS) |
-		       (total & PANEL_FB_ADDRESS_ADDRESS_MASK));
+			       (total & PANEL_FB_ADDRESS_ADDRESS_MASK));
 	} else {
 		poke32(CRT_FB_ADDRESS,
 		       peek32(CRT_FB_ADDRESS) |
-		       (total & CRT_FB_ADDRESS_ADDRESS_MASK));
+			       (total & CRT_FB_ADDRESS_ADDRESS_MASK));
 	}
 	return 0;
 }
-- 
2.31.1

