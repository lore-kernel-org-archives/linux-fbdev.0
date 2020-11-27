Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0224AC63697
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Nov 2020 03:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B762222A
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Nov 2020 03:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U7nqK/EK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392294AbgK0DSI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 26 Nov 2020 22:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388759AbgK0DSI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 26 Nov 2020 22:18:08 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA0EC0613D1;
        Thu, 26 Nov 2020 19:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=k5Qw/Urbgsr4b6oxTUWbMQah+Hz+m37ybtc8zTvtg3E=; b=U7nqK/EKDdovDwzz55RcS0ppju
        I1Rf9vNOYrwUmXr4t5Y3j/ZD7P5gRokg7C/e31NQNhaYAODXPDsPVBwXKf0Wsb5HywMzv0c3eBYjH
        ydfys6t3XpMJaNN3kTzteOasEn8Ylw857262ixWIXz8kJkjCF33eaYR8Z2mDCnbdnle/ekPQ6xhxM
        8f8hntimMkj5vEbURPgsjywjdujWzqghuYDx4sgL3YNzIuVmaF8nEbnzMfiPBpVvUC7wPz87iyRK2
        gMGci9WnsIPYsoWQeM3Wr3ADWKij5lq68ujDD4W0f/8dH93sPWQBpudP+TOtf/dN0piJpeptb6KOi
        xCCuNI6A==;
Received: from [2601:1c0:6280:3f0::cc1f] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiUGm-0007TW-8s; Fri, 27 Nov 2020 03:18:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] fbdev: aty: SPARC64 requires FB_ATY_CT
Date:   Thu, 26 Nov 2020 19:17:52 -0800
Message-Id: <20201127031752.10371-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

It looks like SPARC64 requires FB_ATY_CT to build without errors,
so have FB_ATY select FB_ATY_CT if both SPARC64 and PCI are enabled
instead of using "default y if SPARC64 && PCI", which is not strong
enough to prevent build errors.

As it currently is, FB_ATY_CT can be disabled, resulting in build
errors:

ERROR: modpost: "aty_postdividers" [drivers/video/fbdev/aty/atyfb.ko] undefined!
ERROR: modpost: "aty_ld_pll_ct" [drivers/video/fbdev/aty/atyfb.ko] undefined!

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
---
v2: use select (suggested by Geert)

 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20201124.orig/drivers/video/fbdev/Kconfig
+++ linux-next-20201124/drivers/video/fbdev/Kconfig
@@ -1269,6 +1269,7 @@ config FB_ATY
 	select FB_CFB_IMAGEBLIT
 	select FB_BACKLIGHT if FB_ATY_BACKLIGHT
 	select FB_MACMODES if PPC
+	select FB_ATY_CT if SPARC64 && PCI
 	help
 	  This driver supports graphics boards with the ATI Mach64 chips.
 	  Say Y if you have such a graphics board.
@@ -1279,7 +1280,6 @@ config FB_ATY
 config FB_ATY_CT
 	bool "Mach64 CT/VT/GT/LT (incl. 3D RAGE) support"
 	depends on PCI && FB_ATY
-	default y if SPARC64 && PCI
 	help
 	  Say Y here to support use of ATI's 64-bit Rage boards (or other
 	  boards based on the Mach64 CT, VT, GT, and LT chipsets) as a
