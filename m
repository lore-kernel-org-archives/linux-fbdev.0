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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97114C43603
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B69E613E7
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349159AbhDGGqV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243516AbhDGGqQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:46:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D046DC06174A;
        Tue,  6 Apr 2021 23:46:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id ay2so8843436plb.3;
        Tue, 06 Apr 2021 23:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X/1WQUx4h3Us2MWsdbVA8OpNDkB4BtTTjDqsMm8O3ls=;
        b=LLoGUZhIk6YW+UKKNqOen1oLr0HJDun+yEuhnwfn880onAoEnJfLYW9fYa278+NI6g
         7bg2Md5XZwV8f5JJwJkK7jhfXEgDHTYgW03cCEJLD51fISxqaBoXn0aRL4eo7GPGbo9v
         fko9MRjaIYHZKn8ACTy15FeH8U7DDxTJNbL88RcZKGaBT0qmOG0rDLR3jIoqdCLl9iqa
         rV50+u4tlHgrZGw4djiaCDiyqRTFtefE52ALQ7MtTPT4vF6ji2i00uYhIiYnryMuBMFD
         5XovHaAHJN4GtcEHSK3LaGtp5F65nV6DjVrymT/L0DUYFT7dVjubtHfiFmigfJotZ23S
         Ii1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X/1WQUx4h3Us2MWsdbVA8OpNDkB4BtTTjDqsMm8O3ls=;
        b=rwuJBOjEKaHjcBfO+gpI9aKD5H58afy5m48iE6CGtLgvGAfdEFQg2hdHhNZRQrGK5E
         TTZ9e4gvVlRgkBTL/5cRq+J7AdhDdGEIdxNDoKBK/I66fo6QNMFN6qTWHqzx7IAQdVPm
         LzqcAXYSQX7A7nK2u4PLP3OxemRT7F3YWv1xix4zVxPqLc6y/X6S0fZ80ZNXy7CzfifU
         a77H4WNOfkQUTUEIY4xNngxqa0gcr20LYlNs6/46KQXLfp30tCqCqS9LFpuBx5jJQuWH
         4MUPYg6sK5pe8sNZDwZcb9cVuWdpHSDfy/f8yvp9/bCIrjOo4RnTc8JWQ8LlzhpeMC+Q
         04Aw==
X-Gm-Message-State: AOAM5311SaDN21kLnPcX+Tbj6nvK26gUhKobF0Tk7gDzDBq3W1jDyI/a
        braFbIPlqRsEdgHcxBYd3Z61tnwXAOWW8Q==
X-Google-Smtp-Source: ABdhPJwuxcPKuFNIh/WSZFXCdlX40o5XBWVpLkiVk2vc9UmT6PHe1RjKBk1djEeo4HxzN2TX1hQcYw==
X-Received: by 2002:a17:90a:e50d:: with SMTP id t13mr312566pjy.160.1617777966454;
        Tue, 06 Apr 2021 23:46:06 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id k20sm917135pfa.34.2021.04.06.23.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:46:06 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:46:04 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 42/49] staging: sm750fb: Rename functions *_deWait to
 snake case
Message-ID: <0362262fbce2e49082f213a9bba06b1ac64a5bb5.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the functions
hw_sm750le_deWait and hw_sm750_deWait.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 2 +-
 drivers/staging/sm750fb/sm750.h    | 4 ++--
 drivers/staging/sm750fb/sm750_hw.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 05f3a1d454db..bb25ab4ba0de 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -609,7 +609,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 				 hw_sm750le_set_blank : hw_sm750_set_blank;
 	/* chip specific phase */
 	sm750_dev->accel.de_wait = (sm750_dev->revid == SM750LE_REVISION_ID) ?
-				    hw_sm750le_deWait : hw_sm750_deWait;
+				    hw_sm750le_de_wait : hw_sm750_de_wait;
 	switch (sm750_dev->dataflow) {
 	case sm750_simul_pri:
 		output->paths = sm750_pnc;
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 4f9fe3e9ef81..da37fc81370b 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -194,8 +194,8 @@ static inline unsigned long ps_to_hz(unsigned int psvalue)
 int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev);
 int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev);
 void hw_sm750_init_accel(struct sm750_dev *sm750_dev);
-int hw_sm750_deWait(void);
-int hw_sm750le_deWait(void);
+int hw_sm750_de_wait(void);
+int hw_sm750le_de_wait(void);
 
 int hw_sm750_output_set_mode(struct lynxfb_output *output,
 			    struct fb_var_screeninfo *var,
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index db2c87fe7006..789199e628cd 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -506,7 +506,7 @@ void hw_sm750_init_accel(struct sm750_dev *sm750_dev)
 	sm750_dev->accel.de_init(&sm750_dev->accel);
 }
 
-int hw_sm750le_deWait(void)
+int hw_sm750le_de_wait(void)
 {
 	int i = 0x10000000;
 	unsigned int mask = DE_STATE2_DE_STATUS_BUSY | DE_STATE2_DE_FIFO_EMPTY |
@@ -523,7 +523,7 @@ int hw_sm750le_deWait(void)
 	return -1;
 }
 
-int hw_sm750_deWait(void)
+int hw_sm750_de_wait(void)
 {
 	int i = 0x10000000;
 	unsigned int mask = SYSTEM_CTRL_DE_STATUS_BUSY |
-- 
2.30.2

