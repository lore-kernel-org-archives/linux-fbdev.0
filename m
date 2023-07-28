Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0DCC00528
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Jul 2023 09:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbjG1J0Z (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Jul 2023 05:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbjG1JZ7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Jul 2023 05:25:59 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46EE4ED1
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Jul 2023 02:21:14 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:12b0:7b7e:d1ff:7873])
        by michel.telenet-ops.be with bizsmtp
        id SZMC2A00Z0d1nm806ZMC3r; Fri, 28 Jul 2023 11:21:13 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qPJed-002ltx-Ki;
        Fri, 28 Jul 2023 11:21:12 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qPJeq-00AoGz-Ou;
        Fri, 28 Jul 2023 11:21:12 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] video: logo: LOGO should depend on FB_CORE i.s.o. FB
Date:   Fri, 28 Jul 2023 11:21:11 +0200
Message-Id: <e4142b7cc9aad9975de1bc6b1c7d86ccee487e4c.1690535997.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

If CONFIG_FB_CORE=y and CONFIG_FB=n, the frame buffer bootup logos can
no longer be enabled.  Fix this by making CONFIG_LOGO depend on
CONFIG_FB_CORE instead of CONFIG_FB, as there is no good reason for the
logo code to depend on the presence of real frame buffer device drivers.

Fixes: 55bffc8170bb5813 ("fbdev: Split frame buffer support in FB and FB_CORE symbols")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
v2:
  - Add Reviewed-by.
---
 drivers/video/Kconfig      | 2 +-
 drivers/video/logo/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index e5b1cc54cafa10d5..b694d7669d3200b1 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -63,7 +63,7 @@ if VT
 	source "drivers/video/console/Kconfig"
 endif
 
-if FB || SGI_NEWPORT_CONSOLE
+if FB_CORE || SGI_NEWPORT_CONSOLE
 	source "drivers/video/logo/Kconfig"
 
 endif
diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
index 6d6f8c08792dc897..b7d94d1dd1585a84 100644
--- a/drivers/video/logo/Kconfig
+++ b/drivers/video/logo/Kconfig
@@ -5,7 +5,7 @@
 
 menuconfig LOGO
 	bool "Bootup logo"
-	depends on FB || SGI_NEWPORT_CONSOLE
+	depends on FB_CORE || SGI_NEWPORT_CONSOLE
 	help
 	  Enable and select frame buffer bootup logos.
 
-- 
2.34.1

