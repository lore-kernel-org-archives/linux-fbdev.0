Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FDAC63798
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE66820702
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBaZDIVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgK1Wmo (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgK1Wmn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:42:43 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C570AC061A47
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:35 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id z21so12716456lfe.12
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FQt8Zy/RcRTV8RI+7xEG7mp4eH+bacz1GI81AvTRW6U=;
        b=nBaZDIVAfz80bCWu0yx2DfH3RI13Bv/U6WR5FSXtmNgxDUZXMLAKS8UEUBUWMDvuhH
         iSuHokAerrLo55ZyCEFz3mrNq97Efiej0UmE67ApNz9XOJhfmNvYS2iYP83fqoBPLROX
         BbHu6iprRb37DY6gDWPwEWKmzHulr1TV1D0BYXqNKnDt8u3DJFz/TytLcCZaol9EHDKK
         G3FYHO04RHFffxaqvqP24nuo6UMz2pKoXf5cvdLdbFdFRJLTFa92Yq2jg4aCfbX6v+YK
         /Mt7VGyqhY/26NVWBp0nAtKCVQ3YWvgLxqtlRAYSoa//bjwPkRu4sRtQb74AEgtPmqIl
         gJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FQt8Zy/RcRTV8RI+7xEG7mp4eH+bacz1GI81AvTRW6U=;
        b=FO9coWsW9eUZ3X6YDc3QhpD+1iZ/hnlbPTbufHhyXq+2tpA5cqLEEPpk7n9wyiJXoO
         73oZsOPTNTEI1YKAbuqKNbPdJKXh4sVJHsuFGJdAjOw+ZYOPEhpz+IxLmqsA2S+63wNb
         AA0fQEsynMY4Um2FKLZ3wSigNimcRWzvWDmdkzRdHmVJiAyiiCF8bqhUlATwXTi8iHoS
         hQ4dDtyvKsxYphCOYoWNNu7lcQTca8qgYqZriAdSo7NWnmLu767YaVmM2Cpt9B6Ghf0+
         pilaFdTe+9hx8LV6rJDk160DKKh1PJ5F2RqZp+TvYrh2/y7kpBwm11Xx6F6qjvhuMoHW
         I76g==
X-Gm-Message-State: AOAM531GGCCoF6bMX3KH4wbXqGDXSkau2e5/0PgCcGufDN00uEK+a6QC
        9ZFD22pjllmfPEIKrIaNgqTX1HK6oCLv0w==
X-Google-Smtp-Source: ABdhPJzlQNjBNn705RJBUCQ/M55lwEEf/6mv51LCAvjVISvV38KZWfSsU8ScP0w3xaBDZ7N217vjFA==
X-Received: by 2002:ac2:5b88:: with SMTP id o8mr6729659lfn.265.1606603294085;
        Sat, 28 Nov 2020 14:41:34 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:33 -0800 (PST)
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
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v2 06/28] video: fbdev: aty: Fix set but not used warnings in mach64_ct
Date:   Sat, 28 Nov 2020 23:40:52 +0100
Message-Id: <20201128224114.1033617-7-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warnings about variables assigned but never used.
- One variable is only used when CONFIG_FB_ATY_GENERIC_LCD is defined
  Fix so variable is only defined with CONFIG_FB_ATY_GENERIC_LCD
- Several variables was only assigned by a call to aty_ld_le32().
  Drop the variables but keep the call to aty_ld_le32() as it may
  have unexpected side-effects.

v2:
  - Updated subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/aty/mach64_ct.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/aty/mach64_ct.c b/drivers/video/fbdev/aty/mach64_ct.c
index f87cc81f4fa2..011b07e44e0d 100644
--- a/drivers/video/fbdev/aty/mach64_ct.c
+++ b/drivers/video/fbdev/aty/mach64_ct.c
@@ -281,10 +281,13 @@ static u32 aty_pll_to_var_ct(const struct fb_info *info, const union aty_pll *pl
 void aty_set_pll_ct(const struct fb_info *info, const union aty_pll *pll)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
-	u32 crtc_gen_cntl, lcd_gen_cntrl;
+	u32 crtc_gen_cntl;
 	u8 tmp, tmp2;
 
-	lcd_gen_cntrl = 0;
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	u32 lcd_gen_cntrl = 0;
+#endif
+
 #ifdef DEBUG
 	printk("atyfb(%s): about to program:\n"
 		"pll_ext_cntl=0x%02x pll_gen_cntl=0x%02x pll_vclk_cntl=0x%02x\n",
@@ -402,7 +405,7 @@ static int aty_init_pll_ct(const struct fb_info *info, union aty_pll *pll)
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u8 mpost_div, xpost_div, sclk_post_div_real;
 	u32 q, memcntl, trp;
-	u32 dsp_config, dsp_on_off, vga_dsp_config, vga_dsp_on_off;
+	u32 dsp_config;
 #ifdef DEBUG
 	int pllmclk, pllsclk;
 #endif
@@ -488,9 +491,9 @@ static int aty_init_pll_ct(const struct fb_info *info, union aty_pll *pll)
 
 	/* Allow BIOS to override */
 	dsp_config = aty_ld_le32(DSP_CONFIG, par);
-	dsp_on_off = aty_ld_le32(DSP_ON_OFF, par);
-	vga_dsp_config = aty_ld_le32(VGA_DSP_CONFIG, par);
-	vga_dsp_on_off = aty_ld_le32(VGA_DSP_ON_OFF, par);
+	aty_ld_le32(DSP_ON_OFF, par);
+	aty_ld_le32(VGA_DSP_CONFIG, par);
+	aty_ld_le32(VGA_DSP_ON_OFF, par);
 
 	if (dsp_config)
 		pll->ct.dsp_loop_latency = (dsp_config & DSP_LOOP_LATENCY) >> 16;
-- 
2.27.0

