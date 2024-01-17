Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595B51EA7C
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jan 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496133; cv=none; b=gC3HnabTwNFWGgqlBwhxfpAAP8FEZbUJ40Hb3A+lM5dj/X2UGDxNKci2bSwcHxS8jOPYFm8lwGjsY+svkaM9RMzz+Szk0acl4IW+4o+hFyqQrfJsLxesRFw5XnBcFadYg5V2J1b9W5zLJiYPOaOg8DOUiPhrnE7EZcBYa2xg69I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496133; c=relaxed/simple;
	bh=iPpL4hKYyXuIyZRjNaFFbMGP+0QK5/WfRYOiqV4io2E=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Spam-Score:X-Spam-Flag; b=OAt7oShVwUX5jX/VJCM+mEyg00Zwd9wSS/QU/8MDloZXtU7uof1PNsT5ExsCwnpMlBf6N3cl6kwV99PIM9kStmTYVZis+ew7v0j8lkvgRL05SmBjhdCBwpuY3Kmw1rIDsLzmAI2V+nO5x5IKUGsQYGw7FdxjBjxUrKlZvd4Un44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CDC5221F12;
	Wed, 17 Jan 2024 12:55:30 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F97613800;
	Wed, 17 Jan 2024 12:55:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ELnUJULOp2X1YQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 17 Jan 2024 12:55:30 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	pjones@redhat.com,
	deller@gmx.de,
	ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 7/8] firmware/sysfb: Update screen_info for relocated EFI framebuffers
Date: Wed, 17 Jan 2024 13:39:11 +0100
Message-ID: <20240117125527.23324-8-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: CDC5221F12
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

On ARM PCI systems, the PCI hierarchy might be reconfigured during
boot and the firmware framebuffer might move as a result of that.
The values in screen_info will then be invalid.

Work around this problem by tracking the framebuffer's initial
location before it get relocated; then fix the screen_info state
between reloaction and creating the firmware framebuffer's device.

