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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A801C43470
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32CCC613C0
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349047AbhDGGnv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349042AbhDGGnu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:43:50 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB61C06174A;
        Tue,  6 Apr 2021 23:43:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso773413pjh.2;
        Tue, 06 Apr 2021 23:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sykweF1xow+67RG88cYdeLCD9JLGGBr6+VUxqXfVo3c=;
        b=tMCGc6exiWT5/SzYX95SEtNEdMhsPtWabVZ7qpaIQtCMQr0dLxD+cl0mp09sOgtIiI
         Ce+Hbm33MTfaJAWNV3q8V2n2GjOjww0lkrj5EeXUwHimuzbFmhiMaTXwQh9RFZYt0X2m
         +BVu2C+sqHI/QygpybP359dH28as4BQ4P3zvHxwldYit7tZKFBk4UEH++ClZzfbJZZFl
         7UzdMUioFXLYDD/O+qSVnY1OW93UCI8nFo79d43UpH1X4AkKp4K0qznpe18ugdDKGUfc
         FPHIGN0+UI8fyu3r8gI5wtRhZ6TEqUj6Zb2A2CDUSOm+1BG4IEKz/s09ZiQQitcfZ1av
         7Y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sykweF1xow+67RG88cYdeLCD9JLGGBr6+VUxqXfVo3c=;
        b=BQoc8po91WE8sjfygXlac07JBNNr4VdCp8Jikv0FRheLsUBLCycZdxKY/N9HEvcYs0
         qS2Eix/XT09JJJSm277lz2CqQUtav4dQh3Pr6ggPDPMqwKCb1wtU4mJcjkEtqDsbMFty
         zK+osOaf6s7T0m3A8FLxQtlLoSMaxwTfkrNgTuqsEMFj6mrofUD3wnvEWiqPRja424xJ
         ULlAmquhfCZwKZ4j7thfVJxhUAd8T/WHO+v1vw1q31YbHlrHCxvCtU/MuAATSMFg4VCF
         PuTHH4/ZE5DB+yt8mlZnBojanJa8tp1SVJtr1v7ehvz+4GmXZ+ofkNZWh3rlP1kRi+iy
         EsPA==
X-Gm-Message-State: AOAM5309T8t7bzuKomqZrTCvIOPamWDbH44mzxPPGc5gTLlZPUkzk/Av
        WaBOPW0EamsFeZjRPP0/qViYlOwHCQFkTA==
X-Google-Smtp-Source: ABdhPJxBKfSQkEa2QkysRsUeMg9hiBbRFrLc9DHXYZggn8Gl9H0/Yjp+K7ab73tqIK60RcdNyb71mg==
X-Received: by 2002:a17:90b:f93:: with SMTP id ft19mr1811479pjb.135.1617777820160;
        Tue, 06 Apr 2021 23:43:40 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id e6sm13641235pgm.92.2021.04.06.23.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:43:39 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:43:37 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/49] staging: sm750fb: Update local variables in
 sm750_hw_imageblit to snake case
Message-ID: <8785050f4c2d4b9568689fec897aec03ca01da35.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpoint.pl checks for the local variables
in the function sm750_hw_imageblit.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 760dd036d71a..c840873e9622 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -319,17 +319,17 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
 		       u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
 		       u32 height, u32 fColor, u32 b_olor, u32 rop2)
 {
-	unsigned int ulBytesPerScan;
-	unsigned int ul4BytesPerScan;
-	unsigned int ulBytesRemain;
+	unsigned int ul_bytes_per_scan;
+	unsigned int ul4_bytes_per_scan;
+	unsigned int ul_bytes_remain;
 	unsigned int de_ctrl = 0;
-	unsigned char ajRemain[4];
+	unsigned char aj_remain[4];
 	int i, j;
 
 	start_bit &= 7; /* Just make sure the start bit is within legal range */
-	ulBytesPerScan = (width + start_bit + 7) / 8;
-	ul4BytesPerScan = ulBytesPerScan & ~3;
-	ulBytesRemain = ulBytesPerScan & 3;
+	ul_bytes_per_scan = (width + start_bit + 7) / 8;
+	ul4_bytes_per_scan = ul_bytes_per_scan & ~3;
+	ul_bytes_remain = ul_bytes_per_scan & 3;
 
 	if (accel->de_wait() != 0)
 		return -1;
@@ -395,13 +395,13 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
 	/* Write MONO data (line by line) to 2D Engine data port */
 	for (i = 0; i < height; i++) {
 		/* For each line, send the data in chunks of 4 bytes */
-		for (j = 0; j < (ul4BytesPerScan / 4); j++)
+		for (j = 0; j < (ul4_bytes_per_scan / 4); j++)
 			write_dp_port(accel, *(unsigned int *)(src_buf + (j * 4)));
 
-		if (ulBytesRemain) {
-			memcpy(ajRemain, src_buf + ul4BytesPerScan,
-			       ulBytesRemain);
-			write_dp_port(accel, *(unsigned int *)ajRemain);
+		if (ul_bytes_remain) {
+			memcpy(aj_remain, src_buf + ul4_bytes_per_scan,
+			       ul_bytes_remain);
+			write_dp_port(accel, *(unsigned int *)aj_remain);
 		}
 
 		src_buf += src_delta;
-- 
2.30.2

