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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A08CC433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0236613B3
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349059AbhDGGnx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349049AbhDGGnv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:43:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FBCC061756;
        Tue,  6 Apr 2021 23:43:42 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so756899pjb.0;
        Tue, 06 Apr 2021 23:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iNQgMFGdHCJQybttnc8ZktUg+AuixFV373VKxt8OipQ=;
        b=bL4tLK6rPdC9+pMpm+HgZ5dgrI/LpotabRYSpDBBWA/GPfObATMmj0oDciLDLRPShY
         sXA5qGSY6JqDDlUxFrNOS5K6DaOhD9FNkeKi1J0yNR0qgBn+MEQaHHyUVXB1iUSuRRSX
         hLE9ZBm3U95hSbeespJke+/a1o7eI0a4QBzAZxjEerBV8nRf0XLzTI2RRWQMKKw4tTFo
         3L0fO/i9Q/XwMLOVNY7XZkEzBF9+fiP0M0nZE0wjpRz/N+p2CpVmROeA2QMHqWcVK5Zu
         ZmkodlE1i0ppSsaj6gZiuVrTH1z74+GTKxLid36gFbjvz/4cZubHTHBH/bxkSkOQkTr6
         QoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iNQgMFGdHCJQybttnc8ZktUg+AuixFV373VKxt8OipQ=;
        b=UbXELtrmcTpDraBDuV2Iz/1/WtRX0cze6YktqAi9t+UitRE3gRkDG3tr9uegCUlRYx
         BPcIbe1awY5pqUpzAKq5SdFq5wYPbRTxviVir3htKCskRP9s1hpIE/4ILI39H3PhEp2Y
         rgFmdf1DsjTwZR4SP8yAgeYI3ONwchQulu/dzCCB+vFg/RMhXGDgJ2p31oZbbGrAMIHr
         mAVVdbhhmtr++TZgm6l+B+mpTQugps5Cz/o0y0p+HHRavIHl5uNyiBzhKp6kjkusoK8K
         q2q9Cul3ag/tAsDJ9DpHZ23/qAReV1PIvhPl80zRUuU3LnX1gtV5jLCsvq9duagYDaw0
         rRiA==
X-Gm-Message-State: AOAM531ppqzkOOa8Tht4Mhsr4q0XjHSWxCxqvsW/ix0B1MaKJIkCEMGA
        Lr5rneoqLqpTZ2YMzuYfHlc=
X-Google-Smtp-Source: ABdhPJxBAsCxXKZcvwuM32JlND25qmOd8VBz/H1GWFe+6qjtmSIae702aXP3xKjzS3nHNJ6Koe5VCw==
X-Received: by 2002:a17:90a:9281:: with SMTP id n1mr1867246pjo.146.1617777822010;
        Tue, 06 Apr 2021 23:43:42 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id j205sm3817856pfd.214.2021.04.06.23.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:43:41 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:43:39 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/49] staging: sm750fb: Rename deGetTransparency to snake
 case
Message-ID: <1cdaddb4b127cf70c3ccac2496a29da1b761cfbf.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the function
deGetTransparency in sm750_accel.c.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 1eeedacfc4a8..8ab7d827a99e 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -284,7 +284,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	return 0;
 }
 
-static unsigned int deGetTransparency(struct lynx_accel *accel)
+static unsigned int de_get_transparency(struct lynx_accel *accel)
 {
 	unsigned int de_ctrl;
 
@@ -390,7 +390,7 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
 		DE_CONTROL_ROP_SELECT | DE_CONTROL_COMMAND_HOST_WRITE |
 		DE_CONTROL_HOST | DE_CONTROL_STATUS;
 
-	write_dpr(accel, DE_CONTROL, de_ctrl | deGetTransparency(accel));
+	write_dpr(accel, DE_CONTROL, de_ctrl | de_get_transparency(accel));
 
 	/* Write MONO data (line by line) to 2D Engine data port */
 	for (i = 0; i < height; i++) {
-- 
2.30.2

