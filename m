Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295B1C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Jun 2022 15:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243523AbiFHPlV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Jun 2022 11:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243579AbiFHPlV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Jun 2022 11:41:21 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0E91D819E
        for <linux-fbdev@vger.kernel.org>; Wed,  8 Jun 2022 08:41:20 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:243a:e14b:d107:1f56])
        by albert.telenet-ops.be with bizsmtp
        id gfhJ2700X1qF9lr06fhJ5X; Wed, 08 Jun 2022 17:41:18 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nyxo6-003E1A-CT; Wed, 08 Jun 2022 17:41:18 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nyxo5-008kMo-Tr; Wed, 08 Jun 2022 17:41:17 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] fbcon: Remove obsolete reference to initmem_freed
Date:   Wed,  8 Jun 2022 17:41:16 +0200
Message-Id: <b8b9147a48e233fe32e072f2085c7b413cd92a00.1654702835.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

initmem_freed was removed in v2.1.124, and the underlying issue was
fixed for good in commit 92b004d1aa9f367c ("video/logo: prevent use of
logos after they have been freed").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/video/fbdev/core/fbcon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 594650452afd14d8..1be8aa9f80747987 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2180,7 +2180,6 @@ static int fbcon_switch(struct vc_data *vc)
 	if (logo_shown == FBCON_LOGO_DRAW) {
 
 		logo_shown = fg_console;
-		/* This is protected above by initmem_freed */
 		fb_show_logo(info, ops->rotate);
 		update_region(vc,
 			      vc->vc_origin + vc->vc_size_row * vc->vc_top,
-- 
2.25.1

