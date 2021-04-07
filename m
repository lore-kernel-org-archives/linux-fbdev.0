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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0F6C4360C
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 491B161222
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349167AbhDGGqW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349157AbhDGGqR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:46:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68716C061763;
        Tue,  6 Apr 2021 23:46:08 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c204so8440898pfc.4;
        Tue, 06 Apr 2021 23:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0In7Usm62iDzXGlWXf0B0UqSRUyq5ZkXwX+9zfXFdWA=;
        b=f0eEAxBwZAwKyCusdi6rWc6PV83Li0QqWeBqCWFbovV7R7X36fkRlKIauusERa3X6N
         ZIlMJxAP3oOTwPthCBTn7eMhHQULRSsgnIC6JN7HtzpEZCDbyebtYZORaTM4WvB/QzSZ
         EQuIVuW9oNztqrYY6IbvGSmHbXjS4bN8n2mBX26eCum5hiO5yZ9Ix89W4tI68Edk2xDW
         3WZrjSp6RvrJmMpIS7J+lv5ybyyIuY87EUS/4Av5mCEs9YC8qcVCW2KEfYjM9O7cY9nP
         6e9mREzHX0X5788GK+K67oIiS/3yE0XcYEbkVzylDV+gIUjMnngaVRf/wPWNPubphbSD
         boHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0In7Usm62iDzXGlWXf0B0UqSRUyq5ZkXwX+9zfXFdWA=;
        b=hruIJUyf8fb2V6weLBBAq87XfRJ1l+99FGo/g5b/geMIEop4RJngihQz47OatxK1o9
         tteCvQrGM6rgn7cf+JKnq98QcF6mVzer/k1wY23BXmJV8CCPjisQG3aqndTYR/Rk01aD
         g6WhrmSNipKQeVsDwc8/akFr948OWyc4o4w3oqvaS9vslsXxhzKQap5etbemxD5D1v7s
         kk6yKL32ck2iUB2xexbkclO37usSAiHxYaJ0G6f0A0GXUzSkaLdkDY1uoMSGAXkfaY0C
         m4+d9pJ3CToCDzY7XjunX89S8s9ZutnQgChR3ZljIdnRnZim3qdhCJdr/O1TCc9vIaao
         zAqw==
X-Gm-Message-State: AOAM533RQ8VBbi4XnpjQZsLIv9ITQvQw3F1lu6uO3kciJLJjRDapsE++
        VcLPEF6A1diqfJXoGxPkv5gZWxU2wodJmQ==
X-Google-Smtp-Source: ABdhPJxysv27ETveWY9+1QtkAc3R4IcuOpZgVZZChEL6e09gINMJcJ08dM2ot+ikFn9ueIvYMXGFvA==
X-Received: by 2002:a63:1a47:: with SMTP id a7mr1863095pgm.437.1617777967933;
        Tue, 06 Apr 2021 23:46:07 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id v14sm4035981pju.19.2021.04.06.23.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:46:07 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:46:05 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 43/49] staging: sm750fb: Update members of lynx_accel
 struct to snake case
Message-ID: <52fcfc4480d5ee19f8751dae2d2369a5958fa1fc.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the members of
lynx_accel structure, in particular dprBase and dpPortBase.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750.h       | 4 ++--
 drivers/staging/sm750fb/sm750_accel.c | 6 +++---
 drivers/staging/sm750fb/sm750_hw.c    | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index da37fc81370b..a27aaac5d67a 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -50,9 +50,9 @@ struct init_status {
 
 struct lynx_accel {
 	/* base virtual address of DPR registers */
-	volatile unsigned char __iomem *dprBase;
+	volatile unsigned char __iomem *dpr_base;
 	/* base virtual address of de data port */
-	volatile unsigned char __iomem *dpPortBase;
+	volatile unsigned char __iomem *dp_port_base;
 
 	/* function pointers */
 	void (*de_init)(struct lynx_accel *accel);
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index d0b64962b10e..6ca2e5265836 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -20,17 +20,17 @@
 #include "sm750_accel.h"
 static inline void write_dpr(struct lynx_accel *accel, int offset, u32 reg_value)
 {
-	writel(reg_value, accel->dprBase + offset);
+	writel(reg_value, accel->dpr_base + offset);
 }
 
 static inline u32 read_dpr(struct lynx_accel *accel, int offset)
 {
-	return readl(accel->dprBase + offset);
+	return readl(accel->dpr_base + offset);
 }
 
 static inline void write_dp_port(struct lynx_accel *accel, u32 data)
 {
-	writel(data, accel->dpPortBase);
+	writel(data, accel->dp_port_base);
 }
 
 void sm750_hw_de_init(struct lynx_accel *accel)
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 789199e628cd..97b842148bcb 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -60,8 +60,8 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		pr_info("mmio virtual addr = %p\n", sm750_dev->reg);
 	}
 
-	sm750_dev->accel.dprBase = sm750_dev->reg + DE_BASE_ADDR_TYPE1;
-	sm750_dev->accel.dpPortBase = sm750_dev->reg + DE_PORT_ADDR_TYPE1;
+	sm750_dev->accel.dpr_base = sm750_dev->reg + DE_BASE_ADDR_TYPE1;
+	sm750_dev->accel.dp_port_base = sm750_dev->reg + DE_PORT_ADDR_TYPE1;
 
 	mmio750 = sm750_dev->reg;
 	sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
-- 
2.30.2

