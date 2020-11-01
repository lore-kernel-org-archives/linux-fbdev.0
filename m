Return-Path: <SRS0=n/V2=EH=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26AFC4741F
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 14:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D1DF206DC
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 14:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGIO4h4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgKAOwK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 1 Nov 2020 09:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgKAOwJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 1 Nov 2020 09:52:09 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70178C0617A6;
        Sun,  1 Nov 2020 06:52:09 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id m17so1960967pjz.3;
        Sun, 01 Nov 2020 06:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WDz5iZ7ScqUpsOhTQpFWUX1eJGf0gqLfwcAH1gDLhKk=;
        b=SGIO4h4iravRi2aPjBFdvDhvj8pQlGCnea3mZTKLfxO2XtXlRU4wWdef5CSmwlAxV7
         fZu8o4fh61hzgzWi1+c//2pM8/mqGz/e0nrpuDz9cQHkhtXQsvFQp0TM8+zNbBpgxTel
         q9I7JVvNxjoXmusZurWxx7m5tD1F3Mtp2SmEukDsBInadw1gllYNjZQ6HIdFFiKdP6Bl
         XQuHaKnaTPZQyIe+d0gs7EL8UlCXDUoFlSwTAq8frpZ3yKBtVCOfbkCvKzwb2tJPt9bj
         FS3sOU8ht8kllUYpaqtTDuOqHIsbqXcuLWxdSONGqzPLThuxKQxLJofFbvuQFGy1+dwh
         kyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WDz5iZ7ScqUpsOhTQpFWUX1eJGf0gqLfwcAH1gDLhKk=;
        b=RHChll8LwalRGRbRJXs9u+KEELUtF4bd4MstNwAoPjB+X6qkDpspTnARGfwDApAYtw
         OGtGYFES/+aVMChLpTLJAj88044zbKJ6CfYo9m5tcRuf1IVdNGLojvxBklt0fPJ2PlY9
         HDdszoDdSZGcDdVka2YY/WHwy1KUsxuOpCJyc+gmVtaA+UeYi05s1Mbr/FFndfqQGnVb
         DMpt3BN8O3SETX3s9RwyBYZkYJm/a7QLx8ZiTkFJk47KEb5I8a+DdViu4WObsbLsjpnB
         QxE5PPhJWURDpIppPS+Dnq+7GHpaGl8R89JsaHRt1J4+epZp/y1O0UNvs9MUtfg0KLPl
         RMAQ==
X-Gm-Message-State: AOAM531PzuXMyX5/0wynUz7mLv99PKd6e8jvLBB3JhU8nb5XH0D92Atf
        PgZIY8kY1kRnfN6OHgcmPA==
X-Google-Smtp-Source: ABdhPJy9XzDVddbeWywB9pM2wgZ/snK0yVI0jjUcauuzs+uCMfyNHN9Sj4z+VX0A/0EAWRhmR/lslw==
X-Received: by 2002:a17:90b:e8c:: with SMTP id fv12mr5987572pjb.196.1604242328948;
        Sun, 01 Nov 2020 06:52:08 -0800 (PST)
Received: from localhost.localdomain (59-125-13-244.HINET-IP.hinet.net. [59.125.13.244])
        by smtp.gmail.com with ESMTPSA id h10sm10370939pgj.69.2020.11.01.06.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 06:52:08 -0800 (PST)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH] fbcon: Replace printk() with pr_*()
Date:   Sun,  1 Nov 2020 09:49:04 -0500
Message-Id: <20201101144904.1522611-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201101094718.GD1166694@ravnborg.org>
References: <20201101094718.GD1166694@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Replace printk() with pr_err(), pr_warn() and pr_info(). Do not split long
strings, for easier grepping. Use `__func__` whenever applicable.

