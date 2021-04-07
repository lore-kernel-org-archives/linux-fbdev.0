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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4E6C43460
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F236139C
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhDGGqX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242289AbhDGGqT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:46:19 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D7CC061756;
        Tue,  6 Apr 2021 23:46:10 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y16so109108pfc.5;
        Tue, 06 Apr 2021 23:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r/oBzQNuh63hJGsl/KIQufF0AGvx1q5/RmwFtkCNL+o=;
        b=pJzk1fBbV1MbhZoF8+rV3MlCvT3v6WtiJR+TdKNaJZaKA7lGQQ2pYyfguhIFru8t0s
         RtXPorljbp3FPDO3/EkZsl5J21bsBxWst7PRsYgfKh3qwdKsIGRaEHHo377LloRocV8h
         cZ10BLYrQYC+87Clii+JCtBUKYYJ8UEaynXdOsI9Q/kRYI6hc6wYB9YHkw6ER6v68T3z
         ayFl6/30OWMMnzI+93MXEyRkrEf633fozyr/wJYKVlYlJ7inDn1gDWrgPndH8PbEMTKm
         vGRd1kHUwLewJB+82qUxBymc8k2uJi7UW9XNRolh0iWRiOzFDlbMuqb9srltUOPLikga
         Zv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r/oBzQNuh63hJGsl/KIQufF0AGvx1q5/RmwFtkCNL+o=;
        b=Y3Qaqq+taNA2xan6QhqgnGyH/cWWS2Y1C+49RmbhrT5YBUq65d4vc3qoxWxXgoimpB
         flioEW0FzjABSWlojFvVcMs11cvEK6rw2wxcJzi/wfWntpJ+1LqYt8bd3mQEp0fSY1sm
         T40//yW3etbdBMSkgFlemHTfPywydf+Cm+kLDCdv8N0/kpdQdXzg4MSu3z/w2HXpRImq
         dW5wmVlAMuvkGR1zZFypOerMILBP6vF0LLToVM8PBPYwBkIaoTg9iRPkSC9DBT8cyqGo
         2Xv3xWywBohGp6IhX4sBnYInozBM57TRXHIU+ACXNxBMtGuJdZvjTaA3ld1mXga0QmSZ
         w3jg==
X-Gm-Message-State: AOAM53352ya6zLTb7LxoElmlmDB+oU3pmU9dmbSj2svKKE1RVyKdgDOj
        wYenStESxbyimItL+4nTjOQ=
X-Google-Smtp-Source: ABdhPJw5XIdGszUVi3JOaGNBZJdtQEMf4VsvOZbSVWrStK1FUM+pJHy4cbOkBHrsJRtrgR2Z1mXpuQ==
X-Received: by 2002:a62:1a08:0:b029:220:da90:9173 with SMTP id a8-20020a621a080000b0290220da909173mr1682186pfa.65.1617777969605;
        Tue, 06 Apr 2021 23:46:09 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id u1sm20031904pgg.11.2021.04.06.23.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:46:09 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:46:07 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 44/49] staging: sm750fb: Rename function
 hw_sm750_crtc_checkMode to snake case
Message-ID: <34c28569d6d690d72913dfc0347d05f8536c3a9b.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the function
hw_sm750_crtc_checkMode.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 2 +-
 drivers/staging/sm750fb/sm750.h    | 2 +-
 drivers/staging/sm750fb/sm750_hw.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index bb25ab4ba0de..162eaf08db4c 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -512,7 +512,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 		return -ENOMEM;
 	}
 
-	return hw_sm750_crtc_checkMode(crtc, var);
+	return hw_sm750_crtc_check_mode(crtc, var);
 }
 
 static int lynxfb_ops_setcolreg(unsigned int regno,
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index a27aaac5d67a..2e6481809d43 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -201,7 +201,7 @@ int hw_sm750_output_set_mode(struct lynxfb_output *output,
 			    struct fb_var_screeninfo *var,
 			    struct fb_fix_screeninfo *fix);
 
-int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc,
+int hw_sm750_crtc_check_mode(struct lynxfb_crtc *crtc,
 			    struct fb_var_screeninfo *var);
 
 int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 97b842148bcb..b445f075d0a9 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -221,7 +221,7 @@ int hw_sm750_output_set_mode(struct lynxfb_output *output,
 	return ret;
 }
 
-int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc,
+int hw_sm750_crtc_check_mode(struct lynxfb_crtc *crtc,
 			    struct fb_var_screeninfo *var)
 {
 	struct sm750_dev *sm750_dev;
-- 
2.30.2

