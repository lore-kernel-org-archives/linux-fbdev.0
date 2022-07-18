Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E966FC43334
	for <linux-fbdev@archiver.kernel.org>; Mon, 18 Jul 2022 07:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiGRHXb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 18 Jul 2022 03:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiGRHXa (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 18 Jul 2022 03:23:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE23D17E1D
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Jul 2022 00:23:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3E32020BCF;
        Mon, 18 Jul 2022 07:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658129006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=42h/UIObJ9Ayu66FbgApYndLPjIuMAorzolTv7m88Mk=;
        b=i5oiUoHrc1btfczNi4xxPJTF59a8kcGHmLanNxK1cfVwW9uxg5BIgth/415MgagZn7Jz3K
        AvSS62kQSR0OI62r1nPJjwHNEBTFiRVJjhLkIiTZvr4KN4cpjeymm0laooe75OfibPL9cj
        w+xgvNxX2mfDr2WwacBGdh1JYri7vSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658129006;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=42h/UIObJ9Ayu66FbgApYndLPjIuMAorzolTv7m88Mk=;
        b=gtRt8qUI0msuFgWaqMB6FDij2aNb+9oBv2+ts/VBoPO+PL2uKec5iOSjdK5BazUJkpWT1Q
        FWe1L3I+jOCWWZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1382513AB6;
        Mon, 18 Jul 2022 07:23:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sJvsA24K1WKjcAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 18 Jul 2022 07:23:26 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, deller@gmx.de, daniel@ffwll.ch,
        sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 09/11] video/aperture: Remove conflicting VGA devices, if any
Date:   Mon, 18 Jul 2022 09:23:20 +0200
Message-Id: <20220718072322.8927-10-tzimmermann@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220718072322.8927-1-tzimmermann@suse.de>
References: <20220718072322.8927-1-tzimmermann@suse.de>
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
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
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

