Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E09CE7A94
	for <linux-fbdev@archiver.kernel.org>; Mon, 25 Sep 2023 11:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjIYLKm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjIYLKg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 25 Sep 2023 07:10:36 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB536C0
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Sep 2023 04:10:28 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ee18:727e:6235:2ac2])
        by andre.telenet-ops.be with bizsmtp
        id qBAP2A00E4XpEKH01BAP7T; Mon, 25 Sep 2023 13:10:26 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qkjTT-004Xi7-4c;
        Mon, 25 Sep 2023 13:10:23 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qkjTr-00FDNv-27;
        Mon, 25 Sep 2023 13:10:23 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] sh: ecovec24: Rename missed backlight field from fbdev to dev
Date:   Mon, 25 Sep 2023 13:10:22 +0200
Message-Id: <20230925111022.3626362-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

One instance of gpio_backlight_platform_data.fbdev was renamed, but the
second instance was forgotten, causing a build failure:

    arch/sh/boards/mach-ecovec24/setup.c: In function ‘arch_setup’:
    arch/sh/boards/mach-ecovec24/setup.c:1223:37: error: ‘struct gpio_backlight_platform_data’ has no member named ‘fbdev’; did you mean ‘dev’?
     1223 |                 gpio_backlight_data.fbdev = NULL;
	  |                                     ^~~~~
	  |                                     dev

Fix this by updating the second instance.

Fixes: ed369def91c1579a ("backlight/gpio_backlight: Rename field 'fbdev' to 'dev'")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309231601.Uu6qcRnU-lkp@intel.com/
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/boards/mach-ecovec24/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 3be293335de54512..7a788d44cc73496c 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -1220,7 +1220,7 @@ static int __init arch_setup(void)
 		lcdc_info.ch[0].num_modes		= ARRAY_SIZE(ecovec_dvi_modes);
 
 		/* No backlight */
-		gpio_backlight_data.fbdev = NULL;
+		gpio_backlight_data.dev = NULL;
 
 		gpio_set_value(GPIO_PTA2, 1);
 		gpio_set_value(GPIO_PTU1, 1);
-- 
2.34.1

