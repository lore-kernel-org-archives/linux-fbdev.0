Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227BAC4320A
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 11:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B05560F38
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 11:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhGZLS4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Jul 2021 07:18:56 -0400
Received: from forward103o.mail.yandex.net ([37.140.190.177]:48505 "EHLO
        forward103o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233815AbhGZLSy (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Jul 2021 07:18:54 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2021 07:18:53 EDT
Received: from iva5-76c5c16f2a53.qloud-c.yandex.net (iva5-76c5c16f2a53.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:7bae:0:640:76c5:c16f])
        by forward103o.mail.yandex.net (Yandex) with ESMTP id 1ACF35F82079;
        Mon, 26 Jul 2021 14:52:10 +0300 (MSK)
Received: from iva6-2d18925256a6.qloud-c.yandex.net (iva6-2d18925256a6.qloud-c.yandex.net [2a02:6b8:c0c:7594:0:640:2d18:9252])
        by iva5-76c5c16f2a53.qloud-c.yandex.net (mxback/Yandex) with ESMTP id Ay6r08gAVb-q9HqbptB;
        Mon, 26 Jul 2021 14:52:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1627300330;
        bh=FgcgbDjWxggREdHTT1qnRWwYLnx7YFzAuhtDLKCU1qw=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=VswILzKGincFX9DATVsVy8uCYWb884fyhoiikHNzIepF0dRvwRF5Jq6bhOE8vDV65
         tWZIV/fBa4iVbycESBTcu+vbwleuulVUMSNnOgCzSFjypCYndzk9li4Ju/t8GAYeWw
         DzrYly6VZTughIdQoUGlCf7NyB69LM+knZ+G0w9s=
Authentication-Results: iva5-76c5c16f2a53.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by iva6-2d18925256a6.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id PIKatQa27D-q92Sg7Ih;
        Mon, 26 Jul 2021 14:52:09 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
        linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/8] video: ep93xx: Prepare clock before using it
Date:   Mon, 26 Jul 2021 14:50:48 +0300
Message-Id: <20210726115058.23729-5-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210726115058.23729-1-nikita.shubin@maquefel.me>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
to Common Clock Framework.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 drivers/video/fbdev/ep93xx-fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/ep93xx-fb.c b/drivers/video/fbdev/ep93xx-fb.c
index ba33b4dce0df..2398b3d48fed 100644
--- a/drivers/video/fbdev/ep93xx-fb.c
+++ b/drivers/video/fbdev/ep93xx-fb.c
@@ -548,7 +548,7 @@ static int ep93xxfb_probe(struct platform_device *pdev)
 	}
 
 	ep93xxfb_set_par(info);
-	clk_enable(fbi->clk);
+	clk_prepare_enable(fbi->clk);
 
 	err = register_framebuffer(info);
 	if (err)
@@ -577,7 +577,7 @@ static int ep93xxfb_remove(struct platform_device *pdev)
 	struct ep93xx_fbi *fbi = info->par;
 
 	unregister_framebuffer(info);
-	clk_disable(fbi->clk);
+	clk_disable_unprepare(fbi->clk);
 	ep93xxfb_dealloc_videomem(info);
 	fb_dealloc_cmap(&info->cmap);
 
-- 
2.26.2

