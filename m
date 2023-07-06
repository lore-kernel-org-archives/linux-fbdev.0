Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C5CC001DD
	for <linux-fbdev@archiver.kernel.org>; Thu,  6 Jul 2023 15:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjGFPOh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 6 Jul 2023 11:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjGFPOh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 6 Jul 2023 11:14:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235B7FC
        for <linux-fbdev@vger.kernel.org>; Thu,  6 Jul 2023 08:14:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CC7E91FD65;
        Thu,  6 Jul 2023 15:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688656474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0LAe03vb9IhXaEKz5mFi8+dV6xovZ5LeTsmRknDA0M4=;
        b=ds+VtJ776NQqFdrtbOU4lPKg2Qra8vwur88Yg7N2uGzHgW3dIXK+sRfKHluJnRa2A1pz8A
        KUWHlSLRrtptF2Brajo6ob54qX+FVuUnD6KuHy2+VAiGsbwSLT2tFygerGwwsGuFf6wAfh
        M5qL4Xjy/55edevHHcWQ3Uv85u3zbyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688656474;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0LAe03vb9IhXaEKz5mFi8+dV6xovZ5LeTsmRknDA0M4=;
        b=jxn2l9cLay5aCsU230g+pUua3qH3ZQGr0N21TSHmrKmK1BX1ifGeTEyLWbolFcWbGwyV9V
        3CqgJz1ERQtaLSCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6D6B138FC;
        Thu,  6 Jul 2023 15:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ODvOJ1rapmRvDgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 06 Jul 2023 15:14:34 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 01/10] fbdev/broadsheetfb: Select FB_SYS_HELPERS_DEFERRED
Date:   Thu,  6 Jul 2023 17:08:44 +0200
Message-ID: <20230706151432.20674-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706151432.20674-1-tzimmermann@suse.de>
References: <20230706151432.20674-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The Kconfig token FB_SYS_HELPERS_DEFERRED selects everything that
is required for deferred I/O on system-memory framebuffers. Select
it from FB_BROADSHEET in favor of the existing identical selection.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/Kconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index f14229757311..fd862faafe66 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2179,11 +2179,7 @@ config FB_MX3
 config FB_BROADSHEET
 	tristate "E-Ink Broadsheet/Epson S1D13521 controller support"
 	depends on FB && (ARCH_PXA || COMPILE_TEST)
-	select FB_SYS_FILLRECT
-	select FB_SYS_COPYAREA
-	select FB_SYS_IMAGEBLIT
-	select FB_SYS_FOPS
-	select FB_DEFERRED_IO
+	select FB_SYS_HELPERS_DEFERRED
 	help
 	  This driver implements support for the E-Ink Broadsheet
 	  controller. The release name for this device was Epson S1D13521
-- 
2.41.0

