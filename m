Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52437C48BE5
	for <linux-fbdev@archiver.kernel.org>; Sat, 12 Jun 2021 11:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF7D61376
	for <linux-fbdev@archiver.kernel.org>; Sat, 12 Jun 2021 11:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhFLLrW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 12 Jun 2021 07:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFLLrV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 12 Jun 2021 07:47:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7F4C061574;
        Sat, 12 Jun 2021 04:45:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id k5so7122558pjj.1;
        Sat, 12 Jun 2021 04:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yETzIEA0FE51iHDiilpc4taiEHo/TOmRxZBfjJ3S7Bw=;
        b=INPsrGFMJW9mzsR/+ohw+zzIRzDn+VFI2/sI+DNCnyqJxTh6myJ82Ps1jj9LrtGb6J
         5n+oMRbDavZqOjstkv7tuaphQQqhlEDTedd6WYsQnfDWTtqzySBRtESH6PcsloCRIsXG
         gcsXonkmQJPMsv8EhAfvBl4fr46vSX6GI7GtQw3kDOdeXdvCUUmYJk10E0EGz4G7WtTQ
         wNLhkDpCIss7IPzkISxsxCBxTnJdK/Fw/Pue7mKeNUZgXzdsPq2JR1/7EWPmImXJePrn
         TFgfdRHenFtGTZNMww1uufw63w31WlH+FOGoHKczMesW5ZviySs3dRW5n82YHpcJcgON
         F0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yETzIEA0FE51iHDiilpc4taiEHo/TOmRxZBfjJ3S7Bw=;
        b=Zcg+mUTkdqRca896GuHcIwMLtk1r8rO0Q79ZnJawNN6Xteypi+zC/oYUgOcAcCznI+
         R/MeIlcQiKCoYUNCEAfbppKfWfKtSlKrB7ZG9OiNMcyb4qNhigpu2J+DVtjJzlp2ezag
         43ocCZILFR7wUlKQQkKc1qPhtIAEdejpVZTResZO3PftT1YPzRt2KL3hzsE4ME+bz4AO
         lVQ7+7B7jYV6AvyySpXqXh03G9ljKRe5jVCI8bRxjdXZWHiWsIaSoXTpLhv1XRk4yT5J
         T5mpknLqJ4bLhoPg8/L3tGOu70p4bI2pUtLgXA6FRWxhmGWpNFmH9sQaDdg5heA2N850
         SwFQ==
X-Gm-Message-State: AOAM530DT99J6YOFv2psf5KJVkDbdrA4z5kJydSARMQXSOWpS2ylUerh
        NF/jtinRpoZ+pSq1lOD3busQKnnY8+FJn8jIEzU=
X-Google-Smtp-Source: ABdhPJxCShIv1IMMtVGH1gBsgPqeHLYwuMVVNRSYR7O5mVUCKfza4jq7durCcWsjhxPb39NYNTZF3w==
X-Received: by 2002:a17:90a:4f0a:: with SMTP id p10mr13860518pjh.36.1623498321660;
        Sat, 12 Jun 2021 04:45:21 -0700 (PDT)
Received: from localhost.localdomain ([117.222.175.26])
        by smtp.googlemail.com with ESMTPSA id b5sm1648762pfp.102.2021.06.12.04.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 04:45:21 -0700 (PDT)
From:   arjuncr <arjuncr00@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     arjuncr00@gmail.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fix for checkpatch.pl
Date:   Sat, 12 Jun 2021 17:15:05 +0530
Message-Id: <20210612114505.6833-1-arjuncr00@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Signed-off-by: arjuncr <arjuncr00@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 63c65dd67..cdb451dd3 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8,)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16,)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.25.1

