Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B17AC433DB
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A2123600
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbhAMOvh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbhAMOvg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:36 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BF9C0617A9
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:20 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q18so2430378wrn.1
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qvE9T1Sdi1RAuyfyFAKYPhv+PIZJRg/gdw+xAA12HNM=;
        b=U7XZpCynbw9Y5AThFO42Dm2JoFqWJsr9KG6TgiBESTQlNc3fAWqvrv/vV8/bWuW37L
         5Fjmhghbx5eL6EY4Moqeeu/yko+J0D69QRMZW6dhXQ+Nm9vDb4yEtKNNPUG+swW/GUbD
         nAaRi2O/qE3tCVsaODzksTZRhF5TfWSJtIznTgVmbKSYSnmBQqobEUxuFMK2YTYRo0L7
         5w6ysuaaYARhRutz78Bmdnh6Kc8gc9Z/V8eH/apGCKxMK7Ke/jwJuBK4NTtqahNEJg7W
         TA2E0XY8ZoQAjFera38Ev01dBrJEDrnnCeyVsmeOs34OMOGtHvVAEe9zC9dc+VdMb3Ui
         iGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qvE9T1Sdi1RAuyfyFAKYPhv+PIZJRg/gdw+xAA12HNM=;
        b=p7Gt6ynWvfdSSzZ1QSW1P0VYi6WGuuk0jdTxmOX4kzpPY1jFX/U8GMir2lme+PoUz/
         e71SnCNYlJek3vyjkfORfUyczSyv+vzbCecJydauHpGmPXj3K9GWNEt5VpqbB1QaJtAD
         mfdMvvTbTdQjk3D1xD1vQxHivJCEwbfTyUU3keFCtgSm2oAZFO8sul5k3yRkNZstYfu/
         K174+OqMYjTUQbqv0VknAGDFJ8onJquuqH2Ne8VTp/z3u3kBCdedSZ96XG5CtiUAgEj7
         Awkea/fiAIRYRfa8SeuyVWmriARaFj7jelVI1Xl6HPB/eCFe4jaKvZEidafwxJky2D51
         U8yQ==
X-Gm-Message-State: AOAM533TYiH1L53VmWAgLzx59rrkukHpGhFp4sXAilt131650N2vyuei
        X2UH1mx3/ThZcX/dELtnskVYEQ==
X-Google-Smtp-Source: ABdhPJw8rEyi0DM19K9SdWt8OAokANJ3aIc/AvHlDFnh4GZL9+DaYT3IWFB1YtzXdbd84j6vPII+bw==
X-Received: by 2002:adf:f18a:: with SMTP id h10mr3187110wro.244.1610549419211;
        Wed, 13 Jan 2021 06:50:19 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Alex Kern <alex.kern@gmx.de>, "Eddie C. Dost" <ecd@skynet.be>,
        Anthony Tong <atong@uiuc.edu>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 04/31] video: fbdev: aty: atyfb_base: Mark 'dac_type' as __maybe_unused
Date:   Wed, 13 Jan 2021 14:49:42 +0000
Message-Id: <20210113145009.1272040-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

'dac_type' is only used in the '#ifdef CONFIG_ATARI' clause.

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/aty/atyfb_base.c: In function ‘aty_init’:
 drivers/video/fbdev/aty/atyfb_base.c:2363:6: warning: variable ‘dac_type’ set but not used [-Wunused-but-set-variable]

Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: Alex Kern <alex.kern@gmx.de>
Cc: "Eddie C. Dost" <ecd@skynet.be>
Cc: Anthony Tong <atong@uiuc.edu>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/aty/atyfb_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 11c328f0585ce..9b056b49f2807 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -2360,7 +2360,7 @@ static int aty_init(struct fb_info *info)
 #ifdef CONFIG_FB_ATY_GX
 	if (!M64_HAS(INTEGRATED)) {
 		u32 stat0;
-		u8 dac_type, dac_subtype, clk_type;
+		u8 __maybe_unused dac_type, dac_subtype, clk_type;
 		stat0 = aty_ld_le32(CNFG_STAT0, par);
 		par->bus_type = (stat0 >> 0) & 0x07;
 		par->ram_type = (stat0 >> 3) & 0x07;
-- 
2.25.1

