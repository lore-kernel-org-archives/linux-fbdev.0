Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B7BC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu,  7 Jul 2022 15:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiGGPkC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 7 Jul 2022 11:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbiGGPkB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 7 Jul 2022 11:40:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901082CDC8
        for <linux-fbdev@vger.kernel.org>; Thu,  7 Jul 2022 08:40:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3093B1FE63;
        Thu,  7 Jul 2022 15:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657208399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lF9a02oUlFzrrOo5gyMhGnhLeg9CuZy/YxicIfRKwl4=;
        b=joOnQDXCl+KbKC1sFIJcHKXxuEBjkDT3R/h6zSRm04R3k0k+ED662VUX8iZ4KrzEU8di6g
        6nD26GmkdiQiewCuVdvpKtL3gxKfNRC8cXJaUrX8s4AcdVJgkchWdFWKAzYUjrrjMSoM5h
        U+ST+B7U8AtgM1+jVQvj1YtD9A6njVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657208399;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lF9a02oUlFzrrOo5gyMhGnhLeg9CuZy/YxicIfRKwl4=;
        b=bzFgz22rL0pfT6r+zmlwzJcdN2QXc3guOQyztpoSC9205UNBsbLYM6s6GDHJ0N64Zl98dw
        uImxwMt8Tft/DEBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F09B113B4E;
        Thu,  7 Jul 2022 15:39:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YOfdOU7+xmI9UQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 07 Jul 2022 15:39:58 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, deller@gmx.de, daniel@ffwll.ch,
        sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 04/11] fbdev/core: Remove remove_conflicting_pci_framebuffers()
Date:   Thu,  7 Jul 2022 17:39:45 +0200
Message-Id: <20220707153952.32264-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707153952.32264-1-tzimmermann@suse.de>
References: <20220707153952.32264-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Remove remove_conflicting_pci_framebuffers() and implement similar
functionality in aperture_remove_conflicting_pci_device(), which was
the only caller. Removes an otherwise unused interface and streamlines
the aperture helper. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/aperture.c         | 30 ++++++++++++--------
 drivers/video/fbdev/core/fbmem.c | 48 --------------------------------
 include/linux/fb.h               |  2 --
 3 files changed, 18 insertions(+), 62 deletions(-)

diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
index 538f2d40acda..f42a0d8bc211 100644
--- a/drivers/video/aperture.c
+++ b/drivers/video/aperture.c
@@ -321,30 +321,36 @@ EXPORT_SYMBOL(aperture_remove_conflicting_devices);
  */
 int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *name)
 {
+	bool primary = false;
 	resource_size_t base, size;
 	int bar, ret;
 
-	/*
-	 * WARNING: Apparently we must kick fbdev drivers before vgacon,
-	 * otherwise the vga fbdev driver falls over.
-	 */
-#if IS_REACHABLE(CONFIG_FB)
-	ret = remove_conflicting_pci_framebuffers(pdev, name);
-	if (ret)
-		return ret;
+#ifdef CONFIG_X86
+	primary = pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
 #endif
-	ret = vga_remove_vgacon(pdev);
-	if (ret)
-		return ret;
 
 	for (bar = 0; bar < PCI_STD_NUM_BARS; ++bar) {
 		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
 			continue;
+
 		base = pci_resource_start(pdev, bar);
 		size = pci_resource_len(pdev, bar);
-		aperture_detach_devices(base, size);
+		ret = aperture_remove_conflicting_devices(base, size, primary, name);
+		if (ret)
+			break;
 	}
 
+	if (ret)
+		return ret;
+
+	/*
+	 * WARNING: Apparently we must kick fbdev drivers before vgacon,
+	 * otherwise the vga fbdev driver falls over.
+	 */
+	ret = vga_remove_vgacon(pdev);
+	if (ret)
+		return ret;
+
 	return 0;
 
 }
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index c4a18322dee9..877de85309f3 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1787,54 +1787,6 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
 }
 EXPORT_SYMBOL(remove_conflicting_framebuffers);
 
-/**
- * remove_conflicting_pci_framebuffers - remove firmware-configured framebuffers for PCI devices
- * @pdev: PCI device
- * @name: requesting driver name
- *
- * This function removes framebuffer devices (eg. initialized by firmware)
- * using memory range configured for any of @pdev's memory bars.
- *
- * The function assumes that PCI device with shadowed ROM drives a primary
- * display and so kicks out vga16fb.
- */
-int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, const char *name)
-{
-	struct apertures_struct *ap;
-	bool primary = false;
-	int err, idx, bar;
-
-	for (idx = 0, bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
-		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
-			continue;
-		idx++;
-	}
-
-	ap = alloc_apertures(idx);
-	if (!ap)
-		return -ENOMEM;
-
-	for (idx = 0, bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
-		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
-			continue;
-		ap->ranges[idx].base = pci_resource_start(pdev, bar);
-		ap->ranges[idx].size = pci_resource_len(pdev, bar);
-		pci_dbg(pdev, "%s: bar %d: 0x%lx -> 0x%lx\n", __func__, bar,
-			(unsigned long)pci_resource_start(pdev, bar),
-			(unsigned long)pci_resource_end(pdev, bar));
-		idx++;
-	}
-
-#ifdef CONFIG_X86
-	primary = pdev->resource[PCI_ROM_RESOURCE].flags &
-					IORESOURCE_ROM_SHADOW;
-#endif
-	err = remove_conflicting_framebuffers(ap, name, primary);
-	kfree(ap);
-	return err;
-}
-EXPORT_SYMBOL(remove_conflicting_pci_framebuffers);
-
 /**
  *	register_framebuffer - registers a frame buffer device
  *	@fb_info: frame buffer info structure
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 07fcd0e56682..b91c77016560 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -615,8 +615,6 @@ extern ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);
 extern void unregister_framebuffer(struct fb_info *fb_info);
-extern int remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
-					       const char *name);
 extern int remove_conflicting_framebuffers(struct apertures_struct *a,
 					   const char *name, bool primary);
 extern int fb_prepare_logo(struct fb_info *fb_info, int rotate);
-- 
2.36.1

