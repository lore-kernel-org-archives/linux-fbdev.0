Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167DDC63777
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20EC20771
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rv/zkpFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgK1Wmo (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgK1Wmn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:42:43 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100C2C061A04
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:34 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id s27so12748871lfp.5
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pEqxbCWX9q9yDbDvSbn0kwCSjD77LNJ8Br1S/hGjS4Y=;
        b=Rv/zkpFM80luzwk9qz8tKKHWMQ6AMMsclRVZq8PzkJM18cISEnSccV7Z8NIypZ1jW/
         UpJkema7xmGdArdEUTxR3gSPeu/62Fr6qy4keamZ0qJNqIQD4YRj1StMsnasqAFSSZ2i
         nF68Z1WHShiUim0pi8VvWJKFAcfN8Jfhke8fy9mYSrj/rvKau8xzj8LEJo+jBhVJUZeD
         Clfkv1bN3MyIy9fOm7S9V8Pc+2ayjfrjqSUkchx1EursTN5wqxO9Bb4YCYAyII3W9mYP
         nwn5OYVYnhEOLz4R7WWkyxFs8r+3ZzFCNbcB4d4Y9Fjkmr9TXb3rUL4DXvKhIu65S/qb
         vfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pEqxbCWX9q9yDbDvSbn0kwCSjD77LNJ8Br1S/hGjS4Y=;
        b=iM/ZYCoEeC/qxPjZahIXQIKPKUh5RgdFSBb9SS1vzYhg564INaWfhjWryAEgqAlbnO
         vNdFpd9VqISUe1rkkSmEQRD7/oSdKqZmSEd6gky03S8gyb2QDUp7rcyYfQq7w6b2Ji1w
         9d1kC40LjHEQtn3m6fn6xK2yYbbXlPQRw72KiYVI4DP3IrUZj6HWIzS0cXyAPt6qSc19
         6717KQANaDQUqumaFZj8ItZSVV53ATqmkDEIc+wzgQnGOxd1oYnGiE3/pjqq0vRYqsDv
         AkyU++Jy6CdWbfPEEPkv4JnxC4H7q6+4FMYMLAy0NWsaBgHs96UOtJ7rar66IrXy006O
         JrKQ==
X-Gm-Message-State: AOAM531Ct5qw0NxFrlQJHUmWikr1znzNtG+xpbh8FLfu1Yib/yWYb6OH
        bVskH82wbHPKr8GWVIsOQT2JnwWEQwYlcQ==
X-Google-Smtp-Source: ABdhPJxCfP77M8/2JZ9sjq/1cfSJg2rs/6jPaUmktbALDcsy2SGRemB6E1qPPqvUpiL7ISv6YIEbXA==
X-Received: by 2002:a19:3817:: with SMTP id f23mr6381269lfa.587.1606603292296;
        Sat, 28 Nov 2020 14:41:32 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:31 -0800 (PST)
Sender: Sam Ravnborg <sam.ravnborg@gmail.com>
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Evgeny Novikov <novikov@ispras.ru>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimemrmann <tzimmermann@suse.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 05/28] video: fbdev: aty: Fix set but not used warnings
Date:   Sat, 28 Nov 2020 23:40:51 +0100
Message-Id: <20201128224114.1033617-6-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warnings about variables assigned but never used.

- Drop variables that was set but never used
- Make variable definition conditional om ATARI

v2:
  - Fix m68k build error (kernel test robot)
  - Improve subject (Lee Jones)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reported-by: kernel test robot <lkp@intel.com> # m68k build fix
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Joe Perches <joe@perches.com>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: Jason Yan <yanaijie@huawei.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jani Nikula <jani.nikula@intel.com>
---
 drivers/video/fbdev/aty/atyfb_base.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index c8feff0ee8da..83c8e809955a 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -2353,6 +2353,9 @@ static int aty_init(struct fb_info *info)
 	int gtb_memsize, has_var = 0;
 	struct fb_var_screeninfo var;
 	int ret;
+#ifdef CONFIG_ATARI
+	u8 dac_type;
+#endif
 
 	init_waitqueue_head(&par->vblank.wait);
 	spin_lock_init(&par->int_lock);
@@ -2360,13 +2363,12 @@ static int aty_init(struct fb_info *info)
 #ifdef CONFIG_FB_ATY_GX
 	if (!M64_HAS(INTEGRATED)) {
 		u32 stat0;
-		u8 dac_type, dac_subtype, clk_type;
+		u8 dac_subtype, clk_type;
 		stat0 = aty_ld_le32(CNFG_STAT0, par);
 		par->bus_type = (stat0 >> 0) & 0x07;
 		par->ram_type = (stat0 >> 3) & 0x07;
 		ramname = aty_gx_ram[par->ram_type];
 		/* FIXME: clockchip/RAMDAC probing? */
-		dac_type = (aty_ld_le32(DAC_CNTL, par) >> 16) & 0x07;
 #ifdef CONFIG_ATARI
 		clk_type = CLK_ATI18818_1;
 		dac_type = (stat0 >> 9) & 0x07;
@@ -2375,7 +2377,6 @@ static int aty_init(struct fb_info *info)
 		else
 			dac_subtype = (aty_ld_8(SCRATCH_REG1 + 1, par) & 0xF0) | dac_type;
 #else
-		dac_type = DAC_IBMRGB514;
 		dac_subtype = DAC_IBMRGB514;
 		clk_type = CLK_IBMRGB514;
 #endif
@@ -3062,7 +3063,6 @@ static int atyfb_setup_sparc(struct pci_dev *pdev, struct fb_info *info,
 	if (dp == of_console_device) {
 		struct fb_var_screeninfo *var = &default_var;
 		unsigned int N, P, Q, M, T, R;
-		u32 v_total, h_total;
 		struct crtc crtc;
 		u8 pll_regs[16];
 		u8 clock_cntl;
@@ -3078,9 +3078,6 @@ static int atyfb_setup_sparc(struct pci_dev *pdev, struct fb_info *info,
 		crtc.gen_cntl = aty_ld_le32(CRTC_GEN_CNTL, par);
 		aty_crtc_to_var(&crtc, var);
 
-		h_total = var->xres + var->right_margin + var->hsync_len + var->left_margin;
-		v_total = var->yres + var->lower_margin + var->vsync_len + var->upper_margin;
-
 		/*
 		 * Read the PLL to figure actual Refresh Rate.
 		 */
-- 
2.27.0

