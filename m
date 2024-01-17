Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95441EA8A
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jan 2024 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496133; cv=none; b=Ds+Rw38U5BkO6OvuN8zf3LQehZ86Fk2Jz2IeJLw/nZpn/dWLOi6vE5pmMpo7SNFIHS5CG4PGGWlt/mTx2Ymev4Bpe9pZJmzy7Qv2jQ+B3WW5+ZNNDNNIwvgutrU3TsNwR5cAVU5lEBlQdqOmA15z0iph6WmXcol+7IG54S/JNF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496133; c=relaxed/simple;
	bh=iWs3Ncu9ylSTdel4X2uBeU0/S/euKktQTEClzQBwuio=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Spam-Score:X-Spam-Flag; b=c3JkIrZVan6zni0MVkPNLwZWYggAgu6dgZCzulfhT1esVEhcAe7q27RziYw2850e0KOVPOGvVjgvzVE9VYhaH2qMF8SpGDC2MRTILZuv3oXpI0yR7LletSBpgm8LUio/yWp56p7xByephpJXMAMTGXmEn55f+sFrrWhirgWRoes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 23FDE22267;
	Wed, 17 Jan 2024 12:55:30 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9DAE13800;
	Wed, 17 Jan 2024 12:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +Cb+N0HOp2X1YQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 17 Jan 2024 12:55:29 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	pjones@redhat.com,
	deller@gmx.de,
	ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 4/8] fbdev/efifb: Remove PM for parent device
Date: Wed, 17 Jan 2024 13:39:08 +0100
Message-ID: <20240117125527.23324-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117125527.23324-1-tzimmermann@suse.de>
References: <20240117125527.23324-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 23FDE22267
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

The EFI device has the correct parent device set. This allows Linux
to handle the power management internally. Hence, remove the manual
PM management for the parent device from efifb.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/efifb.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 10fc14ad5d12..e66ef35fa6b6 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -17,7 +17,6 @@
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/screen_info.h>
-#include <linux/pm_runtime.h>
 #include <video/vga.h>
 #include <asm/efi.h>
 #include <drm/drm_utils.h> /* For drm_get_panel_orientation_quirk */
@@ -258,9 +257,6 @@ static void efifb_destroy(struct fb_info *info)
 {
 	struct efifb_par *par = info->par;
 
-	if (efifb_pci_dev)
-		pm_runtime_put(&efifb_pci_dev->dev);
-
 	if (info->screen_base) {
 		if (mem_flags & (EFI_MEMORY_UC | EFI_MEMORY_WC))
 			iounmap(info->screen_base);
@@ -598,26 +594,20 @@ static int efifb_probe(struct platform_device *dev)
 		goto err_groups;
 	}
 
-	if (efifb_pci_dev)
-		WARN_ON(pm_runtime_get_sync(&efifb_pci_dev->dev) < 0);
-
 	err = devm_aperture_acquire_for_platform_device(dev, par->base, par->size);
 	if (err) {
 		pr_err("efifb: cannot acquire aperture\n");
-		goto err_put_rpm_ref;
+		goto err_fb_dealloc_cmap;
 	}
 	err = register_framebuffer(info);
 	if (err < 0) {
 		pr_err("efifb: cannot register framebuffer\n");
-		goto err_put_rpm_ref;
+		goto err_fb_dealloc_cmap;
 	}
 	fb_info(info, "%s frame buffer device\n", info->fix.id);
 	return 0;
 
-err_put_rpm_ref:
-	if (efifb_pci_dev)
-		pm_runtime_put(&efifb_pci_dev->dev);
-
+err_fb_dealloc_cmap:
 	fb_dealloc_cmap(&info->cmap);
 err_groups:
 	sysfs_remove_groups(&dev->dev.kobj, efifb_groups);
-- 
2.43.0

