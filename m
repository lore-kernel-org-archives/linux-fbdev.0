Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948C11EA7E
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jan 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496134; cv=none; b=srFBpDgaxDgdG6mJKqj1MNY0PyqFVwiysnPv/+2dthDrP0ISctsMyVp35+NOFzU9wnIEIix8X2EVK8j4pjzsuIcZTqfg2xwoUehYbuv3rM+ees9zyLEGdgLn6fahfZiFEa+nu1C8qME0piSNooC2kEVyVPZPSzvVFkUZuFubNeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496134; c=relaxed/simple;
	bh=qw/d8ngOHjADKSD6mKn/TX/WgUPI1RmwK0Q48+vCORc=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Level:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Flag; b=psIU7Twi5/sDrFPPkcM9qy8vGWdMCilHXZMFEycbV8nWup5t1cXMEw5B+Uwf0fhz5fDLYDMsIytxvrSvr18PTyrwle+yCrcL0Ha6j52NvbGD0VKfVAPYOasuNZV/fNoN0Hcov+tDQadjZne/cCd06MTYLNX5W5YpFedUhAAc8YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 111A21FC0C;
	Wed, 17 Jan 2024 12:55:31 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D47F613800;
	Wed, 17 Jan 2024 12:55:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6IzGMkLOp2X1YQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 17 Jan 2024 12:55:30 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	pjones@redhat.com,
	deller@gmx.de,
	ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 8/8] fbdev/efifb: Remove framebuffer relocation tracking
Date: Wed, 17 Jan 2024 13:39:12 +0100
Message-ID: <20240117125527.23324-9-tzimmermann@suse.de>
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
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 111A21FC0C
X-Spam-Flag: NO

If the firmware framebuffer has been reloacted, the sysfb code
fixes the screen_info state before it creates the framebuffer's
platform device. Efifb will automatically receive a screen_info
with updated values. Hence remove the tracking from efifb.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/efifb.c | 76 +------------------------------------
 1 file changed, 1 insertion(+), 75 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index f76b7ae00751..8dd82afb3452 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -13,7 +13,6 @@
 #include <linux/efi-bgrt.h>
 #include <linux/errno.h>
 #include <linux/fb.h>
-#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/screen_info.h>
@@ -47,8 +46,6 @@ static bool use_bgrt = true;
 static bool request_mem_succeeded = false;
 static u64 mem_flags = EFI_MEMORY_WC | EFI_MEMORY_UC;
 
-static struct pci_dev *efifb_pci_dev;	/* dev with BAR covering the efifb */
-
 struct efifb_par {
 	u32 pseudo_palette[16];
 	resource_size_t base;
@@ -348,9 +345,6 @@ static struct attribute *efifb_attrs[] = {
 };
 ATTRIBUTE_GROUPS(efifb);
 
-static struct resource *bar_resource;
-static u64 bar_offset;
-
 static int efifb_probe(struct platform_device *dev)
 {
 	struct screen_info *si;
@@ -411,21 +405,7 @@ static int efifb_probe(struct platform_device *dev)
 		si->rsvd_pos = 24;
 	}
 
-	efifb_fix.smem_start = si->lfb_base;
-
-	if (si->capabilities & VIDEO_CAPABILITY_64BIT_BASE) {
-		u64 ext_lfb_base;
-
-		ext_lfb_base = (u64)(unsigned long)si->ext_lfb_base << 32;
-		efifb_fix.smem_start |= ext_lfb_base;
-	}
-
-	if (bar_resource &&
-	    bar_resource->start + bar_offset != efifb_fix.smem_start) {
-		dev_info(&efifb_pci_dev->dev,
-			 "BAR has moved, updating efifb address\n");
-		efifb_fix.smem_start = bar_resource->start + bar_offset;
-	}
+	efifb_fix.smem_start = __screen_info_lfb_base(si);
 
 	efifb_defined.bits_per_pixel = si->lfb_depth;
 	efifb_defined.xres = si->lfb_width;
@@ -640,57 +620,3 @@ static struct platform_driver efifb_driver = {
 };
 
 builtin_platform_driver(efifb_driver);
-
-#if defined(CONFIG_PCI)
-
-static void record_efifb_bar_resource(struct pci_dev *dev, int idx, u64 offset)
-{
-	u16 word;
-
-	efifb_pci_dev = dev;
-
-	pci_read_config_word(dev, PCI_COMMAND, &word);
-	if (!(word & PCI_COMMAND_MEMORY)) {
-		dev_err(&dev->dev,
-			"BAR %d: assigned to efifb but device is disabled!\n",
-			idx);
-		return;
-	}
-
-	bar_resource = &dev->resource[idx];
-	bar_offset = offset;
-
-	dev_info(&dev->dev, "BAR %d: assigned to efifb\n", idx);
-}
-
-static void efifb_fixup_resources(struct pci_dev *dev)
-{
-	u64 base = screen_info.lfb_base;
-	u64 size = screen_info.lfb_size;
-	int i;
-
-	if (efifb_pci_dev || screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
-		return;
-
-	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		base |= (u64)screen_info.ext_lfb_base << 32;
-
-	if (!base)
-		return;
-
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		struct resource *res = &dev->resource[i];
-
-		if (!(res->flags & IORESOURCE_MEM))
-			continue;
-
-		if (res->start <= base && res->end >= base + size - 1) {
-			record_efifb_bar_resource(dev, i, base - res->start);
-			break;
-		}
-	}
-}
-DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY,
-			       16, efifb_fixup_resources);
-
-#endif
-- 
2.43.0

