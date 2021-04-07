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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23028C433B4
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB8E5613C0
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243817AbhDGGqz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349224AbhDGGqe (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:46:34 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8733C06175F;
        Tue,  6 Apr 2021 23:46:25 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so727643pji.5;
        Tue, 06 Apr 2021 23:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8KMjQscDTu2f3qX/EIrSUJ8LapWFh940dfHfctQfV8U=;
        b=nmYWcmTrl1AUYU22euLKozyZVDSQkPaf4gh4z/xzAbjRtmXsQxuKhSN5PMcavyiv2h
         T9y28cNGSmLtswteu2JAPwKXUwpReeUKLzIodYygr7FfXtfyhNTnx2/rV+TWer9o0y2J
         o9gLSnZp7N/gLCxrvDb4ziBC17Z4LQ3dhfxWhjCKEhodfqTOBlYmmpjzPXVzDexQmos4
         m1+RIaEd3lvve7s3FmFEP0g7B4+6hrhBbFo+DMHQG9Hnw9lNRKPw4+Yc+S5orEvJrnQH
         ZrBrNGuW3xUOrvupsTstOdaS+iQ6OqNva9WopXbYVqXmHxf8M02sdxk9BSPqwWIViQlN
         ytnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8KMjQscDTu2f3qX/EIrSUJ8LapWFh940dfHfctQfV8U=;
        b=p8HNNx8PEUTsnaYBOdaPeF4FtqaDfNwLatd4JCh+wiHylsBFST2JOJSHZNBQ7uwnEv
         fMZH56VvlY6InA5eayqgLSWeMMqHDGlNVah9TMApkxt+VRC7kCIb3vhGCRFhAES0nWFF
         tNxvzhyq/udI4UuHVJNIU8Th5II3xuoTQqKcLYZZUhQ5fTGdoHbWXgg9gFyTMRKc+LWD
         h3Gi53kBHazjc5003pqJkcJHFxg4OTbioCouB80AOQLhH+367nizciP5oyoFWUOZzzbM
         qe1trRLGTtqBN+IZzO92UqjfTojJybvKzwBwSxNjWxvXq5gmQtjgiaksF3Yit/uSIKHF
         YVNQ==
X-Gm-Message-State: AOAM533LQdzfQGU2g0YEmgF0qUDRVXNDgXeQuna/JfqrqpkuxseS7e2/
        0tONNRwGXQFXz8b5D5sgQmM=
X-Google-Smtp-Source: ABdhPJz1w6XNaPtFfWFzMBtK3MAqep3koqt9yCzs6xcZ4oja/eBFaNTuGevI7KU8w/uF3GmX8g5mtw==
X-Received: by 2002:a17:90a:77c5:: with SMTP id e5mr1800883pjs.189.1617777985391;
        Tue, 06 Apr 2021 23:46:25 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id t16sm871809pfc.94.2021.04.06.23.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:46:25 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:46:22 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 49/49] staging: sm750fb: Update members of sm750_pnltype
 struct to snake case
Message-ID: <5d8d02f140f9ed246cd5a660a06a3f15daa48297.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the members of
sm750_pnltype structure, in particular sm750_24TFT, sm750_dualTFT,
and sm750_doubleTFT.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 6 +++---
 drivers/staging/sm750fb/sm750.h    | 6 +++---
 drivers/staging/sm750fb/sm750_hw.c | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 946143de11fc..c9b17d6ac9fb 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -894,11 +894,11 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		} else if (!strncmp(opt, "nocrt", strlen("nocrt"))) {
 			sm750_dev->nocrt = 1;
 		} else if (!strncmp(opt, "36bit", strlen("36bit"))) {
-			sm750_dev->pnltype = sm750_doubleTFT;
+			sm750_dev->pnltype = sm750_double_tft;
 		} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
-			sm750_dev->pnltype = sm750_dualTFT;
+			sm750_dev->pnltype = sm750_dual_tft;
 		} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
-			sm750_dev->pnltype = sm750_24TFT;
+			sm750_dev->pnltype = sm750_24_tft;
 		} else if (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
 			g_hwcursor &= ~0x1;
 		} else if (!strncmp(opt, "nohwc1", strlen("nohwc1"))) {
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 06cf136fa28c..ce02671a1419 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -13,9 +13,9 @@
 #endif
 
 enum sm750_pnltype {
-	sm750_24TFT = 0,	/* 24bit tft */
-	sm750_dualTFT = 2,	/* dual 18 bit tft */
-	sm750_doubleTFT = 1,	/* 36 bit double pixel tft */
+	sm750_24_tft = 0,	/* 24bit tft */
+	sm750_dual_tft = 2,	/* dual 18 bit tft */
+	sm750_double_tft = 1,	/* 36 bit double pixel tft */
 };
 
 /* vga channel is not concerned  */
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index b445f075d0a9..ad81fd5c33ad 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -136,12 +136,12 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 			~(PANEL_DISPLAY_CTRL_DUAL_DISPLAY |
 			  PANEL_DISPLAY_CTRL_DOUBLE_PIXEL);
 		switch (sm750_dev->pnltype) {
-		case sm750_24TFT:
+		case sm750_24_tft:
 			break;
-		case sm750_doubleTFT:
+		case sm750_double_tft:
 			val |= PANEL_DISPLAY_CTRL_DOUBLE_PIXEL;
 			break;
-		case sm750_dualTFT:
+		case sm750_dual_tft:
 			val |= PANEL_DISPLAY_CTRL_DUAL_DISPLAY;
 			break;
 		}
-- 
2.30.2

