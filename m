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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BB0C433B4
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50685613ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349168AbhDGGq2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349172AbhDGGqW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:46:22 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9210C061762;
        Tue,  6 Apr 2021 23:46:13 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q10so12287287pgj.2;
        Tue, 06 Apr 2021 23:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m074W+fFkEnWYNx+xHLavlSpN4uemXZiY3b+q0HiAUU=;
        b=FHU0blh6RjBM8BtMRLL9ChwDZ32YGDEWkaMi3L7+Pgl7h99c9/lsrEmPf0k6rnXSxT
         emdtWz7SMBTt6gegFBrrR8hsNfyrDFLYueDsRVGLqelYXV36q6nC83vgmJspou5sK60D
         GuJUkhvnKn8HFlLofTUSE3kv6chHp7nuYNKfnmeBpLBz7F1Ji9hXEL7osG1ONDjTImP0
         2qj7JnoQ6X5AyxbFR2xtI85PDtsrQVVcXtfWdJin6NmCjYPeZ/WajH820G32HtQV+1RX
         sdIMI3GQ2/6Q/9N7vORHMsqTkVu1AOipzLoJMIn/5zsjeFgG4xTyuXj5CIG+YyMq/nm8
         95WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m074W+fFkEnWYNx+xHLavlSpN4uemXZiY3b+q0HiAUU=;
        b=gD8SFixC0km3KDP7yu+oMq3sYHJeOgezrips8b7+go0Rg6C9n/rIelL+73LKxkNPTQ
         zxqk0J32MG6Yrw1c0ww1k/arPgmKmGkkZ/rpCJb6N24dL/lKjZg0m/yswGGxvseRnbIN
         yIiZodP9ofLZbQ0g2/KU/ZuNLEkJn2lNAn1BpV3R/WvUM7gzgciiMQ2lWps09/ZPF7PE
         bnUTc26cJp3+Hy38x3OJrdpmWR+1mLVWiZ3wIJt4ayIz/q1eosaoRSsOukygX/8Z3zJ0
         R7AyYKDbTmPPinBtUjnLk2Gc0WDmCY9CFBA1hRfRUMZD/7k3i4w4fdB9ZiBvnKP3Y6JX
         0n1Q==
X-Gm-Message-State: AOAM5327UYhICZWoWnmx3fbtGSlMUWL6RnAF/4t2qpm2b5wkx5JB3CDR
        vQon3/ym8Ki3oYdr8kIamt8=
X-Google-Smtp-Source: ABdhPJx6IPOkk0HkagSvLJIsZglNVauGdjjn7nSK6ZyfeI0lP0SWEnafiKYcC/WDk3q1snSmaBT4TQ==
X-Received: by 2002:aa7:9394:0:b029:1f4:2b30:4cdb with SMTP id t20-20020aa793940000b02901f42b304cdbmr1563635pfe.50.1617777973359;
        Tue, 06 Apr 2021 23:46:13 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id e3sm20476007pfm.43.2021.04.06.23.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:46:12 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:46:10 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 47/49] staging: sm750fb: Rename proc_setBLANK member of
 lynxfb_output struct
Message-ID: <4ac1f3b8295e4f6e2c82a2508a0742bf0b490ef4.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl check for proc_setBLANK member of
lynxfb_output structure.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 4 ++--
 drivers/staging/sm750fb/sm750.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 937a44530fbf..0c6bfbedde50 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -577,7 +577,7 @@ static int lynxfb_ops_blank(int blank, struct fb_info *info)
 	pr_debug("blank = %d.\n", blank);
 	par = info->par;
 	output = &par->output;
-	return output->proc_setBLANK(output, blank);
+	return output->proc_set_blank(output, blank);
 }
 
 static int sm750fb_set_drv(struct lynxfb_par *par)
@@ -605,7 +605,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 	crtc->ypanstep = 1;
 	crtc->ywrapstep = 0;
 
-	output->proc_setBLANK = (sm750_dev->revid == SM750LE_REVISION_ID) ?
+	output->proc_set_blank = (sm750_dev->revid == SM750LE_REVISION_ID) ?
 				 hw_sm750le_set_blank : hw_sm750_set_blank;
 	/* chip specific phase */
 	sm750_dev->accel.de_wait = (sm750_dev->revid == SM750LE_REVISION_ID) ?
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 2e6481809d43..06cf136fa28c 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -170,7 +170,7 @@ struct lynxfb_output {
 	 */
 	void *priv;
 
-	int (*proc_setBLANK)(struct lynxfb_output *output, int blank);
+	int (*proc_set_blank)(struct lynxfb_output *output, int blank);
 };
 
 struct lynxfb_par {
-- 
2.30.2

