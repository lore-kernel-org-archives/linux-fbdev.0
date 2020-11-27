Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174EDC3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62F220857
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCchEecM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgK1BTT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 20:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731337AbgK0UBX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 15:01:23 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A33C08E9AA
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:46 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id t6so8513948lfl.13
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y8wtXUawbSNHT6itVp9PKOsqounZ7r/XQRvyXGYV8s4=;
        b=uCchEecMQO/c968kGrHMi75DxnjAfug0UW+aYItCxW4i6Iwimiy9pksY5eUBYQwl4O
         r8N9m1kaX8yO9kzMiUW421bnoXfJr7otEBXhAuYXIryg8whiIzfAUYBqIWws/ZaF7Db6
         pUR8dvReqH2RzmOh2Ij82rZii5ClfkmrJcGUNcXSnm47I6Sx8veOKecG4zFG+TEV6VOx
         GpLoAwvsDjFcGew/J71nPkwrXZuP327XdXLBE5wnMp2Lx8H2ZTUaglXR7eTKkIO+I9oV
         huxDVJpCSoAeXhc6pxQuhKPDdR7CWYLz91ohFMgNqaRuE5RVnekpel+nxaAE+kFwn6Ji
         xQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Y8wtXUawbSNHT6itVp9PKOsqounZ7r/XQRvyXGYV8s4=;
        b=pwS/6YtQEUqd7f+8K79ew/ryFkjzHASCSd/LzNRkt4pPBGFs4EpMmS8LOicm6WnV0o
         GPW/ORF/Wo0cw/S2gBdIw6ym371Pcauvu2cjCkz/Y1xAiE4gQhR+6ldpYTyc7r6Bn8xa
         jJNY+N/gKqc4c+lspuTRgN58/x/fGXCTnlOouYcI4bBOoaTP+y8EbxAbkw2CWYrdJsOO
         QHsVWBZk1lmuDb7ygJ46+UQ7w0JTTzEqoL3o4ZUPxJ+4gh7dcUnbgz+WB5vdyUk9tfLx
         1rVvNTUbKR8Y6KxUBzctaP+g0yJ8Q9DC/C39q5ltLTMq3RIwpWIy22Z5aXviVOL17xB6
         BQkw==
X-Gm-Message-State: AOAM532txQLsC8Dell3UbUwVdaJVwbFXCqMI9KHdJ9dtemBQ/hzKfBzJ
        5CErU29V/Y9f/nj4awILyZFhXECeTNXD/XSb
X-Google-Smtp-Source: ABdhPJwgFjbWLJCd/wY65mHVlJvS4se9f+t/fvMNSUof1QOLLwqOeklo9SNHoshiG83N34pr1A6+7w==
X-Received: by 2002:a19:4bd2:: with SMTP id y201mr4378293lfa.330.1606507185047;
        Fri, 27 Nov 2020 11:59:45 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:59:44 -0800 (PST)
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
Subject: [PATCH v1 27/28] video: fbdev: cirrusfb: Fix W=1 warnings
Date:   Fri, 27 Nov 2020 20:58:24 +0100
Message-Id: <20201127195825.858960-28-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix warnings:
- fix kernel-doc
- delete unused code

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Zimemrmann <tzimmermann@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Mike Rapoport <rppt@kernel.org>
---
 drivers/video/fbdev/cirrusfb.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index e9027172c0f5..93802abbbc72 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -2463,8 +2463,6 @@ static void AttrOn(const struct cirrusfb_info *cinfo)
  */
 static void WHDR(const struct cirrusfb_info *cinfo, unsigned char val)
 {
-	unsigned char dummy;
-
 	if (is_laguna(cinfo))
 		return;
 	if (cinfo->btype == BT_PICASSO) {
@@ -2473,18 +2471,18 @@ static void WHDR(const struct cirrusfb_info *cinfo, unsigned char val)
 		WGen(cinfo, VGA_PEL_MSK, 0x00);
 		udelay(200);
 		/* next read dummy from pixel address (3c8) */
-		dummy = RGen(cinfo, VGA_PEL_IW);
+		RGen(cinfo, VGA_PEL_IW);
 		udelay(200);
 	}
 	/* now do the usual stuff to access the HDR */
 
-	dummy = RGen(cinfo, VGA_PEL_MSK);
+	RGen(cinfo, VGA_PEL_MSK);
 	udelay(200);
-	dummy = RGen(cinfo, VGA_PEL_MSK);
+	RGen(cinfo, VGA_PEL_MSK);
 	udelay(200);
-	dummy = RGen(cinfo, VGA_PEL_MSK);
+	RGen(cinfo, VGA_PEL_MSK);
 	udelay(200);
-	dummy = RGen(cinfo, VGA_PEL_MSK);
+	RGen(cinfo, VGA_PEL_MSK);
 	udelay(200);
 
 	WGen(cinfo, VGA_PEL_MSK, val);
@@ -2492,7 +2490,7 @@ static void WHDR(const struct cirrusfb_info *cinfo, unsigned char val)
 
 	if (cinfo->btype == BT_PICASSO) {
 		/* now first reset HDR access counter */
-		dummy = RGen(cinfo, VGA_PEL_IW);
+		RGen(cinfo, VGA_PEL_IW);
 		udelay(200);
 
 		/* and at the end, restore the mask value */
@@ -2800,9 +2798,9 @@ static void bestclock(long freq, int *nom, int *den, int *div)
 
 #ifdef CIRRUSFB_DEBUG
 
-/**
+/*
  * cirrusfb_dbg_print_regs
- * @base: If using newmmio, the newmmio base address, otherwise %NULL
+ * @regbase: If using newmmio, the newmmio base address, otherwise %NULL
  * @reg_class: type of registers to read: %CRT, or %SEQ
  *
  * DESCRIPTION:
@@ -2847,7 +2845,7 @@ static void cirrusfb_dbg_print_regs(struct fb_info *info,
 	va_end(list);
 }
 
-/**
+/*
  * cirrusfb_dbg_reg_dump
  * @base: If using newmmio, the newmmio base address, otherwise %NULL
  *
-- 
2.27.0

