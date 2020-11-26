Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179A8C56202
	for <linux-fbdev@archiver.kernel.org>; Thu, 26 Nov 2020 00:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797F520770
	for <linux-fbdev@archiver.kernel.org>; Thu, 26 Nov 2020 00:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eFJf3F82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgKZAkJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 25 Nov 2020 19:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgKZAkJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 25 Nov 2020 19:40:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3822C0613D4;
        Wed, 25 Nov 2020 16:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ai6vR/Gq0U/F21E/B8Ze23z6NDOsHvmNFcvHUMpigN4=; b=eFJf3F82xSUYckL4tj/YeCilvT
        brc9m+c8mskh+yDyezs1CqjbmGzdyRldFj2RCf0IvFHPR0eRc0UXUn2sJQ3MT2QVlHV6WMg7ZrKKK
        Yk668HMkX3INm9a6DvMV+EH8PQ7Djob198KYxKSTT3RPuUxXOr76HWeY3DEdK2uxhhAnJxp67SEru
        zo2rYDBUMp9Y1m/5ElXiTlbnCHFQXEI7yUgs61M3EHEKLdOyWUwHs7X/3b0ecFjqg+qq4wwhe7IXl
        Ni+hlhXbs7Gv15SpoSMfB5PG8mdqhnnhH3tgEXoNxRhf3snuu6Bo9VuI/5u2ALKLMT7G49VSkfWwl
        ZKqjAa/w==;
Received: from [2601:1c0:6280:3f0::cc1f] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ki5KM-0005PK-U6; Thu, 26 Nov 2020 00:40:03 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] fbdev: aty: SPARC64 requires FB_ATY_CT
Date:   Wed, 25 Nov 2020 16:39:57 -0800
Message-Id: <20201126003957.19604-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

It looks like SPARC64 requires FB_ATY_CT to build without errors,
so adjust the Kconfig entry of FB_ATY_CT so that it is always 'y'
for SPARC64 && PCI by disabling the prompt for SPARC64 && PCI.

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
---
 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20201124.orig/drivers/video/fbdev/Kconfig
+++ linux-next-20201124/drivers/video/fbdev/Kconfig
@@ -1277,7 +1277,7 @@ config FB_ATY
 	  module will be called atyfb.
 
 config FB_ATY_CT
-	bool "Mach64 CT/VT/GT/LT (incl. 3D RAGE) support"
+	bool "Mach64 CT/VT/GT/LT (incl. 3D RAGE) support" if !(SPARC64 && PCI)
 	depends on PCI && FB_ATY
 	default y if SPARC64 && PCI
 	help
