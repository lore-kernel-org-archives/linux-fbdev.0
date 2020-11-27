Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40698C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E075A21D7A
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbH3C6iD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgK1Bav (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 20:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731062AbgK0T72 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:59:28 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F24AC08E85E
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:20 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 142so7095265ljj.10
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xCWN7JDF/GtG5ZT98j8MKTwxgU6VMyLEQn0BdCwiEZg=;
        b=jbH3C6iDq7RWgytVy0NqJ9b8P5K30Cm7OdBwf8Ji9IkOVEjaGTEXkzXn/jjyXzr7kY
         sjLBjzNEg9oFpHLY24Tn7gC2A8ZCORXoCpF9YpsgdLCokn6acUS/J3u73rJxgj6AbLzU
         h8WHUVdRQHAjkyXkxkZ9lkE7tICAm32EGZ/EjMKh5YvrGhcx226zT2Utcb5FqPbogvRY
         4nQynzKQAQk1J30F6wuA2tl7s+4Odrj08KY7ptk0YZ0WgZaJ8bV2yEAxaFmrlwu3ROhJ
         7mIgPTjRQ94jK57rwZOIOYml+tAcX2ezQ9a7rIzmhCA7E1k1Cs4NCE8bzquqiB2US41P
         322g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xCWN7JDF/GtG5ZT98j8MKTwxgU6VMyLEQn0BdCwiEZg=;
        b=pZQh6A+C0i6PbqWWDuqb9oND5NLcyMgbtUWFB1S4/ZJ+EjPSNTgjuCpJvxcoVD2I9D
         izrZoeOWKs/r6JCfyITLDcrW92V+ct1TFsiK1oZ9JFhxOh31flIQfybTF1BcZfX22jTF
         b4nu/OF5UFZ96aY28TtUACghJz95mtwKBaZmEsNZHzi0/wNCozfPrDhVtpbQobR8ehwo
         iuMgNCkxg2OD7J7l4NuEMd7laCaSKhrQZsJgaR3a29pAldGW8v4UFdJUqBD9zhzuyLLE
         8R2yuAkz/HbQJTkI6udArXwU5txEUqFS1lTgc2YC1bICTN1/jJrBG9ZwapAzqkVq+FMi
         KNUQ==
X-Gm-Message-State: AOAM533e/5l5leoVlXxVAUCcULD+AUQZW3riGITSU0B3PEP9jtRCIoj4
        v/pwikCeTBhpN7T5oJSkj5tRVNInQs8Cl/Nx
X-Google-Smtp-Source: ABdhPJwfQQRY1xyFWQCeqxGmr8x+xQ8Y8oFVP5doJc1VCIcNMxQvxTGPTEVTuqS/GyeZgySJ4zyVnA==
X-Received: by 2002:a2e:a54f:: with SMTP id e15mr1958143ljn.461.1606507158904;
        Fri, 27 Nov 2020 11:59:18 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:59:18 -0800 (PST)
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
Subject: [PATCH v1 17/28] video: fbdev: tgafb: Fix W=1 warnings
Date:   Fri, 27 Nov 2020 20:58:14 +0100
Message-Id: <20201127195825.858960-18-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warnings:
- Fix kernel-doc
- Drop unused code

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Joe Perches <joe@perches.com>
---
 drivers/video/fbdev/tgafb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/tgafb.c b/drivers/video/fbdev/tgafb.c
index 666fbe2f671c..ae0cf5540636 100644
--- a/drivers/video/fbdev/tgafb.c
+++ b/drivers/video/fbdev/tgafb.c
@@ -555,7 +555,7 @@ tgafb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue,
 
 /**
  *      tgafb_blank - Optional function.  Blanks the display.
- *      @blank_mode: the blank mode we want.
+ *      @blank: the blank mode we want.
  *      @info: frame buffer structure that represents a single frame buffer
  */
 static int
@@ -837,7 +837,7 @@ tgafb_clut_imageblit(struct fb_info *info, const struct fb_image *image)
 	u32 *palette = ((u32 *)info->pseudo_palette);
 	unsigned long pos, line_length, i, j;
 	const unsigned char *data;
-	void __iomem *regs_base, *fb_base;
+	void __iomem *fb_base;
 
 	dx = image->dx;
 	dy = image->dy;
@@ -855,7 +855,6 @@ tgafb_clut_imageblit(struct fb_info *info, const struct fb_image *image)
 	if (dy + height > vyres)
 		height = vyres - dy;
 
-	regs_base = par->tga_regs_base;
 	fb_base = par->tga_fb_base;
 
 	pos = dy * line_length + (dx * 4);
@@ -1034,7 +1033,7 @@ tgafb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 		     regs_base + TGA_MODE_REG);
 }
 
-/**
+/*
  *      tgafb_copyarea - REQUIRED function. Can use generic routines if
  *                       non acclerated hardware and packed pixel based.
  *                       Copies on area of the screen to another area.
-- 
2.27.0

