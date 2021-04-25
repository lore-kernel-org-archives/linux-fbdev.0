Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AEBC433ED
	for <linux-fbdev@archiver.kernel.org>; Sun, 25 Apr 2021 02:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1E6613AA
	for <linux-fbdev@archiver.kernel.org>; Sun, 25 Apr 2021 02:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhDYCep (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 24 Apr 2021 22:34:45 -0400
Received: from toothrot.meleeweb.net ([62.210.131.231]:46846 "EHLO
        toothrot.meleeweb.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhDYCep (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 24 Apr 2021 22:34:45 -0400
X-Greylist: delayed 676 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Apr 2021 22:34:45 EDT
Received: from [80.111.226.61] (port=9744 helo=lady-voodoo.local)
        by toothrot.meleeweb.net with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
        id 1laUNy-00GNGm-Lx; Sun, 25 Apr 2021 04:20:38 +0200
From:   Bertrand Jacquin <bertrand@jacquin.bzh>
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] video/logo: CONFIG_LOGO conflicts with FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
Date:   Sun, 25 Apr 2021 03:20:06 +0100
Message-Id: <20210425022006.356746-1-bertrand@jacquin.bzh>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

When FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is enabled, logo are not
being displayed
---
 drivers/video/logo/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
index 6d6f8c08792d..fe07dfb59d3d 100644
--- a/drivers/video/logo/Kconfig
+++ b/drivers/video/logo/Kconfig
@@ -5,9 +5,10 @@
 
 menuconfig LOGO
 	bool "Bootup logo"
-	depends on FB || SGI_NEWPORT_CONSOLE
+	depends on (FB && !FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER) || SGI_NEWPORT_CONSOLE
 	help
-	  Enable and select frame buffer bootup logos.
+	  Enable and select frame buffer bootup logos. Note no logo will be
+	  displayed if FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is enabled
 
 if LOGO
 
