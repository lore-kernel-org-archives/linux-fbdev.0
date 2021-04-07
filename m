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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC751C43461
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 975E661222
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349061AbhDGGny (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349054AbhDGGnw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:43:52 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64751C061761;
        Tue,  6 Apr 2021 23:43:43 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id z12so4769223plb.9;
        Tue, 06 Apr 2021 23:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KdD/0jSjXQu+pj5Tw8B9xW+iyGYs472db51etZPlQWM=;
        b=Cuij2ZAyqmlX8ep4uD8ie3JDJu9JmDDWeyfVqGuFYbxLxExVx13/kAMuXmArzRqbIq
         1yNubc40iVWWJhhYDZd0R+4LTJyzP1DuAxZFjSts0glTiC/vEjQUk4Bj2VDxrg6K+xko
         rG+DwQVB9qYCLpJMvKgl360B9lxBTjX6hak4jFtOCGfet/wBVZg4vapOG01LVkv1uupB
         FKUOMHDjRNx5WRR9PShTZgfps5+xEYZfiyYpwNT6Qh08SYmjXGhZxQAnrgWtfmgut9bS
         b89YtfpOz5duji1P/HNN2zJ8xdNhQgx06f3TEClh492et9Yl3nf8lE4HFtatBkrT34Wd
         B75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KdD/0jSjXQu+pj5Tw8B9xW+iyGYs472db51etZPlQWM=;
        b=izHmcrEy5EObfzfgF5cfxpAaaX2s9kbOVGsXg/5EsNMPUROHMxYBLEuE7Xa7iOykhX
         Hd5lJAC4Av1sbdozLBIERM31CsVgnhSu/vnqkIo6k1unn+bbPq3q52RvUoWEf1ZrmBz+
         ekJXHZGvZ98xHMfR14bOcwTx4ULfgGQVKX+ld6nTS0DbCPAR0iAPTctuwBPaPhHEmRqD
         NDFadcqoTvN1rflamEXBbjYkrP5fkb1W1wBOAlty5iSniMtBxFM48vjP87uxI2JGpFmB
         C27y2PSH8DjSK+5Rocg4rvGBKpBcXKjJ8kmEZusUOIBeM2lowoqGxBdgB0yQkjfiRRzC
         l2gQ==
X-Gm-Message-State: AOAM533D8rKp7kuvqxh+uGWxfJjWEjasl4qbFI6eG1c2s5gAE0/rEDVy
        tchmT4h8kkqKoyMPDRQ0A/rKEqJEdNZ6+A==
X-Google-Smtp-Source: ABdhPJwFg0ykpCJkqAF7uxTunboyHBPPTna7uYRLdOsIFwRktA/JTtm8BuYFwjjpCHU1BZjwRltxAw==
X-Received: by 2002:a17:90a:7b85:: with SMTP id z5mr1870880pjc.39.1617777823012;
        Tue, 06 Apr 2021 23:43:43 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id f2sm19378511pfe.177.2021.04.06.23.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:43:42 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:43:40 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 26/49] staging: sm750fb: Update function parameter of
 sm750_hw_imageblit to snake case
Message-ID: <080958faf487654e336a2e8ce152bfd756128617.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpoint.pl checks for the function parameter
fColor in the function sm750_hw_imageblit.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 8ab7d827a99e..d0b64962b10e 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -310,14 +310,14 @@ static unsigned int de_get_transparency(struct lynx_accel *accel)
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
  * @height: height of rectangle in pixel value
- * @fColor: Foreground color (corresponding to a 1 in the monochrome data
+ * @f_color: Foreground color (corresponding to a 1 in the monochrome data
  * @b_olor: Background color (corresponding to a 0 in the monochrome data
  * @rop2: ROP value
  */
 int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
 		       u32 src_delta, u32 start_bit, u32 d_base, u32 d_pitch,
 		       u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
-		       u32 height, u32 fColor, u32 b_olor, u32 rop2)
+		       u32 height, u32 f_color, u32 b_olor, u32 rop2)
 {
 	unsigned int ul_bytes_per_scan;
 	unsigned int ul4_bytes_per_scan;
@@ -383,7 +383,7 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
 		  ((width << DE_DIMENSION_X_SHIFT) & DE_DIMENSION_X_MASK) |
 		  (height & DE_DIMENSION_Y_ET_MASK)); /* dpr08 */
 
-	write_dpr(accel, DE_FOREGROUND, fColor);
+	write_dpr(accel, DE_FOREGROUND, f_color);
 	write_dpr(accel, DE_BACKGROUND, b_olor);
 
 	de_ctrl = (rop2 & DE_CONTROL_ROP_MASK) |
-- 
2.30.2

