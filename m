Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6152FC433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DA8C61222
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbhDGGpb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349151AbhDGGp1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:45:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04E8C06174A;
        Tue,  6 Apr 2021 23:45:18 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so758952pjb.0;
        Tue, 06 Apr 2021 23:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WxWGo8ILtmVAdW7DYZqUtw98RFWj2ze6hbKX+KcSEqI=;
        b=MF2sB6L4LiOtKsVFzSV9iCM5li/W9l6IytIBgpMZmNQDUYUI+qHjjZsjOS8T8o/Xly
         Lg/gMMbN/v2uoWV9lxC0Xl/dSc9n4ZaAkItZt+0aOjZv7CtUyUqd0RAVzhWv+n7+c8FT
         QKUFg9h89HuHub9a/go9nbPJfZ/rVPC8w6DwJBJ0xnsoZu4QHoloGsO2T1DZOiEpMp+B
         HUv8h7ji8AYYCzZ6/wcHUme3La7bvf1odNBmp6Sdu0ecntWk5lW0HjA0LzQEzSqQaq1F
         c8yJNCuPDOI4q7AacmJvMnd9dZJpiN+SZNwRyR2GIQ+VOZvHKyQl14zx8fGheiwIilFt
         /NfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WxWGo8ILtmVAdW7DYZqUtw98RFWj2ze6hbKX+KcSEqI=;
        b=gKnFwHIRhdst3Gv9eiDWUB5d0jRfxO/zrXyaX8XbnjLrGJp/p8W3SO6ytSOEpshH0a
         yw1wRrDZX9CssuXTm83TcpPCYG48TxCxy0z/h83+Z96o8wrVEvgrcmp73YfVqqhbeb4A
         OKNbodc2x4AbwiSfpHPb0L+eyPjr8iG9xoz/7xdAVO2+K6AG1fziM3LDtQ/hVwTCJpR9
         dDOVimTsr6Ejxrm90Tsx3dkEUAEsQa1G3kG2eLmEYjs51/qvLxvrUCxctkttbJS1Y+fF
         QhUk3ThpUf8L5MTTGB2HitRICdveeewsJftPT++D5X0P3x5bQ0sk85r8RSguZ7dVq2On
         aKPA==
X-Gm-Message-State: AOAM531wPWgg7X/0UH+b/QQ108fOehR9fstmJNCGRskJH5IiWJuIRxQh
        6jfj9jpgeEOptGuwo2Ef0rU=
X-Google-Smtp-Source: ABdhPJwBgQPbWKpEIXmeAH2VyBDeKJvWfUDqQScruju9ROclIK6s70UEE31A1gkggUugQQ/uY+fsqQ==
X-Received: by 2002:a17:902:ea93:b029:e9:4b38:deef with SMTP id x19-20020a170902ea93b02900e94b38deefmr1760652plb.22.1617777918397;
        Tue, 06 Apr 2021 23:45:18 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id g15sm3877642pjd.2.2021.04.06.23.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:45:18 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:45:16 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 35/49] staging: sm750fb: Update members of sm750_dev
 struct to snake case
Message-ID: <d56dbb6b124ea025683701cf440bd61eef027f5c.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the members of
sm750_dev structure, in particular initParam, pvReg, pvMem, and hwCursor.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 36 +++++++++++++++---------------
 drivers/staging/sm750fb/sm750.h    |  8 +++----
 drivers/staging/sm750fb/sm750_hw.c | 22 +++++++++---------
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 58de4b9575d9..22881d35c9ad 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -598,7 +598,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		crtc->vidmem_size >>= 1;
 
 	/* setup crtc and output member */
-	sm750_dev->hwCursor = g_hwcursor;
+	sm750_dev->hw_cursor = g_hwcursor;
 
 	crtc->line_pad = 16;
 	crtc->xpanstep = 8;
@@ -615,27 +615,27 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_primary;
 		crtc->oScreen = 0;
-		crtc->vScreen = sm750_dev->pvMem;
+		crtc->vScreen = sm750_dev->mem;
 		pr_info("use simul primary mode\n");
 		break;
 	case sm750_simul_sec:
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_secondary;
 		crtc->oScreen = 0;
-		crtc->vScreen = sm750_dev->pvMem;
+		crtc->vScreen = sm750_dev->mem;
 		break;
 	case sm750_dual_normal:
 		if (par->index == 0) {
 			output->paths = sm750_panel;
 			crtc->channel = sm750_primary;
 			crtc->oScreen = 0;
-			crtc->vScreen = sm750_dev->pvMem;
+			crtc->vScreen = sm750_dev->mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_secondary;
 			/* not consider of padding stuffs for oScreen,need fix */
 			crtc->oScreen = sm750_dev->vidmem_size >> 1;
-			crtc->vScreen = sm750_dev->pvMem + crtc->oScreen;
+			crtc->vScreen = sm750_dev->mem + crtc->oScreen;
 		}
 		break;
 	case sm750_dual_swap:
@@ -643,7 +643,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			output->paths = sm750_panel;
 			crtc->channel = sm750_secondary;
 			crtc->oScreen = 0;
-			crtc->vScreen = sm750_dev->pvMem;
+			crtc->vScreen = sm750_dev->mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_primary;
@@ -651,7 +651,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			 * need fix
 			 */
 			crtc->oScreen = sm750_dev->vidmem_size >> 1;
-			crtc->vScreen = sm750_dev->pvMem + crtc->oScreen;
+			crtc->vScreen = sm750_dev->mem + crtc->oScreen;
 		}
 		break;
 	default:
@@ -719,13 +719,13 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * must be set after crtc member initialized
 	 */
 	crtc->cursor.offset = crtc->oScreen + crtc->vidmem_size - 1024;
