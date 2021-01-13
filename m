Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E03C43332
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9520235FF
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbhAMOvy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbhAMOvx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:53 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FACC061342
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:43 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t30so2435605wrb.0
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZRcivOWCu86KtmbW2EK6Np9SsvS7JZY4Xqa/qkwVtkE=;
        b=t1ER4nwN/WPM6fNnm/Mdum0Pojlr01P78z/COYqJ1z5HyIHjWoDRfik8SQHtBQqxQK
         YmiySxijr8E0W29ccNGw29mWFYTILvz8yqxd4Jhjz4xgCEkubT+0KFcPLzD/bqSuhqOv
         bwbne25dLdz4tncYRuqLl24YT+dNFgIwqI2SBJY9J4cgkiSXbIrT5qKhC9+mgB4yvQc0
         udbu5Cayvxz6NRQyXKyHcIRbULqdBiGQkpmclevO2khhsi+G7TZ0owLOrYnOEnlNsCCt
         PsWXGjmGYEWJlNT1uNBNNRB3QkWWj1iQNibwkHhjoWky2+41zMmhl3Ve1ioMsvWRW5MO
         3aKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRcivOWCu86KtmbW2EK6Np9SsvS7JZY4Xqa/qkwVtkE=;
        b=SBbbOuTNvBE7pw9yR77hAMlWZy/+Yt3gXP9F9vrM58iNMC+wTk1y9uqRxTZmTShZeY
         ICSrfAWdzyXm80335xIs+7UDSozgkSkOVS2lsQCJ3hnqyCXfEqiMBejF4qCIq+OKwQY7
         z1NrjnxRvZPL/pCvoS7QbNvAqxMDLuClbzKB+pEZ7aryOuaVe82LIB+O9wHRNZW27HCw
         UtHabtpn1hCwQ2Fi5WIofUK6CX59sf3Ot8DsTGZudghNw8RurzLP5KuQpOmKDAYxs1Hj
         5lCWHUi7W4oefloUqd1a/ye8Vi5HRWQc7gTaJMJdbBGT1PGB0U6XBFtmR1hWiKHvw+Nh
         YmZQ==
X-Gm-Message-State: AOAM533flWwt2V1Lj9M5cCyThDBtf1h7GVuJzaPmoMfGkhfLmEN0vO4D
        92XNNF342FFyEwrTIfXNcH4NpQ==
X-Google-Smtp-Source: ABdhPJySPsgzKgHkiIcO4ZfvmXeUEmf0jtG+A5MVr9yGI+9UHHrTEsVD5G/gBIMGMpLdJt4RrmnaQg==
X-Received: by 2002:a5d:530c:: with SMTP id e12mr3033393wrv.54.1610549442170;
        Wed, 13 Jan 2021 06:50:42 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hannu Mallat <hmallat@cc.hut.fi>,
        Frodo Looijaard <frodol@dds.nl>,
        Philip Edelbrock <phil@netroedge.com>,
        Ralph Metzler <rjkm@thp.uni-koeln.de>,
        "Mark D. Studebaker" <mdsxyz123@yahoo.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 19/31] video: fbdev: tdfxfb: Remove unused variable 'tmp'
Date:   Wed, 13 Jan 2021 14:49:57 +0000
Message-Id: <20210113145009.1272040-20-lee.jones@linaro.org>
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

 drivers/video/fbdev/tdfxfb.c: In function ‘att_outb’:
 drivers/video/fbdev/tdfxfb.c:209:16: warning: variable ‘tmp’ set but not used [-Wunused-but-set-variable]

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Hannu Mallat <hmallat@cc.hut.fi>
Cc: Frodo Looijaard <frodol@dds.nl>
Cc: Philip Edelbrock <phil@netroedge.com>
Cc: Ralph Metzler <rjkm@thp.uni-koeln.de>
Cc: "Mark D. Studebaker" <mdsxyz123@yahoo.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/tdfxfb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index f056d80f6359f..67e37a62b07c3 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -206,9 +206,7 @@ static inline u8 crt_inb(struct tdfx_par *par, u32 idx)
 
 static inline void att_outb(struct tdfx_par *par, u32 idx, u8 val)
 {
-	unsigned char tmp;
-
-	tmp = vga_inb(par, IS1_R);
+	vga_inb(par, IS1_R);
 	vga_outb(par, ATT_IW, idx);
 	vga_outb(par, ATT_IW, val);
 }
-- 
2.25.1

