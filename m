Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D7DC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 11 Jul 2022 15:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiGKPjg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 11 Jul 2022 11:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiGKPjf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 11 Jul 2022 11:39:35 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9048032B84
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 08:39:33 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id trfX2700U4C55Sk06rfXrQ; Mon, 11 Jul 2022 17:39:32 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvVT-0036sa-FG; Mon, 11 Jul 2022 17:39:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvVT-006sNz-38; Mon, 11 Jul 2022 17:39:31 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] video: fbdev: cirrusfb: Make cirrusfb_zorro_unregister() static
Date:   Mon, 11 Jul 2022 17:39:30 +0200
Message-Id: <f4b0278d16982adaffdae1f30a369a24052c048d.1657553887.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

cirrusfb_zorro_unregister() is only used locally, hence make it static.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/cirrusfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index 51e072c03e1c670b..a41a75841e10ef06 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -2301,7 +2301,7 @@ static int cirrusfb_zorro_register(struct zorro_dev *z,
 	return error;
 }
 
-void cirrusfb_zorro_unregister(struct zorro_dev *z)
+static void cirrusfb_zorro_unregister(struct zorro_dev *z)
 {
 	struct fb_info *info = zorro_get_drvdata(z);
 
-- 
2.25.1

