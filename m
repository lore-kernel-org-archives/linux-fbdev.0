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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E840C433B4
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1DC61222
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345513AbhDGGqU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244668AbhDGGqP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:46:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17DEC061762;
        Tue,  6 Apr 2021 23:46:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so730111pjb.4;
        Tue, 06 Apr 2021 23:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sTRc6HlswoGyydauZH0DMBR4btgAttix5SNGQxPT1ew=;
        b=hCN6Jvlvr0Cy5U3GdI9ixf0wbksuD/gbjt6erm+iwubSjo5xs3jat03k3XWryyQMTV
         9VqUvLyXv+jS0m2JBVL+kS7hnZia78fvMhYaTH8W993GJYDBPO3W/QJ5L4KRBqFlNtZC
         fC4NhlyjlUO5UVQEGKrRDxXXJ1IGvimS0oYBFJmkRetQSqlDslXTmkDRJYSiwKol5srt
         DQjhhMBCwTDkm6knV2BjYnLfc7Hfz6yQf6zpiT4O7iSHs6En9fI2i0pNT2c+0crjiDt+
         ph65aqOR3rNhda+ypS3vforsRLs6NitKKkr+3htyEtW1kEtp3JY+HCa6uImXlPhqnrKd
         fLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sTRc6HlswoGyydauZH0DMBR4btgAttix5SNGQxPT1ew=;
        b=e5TnjgBHgcoALWApkrEDrtv+1o1U2dWzkAenhKFf+5+0mzDMvwqgg+aPYLoRaLd2+s
         5hUkeu/x7cOmeECaa9xevbLsXIZaTHj8OVcr7HwmdM116+gK5GHrAVi6fxcKFuYriWE8
         p9YpnrYRgsk1P6Apj6QzSFDdb+1+d+LrHT63ylgJiGIYMwQ3mkO7umybiOllOgMvROqL
         k1PiPrO2Cd4lrEyEZ/9TDU6mVoYvzM3D9ytgAdA5AwnwyoqmtyJ777jExLCIH8q4NaSa
         ZTFoo4nBKC5VPAY/h4zEw7AoM+c/EEbRC0QUxRW3NHdzDy3D9vZR67PNRzgfOGTSz5TG
         GYVA==
X-Gm-Message-State: AOAM531dmvhN9hIOZMXNxCuP+ZSxxQlsK1/WmzL9Psaey3aA5JHP/wtt
        ir5HXi970zsVA6wDv4cgSGg=
X-Google-Smtp-Source: ABdhPJxyljQWFRlxJtZqw/hZYn1qo52UgdL8HH3oq2aLpC1posUFye0QYm18DMhz0P08sTYZxQPNFw==
X-Received: by 2002:a17:902:bc89:b029:e9:2cd7:382e with SMTP id bb9-20020a170902bc89b02900e92cd7382emr1768815plb.68.1617777965188;
        Tue, 06 Apr 2021 23:46:05 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id 77sm16401786pgf.55.2021.04.06.23.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:46:04 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:46:02 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 41/49] staging: sm750fb: Rename function
 hw_sm750_initAccel to snake case
Message-ID: <9eb8aec92dcef358e174d2e2ab90c91373baeefa.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the function
hw_sm750_init_accel.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750.h    | 2 +-
 drivers/staging/sm750fb/sm750_hw.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 7347be7dcded..4f9fe3e9ef81 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -193,7 +193,7 @@ static inline unsigned long ps_to_hz(unsigned int psvalue)
 
 int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev);
 int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev);
-void hw_sm750_initAccel(struct sm750_dev *sm750_dev);
+void hw_sm750_init_accel(struct sm750_dev *sm750_dev);
 int hw_sm750_deWait(void);
 int hw_sm750le_deWait(void);
 
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 87d2b82f0880..db2c87fe7006 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -175,7 +175,7 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 
 	/* init 2d engine */
 	if (!sm750_dev->accel_off)
-		hw_sm750_initAccel(sm750_dev);
+		hw_sm750_init_accel(sm750_dev);
 
 	return 0;
 }
@@ -476,7 +476,7 @@ int hw_sm750_set_blank(struct lynxfb_output *output, int blank)
 	return 0;
 }
 
-void hw_sm750_initAccel(struct sm750_dev *sm750_dev)
+void hw_sm750_init_accel(struct sm750_dev *sm750_dev)
 {
 	u32 reg;
 
-- 
2.30.2

