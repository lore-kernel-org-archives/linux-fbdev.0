Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94117C43381
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A0A235FF
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbhAMOvh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbhAMOvg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:36 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15C1C0617A6
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 190so1850490wmz.0
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z+Wneugk0qlue2K4+v5y/OOFUzDsbbip7TVziVpxlQg=;
        b=IrAuQ7STah/wSU3pxyHJvgSYn2RFJdHG53sANMcOvFWEelHr6MWbdgH0ILose47Zot
         Z7KuINVRHXAMOA906n8OR8iFtf4Nj4LcjAyitSzAalDlz9HRtVPGlTQdbmekRtEQvGci
         mwZQ7Bb/HQ3c6/5luRJ3paeeu2VckReWTpFW7IRFzHAedOHDtIquldPM8aztOfgvKxxD
         s6M1i1MfLLNqZIHLouLNp+LTtcAhj/vFkE7Sl4+oIe3REJUFHIDtu/tkOMeXBy2FAK74
         x/2MlHNNGii/IG81iFi1rPP9oiZBxGa2SQxXcMDTHrLT+hIaHOP1bEfVoE+Viqsap5Ze
         aNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z+Wneugk0qlue2K4+v5y/OOFUzDsbbip7TVziVpxlQg=;
        b=OXd1oHlr2WCnqm5ruX4mu01HfBPo4VgAwJS6EV16Kuk8uUc4bT6OxhxWqtQ8R4BU3h
         ew7hAaD3GK7Uxk3OGVIBaYUXVCUkPIRtzUWqbzyVjY/6MV7ofdawvR1//MtZ4yVrzOe4
         SReSD5HdhzJribVtW54SDR2/k/YvrW34b2o/eiWmYkY9JQVux8oTNd5UXM4/PdcuYA/p
         Jn/4vvQ6cYR/846C4dfUBNXSJnkdncYf/DmLmPEWvYH+jTWaw6lNFtbobTxIJcT+hz6q
         5WriOXfVykNaszpJSLFf4MxRqadIoHn83fhNgSLV1LCl6ByxXn9xhRMzbhlSuyd65V+E
         7ueA==
X-Gm-Message-State: AOAM53158PiBuU4a3SAVwHI4bMjMVdL0nHoXS9ZdPBCEfYu3YRw5fTzM
        /N9rEEtSXG5NzIup6HMEJA853A==
X-Google-Smtp-Source: ABdhPJwjKCL09Sc77kIICMVKTnbILEqHPsQQ1uMvyk6hJHaNqRVyJKhV6HK5PA5SegcO2ZY3WnDx2Q==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr2562890wmj.168.1610549417412;
        Wed, 13 Jan 2021 06:50:17 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:16 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Alex Kern <alex.kern@gmx.de>, "Eddie C. Dost" <ecd@skynet.be>,
        Anthony Tong <atong@uiuc.edu>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 03/31] video: fbdev: aty: atyfb_base: Remove superfluous code surrounding 'dac_type'
Date:   Wed, 13 Jan 2021 14:49:41 +0000
Message-Id: <20210113145009.1272040-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

If used, 'dac_type' is overwritten in the '#ifdef CONFIG_ATARI' clause.

It's also not used after the last assignment, so we'll rid that too.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: Alex Kern <alex.kern@gmx.de>
Cc: "Eddie C. Dost" <ecd@skynet.be>
Cc: Anthony Tong <atong@uiuc.edu>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/aty/atyfb_base.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index c8feff0ee8da9..11c328f0585ce 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -2365,8 +2365,6 @@ static int aty_init(struct fb_info *info)
 		par->bus_type = (stat0 >> 0) & 0x07;
 		par->ram_type = (stat0 >> 3) & 0x07;
 		ramname = aty_gx_ram[par->ram_type];
-		/* FIXME: clockchip/RAMDAC probing? */
-		dac_type = (aty_ld_le32(DAC_CNTL, par) >> 16) & 0x07;
 #ifdef CONFIG_ATARI
 		clk_type = CLK_ATI18818_1;
 		dac_type = (stat0 >> 9) & 0x07;
@@ -2375,7 +2373,6 @@ static int aty_init(struct fb_info *info)
 		else
 			dac_subtype = (aty_ld_8(SCRATCH_REG1 + 1, par) & 0xF0) | dac_type;
 #else
-		dac_type = DAC_IBMRGB514;
 		dac_subtype = DAC_IBMRGB514;
 		clk_type = CLK_IBMRGB514;
 #endif
-- 
2.25.1