This functionality has been lifted from efifb. See the commit message
of commit 55d728a40d36 ("efi/fb: Avoid reconfiguration of BAR that
covers the framebuffer") for more information.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/sysfb.c        |  2 +
 drivers/video/screen_info_pci.c | 88 +++++++++++++++++++++++++++++++++
 include/linux/screen_info.h     | 16 ++++++
 3 files changed, 106 insertions(+)

diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 48a550bd1a93..5791f9dc47df 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -101,6 +101,8 @@ static __init int sysfb_init(void)
 	bool compatible;
 	int ret = 0;
 
+	screen_info_apply_fixups();
+
 	mutex_lock(&disable_lock);
 	if (disabled)
 		goto unlock_mutex;
diff --git a/drivers/video/screen_info_pci.c b/drivers/video/screen_info_pci.c
index 16fe4afa3377..a546681b2d15 100644
--- a/drivers/video/screen_info_pci.c
+++ b/drivers/video/screen_info_pci.c
@@ -1,7 +1,95 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/pci.h>
+#include <linux/printk.h>
 #include <linux/screen_info.h>
+#include <linux/string.h>
+
+static struct pci_dev *screen_info_lfb_pdev;
+static size_t screen_info_lfb_bar;
+static resource_size_t screen_info_lfb_offset;
+static struct resource screen_info_lfb_res = DEFINE_RES_MEM(0, 0);
+
+static bool __screen_info_relocation_is_valid(const struct screen_info *si, struct resource *pr)
+{
+	u64 size = __screen_info_lfb_size(si, screen_info_video_type(si));
+
+	if (screen_info_lfb_offset > resource_size(pr))
+		return false;
+	if (size > resource_size(pr))
+		return false;
+	if (resource_size(pr) - size < screen_info_lfb_offset)
+		return false;
+
+	return true;
+}
+
+void screen_info_apply_fixups(void)
+{
+	struct screen_info *si = &screen_info;
+
+	if (screen_info_lfb_pdev) {
+		struct resource *pr = &screen_info_lfb_pdev->resource[screen_info_lfb_bar];
+
+		if (pr->start != screen_info_lfb_res.start) {
+			if (__screen_info_relocation_is_valid(si, pr)) {
+				/*
+				 * Only update base if we have an actual
+				 * relocation to a valid I/O range.
+				 */
+				__screen_info_set_lfb_base(si, pr->start + screen_info_lfb_offset);
+				pr_info("Relocating firmware framebuffer to offset %pa[d] within %pr\n",
+					&screen_info_lfb_offset, pr);
+			} else {
+				pr_warn("Invalid relocating, disabling firmware framebuffer\n");
+			}
+		}
+	}
+}
+
+static void screen_info_fixup_lfb(struct pci_dev *pdev)
+{
+	unsigned int type;
+	struct resource res[SCREEN_INFO_MAX_RESOURCES];
+	size_t i, numres;
+	int ret;
+	const struct screen_info *si = &screen_info;
+
+	if (screen_info_lfb_pdev)
+		return; // already found
+
+	type = screen_info_video_type(si);
+	if (type != VIDEO_TYPE_EFI)
+		return; // only applies to EFI
+
+	ret = screen_info_resources(si, res, ARRAY_SIZE(res));
+	if (ret < 0)
+		return;
+	numres = ret;
+
+	for (i = 0; i < numres; ++i) {
+		struct resource *r = &res[i];
+		const struct resource *pr;
+
+		if (!(r->flags & IORESOURCE_MEM))
+			continue;
+		pr = pci_find_resource(pdev, r);
+		if (!pr)
+			continue;
+
+		/*
+		 * We've found a PCI device with the framebuffer
+		 * resource. Store away the parameters to track
+		 * relocation of the framebuffer aperture.
+		 */
+		screen_info_lfb_pdev = pdev;
+		screen_info_lfb_bar = pr - pdev->resource;
+		screen_info_lfb_offset = r->start - pr->start;
+		memcpy(&screen_info_lfb_res, r, sizeof(screen_info_lfb_res));
+	}
+}
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY, 16,
+			       screen_info_fixup_lfb);
 
 static struct pci_dev *__screen_info_pci_dev(struct resource *res)
 {
diff --git a/include/linux/screen_info.h b/include/linux/screen_info.h
index 746645b8ee83..80b348137492 100644
--- a/include/linux/screen_info.h
+++ b/include/linux/screen_info.h
@@ -4,6 +4,8 @@
 
 #include <uapi/linux/screen_info.h>
 
+#include <linux/bits.h>
+
 /**
  * SCREEN_INFO_MAX_RESOURCES - maximum number of resources per screen_info
  */
@@ -27,6 +29,17 @@ static inline u64 __screen_info_lfb_base(const struct screen_info *si)
 	return lfb_base;
 }
 
+static inline void __screen_info_set_lfb_base(struct screen_info *si, u64 lfb_base)
+{
+	si->lfb_base = lfb_base & GENMASK_ULL(31, 0);
+	si->ext_lfb_base = (lfb_base & GENMASK_ULL(63, 32)) >> 32;
+
+	if (si->ext_lfb_base)
+		si->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
+	else
+		si->capabilities &= ~VIDEO_CAPABILITY_64BIT_BASE;
+}
+
 static inline u64 __screen_info_lfb_size(const struct screen_info *si, unsigned int type)
 {
 	u64 lfb_size = si->lfb_size;
@@ -106,8 +119,11 @@ static inline unsigned int screen_info_video_type(const struct screen_info *si)
 int screen_info_resources(const struct screen_info *si, struct resource *r, size_t num);
 
 #if defined(CONFIG_PCI)
+void screen_info_apply_fixups(void);
 struct pci_dev *screen_info_pci_dev(const struct screen_info *si);
 #else
+static inline void screen_info_apply_fixups(void)
+{ }
 static inline struct pci_dev *screen_info_pci_dev(const struct screen_info *si)
 {
 	return NULL;
-- 
2.43.0

