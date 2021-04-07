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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3DCC433B4
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000F2610C8
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349002AbhDGGn3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhDGGn3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:43:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33BAC06174A;
        Tue,  6 Apr 2021 23:43:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so775858pjv.1;
        Tue, 06 Apr 2021 23:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZAuGglzaZUilwxmfKh+vB3j+5qRuKYKMV1iFQ03oySg=;
        b=g6gIelmtiXWSl9iuGdO97naDvYmDnPLLIeCo+nOz0LwZQrG3lVCa7DRF+/9bVjM2wr
         iDgR3R00ajkdSNzDQdJpXxcq/WnHvAHMspdV7Cu6w6Z6ysrJSpOjG8zF9gapZh+7/1bg
         S7N7c136/ZrRf4Xtgbi+nPXD+6YJr2CZ+Cce1/TAyzMc60R9mB3Nv59+gz7AXVk94ZWt
         53/IYMrtJ5hJ8MfKPZ7z/ZhoaIwrCnKS3lWkvUz8WFpvuufWEILVtctw70t/eoxLFzol
         hG3hwEpk3M6SIFgDJ87GJrCkB2ZVg8KuwCWNP+y718zerzJDUP1P91PaQbzP96ebVzoY
         PTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZAuGglzaZUilwxmfKh+vB3j+5qRuKYKMV1iFQ03oySg=;
        b=ZXc8T63bDni4f6c+/qnm+s8vKh6ThIgOeHMfpACc/xuGrmQ8MO3Sw/ZVYsru1Pm4YR
         jA4IEyn8y2btR5E2yRWaJjz5BEUShb5VwGboImcrlFYQdQuAhDPVH9bplY+yGStSzD6S
         iIBlDHERbyuEzpLyvfFO1H9ktlxIAkwXnq9cekk1GxbBFJtufidOPyQlKfnS74hD8rBz
         CpfALcmV8Hh6p28pFbKIc8OJl3IOLjlbqi/5pjHiElSltI2O1cY7vJV6tO4xkZvAMPGD
         8ugbGUE96z7QY9HM8XUPusdZYxLvzwXgwTJIGpm/iUmhPOdyP/V6Rt/JtG/N6XPUC1XS
         UY7g==
X-Gm-Message-State: AOAM532FelZAJbonuQjpBzqcpUoLbjYKsTAlsTsCAJnXKQfuA7MjFCLF
        +mbyxcDHcLiehGysdVmJtWkyWcFgoYooLQ==
X-Google-Smtp-Source: ABdhPJxWSmAXAukOFlyPPiMrn1UKacPWX0YrpPIz/Oc7rAqf79rADJkQBtWoKzOPV9hdfH5AU+ht7A==
X-Received: by 2002:a17:902:ea0e:b029:e4:81d4:ddae with SMTP id s14-20020a170902ea0eb02900e481d4ddaemr1859233plg.12.1617777798266;
        Tue, 06 Apr 2021 23:43:18 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id c11sm20233683pgk.83.2021.04.06.23.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:43:17 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:43:15 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/49] staging: sm750fb: Rename function params of
 sii164_init_chip
Message-ID: <902ae58f025b3cce6004b83d8ee8fbc3f6ecee7a.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for function parameter
names of the function sii164_init_chip.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/ddk750_sii164.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index cf17b9029496..ceafac60340f 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -16,16 +16,16 @@ enum sii164_hot_plug_mode {
 };
 
 /* Silicon Image SiI164 chip prototype */
-long sii164_init_chip(unsigned char edgeSelect,
-		    unsigned char busSelect,
-		    unsigned char dualEdgeClkSelect,
-		    unsigned char hsyncEnable,
-		    unsigned char vsyncEnable,
-		    unsigned char deskewEnable,
-		    unsigned char deskewSetting,
-		    unsigned char continuousSyncEnable,
-		    unsigned char pllFilterEnable,
-		    unsigned char pllFilterValue);
+long sii164_init_chip(unsigned char edge_select,
+		    unsigned char bus_select,
+		    unsigned char dual_edge_clk_select,
+		    unsigned char hsync_enable,
+		    unsigned char vsync_enable,
+		    unsigned char deskew_enable,
+		    unsigned char deskew_setting,
+		    unsigned char continuous_sync_enable,
+		    unsigned char pll_filter_enable,
+		    unsigned char pll_filter_value);
 
 unsigned short sii164_get_vendor_id(void);
 unsigned short sii164_get_device_id(void);
-- 
2.30.2

