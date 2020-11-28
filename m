Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041B8C63777
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DBD20702
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tvzCFnaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbgK1Wnb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbgK1Wn3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:43:29 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF0FC0613D1
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:42:03 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id s27so12750239lfp.5
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5MJlaKcTS845wbNZGaIoS2kPxxU74n2R9tKR7IOQIuA=;
        b=tvzCFnaKarri4MrMt/OOBX4UYabnmocLUjuejQpGNQHUbU1DV6B8ZgY3G77V3kezjS
         TjZKXyvlQ9iCHDG6ntv/X/orBmg0DjjdkGE6hTXPdAuSBP2EYE1V8VsonslrBQw9+mGb
         FD854fbfMhhp0lNLk880C3CTN4ruQLvxeqY3O4+fCM8IRdEhz5qLr15AO69rFVOYqyzZ
         svz4z+Qz8nd4wmxP3lb28IIk1+Bl24bS8CGDh5JSpkdhBS0ouH65+e0hekQ5q/QfxGFC
         DNnmoyu4ginXvCr6uQdvL6yx9/fXSAVcuv+WiZz0VrA8PRDNzTrGcFt5rkgJYY29QCr7
         8upA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5MJlaKcTS845wbNZGaIoS2kPxxU74n2R9tKR7IOQIuA=;
        b=mcekx80I/4T1FzhBXkkyIHM+v9XyiueGqwKxDKKQMgwMdih4v3AoW82yRt3+is8e7E
         Jp5VebJMEwlPzJy9fb9sfkL2OlbogjHpTBBjw7wT2eoX+Wse2u4pO/Ei8adU2UKXZSoE
         7Y3xjyTASsUr+PpQ/kb96R1g90xDcCydAoj15NgB/MnmdPQAPhu9HBZ6Q4KILHncB3pn
         uHVf5gwtXecB/y9+Mo+qTsqFKE19HTO5emZ1Jp2YXoXSTN8dktZ8KJa0yOgN0ok9W/jc
         yvcuJpeN3PZlq2y4CPqdRdfofdEZ8BXSBSukzqIA8DxoaDW0SOwWwxWF3h/S13kzuVGf
         /CyA==
X-Gm-Message-State: AOAM533SHNc4HvmMjV8LvzH8CYy85Nb/vhd1zcCkv0YFzNGuOyUr139m
        Iet10FasApQf1wxb7aWbi4+GBu48VCfSTA==
X-Google-Smtp-Source: ABdhPJxedjLhnAr5B6nJvt/A/46S2ueviNNylSrgyAirvdAVc5ST23a882taVbnarg8qv8rIuZvs4g==
X-Received: by 2002:ac2:446f:: with SMTP id y15mr6344891lfl.415.1606603321907;
        Sat, 28 Nov 2020 14:42:01 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:42:01 -0800 (PST)
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
Subject: [PATCH v2 21/28] video: fbdev: tmiofb: Fix set but not used warnings
Date:   Sat, 28 Nov 2020 23:41:07 +0100
Message-Id: <20201128224114.1033617-22-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warnings by avoiding local variables and use direct references.

v2:
  - Updated subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/tmiofb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/tmiofb.c b/drivers/video/fbdev/tmiofb.c
index 50111966c981..b70faa3850f2 100644
--- a/drivers/video/fbdev/tmiofb.c
+++ b/drivers/video/fbdev/tmiofb.c
@@ -802,10 +802,8 @@ static int tmiofb_remove(struct platform_device *dev)
 	const struct mfd_cell *cell = mfd_get_cell(dev);
 	struct fb_info *info = platform_get_drvdata(dev);
 	int irq = platform_get_irq(dev, 0);
-	struct tmiofb_par *par;
 
 	if (info) {
-		par = info->par;
 		unregister_framebuffer(info);
 
 		tmiofb_hw_stop(dev);
@@ -816,8 +814,8 @@ static int tmiofb_remove(struct platform_device *dev)
 		free_irq(irq, info);
 
 		iounmap(info->screen_base);
-		iounmap(par->lcr);
-		iounmap(par->ccr);
+		iounmap(((struct tmiofb_par *)info->par)->lcr);
+		iounmap(((struct tmiofb_par *)info->par)->ccr);
 
 		framebuffer_release(info);
 	}
-- 
2.27.0

