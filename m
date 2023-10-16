Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715D1CDB474
	for <linux-fbdev@archiver.kernel.org>; Mon, 16 Oct 2023 20:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjJPUE7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 16 Oct 2023 16:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjJPUE6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 16 Oct 2023 16:04:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036B883;
        Mon, 16 Oct 2023 13:04:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C629CC433C7;
        Mon, 16 Oct 2023 20:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697486696;
        bh=+CKoakIKRn8tAacvsCSRM0rsr0ykK+jJR6uwcT1H03s=;
        h=From:To:Cc:Subject:Date:From;
        b=D1h/PEOWkFFhGEqvx5NqiK82gHeTCGUuSJfwks5MkWbwbnVN/mKglBBjVG/UHIvoS
         bqRgcaOcPoHaX36lDPsDBYKWGUHx+BLHKth43SR+8/HZBK536qNAVWUNRnMFfmBeR0
         G4pQ6zdHgkwse4tO9ZiGSJAq3eubliFJE+nD3eEMfS2wj1Q4sdKlYsVkCpBqG7nze5
         Ga8OAYDOjmzwh/8k01bTNCEWpoSTqACdKKWMmrejxvQhebsnz5NGebFKwR5QEojhgl
         9xZHX5iPtj+dHURWf7GWlGDOUz/BjgQvHadd81mhkY313PyS/ym0fs+tAg3pbd6FUZ
         XHyCLk+toyTAQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: sa1100fb: mark sa1100fb_init() static
Date:   Mon, 16 Oct 2023 22:04:40 +0200
Message-Id: <20231016200450.826502-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This is a global function that is only referenced as an initcall. This causes
a warning:

drivers/video/fbdev/sa1100fb.c:1218:12: error: no previous prototype for 'sa1100fb_init' [-Werror=missing-prototypes]

Make it static instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/sa1100fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index 63e12a7c1100e..e14eb634cb944 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -1215,7 +1215,7 @@ static struct platform_driver sa1100fb_driver = {
 	},
 };
 
-int __init sa1100fb_init(void)
+static int __init sa1100fb_init(void)
 {
 	if (fb_get_options("sa1100fb", NULL))
 		return -ENODEV;
-- 
2.39.2

