Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4453FC636CA
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Jul 2021 02:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBC4610CB
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Jul 2021 02:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhGSCg1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 18 Jul 2021 22:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbhGSCg1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 18 Jul 2021 22:36:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB74C061762;
        Sun, 18 Jul 2021 19:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ZtCcOaKTvtS9l/xs1TVQk4erPEkBsRk/M21z8hXpb7s=; b=S4EqwdsuFc7IC9+1JGs+SrY2zi
        EjbfjXj2cAEEYRiIGHYQTFmZMpSv+GbtNUqwhDYD7iybZav/yV8nxlGVFSB90+UvjVFCYOtoT6wqU
        DS/ezlTh1yvMAaK8v8ZCEofZeFxYztidg5aaIU2EnPIVPqKDm5GUmKJzNfUF8pYG89mqObvbs79FG
        ni0N0IPdS3oWU7pWwpTQpDF7Q4JPrxwy4e04a0+6N4rYHA3VQoWG3vw5tX6OxDpjQP1QE8U63J8xv
        DA7gcNTHrLAtWDIekebeEJ4sm3pVOAMrHkd5fG+31S4/snKZmWIMlJ0Mjq1CqlgDpYWGF8Qz7V5Tr
        BGdrMk0w==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5J5z-008HfG-RW; Mon, 19 Jul 2021 02:33:27 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] fbdev: simplefb: limit its use to DRM_SIMPLEDRM=n
Date:   Sun, 18 Jul 2021 19:33:27 -0700
Message-Id: <20210719023327.17039-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

When DRM_SIMPLEDRM=m, all of FB_CFB_{FILLRECT,COPYAREA,IMAGEBLIT} are =m,
causing undefined references in fbdev/simplefb.o.

By restricting FB_SIMPLEFB to be set only when DRM_SIMPLEDRM is not set,
the FB_CFB_* symbols are =y and the build completes without these
undefined references.

IOW, really "disable simplefb if simpledrm has been selected".

or1k-linux-ld: drivers/video/fbdev/simplefb.o:(.rodata+0x2c): undefined reference to `cfb_fillrect'
or1k-linux-ld: drivers/video/fbdev/simplefb.o:(.rodata+0x30): undefined reference to `cfb_copyarea'
or1k-linux-ld: drivers/video/fbdev/simplefb.o:(.rodata+0x34): undefined reference to `cfb_imageblit'

Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210716.orig/drivers/video/fbdev/Kconfig
+++ linux-next-20210716/drivers/video/fbdev/Kconfig
@@ -2192,7 +2192,7 @@ config FB_HYPERV
 
 config FB_SIMPLE
 	bool "Simple framebuffer support"
-	depends on (FB = y) && !DRM_SIMPLEDRM
+	depends on (FB = y) && DRM_SIMPLEDRM=n
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
