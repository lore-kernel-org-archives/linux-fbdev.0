Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34870C433DB
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 066B8235FF
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbhAMOwJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbhAMOwI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:08 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E5CC061349
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:46 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q18so2432036wrn.1
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GoUfRt23bqbKPl1TGglCjWozG44qym29OpcwnZGK6kU=;
        b=DVx9RGOhwl5u8ldZy5VrfBB5nqUBSa6oCbOAtc/naAE4if9nM+qG1VzCKee+LVG+3B
         pYMHjLmmVhejEEkmBIU3VqOIbS0QbervpRSbvt8RbrJ65WI6sdAQJIFHQBuqYquGY9sm
         C0BoNNBF1vlcU19yuj0aroZuKk5XVtUWIzVX0dv3Fl5+wU5eXqndsETD1SuasAlFPapO
         Ndex26m6UwPr44hJ1bIN/A68qcXyyjbFTxYEWrG/wLv+f8ePNT5PGN0tbNcfIJ6tyYVQ
         66n2l1NmCju3l+XV3FxP/N8a/cWJvm9uSD3UZcReTj1OIqHd9zRtoKkjQOixv9hbaPDF
         TjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GoUfRt23bqbKPl1TGglCjWozG44qym29OpcwnZGK6kU=;
        b=NWUMPBGrY75PIccMdoPaOzAje+mUFOq+V5pD7b3GEIZaJjee1ycvLzofFH5wEOuBQ3
         igzxUd3d88WIwIZOkEKo845mtc+bCKIehS9Hsuk+7RYF9SIBTCj01fdFy0I6ZUCbF/RN
         M5Xx+Peg3R2r21d49MhLr31zg2fdC8FPOnnC7ySpCcugLTAfpZFyfW+NTMq07drO5v5x
         r8JHhxTPxW/hNTHZ6WF1I0F3bIzJBQ8qPoG3hKmhVSP7cO9vBZ+zsCoJM2FhY16Cynmi
         5zhQpOypBvY8r7P+wq2EvFTA3VZ+fBME/qKqwcFRcB2PXq0a9J77JqTxRRUJ9kFAzXsx
         SjHQ==
X-Gm-Message-State: AOAM532jFuEOUO5q0vQDHbeljtPdnJ4uS03E5JCz/FuqCqjmpt+9Pxcx
        ib6sjbi+UY/Nb643kFV4N7Rdsw==
X-Google-Smtp-Source: ABdhPJzAZpIkSU3ZuxYWodWKq2E4apdvM/gowpmYALF9g0lHHwu0yWyxlERCrNd/IkX0NEsPk4cbEg==
X-Received: by 2002:a5d:6852:: with SMTP id o18mr2897319wrw.371.1610549445789;
        Wed, 13 Jan 2021 06:50:45 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 22/31] video: fbdev: cirrusfb: Remove unused variable 'dummy' from 'WHDR()'
Date:   Wed, 13 Jan 2021 14:50:00 +0000
Message-Id: <20210113145009.1272040-23-lee.jones@linaro.org>
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

 drivers/video/fbdev/cirrusfb.c: In function ‘WHDR’:
 drivers/video/fbdev/cirrusfb.c:2466:16: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]

Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/cirrusfb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index e9027172c0f55..f05160fa34da9 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -2463,8 +2463,6 @@ static void AttrOn(const struct cirrusfb_info *cinfo)
  */
 static void WHDR(const struct cirrusfb_info *cinfo, unsigned char val)
 {
-	unsigned char dummy;
-
 	if (is_laguna(cinfo))
 		return;
 	if (cinfo->btype == BT_PICASSO) {
@@ -2473,18 +2471,18 @@ static void WHDR(const struct cirrusfb_info *cinfo, unsigned char val)
 		WGen(cinfo, VGA_PEL_MSK, 0x00);
 		udelay(200);
 		/* next read dummy from pixel address (3c8) */
-		dummy = RGen(cinfo, VGA_PEL_IW);
+		RGen(cinfo, VGA_PEL_IW);
 		udelay(200);
 	}
 	/* now do the usual stuff to access the HDR */
 
-	dummy = RGen(cinfo, VGA_PEL_MSK);
+	RGen(cinfo, VGA_PEL_MSK);
 	udelay(200);
-	dummy = RGen(cinfo, VGA_PEL_MSK);
+	RGen(cinfo, VGA_PEL_MSK);
 	udelay(200);
-	dummy = RGen(cinfo, VGA_PEL_MSK);
+	RGen(cinfo, VGA_PEL_MSK);
 	udelay(200);
-	dummy = RGen(cinfo, VGA_PEL_MSK);
+	RGen(cinfo, VGA_PEL_MSK);
 	udelay(200);
 
 	WGen(cinfo, VGA_PEL_MSK, val);
@@ -2492,7 +2490,7 @@ static void WHDR(const struct cirrusfb_info *cinfo, unsigned char val)
 
 	if (cinfo->btype == BT_PICASSO) {
 		/* now first reset HDR access counter */
-		dummy = RGen(cinfo, VGA_PEL_IW);
+		RGen(cinfo, VGA_PEL_IW);
 		udelay(200);
 
 		/* and at the end, restore the mask value */
-- 
2.25.1

