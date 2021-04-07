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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5650C433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82AF7613CD
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349039AbhDGGnu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhDGGnu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:43:50 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28011C061756;
        Tue,  6 Apr 2021 23:43:41 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id m11so9552116pfc.11;
        Tue, 06 Apr 2021 23:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7SRBX2zWlmG+Wnp7OjpNFHLRL6YKU9gaSLUgjStjeSA=;
        b=AMYUtoZ2wZYY0gE9hzXqShCPRugVZ8z0VUJuJH69xXJaXI/FZ+5yIsOAHHhp/Xa8EG
         nG060gKFAckyldI9nEBSQFRlUT5CBU5SN/CdLeGI3klVLm++zuw+TWeFGFhcsC4+J2Tr
         YT6c2ZKmlY8a3+ecoahFAL7uMsLzRMzRR01xwgPZhBbBmxe56yV8/VeRhVyaLqGT7lDN
         7dVox0XD/bmyyw1HFVvKsHHtMj11E4isqMso+4SBhUk2EItcxuSE0vnAEObsO8BNXkEO
         wnG4SUBiLS1blPlV21YE0eSx40atF61ipiDIbZ5sqVgOW+UnA6x9Z1T2uG8dTOAw+OFR
         yCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7SRBX2zWlmG+Wnp7OjpNFHLRL6YKU9gaSLUgjStjeSA=;
        b=DtA2BNvFgYPbhwI96NDCa6Ixai64+iVKfMzLRzGZQVduGDDGdKfW5naiSoTLzyaQip
         DHUn1L6aX+hRnFChzHSnuDYGOyA1QnbGHjuf9HNco9LgVnmS0M+hLeYsOzjiNmry18Xu
         qYsRsPXG5Xy9EXecqbZkD4XD8pnAoyzKdZINAI/JCnsFtRF5eJ+nSwXvy0huBQTsJpMr
         T2xjG2Gsacx3M7LcXF0UKPzBp2wPahdhh3bXA0EtGU4T7nPMSV4UgKmtBfLRkRGpFqOg
         83gbYLc/6lPmuI3GFAdNHoSP8yPJwSAM0UufYiB+54wSXXIvuNs6gF4RZpKUCmr18/a0
         g/WA==
X-Gm-Message-State: AOAM532IxVx0Z4fSDDJZ8uGU76MnOv8QgYb6T/rhzDCpBFO5gCxhrc04
        1UNsHjBSmIGq9z1HYRBaKRU=
X-Google-Smtp-Source: ABdhPJwqQmSR9ejO+2SH7wVFCu55gOSjGn+5iNaoES3fzICyJ7d5/kNX9xjU90SUtbPAmh/KqTV17g==
X-Received: by 2002:a63:dd14:: with SMTP id t20mr1912847pgg.258.1617777820715;
        Tue, 06 Apr 2021 23:43:40 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id x2sm20604956pgb.89.2021.04.06.23.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:43:40 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:43:38 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/49] staging: sm750fb: Update local variable in
 sm750_hw_fillrect to snake case
Message-ID: <cd24d36b55d3bdb6121e86b8fb2112efbfdd3f89.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpoint.pl checks for the local variable
deCtrl in the function sm750_hw_fillrect.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index c840873e9622..1eeedacfc4a8 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -90,7 +90,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 		      u32 x, u32 y, u32 width, u32 height,
 		      u32 color, u32 rop)
 {
-	u32 deCtrl;
+	u32 de_ctrl;
 
 	if (accel->de_wait() != 0) {
 		/*
@@ -122,11 +122,11 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 		  ((width << DE_DIMENSION_X_SHIFT) & DE_DIMENSION_X_MASK) |
 		  (height & DE_DIMENSION_Y_ET_MASK)); /* dpr8 */
 
-	deCtrl = DE_CONTROL_STATUS | DE_CONTROL_LAST_PIXEL |
+	de_ctrl = DE_CONTROL_STATUS | DE_CONTROL_LAST_PIXEL |
 		DE_CONTROL_COMMAND_RECTANGLE_FILL | DE_CONTROL_ROP_SELECT |
 		(rop & DE_CONTROL_ROP_MASK); /* dpr0xc */
 
-	write_dpr(accel, DE_CONTROL, deCtrl);
+	write_dpr(accel, DE_CONTROL, de_ctrl);
 	return 0;
 }
 
-- 
2.30.2

