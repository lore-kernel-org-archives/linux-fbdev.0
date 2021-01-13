Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C917C433E9
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0313E235FF
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbhAMOwD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbhAMOwC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:02 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914BDC061345
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:44 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id 91so2407125wrj.7
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8AKZe0pvPLHu3x895juPn/Z4GbXtcqzxxje+6pz86KU=;
        b=MweOdz1mBiZ3YANYAenthalC1RAZ2L7YBzcfY2mxwBScLf0FZ7dfPLhGVCYJ3wStLt
         C3s1vvBrFa415Wr1aCWWYyc6yuvzFexaNiSTEv/rsPJ+qSMCxbo/gkIkbK6PkL7+YYiN
         j4X4qJFw6IVfKE3+eKxdcIPKq3uf/B3BN8WWKumhwaTV44EooXi7ZrrsGRMN/hPU9R9g
         aM2d+N3S2d8PdXVSrkZFhnz4GytrdOwPuh2vbjAk7nR/Um1bObWFqsibjGktJZnkTX2+
         LSnF9sH+yRTO8ixzJlE682O8bs4obJ1NQRctXzq69GkYjy20O7QmRaSjmdm9hW95TO4e
         51pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8AKZe0pvPLHu3x895juPn/Z4GbXtcqzxxje+6pz86KU=;
        b=QvEcU2Y9gxFE4oGBqjbqY2owOba2PQxJ6qIeMGNpW1E5305rcKqIhW8WNxtJvuUA4b
         SWLXBn9Ggk8P+TL+X8XmE+KItnYr2MJEv7BZqzThS8YeoC/1ai3546q+PkF6gpzF6cYC
         YEuin9OML4X+J6HYXGxfMEaQ8zOWqnQcteZbRgUKF2JrQFrI0rnaB26m2o6ZIh+2HAj+
         nTySH9Dijkxnn/5zaywAXCyotnKzPH8N5eTtaVqcev/ObJEkmXXpNXJOcal+VgrcHe87
         /3LTlVSDm5yh5XgYEovOZVoMHQQ8qJernEaLykz2YGvamhO77Hw2sgfTcOlZ802pnfhe
         nzlQ==
X-Gm-Message-State: AOAM533hEMpfPES/S9PBCRbl3dnnN1SBmcmcALo6AWkdQbwMWuqQr1fL
        QNUX/THoCWxmpmUc40+u79YPbA==
X-Google-Smtp-Source: ABdhPJw5rVCSN67wNU6TdCizFMPeOQwAc4JEScwBmwUscxQjY1orEkpeVLOPrWKc5N9q4Vjxl5enIA==
X-Received: by 2002:a05:6000:124e:: with SMTP id j14mr3073602wrx.310.1610549443321;
        Wed, 13 Jan 2021 06:50:43 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, carter@compsci.bristol.ac.uk,
        William Rucklidge <wjr@cs.cornell.edu>,
        Jes Sorensen <jds@kom.auc.dk>,
        Emmanuel Marty <core@ggi-project.org>,
        Jakub Jelinek <jj@ultra.linux.cz>, Martin Mares <mj@ucw.cz>,
        Brad Douglas <brad@neruo.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 20/31] video: fbdev: core: fbcon: Mark 'pending' as __maybe_unused
Date:   Wed, 13 Jan 2021 14:49:58 +0000
Message-Id: <20210113145009.1272040-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

'pending' is only used if FBCONDEBUG is defined.

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/core/fbcon.c: In function ‘fbcon_exit’:
 drivers/video/fbdev/core/fbcon.c:3295:7: warning: variable ‘pending’ set but not used [-Wunused-but-set-variable]

Cc: carter@compsci.bristol.ac.uk
Cc: William Rucklidge <wjr@cs.cornell.edu>
Cc: Jes Sorensen <jds@kom.auc.dk>
Cc: Emmanuel Marty <core@ggi-project.org>
Cc: Jakub Jelinek <jj@ultra.linux.cz>
Cc: Martin Mares <mj@ucw.cz>
Cc: Brad Douglas <brad@neruo.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/core/fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index bf61598bf1c39..f3d628fd07dc1 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3292,7 +3292,7 @@ static void fbcon_exit(void)
 #endif
 
 	for_each_registered_fb(i) {
-		int pending = 0;
+		int __maybe_unused pending = 0;
 
 		mapped = 0;
 		info = registered_fb[i];
-- 
2.25.1