-	crtc->cursor.mmio = sm750_dev->pvReg +
+	crtc->cursor.mmio = sm750_dev->reg +
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
 	crtc->cursor.max_h = crtc->cursor.max_w = 64;
 	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
-	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
+	crtc->cursor.vstart = sm750_dev->mem + crtc->cursor.offset;
 
 	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
 	if (!g_hwcursor) {
@@ -870,12 +870,12 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 
 	swap = 0;
 
-	sm750_dev->initParm.chip_clk = 0;
-	sm750_dev->initParm.mem_clk = 0;
-	sm750_dev->initParm.master_clk = 0;
-	sm750_dev->initParm.power_mode = 0;
-	sm750_dev->initParm.set_all_eng_off = 0;
-	sm750_dev->initParm.reset_memory = 1;
+	sm750_dev->init_parm.chip_clk = 0;
+	sm750_dev->init_parm.mem_clk = 0;
+	sm750_dev->init_parm.master_clk = 0;
+	sm750_dev->init_parm.power_mode = 0;
+	sm750_dev->init_parm.set_all_eng_off = 0;
+	sm750_dev->init_parm.reset_memory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
 	g_hwcursor = 3;
@@ -1061,7 +1061,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 		sm750_dev->mtrr.vram = arch_phys_wc_add(sm750_dev->vidmem_start,
 							sm750_dev->vidmem_size);
 
-	memset_io(sm750_dev->pvMem, 0, sm750_dev->vidmem_size);
+	memset_io(sm750_dev->mem, 0, sm750_dev->vidmem_size);
 
 	pci_set_drvdata(pdev, sm750_dev);
 
@@ -1092,8 +1092,8 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	sm750fb_framebuffer_release(sm750_dev);
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
-	iounmap(sm750_dev->pvReg);
-	iounmap(sm750_dev->pvMem);
+	iounmap(sm750_dev->reg);
+	iounmap(sm750_dev->mem);
 	kfree(g_settings);
 }
 
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index f946d35d30d0..6f3af779f3b0 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -97,12 +97,12 @@ struct sm750_dev {
 	unsigned long vidreg_start;
 	__u32 vidmem_size;
 	__u32 vidreg_size;
-	void __iomem *pvReg;
-	unsigned char __iomem *pvMem;
+	void __iomem *reg;
+	unsigned char __iomem *mem;
 	/* locks*/
 	spinlock_t slock;
 
-	struct init_status initParm;
+	struct init_status init_parm;
 	enum sm750_pnltype pnltype;
 	enum sm750_dataflow dataflow;
 	int nocrt;
@@ -113,7 +113,7 @@ struct sm750_dev {
 	 * 2: secondary crtc hw cursor enabled
 	 * 3: both ctrc hw cursor enabled
 	 */
-	int hwCursor;
+	int hw_cursor;
 };
 
 struct lynx_cursor {
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index efe379ef3438..add9daa585fd 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -50,20 +50,20 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	}
 
 	/* now map mmio and vidmem */
-	sm750_dev->pvReg = ioremap(sm750_dev->vidreg_start,
+	sm750_dev->reg = ioremap(sm750_dev->vidreg_start,
 				   sm750_dev->vidreg_size);
-	if (!sm750_dev->pvReg) {
+	if (!sm750_dev->reg) {
 		pr_err("mmio failed\n");
 		ret = -EFAULT;
 		goto exit;
 	} else {
-		pr_info("mmio virtual addr = %p\n", sm750_dev->pvReg);
+		pr_info("mmio virtual addr = %p\n", sm750_dev->reg);
 	}
 
-	sm750_dev->accel.dprBase = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
-	sm750_dev->accel.dpPortBase = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
+	sm750_dev->accel.dprBase = sm750_dev->reg + DE_BASE_ADDR_TYPE1;
+	sm750_dev->accel.dpPortBase = sm750_dev->reg + DE_PORT_ADDR_TYPE1;
 
-	mmio750 = sm750_dev->pvReg;
+	mmio750 = sm750_dev->reg;
 	sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
 
 	sm750_dev->vidmem_start = pci_resource_start(pdev, 0);
@@ -78,14 +78,14 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		sm750_dev->vidmem_start, sm750_dev->vidmem_size);
 
 	/* reserve the vidmem space of smi adaptor */
-	sm750_dev->pvMem = ioremap_wc(sm750_dev->vidmem_start,
+	sm750_dev->mem = ioremap_wc(sm750_dev->vidmem_start,
 				      sm750_dev->vidmem_size);
-	if (!sm750_dev->pvMem) {
+	if (!sm750_dev->mem) {
 		pr_err("Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
 	} else {
-		pr_info("video memory vaddr = %p\n", sm750_dev->pvMem);
+		pr_info("video memory vaddr = %p\n", sm750_dev->mem);
 	}
 exit:
 	return ret;
@@ -95,7 +95,7 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 {
 	struct init_status *parm;
 
-	parm = &sm750_dev->initParm;
+	parm = &sm750_dev->init_parm;
 	if (parm->chip_clk == 0)
 		parm->chip_clk = (sm750_get_chip_type() == SM750LE) ?
 						DEFAULT_SM750LE_CHIP_CLOCK :
@@ -106,7 +106,7 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	if (parm->master_clk == 0)
 		parm->master_clk = parm->chip_clk / 3;
 
-	ddk750_init_hw((struct initchip_param *)&sm750_dev->initParm);
+	ddk750_init_hw((struct initchip_param *)&sm750_dev->init_parm);
 	/* for sm718, open pci burst */
 	if (sm750_dev->devid == 0x718) {
 		poke32(SYSTEM_CTRL,
-- 
2.30.2

