Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D851EA84
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jan 2024 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496133; cv=none; b=SaY7W6QrsJNugJmVvldnERuUob6mFrak11ChO+qMdgh7s32onpNRVhrUHpC65W9XCztjfSbFbDQm5DKqgisczWO5GaXO26NMHUHVzT8r4OHLbne3ST/SjGqGoSU8xBrbPyd4cxVyYctgl3VeGbtjdAH9bVTkZXk1zoomTPbHfc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496133; c=relaxed/simple;
	bh=GZSdExPagUhM96aK3VKm6jA32Z08Nb5xzN3QVQBSr98=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Level:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Flag; b=UwQgLULsp3071KPpOOazCficELMeNOzsrE3DxKBRIlgM+kH6fho+7X3NysFmg5dUxedjx3cchp8xS0sp90s3YpBTA+Jtsn10k/8+R8jqgvv4lBnKv6Mm9hUg/Yyv31H7qcaxdHIIUIrfqYllsJyLDwGflEkcMrgnY4d1f3Wr5dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7BD842226E;
	Wed, 17 Jan 2024 12:55:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BB7713808;
	Wed, 17 Jan 2024 12:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MINoEUHOp2X1YQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 17 Jan 2024 12:55:29 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	pjones@redhat.com,
	deller@gmx.de,
	ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/8] video: Add helpers for decoding screen_info
Date: Wed, 17 Jan 2024 13:39:05 +0100
Message-ID: <20240117125527.23324-2-tzimmermann@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 7BD842226E
X-Spam-Flag: NO

The plain values as stored in struct screen_info need to be decoded
before being used. Add helpers that decode the type of video output
and the framebuffer I/O aperture.

Old or non-x86 systems may not set the type of video directly, but
only indicate the presence by storing 0x01 in orig_video_isVGA. The
decoding logic in screen_info_video_type() takes this into account.
It then follows similar code in vgacon's vgacon_startup() to detect
the video type from the given values.

A call to screen_info_resources() returns all known resources of the
given screen_info. The resources' values have been taken from existing
code in vgacon and vga16fb. These drivers can later be converted to
use the new interfaces.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/Kconfig            |   1 +
 drivers/video/Kconfig               |   4 +
 drivers/video/Makefile              |   3 +
 drivers/video/screen_info_generic.c | 148 ++++++++++++++++++++++++++++
 include/linux/screen_info.h         | 100 +++++++++++++++++++
 5 files changed, 256 insertions(+)
 create mode 100644 drivers/video/screen_info_generic.c

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 4a98a859d44d..deba323178cc 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -191,6 +191,7 @@ config MTK_ADSP_IPC
 config SYSFB
 	bool
 	select BOOT_VESA_SUPPORT
+	select SCREEN_INFO
 
 config SYSFB_SIMPLEFB
 	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index b694d7669d32..1eb755a94940 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -11,6 +11,10 @@ config APERTURE_HELPERS
 	  Support tracking and hand-over of aperture ownership. Required
 	  by graphics drivers for firmware-provided framebuffers.
 
+config SCREEN_INFO
+	bool
+	default n
+
 config STI_CORE
 	bool
 	depends on PARISC
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 6bbc03950899..b929b664d52c 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -1,12 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_APERTURE_HELPERS)    += aperture.o
+obj-$(CONFIG_SCREEN_INFO)         += screen_info.o
 obj-$(CONFIG_STI_CORE)            += sticore.o
 obj-$(CONFIG_VGASTATE)            += vgastate.o
 obj-$(CONFIG_VIDEO_CMDLINE)       += cmdline.o
 obj-$(CONFIG_VIDEO_NOMODESET)     += nomodeset.o
 obj-$(CONFIG_HDMI)                += hdmi.o
 
