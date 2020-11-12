Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1731C56201
	for <linux-fbdev@archiver.kernel.org>; Thu, 12 Nov 2020 12:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823E62085B
	for <linux-fbdev@archiver.kernel.org>; Thu, 12 Nov 2020 12:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWZZLSpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgKLMFT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 12 Nov 2020 07:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgKLMFQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 12 Nov 2020 07:05:16 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363D5C0613D1;
        Thu, 12 Nov 2020 04:05:16 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i13so3992489pgm.9;
        Thu, 12 Nov 2020 04:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IZQaNtNkLL6z6ZbtohWqKAcM+GdB+jm2XeErfe9vHvk=;
        b=tWZZLSpZQp22wCUD9a5oZxqbpelF7THomnGgPYP9PNTyxbAVSr2agCxI5OniPq2g/r
         nf0TcAHxo3fIWXJa8O3yMqN2ED6fxzXQso9mKvKJYl/vBT2n5S2PvEGtxG3t0j/DxoGA
         NwbXNERV6wV9E8oxhZNi5NSYn6BVRl+0Rw7j6iHVtWXEnVXIqEiySm3yYyb2j9C1B/On
         k39IE3CQkFcuD4rvK77NtBJAMo3Px1OMJ2NI/e23UFzOgPK4xQY495FJ79OUycHZfQgR
         aRVTK4R9TwBAmdh4ulPFceB0/1cJpm3N47vf/y4qvSBZAaTf2Yqy4pj4fiA6356S5ofz
         wQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IZQaNtNkLL6z6ZbtohWqKAcM+GdB+jm2XeErfe9vHvk=;
        b=QKRzFQNgEM8DIBlPUhHdiNsy/zWQL2Lus+aLw9iF8DTjbLkUd73oMewO5vLVHUJ3c0
         GoglmCtr5Mfkn3s2R3B7iNjqUTVrbAjkPkVLfwmUK86C96UV15dBwIfc1ZudiQfNfznU
         abOlH/lH50c4THB70hJc0N1xxQvlJOv62qIDz7oFfyoq5NEA0t5b2J2CvO5iZBPtwdXR
         WxdexpVgVG1i3M2kQIN1VgMjPS4RKIhYWFsJt48zZlEBtxJwebexRn0c0O1ewqjcESTB
         7IAnn0SoCQ2vEgKoBXeENvaFP4Ir1rAIgJJ7p+SkjfXjpyvawzKbsmxvvLM+TxpzdX5s
         vlZQ==
X-Gm-Message-State: AOAM530/BHLnXpeljgdIAs1O5inoYPq6j0ztYrQRNwz7yDu7rZ+YNT/J
        aFPAlp9788RXOgyFImsPIw==
X-Google-Smtp-Source: ABdhPJzO1hDeZ2IhKJ6bqNEiYkz8GU6RttBVRGOqDMF23KFVlKIirfFc4QCLUbOzesItxvr8eD/yrg==
X-Received: by 2002:a62:1b02:0:b029:18a:b052:deb1 with SMTP id b2-20020a621b020000b029018ab052deb1mr28203408pfb.32.1605182715659;
        Thu, 12 Nov 2020 04:05:15 -0800 (PST)
Received: from localhost.localdomain ([221.124.243.27])
        by smtp.gmail.com with ESMTPSA id i7sm6567928pjj.20.2020.11.12.04.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 04:05:14 -0800 (PST)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH 1/5] console: Delete unused con_font_copy() callback implementations
Date:   Thu, 12 Nov 2020 07:04:03 -0500
Message-Id: <c8d28007edf50de4387e1532eb3eb736db716f73.1605169912.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1605169912.git.yepeilin.cs@gmail.com>
References: <cover.1605169912.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Recently in commit 3c4e0dff2095 ("vt: Disable KD_FONT_OP_COPY") we
disabled the KD_FONT_OP_COPY ioctl() option. Delete all the
con_font_copy() callbacks, since we no longer use them.

