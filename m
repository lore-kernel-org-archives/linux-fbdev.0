Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A333C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 486222224C
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ko3vuo/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgK0UAz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 15:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731059AbgK0T7C (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:59:02 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5DCC061A48
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:51 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id t22so7142893ljk.0
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/znDw06zFdh3Au85v8bQXn1l/SWiG3rqtYog18OgpP0=;
        b=Ko3vuo/CkINDtMby612nix2mMnEfnh1/yge7yOuFBmqaxTz4vqSVCRZfsDRQ2icjG9
         DMW/AY92frRlDN8st+P+UB8p1cOq7yx4/1vy67JClUGRQSi0Z42QttbRMIO8XAL7DLEj
         YeAc0Bijvcd2cna3RONHjpYkdRyZb+7xbxZMYcPD1628/DfTeaMwmDicQUkMQ9yzI3Q1
         VB5asklArK8o3s+R8dNYIVJko1jnksafX1OI2PSXgp1pXNgdw5bEt+q7ac25VhjnEYA9
         iEcWUDrH9cUe4lSCTfkfLYD000OMDCJ5rpPHF8lRZf1ihE85tIdvhLZE7h31TeCPQrhg
         0E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/znDw06zFdh3Au85v8bQXn1l/SWiG3rqtYog18OgpP0=;
        b=nrIZ96N/6RJ3+YMWxVgJtL5DkIWNPESORgtp2SmCh1h6xdveIfk8WXXcrso+v2seP4
         mAUH6yGIiGOQbTXuFSs9oiS6V4mA+ufVqeugRXVdUUaqXJ/xiN+lQjgh/KrPCAVuFMFJ
         Z6eedPpD911ORuwrR8TlCfxcrbXycHmUqZkDUOVw3LYorExVrKI+KPgxzc8BLZ4C+RR0
         JrZmUw8FtriQ2jeOWlN4IzRcmvhP4owtzYjBP+d4YCcxe5ZEQe75AJEVYnoRLaEZ867+
         FEd71XbROmAW1YbYB8Z3XZI2KVFqyVMP7QlJ69EnFzZqAo9nsrpSR2obLLHjccYMpL9y
         yM3Q==
X-Gm-Message-State: AOAM533egdR/9rYV15dW+fIMV2lTIlh26uoNVXTulLtrcsTTlR9NROhk
        D5KcZ0qVTZbqwKmUJD4pDtDPZQFW+eyqKPOA
X-Google-Smtp-Source: ABdhPJxJJrsSyrEycBj6HJRNco5cA49HBb6Xw5g+OEZnzHuIEFNhlHoXUIBL26kqzIT6LvYFOGW9zQ==
X-Received: by 2002:a2e:9118:: with SMTP id m24mr439285ljg.363.1606507129848;
        Fri, 27 Nov 2020 11:58:49 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:58:49 -0800 (PST)
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
Subject: [PATCH v1 06/28] video: fbdev: aty: Fix W=1 warnings in mach64_ct
Date:   Fri, 27 Nov 2020 20:58:03 +0100
Message-Id: <20201127195825.858960-7-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 about variables assigned but never used.
- One variable is only used when CONFIG_FB_ATY_GENERIC_LCD is defined
  Fix so variable is only defined with CONFIG_FB_ATY_GENERIC_LCD
- Several variables was only assigned by a call to aty_ld_le32().
  Drop the variables but keep the call to aty_ld_le32() as it may
  have unexpected side-effects.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
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