fbcon_prepare_logo() has more than one callers, use "fbcon_prepare_logo:"
instead of "fbcon_init:", for less confusion.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 42 +++++++++++++-------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index cef437817b0d..a3e87ab0e523 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -659,8 +659,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 
 	if (logo_lines > vc->vc_bottom) {
 		logo_shown = FBCON_LOGO_CANSHOW;
-		printk(KERN_INFO
-		       "fbcon_init: disable boot-logo (boot-logo bigger than screen).\n");
+		pr_info("%s: disable boot-logo (boot-logo bigger than screen).\n", __func__);
 	} else {
 		logo_shown = FBCON_LOGO_DRAW;
 		vc->vc_top = logo_lines;
@@ -785,9 +784,8 @@ static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
 			ret = newinfo->fbops->fb_set_par(newinfo);
 
 			if (ret)
-				printk(KERN_ERR "con2fb_release_oldinfo: "
-					"detected unhandled fb_set_par error, "
-					"error code %d\n", ret);
+				pr_err("%s: detected unhandled fb_set_par error, error code %d\n",
+				       __func__, ret);
 		}
 	}
 
@@ -806,9 +804,8 @@ static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
 		ret = info->fbops->fb_set_par(info);
 
 		if (ret)
-			printk(KERN_ERR "con2fb_init_display: detected "
-				"unhandled fb_set_par error, "
-				"error code %d\n", ret);
+			pr_err("%s: detected unhandled fb_set_par error, error code %d\n",
+			       __func__, ret);
 	}
 
 	ops->flags |= FBCON_FLAGS_INIT;
@@ -1137,9 +1134,8 @@ static void fbcon_init(struct vc_data *vc, int init)
 			ret = info->fbops->fb_set_par(info);
 
 			if (ret)
-				printk(KERN_ERR "fbcon_init: detected "
-					"unhandled fb_set_par error, "
-					"error code %d\n", ret);
+				pr_err("%s: detected unhandled fb_set_par error, error code %d\n",
+				       __func__, ret);
 		}
 
 		ops->flags |= FBCON_FLAGS_INIT;
@@ -2126,9 +2122,8 @@ static int fbcon_switch(struct vc_data *vc)
 			ret = info->fbops->fb_set_par(info);
 
 			if (ret)
-				printk(KERN_ERR "fbcon_switch: detected "
-					"unhandled fb_set_par error, "
-					"error code %d\n", ret);
+				pr_err("%s: detected unhandled fb_set_par error, error code %d\n",
+				       __func__, ret);
 		}
 
 		if (old_info != info)
@@ -2899,9 +2894,8 @@ void fbcon_remap_all(struct fb_info *info)
 		set_con2fb_map(i, idx, 0);
 
 	if (con_is_bound(&fb_con)) {
-		printk(KERN_INFO "fbcon: Remapping primary device, "
-		       "fb%i, to tty %i-%i\n", idx,
-		       first_fb_vc + 1, last_fb_vc + 1);
+		pr_info("fbcon: Remapping primary device, fb%i, to tty %i-%i\n",
+			idx, first_fb_vc + 1, last_fb_vc + 1);
 		info_idx = idx;
 	}
 	console_unlock();
@@ -2914,17 +2908,16 @@ static void fbcon_select_primary(struct fb_info *info)
 	    fb_is_primary_device(info)) {
 		int i;
 
-		printk(KERN_INFO "fbcon: %s (fb%i) is primary device\n",
-		       info->fix.id, info->node);
+		pr_info("fbcon: %s (fb%i) is primary device\n",
+			info->fix.id, info->node);
 		primary_device = info->node;
 
 		for (i = first_fb_vc; i <= last_fb_vc; i++)
 			con2fb_map_boot[i] = primary_device;
 
 		if (con_is_bound(&fb_con)) {
-			printk(KERN_INFO "fbcon: Remapping primary device, "
-			       "fb%i, to tty %i-%i\n", info->node,
-			       first_fb_vc + 1, last_fb_vc + 1);
+			pr_info("fbcon: Remapping primary device, fb%i, to tty %i-%i\n",
+				info->node, first_fb_vc + 1, last_fb_vc + 1);
 			info_idx = primary_device;
 		}
 	}
@@ -3394,9 +3387,8 @@ void __init fb_console_init(void)
 				     "fbcon");
 
 	if (IS_ERR(fbcon_device)) {
-		printk(KERN_WARNING "Unable to create device "
-		       "for fbcon; errno = %ld\n",
-		       PTR_ERR(fbcon_device));
+		pr_warn("Unable to create device for fbcon; errno = %ld\n",
+			PTR_ERR(fbcon_device));
 		fbcon_device = NULL;
 	} else
 		fbcon_init_device();
-- 
2.25.1

