Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16604C43460
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D983D61222
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349092AbhDGGoz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349108AbhDGGow (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:44:52 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FDCC061762;
        Tue,  6 Apr 2021 23:44:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id a6so5505174pls.1;
        Tue, 06 Apr 2021 23:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v5F66A4CVLf0PCVKwwhgQWPfplNHHogpzp6J0Rowd60=;
        b=J+83Zbiiag6BpOcxsapxpcpjCFeBM7GFFXJ7MMoFNkOQCMOCajfwQGgfim/yMz0Xjt
         r/trgUh9QydkyOeFJcI/BZc2virqSs1viHTFxvfI7NZe0cYbSDqrBPHHzmDx6n3xqpoM
         7iduvXOrbE7tVdAq9UGLBTTwSCxIaBRnbc62ws0d/RTJoPt5joGBvs9xIguZqxyZ3lsw
         6bCdTnUTj/tFQvvJqsFWlLqV8neyHLzoOM/njFTZn/3e7JPeTm4TN2RyaBVTWuw9A7+9
         sZdvSHAdOCShuJvMkLf676LEssxQxskJJTIAg/HOK6GJbp863xGhS6Amb7LR/6A3bBZu
         qHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v5F66A4CVLf0PCVKwwhgQWPfplNHHogpzp6J0Rowd60=;
        b=JAJ7Tz/1yUIvlfeyFk2BH/EPMdWACfGSjLmtJWFIb/VilMH+S9lg/K7Smg0x1QvABU
         3bBFOkzxfjeqm8MaI5dyg6I9uPHfyJQ73MY4TxQqZaK205KaKouOr0T5oW836LzeILl5
         QLVC7/NmgXkmfZqgTqrf9Uaghv2K5W2P3krcWXcvWnWLCGfTVWmu5wYiW4hGWY0DU+gy
         v447IpmMVQelB64E5nWOL/jsL7Iv93ZW7p5IQxUy5SrcqV6Ltq6/c4k86fbVdfJUCNJt
         SqJX2Y6Y6rcvX6FA6o54q7stsCF2FSmHILdFZA1VDfDghClDR/Yx5hFM5r32wJJEunEw
         FVGg==
X-Gm-Message-State: AOAM5309sbukK/Rabuj+1J2tyZg6MO81E4+5+dIIGullosIEEwcPmwfP
        ez/2BGA7P46a35CEn/ZNv+OKUZZ44ID4uQ==
X-Google-Smtp-Source: ABdhPJz+XXWB75AReec2tP6DygxwX83W/w/NAB6x50T3Tg926mjmOGn4LbRYExRzqS4N1RCtTls18A==
X-Received: by 2002:a17:90b:1993:: with SMTP id mv19mr1869403pjb.193.1617777883018;
        Tue, 06 Apr 2021 23:44:43 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id s9sm3816977pfc.192.2021.04.06.23.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:44:42 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:44:40 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/49] staging: sm750fb: Rename function
 hw_sm750_crtc_setMode to snake case
Message-ID: <db83765fac5956430ffc87118a6a667c45377665.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the function
hw_sm750_crtc_setMode.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 2 +-
 drivers/staging/sm750fb/sm750.h    | 2 +-
 drivers/staging/sm750fb/sm750_hw.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 9263d4bdd222..2343cd897989 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -393,7 +393,7 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 		pr_err("bpp %d not supported\n", var->bits_per_pixel);
 		return ret;
 	}
-	ret = hw_sm750_crtc_setMode(crtc, var, fix);
+	ret = hw_sm750_crtc_set_mode(crtc, var, fix);
 	if (!ret)
 		ret = hw_sm750_output_setMode(output, var, fix);
 	return ret;
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 8271cf7c89f3..6e0805a99180 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -204,7 +204,7 @@ int hw_sm750_output_setMode(struct lynxfb_output *output,
 int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc,
 			    struct fb_var_screeninfo *var);
 
-int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
+int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
 			  struct fb_var_screeninfo *var,
 			  struct fb_fix_screeninfo *fix);
 
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index e31f4c6bc69e..efe379ef3438 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -247,7 +247,7 @@ int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc,
 }
 
 /* set the controller's mode for @crtc charged with @var and @fix parameters */
-int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
+int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
 			  struct fb_var_screeninfo *var,
 			  struct fb_fix_screeninfo *fix)
 {
-- 
2.30.2

