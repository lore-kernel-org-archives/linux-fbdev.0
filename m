Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBE3C43381
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C3E823600
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbhAMOvc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbhAMOvc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:32 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18276C0617BB
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:27 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r3so2426127wrt.2
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xVuJfuGZFscYbOy1MUiffPVpTle7WgNo/eVkJwf7WNU=;
        b=q+MZOwcKb62nI3dDtefjHxCD1svvGR60Jf4GADTHbVCFSZk5ahffVs42713RFmCF3M
         hhNPD9AVosxvdPh3Z8yE2EAX9AIqiNvXNvlrh/+KWS1FF0B5BjXeeykrTfib5131sKFj
         mn2tgU4dkCSlErK842cyu7HwusDnIaakfzs1I7cSnM4yplICdcp2mBAJcvH34TWQSDE0
         Dng1yBz0vV3j29G56BqJw78ZGoOyPY6hhoK+WPjPT+6lUPxLOPjPUWuXCAoeTfdRwhJo
         a9h437HEm5yNmdhcoLqG033+xaunKcJYY/dyF8W3QR8fqLXStt350nJ0m0HkPZgnnZIh
         3SRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVuJfuGZFscYbOy1MUiffPVpTle7WgNo/eVkJwf7WNU=;
        b=DjTuwtxfmqDwphUhpGj59/EwNS9e5mCsHVY9JTOhBSlUncomlUn4IWUNQHyAZh5i1X
         spa+S3ESckZVcsqeUIRO60362gIaG3NLsuijLyBnAJTVqpDoAHqcsDtXPB84ItL3uyz3
         IISEQbORrW7H/3M3AoVqIrkYXpFPQQVNxuwZMnYoHlfEY3BmDWXSpXnIUEgzGWKohPud
         giBf6JSDahMkRKWWzHWEb7dP+Lex2zFkv1efMAO8tlG5N+cDEDqFltAkRaPGDcGuBYEv
         qcBHQin1F1nbmHemaS1lrz77Wux2TIxk/X43heWp6CVYb9wNwQkXGYWe+UCo58k/aMb1
         vzWg==
X-Gm-Message-State: AOAM530AJYN2n4Sewg6p1wE7vzY2k9NPGfvsLs2cv13KypRQn+pCEjfX
        fTZkGMIJSS+ckCye/FB64+L/lA==
X-Google-Smtp-Source: ABdhPJwVCTsByjCEjav6tW14+5dv7xLsxBc5Eorij361Ct+VXeRJyY7s7OCdf+rGi3SgUVSd2g+Hog==
X-Received: by 2002:a5d:4d50:: with SMTP id a16mr2925284wru.43.1610549425879;
        Wed, 13 Jan 2021 06:50:25 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:24 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Gerd Knorr <kraxel@goldbach.in-berlin.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 08/31] video: fbdev: sis: sis_main: Remove unused variable 'reg'
Date:   Wed, 13 Jan 2021 14:49:46 +0000
Message-Id: <20210113145009.1272040-9-lee.jones@linaro.org>
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

 drivers/video/fbdev/sis/sis_main.c: In function ‘sisfb_post_xgi_ddr2’:
 drivers/video/fbdev/sis/sis_main.c:5032:5: warning: variable ‘reg’ set but not used [-Wunused-but-set-variable]

Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Gerd Knorr <kraxel@goldbach.in-berlin.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/sis/sis_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 03c736f6f3d08..266a5582f94d3 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -5029,7 +5029,6 @@ static void sisfb_post_xgi_ddr2(struct sis_video_info *ivideo, u8 regb)
 	static const u8 cs168[8] = {
 		0x48, 0x78, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00
 	};
-	u8 reg;
 	u8 v1;
 	u8 v2;
 	u8 v3;
@@ -5037,9 +5036,9 @@ static void sisfb_post_xgi_ddr2(struct sis_video_info *ivideo, u8 regb)
 	SiS_SetReg(SISCR, 0xb0, 0x80); /* DDR2 dual frequency mode */
 	SiS_SetReg(SISCR, 0x82, 0x77);
 	SiS_SetReg(SISCR, 0x86, 0x00);
-	reg = SiS_GetReg(SISCR, 0x86);
+	SiS_GetReg(SISCR, 0x86);
 	SiS_SetReg(SISCR, 0x86, 0x88);
-	reg = SiS_GetReg(SISCR, 0x86);
+	SiS_GetReg(SISCR, 0x86);
 	v1 = cs168[regb]; v2 = cs160[regb]; v3 = cs158[regb];
 	if (ivideo->haveXGIROM) {
 		v1 = bios[regb + 0x168];
@@ -5049,9 +5048,9 @@ static void sisfb_post_xgi_ddr2(struct sis_video_info *ivideo, u8 regb)
 	SiS_SetReg(SISCR, 0x86, v1);
 	SiS_SetReg(SISCR, 0x82, 0x77);
 	SiS_SetReg(SISCR, 0x85, 0x00);
-	reg = SiS_GetReg(SISCR, 0x85);
+	SiS_GetReg(SISCR, 0x85);
 	SiS_SetReg(SISCR, 0x85, 0x88);
-	reg = SiS_GetReg(SISCR, 0x85);
+	SiS_GetReg(SISCR, 0x85);
 	SiS_SetReg(SISCR, 0x85, v2);
 	SiS_SetReg(SISCR, 0x82, v3);
 	SiS_SetReg(SISCR, 0x98, 0x01);
-- 
2.25.1

