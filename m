Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD59CCA486
	for <linux-fbdev@archiver.kernel.org>; Thu,  7 Jul 2022 15:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiGGPkE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 7 Jul 2022 11:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbiGGPkD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 7 Jul 2022 11:40:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0D22CCBF
        for <linux-fbdev@vger.kernel.org>; Thu,  7 Jul 2022 08:40:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5FF9A1FF5D;
        Thu,  7 Jul 2022 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657208400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TqAP4rJMs1E32DmINLCxdsX/lKz0Fb4DoldPS6u51bM=;
        b=x1invp6cc5qcJg27MWdxxKsj0xu+II4VnTo8oLHZCLkpQg6qUyQsPvypiGYuBd6c/L+Rr/
        JcRpfXXtrEV6K7Jzv6AvOiVN0JEyflnqUiZ2zW3JWGpDjk9KZhebiGLqx2m3aqybjNe8l4
        A6q4rYpfT+dACc6mHK/E073wPyIzcOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657208400;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TqAP4rJMs1E32DmINLCxdsX/lKz0Fb4DoldPS6u51bM=;
        b=UVxFWqbVxD3dfdTYH7mVJPgIgHHt0bynsw+6PsbrtBNryfMMypzPoPKtML/7X4Uqwg4IZ5
        Qwx21swcbkQ6ygCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3111E13A33;
        Thu,  7 Jul 2022 15:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uCsMC1D+xmI9UQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 07 Jul 2022 15:40:00 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, deller@gmx.de, daniel@ffwll.ch,
        sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 09/11] video/aperture: Remove conflicting VGA devices, if any
Date:   Thu,  7 Jul 2022 17:39:50 +0200
Message-Id: <20220707153952.32264-10-tzimmermann@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707153952.32264-1-tzimmermann@suse.de>
References: <20220707153952.32264-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On the primary graphics adapter, a driver might conflict with a VGA
driver that controls the VGA framebuffer I/O range. Remove the VGA
driver from the aperture helpers. Until now, this case has been
hendled by fbdev, but it should work even with fbdev disabled.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/aperture.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
index 101e13c2cf41..abc691284a77 100644
--- a/drivers/video/aperture.c
+++ b/drivers/video/aperture.c
@@ -12,6 +12,8 @@
 #include <linux/types.h>
 #include <linux/vgaarb.h>
 
+#include <video/vga.h>
+
 /**
  * DOC: overview
  *
@@ -300,6 +302,16 @@ int aperture_remove_conflicting_devices(resource_size_t base, resource_size_t si
 	 */
 	sysfb_disable();
 
+	aperture_detach_devices(base, size);
+
+	/*
+	 * If this is the primary adapter, there could be a VGA device
+	 * that consumes the VGA framebuffer I/O range. Remove this device
+	 * as well.
+	 */
+	if (primary)
+		aperture_detach_devices(VGA_FB_PHYS_BASE, VGA_FB_PHYS_SIZE);
+
 #if IS_REACHABLE(CONFIG_FB)
 	a = alloc_apertures(1);
 	if (!a)
@@ -315,8 +327,6 @@ int aperture_remove_conflicting_devices(resource_size_t base, resource_size_t si
 		return ret;
 #endif
 
-	aperture_detach_devices(base, size);
-
 	return 0;
 }
 EXPORT_SYMBOL(aperture_remove_conflicting_devices);
-- 
2.36.1