Mark KD_FONT_OP_COPY as "obsolete" in include/uapi/linux/kd.h, just like
what we have done for PPPIOCDETACH in commit af8d3c7c001a ("ppp: remove
the PPPIOCDETACH ioctl").

Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 drivers/usb/misc/sisusbvga/sisusb_con.c |  6 ------
 drivers/video/console/dummycon.c        |  6 ------
 drivers/video/fbdev/core/fbcon.c        | 11 -----------
 include/linux/console.h                 |  1 -
 include/uapi/linux/kd.h                 |  2 +-
 5 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index c63e545fb105..fd9954381fbf 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -1358,11 +1358,6 @@ static int sisusbdummycon_font_default(struct vc_data *vc,
 	return 0;
 }
 
-static int sisusbdummycon_font_copy(struct vc_data *vc, int con)
-{
-	return 0;
-}
-
 static const struct consw sisusb_dummy_con = {
 	.owner =		THIS_MODULE,
 	.con_startup =		sisusbdummycon_startup,
@@ -1377,7 +1372,6 @@ static const struct consw sisusb_dummy_con = {
 	.con_blank =		sisusbdummycon_blank,
 	.con_font_set =		sisusbdummycon_font_set,
 	.con_font_default =	sisusbdummycon_font_default,
-	.con_font_copy =	sisusbdummycon_font_copy,
 };
 
 int
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 2a0d0bda7faa..ab3df752fb57 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -136,11 +136,6 @@ static int dummycon_font_default(struct vc_data *vc,
 	return 0;
 }
 
-static int dummycon_font_copy(struct vc_data *vc, int con)
-{
-	return 0;
-}
-
 /*
  *  The console `switch' structure for the dummy console
  *
@@ -161,6 +156,5 @@ const struct consw dummy_con = {
 	.con_blank =	dummycon_blank,
 	.con_font_set =	dummycon_font_set,
 	.con_font_default =	dummycon_font_default,
-	.con_font_copy =	dummycon_font_copy,
 };
 EXPORT_SYMBOL_GPL(dummy_con);
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index cef437817b0d..26d1b0916692 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2451,16 +2451,6 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h,
 	return 0;
 }
 
-static int fbcon_copy_font(struct vc_data *vc, int con)
-{
-	struct fbcon_display *od = &fb_display[con];
-	struct console_font *f = &vc->vc_font;
-
-	if (od->fontdata == f->data)
-		return 0;	/* already the same font... */
-	return fbcon_do_set_font(vc, f->width, f->height, od->fontdata, od->userfont);
-}
-
 /*
  *  User asked to set font; we are guaranteed that
  *	a) width and height are in range 1..32
@@ -3111,7 +3101,6 @@ static const struct consw fb_con = {
 	.con_font_set 		= fbcon_set_font,
 	.con_font_get 		= fbcon_get_font,
 	.con_font_default	= fbcon_set_def_font,
-	.con_font_copy 		= fbcon_copy_font,
 	.con_set_palette 	= fbcon_set_palette,
 	.con_invert_region 	= fbcon_invert_region,
 	.con_screen_pos 	= fbcon_screen_pos,
diff --git a/include/linux/console.h b/include/linux/console.h
index 4b1e26c4cb42..20874db50bc8 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -62,7 +62,6 @@ struct consw {
 	int	(*con_font_get)(struct vc_data *vc, struct console_font *font);
 	int	(*con_font_default)(struct vc_data *vc,
 			struct console_font *font, char *name);
-	int	(*con_font_copy)(struct vc_data *vc, int con);
 	int     (*con_resize)(struct vc_data *vc, unsigned int width,
 			unsigned int height, unsigned int user);
 	void	(*con_set_palette)(struct vc_data *vc,
diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
index 4616b31f84da..ee929ece4112 100644
--- a/include/uapi/linux/kd.h
+++ b/include/uapi/linux/kd.h
@@ -173,7 +173,7 @@ struct console_font {
 #define KD_FONT_OP_SET		0	/* Set font */
 #define KD_FONT_OP_GET		1	/* Get font */
 #define KD_FONT_OP_SET_DEFAULT	2	/* Set font to default, data points to name / NULL */
-#define KD_FONT_OP_COPY		3	/* Copy from another console */
+#define KD_FONT_OP_COPY		3	/* Obsolete, do not use */
 
 #define KD_FONT_FLAG_DONT_RECALC 	1	/* Don't recalculate hw charcell size [compat] */
 
-- 
2.25.1

