Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E3DC63798
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA9020702
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4+pA68y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbgK1WnK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388310AbgK1WnJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:43:09 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CCDC0613D2
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:42:14 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id s9so10558405ljo.11
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BP0tdGdOicm/g6FYqITXj/E741V7SOdfxHbuSnOa2vI=;
        b=A4+pA68yf5NQVAPnKHbZYVBDWIiXGs+Bvvu5J6D3tuTktlHbucucuyXSkvyUy1Z1ad
         qugn8GtpY2nk3MyGG1NB0/O+SXqhFzV50AwcMgZMDEIzlcPovhiNq/Vp3PCTW362qNUS
         akY1e5rXqcvvcDXERh7JZfSHWjcCL7TT1XmLL6eKoNkpqDIadVv/n/BApO2EhP/R519x
         Xwk9g4doicNQ+LGaenNYRm+DemOqIRzrgbI3ZIYi5/QYHt4ULU/wupW4572a5bKokc1P
         GCVqE5qF8LeEuIz06k9OEgsBZgfX2rLwP5Lto5zDv6y9chUDrSbEr65fc8MNx0jvyhTX
         Xoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BP0tdGdOicm/g6FYqITXj/E741V7SOdfxHbuSnOa2vI=;
        b=LW4GJGtoMntx4KhtNm+tG+g57nO1EXwacXzeWdqQnQDW7DrW3fWmp0ndKd9jLcu8MU
         v96QfKvecSob9Kgjt0P5l8E4V90eDO+bZE6t2AelEcgU1JMQelpAIU4gMZJVr90SOAwc
         xihO1hTccjohy24gYLsuxnOTKHoY2uN8XsFV8dT/WKCYrFr9fo8NMyhrghvMAi7r62Ge
         99BZKtPTG9H7CHA0Gke0L2POYNVg2p1aw9cRbDQTJDXH993ReHbQhvLsM8F3rIcz2VS5
         AJyni3KduCR9rp6/XH7WsAsbPLopl2QBUdGP2eaxIOfnP74CwbN1PDtV6tor6palLQkD
         2Rlw==
X-Gm-Message-State: AOAM531HYFdv/rOzv0/YBqC4GmFeEnF34zuqut7s7O6VE4KH1CtsyryI
        oKoEQTj8gW9ZLXiKXiw0y5ZLpdaQbKIW1A==
X-Google-Smtp-Source: ABdhPJwwf1ZWhffUvstO1LtukDoI2Zp+qJq1Q3l5sM/werUk5+/LklnUG0w4Xy6qOp1ekvjP6B84Ew==
X-Received: by 2002:a2e:888a:: with SMTP id k10mr6395463lji.341.1606603333226;
        Sat, 28 Nov 2020 14:42:13 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:42:12 -0800 (PST)
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
Subject: [PATCH v2 27/28] video: fbdev: cirrusfb: Fix kernel-doc and set but not used warnings
Date:   Sat, 28 Nov 2020 23:41:13 +0100
Message-Id: <20201128224114.1033617-28-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix warnings:
- drop kernel-doc for the two debug functions to avoid the warnings
- delete unused code

v2:
  - Updated subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Zimemrmann <tzimmermann@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>
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

