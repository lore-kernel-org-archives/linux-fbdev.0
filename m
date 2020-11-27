Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86E5C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Nov 2020 19:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE2E024101
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Nov 2020 19:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GagEkA9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgK0TaW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 14:30:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44895 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730080AbgK0TFi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606503919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=P4J8EBWPnBVFoHBHwgQRXiVw93w2If7dqdzr9ZCw24E=;
        b=GagEkA9rSJUY+3Kk0NLoDk6fGvYMhc2QV78uZlpYFqu72+prMISH7hclQFyAyziHOwOANW
        sgCwtqvoqfbBPdT4ekzKjMIBZAd8kv96PkQGRXveuqRvEGwSoZBgTpmmk7DBOLVbt/LSJK
        00AoW7LeGp3gA1i/kvlcVFzXZNASaLM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-61uD7kApMs2hE6iAc43DVw-1; Fri, 27 Nov 2020 14:05:17 -0500
X-MC-Unique: 61uD7kApMs2hE6iAc43DVw-1
Received: by mail-qv1-f70.google.com with SMTP id ca17so3556336qvb.1
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P4J8EBWPnBVFoHBHwgQRXiVw93w2If7dqdzr9ZCw24E=;
        b=ns5A594Cs+eBVE6ti5XrTTrrKnIP/ZWYZ7+s74yxm/FO73+nDqVHRhYfHq6MOLfhm1
         /U0Pp1xC9pAe1J4MxkYyH3S5CX4/4MS0PbqUrHRPqeuWQXwZaKunBNUY/3rbfr0CyV3K
         piCaeiQjmNruL+fprhrbu38W6fq52zRom/7Gz+7aPjrf6uXEKE988rUVUup0XmRSIuTD
         Jz2+cDKra0bsxP5DQa+lediX+yZfT/Nq4LQ6F1hzoVfGEbagULop7lRvu4StnBzFN/w1
         IW0cErPvKfPmRNJLpnJ/O/SzhePg/DhvELY+5DxqsfMwK3NQZfPR8rZyWgkFUvsth0T4
         A8zQ==
X-Gm-Message-State: AOAM533pdPrkM+mAontoLtkpmutfHhXrLCORPn5Q7Kd1PIzkl8xEP6Dd
        fBrb34loN5RWB4Dvg2VMdcKjyg/hR+jQ5xP02MzxOlcNU7n3/wXTV4AwYqFjoBeSyPEGXEcSD8K
        eMy4qFZ1/nKpt2/xlPlGlrKQ=
X-Received: by 2002:a05:620a:22eb:: with SMTP id p11mr10254697qki.224.1606503916860;
        Fri, 27 Nov 2020 11:05:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlHMd5iGgdFcDE7TXlKessUY1X4ETN8EOl5uRxiIteKlzhnCF61nP8e6tAtR4EIGlPYbb+vw==
X-Received: by 2002:a05:620a:22eb:: with SMTP id p11mr10254684qki.224.1606503916681;
        Fri, 27 Nov 2020 11:05:16 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k128sm6806898qkd.48.2020.11.27.11.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:05:16 -0800 (PST)
From:   trix@redhat.com
To:     b.zolnierkie@samsung.com, pakki001@umn.edu
Cc:     linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] omapfb: fbcon: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 11:05:08 -0800
Message-Id: <20201127190508.2842786-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c | 2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c
index 3417618310ff..cc2ad787d493 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c
@@ -75,7 +75,7 @@ static void dispc_dump_irqs(struct seq_file *s)
 
 	seq_printf(s, "irqs %d\n", stats.irq_count);
 #define PIS(x) \
-	seq_printf(s, "%-20s %10d\n", #x, stats.irqs[ffs(DISPC_IRQ_##x)-1]);
+	seq_printf(s, "%-20s %10d\n", #x, stats.irqs[ffs(DISPC_IRQ_##x)-1])
 
 	PIS(FRAMEDONE);
 	PIS(VSYNC);
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
index 6f9c25fec994..101fa66f9b58 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
@@ -1554,7 +1554,7 @@ static void dsi_dump_dsidev_irqs(struct platform_device *dsidev,
 
 	seq_printf(s, "irqs %d\n", stats.irq_count);
 #define PIS(x) \
-	seq_printf(s, "%-20s %10d\n", #x, stats.dsi_irqs[ffs(DSI_IRQ_##x)-1]);
+	seq_printf(s, "%-20s %10d\n", #x, stats.dsi_irqs[ffs(DSI_IRQ_##x)-1])
 
 	seq_printf(s, "-- DSI%d interrupts --\n", dsi->module_id + 1);
 	PIS(VC0);
-- 
2.18.4

