Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65055EB64DA
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Jun 2023 12:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345045AbjFPMFn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 16 Jun 2023 08:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344705AbjFPMFn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 16 Jun 2023 08:05:43 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9339D30E0
        for <linux-fbdev@vger.kernel.org>; Fri, 16 Jun 2023 05:05:40 -0700 (PDT)
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1FB283F120
        for <linux-fbdev@vger.kernel.org>; Fri, 16 Jun 2023 12:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686917139;
        bh=m7ySH3JrcTV8+yw7ueBFG47cxZsJ9e+MajPgheIKd1w=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=sgvBiES5LemzjKmE5arXKRcu7Tc5bUYOste+4GM84XMboqjj399vY+XAcF+GxVqLr
         J+YhN/FibZAZUhdkseItgGZNB74pE+o9t5A1zcfycYX693rh1/o3FEUO3vtohA+2gj
         nR/MiSi480xNUKe0zUl6e7TJ5aOFeKJAIpDpn1y4khNo17oF0GhXVeSP4rcQ8J5Dfx
         fO4p2VvrUTT0GA966CJ5h8efNMnbqq6hlWRABd+W42PBKcrmRU3P+0oQttw8UhZHkU
         CQLIuLC0SCH4EqQ/BMgCwPjJOxJYswOuti07KghoNB3bUZxCUaBCJxhZAGRLxryCdD
         F/h6C/LSKDUQw==
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b1b1693338so4759051fa.3
        for <linux-fbdev@vger.kernel.org>; Fri, 16 Jun 2023 05:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686917138; x=1689509138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7ySH3JrcTV8+yw7ueBFG47cxZsJ9e+MajPgheIKd1w=;
        b=ikoxv3b6PO+xYHrtdUro8meGULMaIr6NqsHzRNz3d8GoTsD2vblZ/+jh965bS3Xqe1
         fOC05YD3zC1P0nVQU4PKccBnP75zvvDfWMMzsIV8HB4xzLlU2FH8B9fKhdP+ETQuTsAb
         7FKOn3D3dvT5izTQgbzo7b/d6q1BlDiqRe/Va0gKX8FBz6mxhTk9rcbE7VCyPVyLeGWp
         ZTTFmRkUuiJRF2jwTGzx+jurEUa5JZKC11eybs9Dni97tuCjWs+Ugs8PLygXl772Ee6B
         Y6ML+O9bXR32HsnKsRsExiS70hq036f04Y+iOtpNIVjcYl7qP6/Clog6DQVu7ltZsgL5
         REkw==
X-Gm-Message-State: AC+VfDyU3BonA8axcuv9MUnjRauXtSsExFTWeToo2h9mX2Ge4k30fl/3
        6Xv6tPz+JM6LPxTgf/YpAjDqfeP3OAi9OCjLs4IIu5qBKJiGhD+cFSFRfz04SvL6851KftJZ5y5
        cTvgWXrjsKGOOM4sAOZBdoyooQ7cjS5/7aA7jLvMtBltgCeSJdNc=
X-Received: by 2002:ac2:5f9b:0:b0:4f3:78c2:2a6d with SMTP id r27-20020ac25f9b000000b004f378c22a6dmr1288648lfe.3.1686917138630;
        Fri, 16 Jun 2023 05:05:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ75fXyeKCuznl3pidwrqckduT+X32ZYDJY7P5oHI98szTnf3jjwPSD9DqOJGAXHWnqzY1XyWA==
X-Received: by 2002:ac2:5f9b:0:b0:4f3:78c2:2a6d with SMTP id r27-20020ac25f9b000000b004f378c22a6dmr1288629lfe.3.1686917138336;
        Fri, 16 Jun 2023 05:05:38 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id c25-20020a05600c0ad900b003f18b942338sm2068082wmr.3.2023.06.16.05.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 05:05:37 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     deller@gmx.de, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, juerg.haefliger@canonical.com,
        u.kleine-koenig@pengutronix.de
Subject: [PATCH] fbdev: metronomefb: Add MODULE_FIRMWARE macro
Date:   Fri, 16 Jun 2023 14:05:29 +0200
Message-Id: <20230616120529.1028798-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The module loads firmware so add a MODULE_FIRMWARE macro to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 drivers/video/fbdev/metronomefb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/metronomefb.c b/drivers/video/fbdev/metronomefb.c
index bbdbf463f0c8..4e50882d080c 100644
--- a/drivers/video/fbdev/metronomefb.c
+++ b/drivers/video/fbdev/metronomefb.c
@@ -778,3 +778,5 @@ MODULE_PARM_DESC(user_wfm_size, "Set custom waveform size");
 MODULE_DESCRIPTION("fbdev driver for Metronome controller");
 MODULE_AUTHOR("Jaya Kumar");
 MODULE_LICENSE("GPL");
+
+MODULE_FIRMWARE("metronome.wbf");
-- 
2.37.2

