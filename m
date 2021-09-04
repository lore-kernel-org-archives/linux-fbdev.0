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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A53C433EF
	for <linux-fbdev@archiver.kernel.org>; Sat,  4 Sep 2021 08:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E87360FD7
	for <linux-fbdev@archiver.kernel.org>; Sat,  4 Sep 2021 08:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhIDIKa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 4 Sep 2021 04:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhIDIKZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 4 Sep 2021 04:10:25 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B09C061575;
        Sat,  4 Sep 2021 01:09:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i24so1318610pfo.12;
        Sat, 04 Sep 2021 01:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FM13umhiUZ5Y1cUzG3acpmqo6yaDvf6xGiDzXDodIV4=;
        b=D0uiAgyFHTZSJ4/mZMzCUe+Jr2nKhjSLljLCR+masb9b9IJGho5k7blEZ1czjm5rdu
         nCNNYHTB8l3Pl47jvWNNjjAY/e+j660nE25+7fcj9vOAg191PVM7eiMAWx5jdXd5U8FJ
         Qu3B8SBmkuezbXMEijcA3FoWGXOGJ+6tqEaRwHS/B9QEpdc2OvAu72ORHNHUyRpPfBaY
         lGUJ5441GZRBape+BPLrCjTyKCccIAoGqKfc8jl3NQiCxPk/sMXq5KkV/aSvtVLF+8nI
         sCBRWe7mKtFAcS7uW7faPNazuW9lYnqig0m/MRU/P36SnSQ5cV6hPRRZ0aYGJHuKnrzO
         FJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FM13umhiUZ5Y1cUzG3acpmqo6yaDvf6xGiDzXDodIV4=;
        b=qGddrnrrsi5E9pMKi28HWYXfWYoBfsOrR3jUCLA1ESbvEvMu4okyoVLs67ji6KUd4Z
         Ovy/+R/oJzePdcX52RVDkRCdshSaQ+ImtJKfXCahuJr4Cpco098DVeKNrZFf98uabRL1
         XnPb8t128yNu0JXTk1KPfDkGeGLL33aq3l8VLV6sGNywyjYN11kjB9eX4GhDiFwPv07o
         JoZ9Xugr8VpqmlEkyJIdYREYt1q9usLkPqc0nSwh+/G6vI3dmvFWNO2/w8pCqVoI0Hw3
         J4KIAypSTEAV8HZsAXvZAgAXWVwxULlbeNF5wIqEZ3898lQ3bDfpyzc72fgZuUZ06nid
         /xOQ==
X-Gm-Message-State: AOAM531CwBLCYgLyBYdsCRcWiMrj7neS9gWdW8G/DYpkBuTydlFRN+Ck
        VRvLJT7zbxHeTiPyPxqMT0QElcMIHOFnqw==
X-Google-Smtp-Source: ABdhPJyWZDgzCINK92xB/oRyNQ1gtNbqN/d0OGjoJcpsnAW/olWibQZxe3s8v9+NLAWK4kHylgXOCA==
X-Received: by 2002:a62:a203:0:b0:3ea:eeb7:fdd with SMTP id m3-20020a62a203000000b003eaeeb70fddmr2558895pff.59.1630742963493;
        Sat, 04 Sep 2021 01:09:23 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c26:4b2d:32ce:9155:7c42:8667])
        by smtp.gmail.com with ESMTPSA id v8sm1445652pjh.24.2021.09.04.01.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 01:09:22 -0700 (PDT)
From:   Srivathsa Dara <srivathsa729.8@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Srivathsa Dara <srivathsa729.8@gmail.com>
Subject: [PATCH] staging: fbtft: fbtft-core: fix 'trailing statements should be on next line' coding style error
Date:   Sat,  4 Sep 2021 13:39:16 +0530
Message-Id: <20210904080916.15476-1-srivathsa729.8@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix coding style error 'trailing statements should be on next line'

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

