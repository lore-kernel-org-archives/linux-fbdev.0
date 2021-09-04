Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71E2C433EF
	for <linux-fbdev@archiver.kernel.org>; Sat,  4 Sep 2021 06:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5E5560FD7
	for <linux-fbdev@archiver.kernel.org>; Sat,  4 Sep 2021 06:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbhIDGcm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 4 Sep 2021 02:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhIDGcl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 4 Sep 2021 02:32:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78157C061575;
        Fri,  3 Sep 2021 23:31:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j1so945990pjv.3;
        Fri, 03 Sep 2021 23:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1uz0oGH2peoXwoViq7ISy7dnv7QydlkNRkRbvHanRv4=;
        b=RAzfx9ZbzUl7+CFMq0YA99u/jBVlx0xAFoDQ2uq9SPGKcXCE2+Q2vR2gWB6JAYMuqQ
         MTGDDdoK8qKWA+vqpmJOEaw0lNPiQseAra9NdeULs/2vhQgOrSLeDLLrFmTBMzz1LghF
         /GD7qLHU/q4KrGboP47vLzgj0cNRHLW2SBxtpzpNAF+OmKtbD8J/yJUNtVpfg/yq2Jqm
         hE3lYVv3Po8vCIE2DYjbwKTk7sq47wqMRnSeSGII+7Vw31r8VB+D5tE1CwSfWatQnmmw
         /9Ddaz35OJUq3A581q5LUQqFK9uy+vLNA9W0l59W+KTB6FhEd2q+7pZmIVLy/o0LFkHA
         m+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1uz0oGH2peoXwoViq7ISy7dnv7QydlkNRkRbvHanRv4=;
        b=EJoRI0C4eI8VsX/vkj6bSe3tfPUFaIBZVlMzLT1bXguMnHLILC0aubakphdCg5VM/p
         H1V07aIAWfkFpI1VT4C+gcIdVJ2dmFnzYYNGYedY3yzVr+ayptNAm9kq2hXLPQYqE042
         kyZk5HVgF25g15+Ox/rB8Zc9D0HNzgCeK5LI88KWkVrypfckt51WT7sLV6y/1VrUWADM
         pKg2Y50BiOXh2wlubRpyLxEPYKIJqYy2P0OkJCo7VJqp3zriKKf2b5kIyzf3ij1/T0UQ
         XEyB7AoAOdt/oNeQevbtHVL6oz0IgiZHJA4ylsLVd2WOR3dZoLQl4jSZs0NUBo7T0VnZ
         HesA==
X-Gm-Message-State: AOAM530BveN/LdArrI7WcABSa5NBgAyM2inL6+8ows/ty3eS+s6BgXaC
        At1d4HqbaOh4zV8mX6dSf8s=
X-Google-Smtp-Source: ABdhPJyuZpl9wW4ps+FAaEdQj7Q0fyN344v3p+LFNSy1+2G2NRjD4gsEKPT8X3Keja90XKvEm0DFKA==
X-Received: by 2002:a17:902:6b49:b0:136:3f21:7a9 with SMTP id g9-20020a1709026b4900b001363f2107a9mr2196578plt.81.1630737099883;
        Fri, 03 Sep 2021 23:31:39 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c26:4b2d:32ce:9155:7c42:8667])
        by smtp.gmail.com with ESMTPSA id p24sm1408256pgm.54.2021.09.03.23.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 23:31:39 -0700 (PDT)
From:   srivathsa <srivathsa729.8@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        srivathsa <srivathsa729.8@gmail.com>
Subject: [PATCH] Fix ERROR: trailing statements should be on next line
Date:   Sat,  4 Sep 2021 12:01:27 +0530
Message-Id: <20210904063127.11142-1-srivathsa729.8@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Signed-off-by: Srivathsa Dara <srivathsa729.8@gmail.com>
---
 drivers/staging/fbtft/fbtft-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index ed992ca605eb..65de1c02e7dc 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -1038,7 +1038,8 @@ int fbtft_init_display(struct fbtft_par *par)
 			i++;
 
 			/* make debug message */
-			for (j = 0; par->init_sequence[i + 1 + j] >= 0; j++);
+			for (j = 0; par->init_sequence[i + 1 + j] >= 0; j++)
+				;
 
 			fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
 				      "init: write(0x%02X) %*ph\n",
-- 
2.25.1

