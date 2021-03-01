Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A74C433E0
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Mar 2021 18:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDCAA60C40
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Mar 2021 18:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbhCASlz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 1 Mar 2021 13:41:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233087AbhCASjv (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 1 Mar 2021 13:39:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD32564EDB;
        Mon,  1 Mar 2021 16:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614616721;
        bh=HWt8j+hbvhrQPej1Uq8e3ZIKSqaMxvW7ZbU4BXe/xqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPk0P7NmpMbH/JLHKQTffLe1ShcFC2yvPT+I6sW4eFe6ggN30WSya8yTimlwN+l74
         cvnYt08/7ZA5Mc2e67MZAhNkSNsmsZU3N0pBIJ7lVTu4cOCkwu6iss1WCVT3ARsMqs
         sZTAcWrL2xHe4VwDYDT4R1YDqzdmBrtqmYQaYOcE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 073/247] fbdev: aty: SPARC64 requires FB_ATY_CT
Date:   Mon,  1 Mar 2021 17:11:33 +0100
Message-Id: <20210301161035.261994907@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161031.684018251@linuxfoundation.org>
References: <20210301161031.684018251@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit c6c90c70db4d9a0989111d6b994d545659410f7a ]

It looks like SPARC64 requires FB_ATY_CT to build without errors,
so have FB_ATY select FB_ATY_CT if both SPARC64 and PCI are enabled
instead of using "default y if SPARC64 && PCI", which is not strong
enough to prevent build errors.

As it currently is, FB_ATY_CT can be disabled, resulting in build
errors:

ERROR: modpost: "aty_postdividers" [drivers/video/fbdev/aty/atyfb.ko] undefined!
ERROR: modpost: "aty_ld_pll_ct" [drivers/video/fbdev/aty/atyfb.ko] undefined!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: f7018c213502 ("video: move fbdev to drivers/video/fbdev")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20201127031752.10371-1-rdunlap@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index f99558d006bf4..97c4319797d5c 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1303,6 +1303,7 @@ config FB_ATY
 	select FB_CFB_IMAGEBLIT
 	select FB_BACKLIGHT if FB_ATY_BACKLIGHT
 	select FB_MACMODES if PPC
+	select FB_ATY_CT if SPARC64 && PCI
 	help
 	  This driver supports graphics boards with the ATI Mach64 chips.
 	  Say Y if you have such a graphics board.
@@ -1313,7 +1314,6 @@ config FB_ATY
 config FB_ATY_CT
 	bool "Mach64 CT/VT/GT/LT (incl. 3D RAGE) support"
 	depends on PCI && FB_ATY
-	default y if SPARC64 && PCI
 	help
 	  Say Y here to support use of ATI's 64-bit Rage boards (or other
 	  boards based on the Mach64 CT, VT, GT, and LT chipsets) as a
-- 
2.27.0