+screen_info-y			  := screen_info_generic.o
+
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_FB_STI)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
diff --git a/drivers/video/screen_info_generic.c b/drivers/video/screen_info_generic.c
new file mode 100644
index 000000000000..4be26941b2d9
--- /dev/null
+++ b/drivers/video/screen_info_generic.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <linux/ioport.h>
+#include <linux/screen_info.h>
+#include <linux/string.h>
+
+static void resource_init_named(struct resource *r,
+				resource_size_t start, resource_size_t size,
+				const char *name, unsigned int flags)
+{
+	memset(r, 0, sizeof(*r));
+
+	r->start = start;
+	r->end = start + size - 1;
+	r->name = name;
+	r->flags = flags;
+}
+
+static void resource_init_io_named(struct resource *r,
+				   resource_size_t start, resource_size_t size,
+				   const char *name)
+{
+	resource_init_named(r, start, size, name, IORESOURCE_IO);
+}
+
+static void resource_init_mem_named(struct resource *r,
+				   resource_size_t start, resource_size_t size,
+				   const char *name)
+{
+	resource_init_named(r, start, size, name, IORESOURCE_MEM);
+}
+
+static inline bool __screen_info_has_ega_gfx(unsigned int mode)
+{
+	switch (mode) {
+	case 0x0d:	/* 320x200-4 */
+	case 0x0e:	/* 640x200-4 */
+	case 0x0f:	/* 640x350-1 */
+	case 0x10:	/* 640x350-4 */
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline bool __screen_info_has_vga_gfx(unsigned int mode)
+{
+	switch (mode) {
+	case 0x10:	/* 640x480-1 */
+	case 0x12:	/* 640x480-4 */
+	case 0x13:	/* 320-200-8 */
+	case 0x6a:	/* 800x600-4 (VESA) */
+		return true;
+	default:
+		return __screen_info_has_ega_gfx(mode);
+	}
+}
+
+/**
+ * screen_info_resources() - Get resources from screen_info structure
+ * @si: the screen_info
+ * @r: pointer to an array of resource structures
+ * @num: number of elements in @r:
+ *
+ * Returns:
+ * The number of resources stored in @r on success, or a negative errno code otherwise.
+ *
+ * A call to screen_info_resources() returns the resources consumed by the
+ * screen_info's device or framebuffer. The result is stored in the caller-supplied
+ * array @r with up to @num elements. The function returns the number of
+ * initialized elements.
+ */
+int screen_info_resources(const struct screen_info *si, struct resource *r, size_t num)
+{
+	struct resource *pos = r;
+	unsigned int type = screen_info_video_type(si);
+	u64 base, size;
+
+	switch (type) {
+	case VIDEO_TYPE_MDA:
+		if (num > 0)
+			resource_init_io_named(pos++, 0x3b0, 12, "mda");
+		if (num > 1)
+			resource_init_io_named(pos++, 0x3bf, 0x01, "mda");
+		if (num > 2)
+			resource_init_mem_named(pos++, 0xb0000, 0x2000, "mda");
+		break;
+	case VIDEO_TYPE_CGA:
+		if (num > 0)
+			resource_init_io_named(pos++, 0x3d4, 0x02, "cga");
+		if (num > 1)
+			resource_init_mem_named(pos++, 0xb8000, 0x2000, "cga");
+		break;
+	case VIDEO_TYPE_EGAM:
+		if (num > 0)
+			resource_init_io_named(pos++, 0x3bf, 0x10, "ega");
+		if (num > 1)
+			resource_init_mem_named(pos++, 0xb0000, 0x8000, "ega");
+		break;
+	case VIDEO_TYPE_EGAC:
+		if (num > 0)
+			resource_init_io_named(pos++, 0x3c0, 0x20, "ega");
+		if (num > 1) {
+			if (__screen_info_has_ega_gfx(si->orig_video_mode))
+				resource_init_mem_named(pos++, 0xa0000, 0x10000, "ega");
+			else
+				resource_init_mem_named(pos++, 0xb8000, 0x8000, "ega");
+		}
+		break;
+	case VIDEO_TYPE_VGAC:
+		if (num > 0)
+			resource_init_io_named(pos++, 0x3c0, 0x20, "vga+");
+		if (num > 1) {
+			if (__screen_info_has_vga_gfx(si->orig_video_mode))
+				resource_init_mem_named(pos++, 0xa0000, 0x10000, "vga+");
+			else
+				resource_init_mem_named(pos++, 0xb8000, 0x8000, "vga+");
+		}
+		break;
+	case VIDEO_TYPE_VLFB:
+	case VIDEO_TYPE_EFI:
+		if (!__screen_info_has_lfb(type))
+			break;
+		base = __screen_info_lfb_base(si);
+		if (!base)
+			break;
+		size = __screen_info_lfb_size(si, type);
+		if (!size)
+			break;
+		if (num > 0)
+			resource_init_mem_named(pos++, base, size, "lfb");
+		break;
+	case VIDEO_TYPE_PICA_S3:
+	case VIDEO_TYPE_MIPS_G364:
+	case VIDEO_TYPE_SGI:
+	case VIDEO_TYPE_TGAC:
+	case VIDEO_TYPE_SUN:
+	case VIDEO_TYPE_SUNPCI:
+	case VIDEO_TYPE_PMAC:
+	default:
+		/* not supported */
+		return -EINVAL;
+	}
+
+	return pos - r;
+}
+EXPORT_SYMBOL(screen_info_resources);
diff --git a/include/linux/screen_info.h b/include/linux/screen_info.h
index eab7081392d5..d4d45395df19 100644
--- a/include/linux/screen_info.h
+++ b/include/linux/screen_info.h
@@ -4,6 +4,106 @@
 
 #include <uapi/linux/screen_info.h>
 
+/**
+ * SCREEN_INFO_MAX_RESOURCES - maximum number of resources per screen_info
+ */
+#define SCREEN_INFO_MAX_RESOURCES	3
+
+struct resource;
+
+static inline bool __screen_info_has_lfb(unsigned int type)
+{
+	return (type == VIDEO_TYPE_VLFB) || (type == VIDEO_TYPE_EFI);
+}
+
+static inline u64 __screen_info_lfb_base(const struct screen_info *si)
+{
+	u64 lfb_base = si->lfb_base;
+
+	if (si->capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		lfb_base |= (u64)si->ext_lfb_base << 32;
+
+	return lfb_base;
+}
+
+static inline u64 __screen_info_lfb_size(const struct screen_info *si, unsigned int type)
+{
+	u64 lfb_size = si->lfb_size;
+
+	if (type == VIDEO_TYPE_VLFB)
+		lfb_size <<= 16;
+	return lfb_size;
+}
+
+static inline unsigned int __screen_info_video_type(unsigned int type)
+{
+	switch (type) {
+	case VIDEO_TYPE_MDA:
+	case VIDEO_TYPE_CGA:
+	case VIDEO_TYPE_EGAM:
+	case VIDEO_TYPE_EGAC:
+	case VIDEO_TYPE_VGAC:
+	case VIDEO_TYPE_VLFB:
+	case VIDEO_TYPE_PICA_S3:
+	case VIDEO_TYPE_MIPS_G364:
+	case VIDEO_TYPE_SGI:
+	case VIDEO_TYPE_TGAC:
+	case VIDEO_TYPE_SUN:
+	case VIDEO_TYPE_SUNPCI:
+	case VIDEO_TYPE_PMAC:
+	case VIDEO_TYPE_EFI:
+		return type;
+	default:
+		return 0;
+	}
+}
+
+/**
+ * screen_info_video_type() - Decodes the video type from struct screen_info
+ * @si: an instance of struct screen_info
+ *
+ * Returns:
+ * A VIDEO_TYPE_ constant representing si's type of video display, or 0 otherwise.
+ */
+static inline unsigned int screen_info_video_type(const struct screen_info *si)
+{
+	unsigned int type;
+
+	// check if display output is on
+	if (!si->orig_video_isVGA)
+		return 0;
+
+	// check for a known VIDEO_TYPE_ constant
+	type = __screen_info_video_type(si->orig_video_isVGA);
+	if (type)
+		return si->orig_video_isVGA;
+
+	// check if text mode has been initialized
+	if (!si->orig_video_lines || !si->orig_video_cols)
+		return 0;
+
+	// 80x25 text, mono
+	if (si->orig_video_mode == 0x07) {
+		if ((si->orig_video_ega_bx & 0xff) != 0x10)
+			return VIDEO_TYPE_EGAM;
+		else
+			return VIDEO_TYPE_MDA;
+	}
+
+	// EGA/VGA, 16 colors
+	if ((si->orig_video_ega_bx & 0xff) != 0x10) {
+		if (si->orig_video_isVGA)
+			return VIDEO_TYPE_VGAC;
+		else
+			return VIDEO_TYPE_EGAC;
+	}
+
+	// the rest...
+	return VIDEO_TYPE_CGA;
+}
+
+int screen_info_resources(const struct screen_info *si, struct resource *r, size_t num);
+
 extern struct screen_info screen_info;
 
 #endif /* _SCREEN_INFO_H */
-- 
2.43.0

