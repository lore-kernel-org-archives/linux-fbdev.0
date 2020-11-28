Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AD9C71155
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A322720702
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6GqQD3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387803AbgK1Wmy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387804AbgK1Wmx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:42:53 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB0FC061A4C
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:44 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y10so10588735ljc.7
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qQbdoMGfp7HI6Wmt4IR8iWJeCZkxPlinkDvEVc1r82A=;
        b=I6GqQD3fz1EqGD498t1GsLkIHDFsRv7/o3xRXWseWPdVQCKrCv2QN8njbKtX7/+cz+
         smvA7q0jnFm1q/Dd7pQ2F/L2yCX1fFZPKJj0Kw043RE5OWX9f2eAIn3tkU+6HpN70Cji
         AyBSZBvy9qs/unaX+yF8BwNQrOkMG/ffP2VFFu/g7pVCSjL9G+x7Q+Vup9KCo38ZNOIy
         VG2zGt8jy6PeULtQMpE8KtRVaMPR7wrdMa45Aho5tLl8Ai/h9m7nCT0zjkFDzxwxXw45
         bsU1QTW0NdlWDMGK4uCZL+WLbgDejqM9XOPK5RqZfGE7Vq/eMRQT9z11o0frnevy8AyM
         pZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qQbdoMGfp7HI6Wmt4IR8iWJeCZkxPlinkDvEVc1r82A=;
        b=YKunubawUV7yE9Uwk3E21x9H0vz7aToArXGbqx8i4U6ahWQDeZ6ELsX914dKtcsEw8
         AzzX1vcPp+ReesYoV84WB6B5DMhyADDxTP3uOsfvgzct2O/FfFa+qpLAd9AT09xxffkS
         2dGQcfvWPosSVqwXgmYqw9V3DeX2WrQG1BjtW0D+pVmxJbSKuu1iV8gjfoigrUyLLSfe
         f3hgZD/8uiy9wz5WPyPUdhKvUQUQHTDeGaYeXxVJ2W+z+4qfxGe7q66SNtuaA/AIh9YF
         qWhMzLsims1afljq0wiQGpYtWod1QE+3O6BkI8qGQjbL4eAl3p3uYCEeyfuFext7dvDH
         Ch7A==
X-Gm-Message-State: AOAM530VzWa+1Rv1HjFuoAlbhwzu29TmfNPBuQx/nz/RiUoDaU32bwKz
        GM1ahTO6Gg2X7OiTYBjOrntIqpWux/7sgA==
X-Google-Smtp-Source: ABdhPJzFyXGSucNfx9yncv1e42W9SVj8LPo5R/vJS1rgbRNBov9ReHwMEZgrMKy4kizi21GFlNwCQA==
X-Received: by 2002:a2e:535a:: with SMTP id t26mr6393928ljd.87.1606603303293;
        Sat, 28 Nov 2020 14:41:43 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:42 -0800 (PST)
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
Subject: [PATCH v2 11/28] video: fbdev: via: Fix set but not used warning for mode_crt_table
Date:   Sat, 28 Nov 2020 23:40:57 +0100
Message-Id: <20201128224114.1033617-12-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix warning by deleting the variable. The function call
viafb_get_best_mode() were verified to have no side-effects,
and thus could be dropped too.

v2:
  - Update subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/via/lcd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/via/lcd.c b/drivers/video/fbdev/via/lcd.c
index 4a869402d120..088b962076b5 100644
--- a/drivers/video/fbdev/via/lcd.c
+++ b/drivers/video/fbdev/via/lcd.c
@@ -537,11 +537,9 @@ void viafb_lcd_set_mode(const struct fb_var_screeninfo *var, u16 cxres,
 	u32 clock;
 	struct via_display_timing timing;
 	struct fb_var_screeninfo panel_var;
-	const struct fb_videomode *mode_crt_table, *panel_crt_table;
+	const struct fb_videomode *panel_crt_table;
 
 	DEBUG_MSG(KERN_INFO "viafb_lcd_set_mode!!\n");
-	/* Get mode table */
-	mode_crt_table = viafb_get_best_mode(set_hres, set_vres, 60);
 	/* Get panel table Pointer */
 	panel_crt_table = viafb_get_best_mode(panel_hres, panel_vres, 60);
 	viafb_fill_var_timing_info(&panel_var, panel_crt_table);
-- 
2.27.0

