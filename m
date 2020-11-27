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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EFDC63798
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76F222210
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtFG8lhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgK1C3Q (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 21:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731056AbgK0T66 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:58:58 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3946C0613D4
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:48 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id d20so8514001lfe.11
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n7AUSPOHxh+ROspnXmAGmt29lw2/92P6Xx7q8Q73sVQ=;
        b=rtFG8lhgrSILnbwb3Lrt+6OpeHbZNZZZ0Hk1Pq3EWdYR4I2S5LnrPrBzUfYZdnhLbD
         NvK9RUJ9xGorG4tNxoKdBJ82XL2i8RQ04daPP5LdoFpZ5lZhxqs6KOh1eSj0w9JDaEWs
         kxhsYH47ImmndKEPH6OoKLEcPH0Ei1WHeekziKNNKCbiBTWrB4dPDNM659FywgbWkLjL
         syfH61UpKOOV4ilWc+dl+pdPB9hiUwUvphw+JRZZbGoS1fet27fx8K5LZezyUNZWqGpH
         oKkfek3UuGGeZo3m4GxX3ZegpL4xG8XJIvJLoC53LI2iYHIw0aLB76MnGLTcyklWZdf6
         Ig2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=n7AUSPOHxh+ROspnXmAGmt29lw2/92P6Xx7q8Q73sVQ=;
        b=saBBhJjyf6UY5g5+mArpD0EJUQP7dcwJhRo7eqE3QTRG3BNWYHbAFKQu3ir1+6WyaY
         8hpddTunqOrZEoaZ9rvIzYbvi2HhZqG3K6ftapGe9LYmCpV8slZgSW/rcXYUFdrB+doO
         ch/ZKP+xIY56L+NWlnXKovRqW+BoVaYZCn7BqtqoyX1e6J6NDNXe7sukexNYah0CbwB7
         wpg9JdW5kOGamWctgI0NIPzLwjeDQWiD3F+IC5A9BTnuHwtLIl7MJ0hq+omAC0pz8GgO
         zhC9oVH1GZwaCI3GCufxyfVw25oqpw5t4chQzq3drv9rpm6hI5cppLEO0+HjUmzpylQm
         7Odg==
X-Gm-Message-State: AOAM5307c0MQqQDXp5/7A4w5Am0YnWEdhGH5ES9X4qt/vTFlcmnX3GBn
        0+NPUD9HLjlaJ1vJLI0VlaIhpkFSkUrosao0
X-Google-Smtp-Source: ABdhPJwT6Vp8ufL83Vnm7rhaXWMBXozvqUMkmLlmRs0l1JHZOollRcQVcjhC7wW8zOiKw6exXOpPFA==
X-Received: by 2002:a05:6512:358d:: with SMTP id m13mr4193587lfr.435.1606507127242;
        Fri, 27 Nov 2020 11:58:47 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:58:46 -0800 (PST)
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
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
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
        linux-nvidia@lists.surfsouth.com,
        Michal Januszewski <spock@gentoo.org>,
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
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v1 05/28] video: fbdev: aty: Fix W=1 warnings in atyfb_base
Date:   Fri, 27 Nov 2020 20:58:02 +0100
Message-Id: <20201127195825.858960-6-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warnings about variables assigned but never used.

- Drop variables that was never used
- Avoid using a local variable by moving the expression to an if
  condition

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Joe Perches <joe@perches.com>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: Jason Yan <yanaijie@huawei.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jani Nikula <jani.nikula@intel.com>
---
 drivers/video/fbdev/aty/atyfb_base.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index c8feff0ee8da..d1eb9218debb 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -2360,22 +2360,20 @@ static int aty_init(struct fb_info *info)
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
+		aty_ld_le32(DAC_CNTL, par);
 #ifdef CONFIG_ATARI
 		clk_type = CLK_ATI18818_1;
-		dac_type = (stat0 >> 9) & 0x07;
-		if (dac_type == 0x07)
+		if (((stat0 >> 9) & 0x07) == 0x07)
 			dac_subtype = DAC_ATT20C408;
 		else
 			dac_subtype = (aty_ld_8(SCRATCH_REG1 + 1, par) & 0xF0) | dac_type;
 #else
-		dac_type = DAC_IBMRGB514;
 		dac_subtype = DAC_IBMRGB514;
 		clk_type = CLK_IBMRGB514;
 #endif
@@ -3062,7 +3060,6 @@ static int atyfb_setup_sparc(struct pci_dev *pdev, struct fb_info *info,
 	if (dp == of_console_device) {
 		struct fb_var_screeninfo *var = &default_var;
 		unsigned int N, P, Q, M, T, R;
-		u32 v_total, h_total;
 		struct crtc crtc;
 		u8 pll_regs[16];
 		u8 clock_cntl;
@@ -3078,9 +3075,6 @@ static int atyfb_setup_sparc(struct pci_dev *pdev, struct fb_info *info,
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

