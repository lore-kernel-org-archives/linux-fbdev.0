Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCC1C433B4
	for <linux-fbdev@archiver.kernel.org>; Wed, 31 Mar 2021 22:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E19F61076
	for <linux-fbdev@archiver.kernel.org>; Wed, 31 Mar 2021 22:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhCaWHn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 31 Mar 2021 18:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhCaWHX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 31 Mar 2021 18:07:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A92C061574
        for <linux-fbdev@vger.kernel.org>; Wed, 31 Mar 2021 15:07:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k8so21122167wrc.3
        for <linux-fbdev@vger.kernel.org>; Wed, 31 Mar 2021 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IE0NHC+B7WM4oHnzUAb/T162fdB57ZZtfDzZlQLPsWQ=;
        b=cESdP8es/GN0f1lVMQaBFDBcGDJ1lIamwN/O691MvzEUjqi2bufaO1gaOoS9Ynbacy
         3ul0+Hxi8sOyKWS02Z9WdRpc5G7DWiB8YlJJhe+qYfNebwhioubnM7IoYjjqnac70G+1
         zYQqyMfCxQNMy197l6PyY/s3HHCXKFwZfjt8z+WL/Iz1yTNVyn1R5ZjosSHF42udHtyh
         ANaXWn7yk7CAMCxaUvbdw36u6WTd6IYqS7qYzDV7FiBNr7v8WyuvWyLFc33FBA7Mq76Z
         x5V+xN03fl1rqTHLaq6kW5uX+Q9V/HuoH+kIAfE+u+4SVXPV7r8JM9r5g+1Vpty6MP05
         073w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IE0NHC+B7WM4oHnzUAb/T162fdB57ZZtfDzZlQLPsWQ=;
        b=MlUGo7BNrw97L/jiIkxKHCnqvC4bpnX47bpthSVX83LpmSPycSD21ZN5vTiwC+j8bl
         wx7jl8rLQTFbjgdvyEmAruLyX/tV8xoV7ievECX27k4UGkCYAkHf5Ef19FwNdLOs5Sk8
         Yc02UmKzzjguP/EHKyzu2tmh20PoFMpUKjUayTqvu6hOoY8mAMV5rbIWG8vT0Amj6565
         wA++AtSm9hhjoYnInO3M+3G8a5DKSZKOTAHpx8/JnxRREdm8V1ZDDB1Q39HCEATlDPzm
         Y0MgKRn/QiQmuJ/nl/+lzAr1sfxhWrXjrnon5BA129z0pLZusMbU4V7GCOLXsJJiuPUB
         UHVA==
X-Gm-Message-State: AOAM5311lJjLEdBPEM0E5/3rp5bYzwzqA/6ejy8lk924BnZkl4FBSNDw
        66xki9jPDbecZP7I2jGMHLmj20DewDjYakls
X-Google-Smtp-Source: ABdhPJwe16krazFRt0g3sMEwwwsGfIoOhECLnObZ2z9hz7fYHOcZNZ8Te7ytCOBcbZm4yzZrB0Drsw==
X-Received: by 2002:adf:cd81:: with SMTP id q1mr6066166wrj.125.1617228441230;
        Wed, 31 Mar 2021 15:07:21 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id g9sm6531654wrp.14.2021.03.31.15.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 15:07:20 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     mchehab+huawei@kernel.org
Cc:     daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] zero-fill colormap in drivers/video/fbdev/core/fbcmap.c
Date:   Wed, 31 Mar 2021 23:07:19 +0100
Message-Id: <20210331220719.1499743-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Use kzalloc() rather than kmalloc() for the dynamically allocated parts
of the colormap in fb_alloc_cmap_gfp, to prevent a leak of random kernel
data to userspace under certain circumstances.

Fixes a KMSAN-found infoleak bug reported by syzbot at:
https://syzkaller.appspot.com/bug?id=741578659feabd108ad9e06696f0c1f2e69c4b6e

Reported-by: syzbot+47fa9c9c648b765305b9@syzkaller.appspotmail.com
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/video/fbdev/core/fbcmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcmap.c b/drivers/video/fbdev/core/fbcmap.c
index 757d5c3f620b..ff09e57f3c38 100644
--- a/drivers/video/fbdev/core/fbcmap.c
+++ b/drivers/video/fbdev/core/fbcmap.c
@@ -101,17 +101,17 @@ int fb_alloc_cmap_gfp(struct fb_cmap *cmap, int len, int transp, gfp_t flags)
 		if (!len)
 			return 0;
 
-		cmap->red = kmalloc(size, flags);
+		cmap->red = kzalloc(size, flags);
 		if (!cmap->red)
 			goto fail;
-		cmap->green = kmalloc(size, flags);
+		cmap->green = kzalloc(size, flags);
 		if (!cmap->green)
 			goto fail;
-		cmap->blue = kmalloc(size, flags);
+		cmap->blue = kzalloc(size, flags);
 		if (!cmap->blue)
 			goto fail;
 		if (transp) {
-			cmap->transp = kmalloc(size, flags);
+			cmap->transp = kzalloc(size, flags);
 			if (!cmap->transp)
 				goto fail;
 		} else {
-- 
2.30.2

