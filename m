Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F71C43332
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1430723600
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbhAMOwN (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbhAMOwM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:12 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D075C061385
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:36 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id a6so1851287wmc.2
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hcCYDUMcS26jDuM5+gRx+fiSHXa/31pKXfkIX189fZc=;
        b=WKJOrwZ97W06sGNe/8643fsBAhUrIy3pw+p8/Z4nnVsXP2eywnUTF/fuu6aqQ7IqnV
         6bqyAhBD4abY+s60Rl5IZigMaAmPXz8Uw2c1DpBJK4PQxmaJxmh9tA+R2LxW1BhiiZTk
         yiuf3i9VtB5gHvfNiYKnHs1w8ffM0OURr8SS6DOOcwdI/uLEYMkd3eiV0TcMkLorYNz2
         63JkGhf4cM01/SzrmAxd+HQf+HPnQA/eQoOZlRp6Lb9kAQGSlV4OiRy91CNfm/Ap5ieG
         bufuyVkbrh7vj7Mtxphu1YXK2MYICuU0icBn09Vb30KwCkk8oOWznjZavOmb2Rr1w40u
         CRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hcCYDUMcS26jDuM5+gRx+fiSHXa/31pKXfkIX189fZc=;
        b=aMUORw5MJZJVgqvGAPJGDPz0Kk1jHmVIc/K9p5NjeGmBOXp4cSM10DbEDRlkZ6zcfv
         /i1uo9hOFLjKMHuCbogsuT1vgXmk/JEo9OeevgiYwTOIc8bXPH+Vl4O40pps6DOgLc0t
         QQkgiNXtAD/5e1JnaYlKEnFeFIzZ2gweihw2NBr2oPBZVs/rd6jDYhLGfqbfjzhILwMp
         AVzw/38Mj4uqM0mQ9vOFoukGLndmIZ2VJtjG0o/R07nigaBZdV2OpeN8sAKV2UWZTOvP
         djUC8gWLc9tOIx7am434UMc6kmLJfRbfCkbTb8sK4D5U/GhB4R+q+oHde91Ra1DS/n3d
         LiPQ==
X-Gm-Message-State: AOAM5334WLXbV6QIDWlgD5NADNRSZBppef6cRZn7kCQKFBvqqI7MMQxC
        ZWfyxgZRQiuSXI6499JqJTOL1TF8giRjtbAp
X-Google-Smtp-Source: ABdhPJxI/06Eq2Rl5+qCibE+uAUvKG7ngE/AQ/AKyFAKVjTjbxsN6HN/O2nM7Z2/XWrJTZE0EwxiWQ==
X-Received: by 2002:a1c:2d92:: with SMTP id t140mr2585614wmt.114.1610549434915;
        Wed, 13 Jan 2021 06:50:34 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:34 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@gmail.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 13/31] video: fbdev: nvidia: nv_setup: Remove a couple of unused 'tmp' variables
Date:   Wed, 13 Jan 2021 14:49:51 +0000
Message-Id: <20210113145009.1272040-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/nvidia/nv_setup.c: In function ‘NVWriteAttr’:
 drivers/video/fbdev/nvidia/nv_setup.c:92:14: warning: variable ‘tmp’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/nvidia/nv_setup.c: In function ‘NVReadAttr’:
 drivers/video/fbdev/nvidia/nv_setup.c:104:14: warning: variable ‘tmp’ set but not used [-Wunused-but-set-variable]

Cc: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/nvidia/nv_setup.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nv_setup.c b/drivers/video/fbdev/nvidia/nv_setup.c
index 2fa68669613af..47a96a066f998 100644
--- a/drivers/video/fbdev/nvidia/nv_setup.c
+++ b/drivers/video/fbdev/nvidia/nv_setup.c
@@ -89,9 +89,7 @@ u8 NVReadSeq(struct nvidia_par *par, u8 index)
 }
 void NVWriteAttr(struct nvidia_par *par, u8 index, u8 value)
 {
-	volatile u8 tmp;
-
-	tmp = VGA_RD08(par->PCIO, par->IOBase + 0x0a);
+	VGA_RD08(par->PCIO, par->IOBase + 0x0a);
 	if (par->paletteEnabled)
 		index &= ~0x20;
 	else
@@ -101,9 +99,7 @@ void NVWriteAttr(struct nvidia_par *par, u8 index, u8 value)
 }
 u8 NVReadAttr(struct nvidia_par *par, u8 index)
 {
-	volatile u8 tmp;
-
-	tmp = VGA_RD08(par->PCIO, par->IOBase + 0x0a);
+	VGA_RD08(par->PCIO, par->IOBase + 0x0a);
 	if (par->paletteEnabled)
 		index &= ~0x20;
 	else
-- 
2.25.1

