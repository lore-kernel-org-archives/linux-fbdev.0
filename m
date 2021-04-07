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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45243C433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF14613C0
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349026AbhDGGnr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhDGGnr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:43:47 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43429C06174A;
        Tue,  6 Apr 2021 23:43:38 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id s11so12191336pfm.1;
        Tue, 06 Apr 2021 23:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qFLPg7mZDXW2+QgSTwSk0nVCNAL/L9QDEUI+JqqFX3k=;
        b=mT/mUn7WmUIME4GnBmCZDyfX4zs6Bm6ohDT27mTk5sndsJ7EnOZQ7klKCB/g909puv
         uyusQntZbxLgSrr/+dFpa8tAX6RBUqMCciTeiWL9Qw165iKf5o31jJTdvwfiAlcRVWQ3
         OHEchdISJQ52hUxRg4KgfaFBe0K3MoLdd4EkkNHZVnEYYVab6kQ5EeGxc1iRt+UScqNF
         tSubDVgI7VeWKzKXFEQO+HOLhsWo01lrNoal28Cd/ayNyNq6RMIxb6+jJmJ24XFwmCBa
         zbp3avkBtTjbigntRHWsp/RjggErHM4bg83IMROKbnlrqJbgVPn4m0O/U9UQbI4ydauH
         0mEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qFLPg7mZDXW2+QgSTwSk0nVCNAL/L9QDEUI+JqqFX3k=;
        b=iODILrgpp/QGc+n28w7my7qN6fwDOddnQZZ5zCk0PPPHakq0ypy8DNtrxBJc5LGbDP
         ABFPzxJRQyV+2ttWd3Sv6yUqCT0hHgZdL63xn3F7pLu1p8uShEtgh0Atn3wDMGGX6NIc
         GhhJ0rdnPoDWRX09rhms3K8M5h/FZS5LmacSM8yCuAy57VhbdlUDnxOLKpKMfzy2ze/5
         5L4KoeAa8ia4YCVLyj1stn1GeLkXChKOxuwPUZ9Rh4VCabcdQeWPC8JGLFPbN2cXRIeZ
         sjbBp2GJ26S169JhOZk/4qPsFuzjMjcIX2L5hDBtvPWenQaZwzOnnz3c3WyYHW3wwrpZ
         i5yQ==
X-Gm-Message-State: AOAM530CnO5vnL/JQQDnPviph/dOvq5O4fcfgC6opSy6nT1ST6suVanH
        FIukL0dqPTDsXekn7D/K83s=
X-Google-Smtp-Source: ABdhPJwOqNX467U2gyXYnZ7HmnsGJu0HLQzRCxRCYJua+3faT0g0IMb6lROPCAKfblaoO8iLfgb1Rw==
X-Received: by 2002:a63:dc57:: with SMTP id f23mr774017pgj.294.1617777817858;
        Tue, 06 Apr 2021 23:43:37 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id gk20sm3035930pjb.17.2021.04.06.23.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:43:37 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:43:35 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/49] staging: sm750fb: Rename function write_dpPort to
 snake case
Message-ID: <ed10428746cc0d22256876ab5c11bb1d4c798669.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl check for the function
write_dpPort.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 4327bda871e1..4ad2814b5b54 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -28,7 +28,7 @@ static inline u32 read_dpr(struct lynx_accel *accel, int offset)
 	return readl(accel->dprBase + offset);
 }
 
-static inline void write_dpPort(struct lynx_accel *accel, u32 data)
+static inline void write_dp_port(struct lynx_accel *accel, u32 data)
 {
 	writel(data, accel->dpPortBase);
 }
@@ -396,12 +396,12 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
 	for (i = 0; i < height; i++) {
 		/* For each line, send the data in chunks of 4 bytes */
 		for (j = 0; j < (ul4BytesPerScan / 4); j++)
-			write_dpPort(accel, *(unsigned int *)(src_buf + (j * 4)));
+			write_dp_port(accel, *(unsigned int *)(src_buf + (j * 4)));
 
 		if (ulBytesRemain) {
 			memcpy(ajRemain, src_buf + ul4BytesPerScan,
 			       ulBytesRemain);
-			write_dpPort(accel, *(unsigned int *)ajRemain);
+			write_dp_port(accel, *(unsigned int *)ajRemain);
 		}
 
 		src_buf += src_delta;
-- 
2.30.2

