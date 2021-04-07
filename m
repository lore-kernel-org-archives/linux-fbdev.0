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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C6EC433B4
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A30661222
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbhDGGqS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349160AbhDGGpv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:45:51 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E70C061756;
        Tue,  6 Apr 2021 23:45:42 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id b17so8629030pgh.7;
        Tue, 06 Apr 2021 23:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2cYF68oFcyjU4Kfw0xfEVQzUH83t8nX8JKIHWjr/Ga4=;
        b=MEokI6t3x8iAwgGFuejhxCZfmi/8MZr1VfKdpod4k0sm+6g0CTIMZud2LT2aIEjPmM
         SGKqVjzmxeHkaq0RbhWqK0TBvdEod2XCaDHzh/O+S05TvY7T4fiacuLDQYI0hK5UsLrx
         V11h9pGD6iJZxUEwJAszphcVnKmeM/Ocutf6obIGu5JpbkxIbabAI7FQNc0salQf6OM7
         c/7tfo6Dv6UW+r1B8uAkp5FRh0kDMHvq+hWQcI4vn1ZZr4ApZ6xoBHx0W4cLNPgXbCqF
         XxEMZZLA2z0RavXGOmdGyc+9iPDhPjiQPQltvlyDzrowszOJj14dxsOjLdROM37Nf0zw
         GhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2cYF68oFcyjU4Kfw0xfEVQzUH83t8nX8JKIHWjr/Ga4=;
        b=qUSiDfJ48CQoTi3FMYePhb7EdPXmv8gCZBtnz+Rg5ct8aCMe76/Wvc2xq/KkfYhT6d
         D4bedTOH/lUwgJC2N2S6I3wIYqCo92htDfA9Bgw3b1xF1wqM3MXwzoSuekgH1/UU7Q/t
         ELCzKKWxcGOp5qq0SbzI/46v9yUrLMapU+CtBFfU1ZGacYHUOhitobPtl6+w7IHKQ3ZP
         N/KRnC5HDU5qqjw+ftnhabE2bsqpLV0xoqvUVt2sKkqdrHSsOkfchI1k0VztQmfKchQ2
         VoNb14GCtbx5XL+Otbs6Su8CIvb9eNljaYmSwW9gkugxJ5tRQ2lbh7MySpAl9ZTL3Mhk
         eMbg==
X-Gm-Message-State: AOAM532yVPhJDyOTSxqvol4v8OplSOzQ+YIf6wWq10lpFLiIZFItNr6N
        IQwdGuNUwZ9lVRpZfoLLcg4vn3a5M/2/yg==
X-Google-Smtp-Source: ABdhPJxk+9euoAl2I+ED+syNGgwrNK2Klr1blr3hUcYgQ/TU2vQI/PVdYVYP0vPQ22ggVoTxZGYaBg==
X-Received: by 2002:a63:1b5f:: with SMTP id b31mr1968300pgm.194.1617777941781;
        Tue, 06 Apr 2021 23:45:41 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id l25sm21847554pgu.72.2021.04.06.23.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:45:41 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:45:39 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 37/49] staging: sm750fb: Rename function
 hw_sm750_output_setMode to snake case
Message-ID: <b24581cc3a52db532d55f0c2a0a079f95e21613f.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the function
hw_sm750_output_set_mod.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 2 +-
 drivers/staging/sm750fb/sm750.h    | 2 +-
 drivers/staging/sm750fb/sm750_hw.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 2c944539eaf0..8e803b580a71 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -395,7 +395,7 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 	}
 	ret = hw_sm750_crtc_set_mode(crtc, var, fix);
 	if (!ret)
-		ret = hw_sm750_output_setMode(output, var, fix);
+		ret = hw_sm750_output_set_mode(output, var, fix);
 	return ret;
 }
 
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 368e5cc19147..b46d13134f76 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -197,7 +197,7 @@ void hw_sm750_initAccel(struct sm750_dev *sm750_dev);
 int hw_sm750_deWait(void);
 int hw_sm750le_deWait(void);
 
-int hw_sm750_output_setMode(struct lynxfb_output *output,
+int hw_sm750_output_set_mode(struct lynxfb_output *output,
 			    struct fb_var_screeninfo *var,
 			    struct fb_fix_screeninfo *fix);
 
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 7c852c6a153b..410f726b03e9 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -180,7 +180,7 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	return 0;
 }
 
-int hw_sm750_output_setMode(struct lynxfb_output *output,
+int hw_sm750_output_set_mode(struct lynxfb_output *output,
 			    struct fb_var_screeninfo *var,
 			    struct fb_fix_screeninfo *fix)
 {
-- 
2.30.2

