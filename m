Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2470B1B0F2C
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Jun 2025 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748851162; cv=none; b=ntMxXhimUlct/1rDZbG4z26MdgsmtvwvxzSb5tVi9ZgCE5Qdop1zWa9POKdTGlUgmeU+N/Q0qJ8LBQ6M+uRoj8PpIn1d0VvuU51hMXfzGftjyyy4wlJrbz/0aMyl/07Wl4qqupIcDL/NQe6NbmsGbhnSkFy6E3DgG3NbgG80XX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748851162; c=relaxed/simple;
	bh=MHnBhv0EdTlDaAN7k7M/XwhptxZvJDrmaTvK/mOnCQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2tlEkTGbNEFJfIRc7HDoNRk/YBEdiKW0jHK8L9j8BgN6z5t0ywEWe8CQnTep2IQKc/bcZ2N15sn/bBUPOcA+6cJKE4FTeB1e5qLlIvVxyPc4bgPSNWstTGYg0m9i5oKAK8kwQILhdS13SoS24U4q/VaIsnJT8VgkcEh9SvqTJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CEC8721264;
	Mon,  2 Jun 2025 07:59:06 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B589136C7;
	Mon,  2 Jun 2025 07:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AKeYJMpZPWhuYQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Jun 2025 07:59:06 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: arnd@arndb.de,
	javierm@redhat.com,
	deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/2] video: Make global edid_info depend on CONFIG_FIRMWARE_EDID
Date: Mon,  2 Jun 2025 09:51:44 +0200
Message-ID: <20250602075537.137759-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602075537.137759-1-tzimmermann@suse.de>
References: <20250602075537.137759-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:9498, ipnet:::/1, country:IN]
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CEC8721264
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00

Protect global edid_info behind CONFIG_FIRMWARE_EDID and remove
the config tests for CONFIG_X86. Makes edid_info available iff
its option has been enabled.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/x86/kernel/setup.c         | 4 ++++
 drivers/gpu/drm/sysfb/efidrm.c  | 2 +-
 drivers/gpu/drm/sysfb/vesadrm.c | 2 +-
 include/video/edid.h            | 3 ++-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 9d2a13b37833..cfe501d323d5 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -217,8 +217,10 @@ arch_initcall(init_x86_sysctl);
  */
 struct screen_info screen_info;
 EXPORT_SYMBOL(screen_info);
+#if defined(CONFIG_FIRMWARE_EDID)
 struct edid_info edid_info;
 EXPORT_SYMBOL_GPL(edid_info);
+#endif
 
 extern int root_mountflags;
 
@@ -503,7 +505,9 @@ static void __init parse_boot_params(void)
 {
 	ROOT_DEV = old_decode_dev(boot_params.hdr.root_dev);
 	screen_info = boot_params.screen_info;
+#if defined(CONFIG_FIRMWARE_EDID)
 	edid_info = boot_params.edid_info;
+#endif
 #ifdef CONFIG_X86_32
 	apm_info.bios = boot_params.apm_bios_info;
 	ist_info = boot_params.ist_info;
diff --git a/drivers/gpu/drm/sysfb/efidrm.c b/drivers/gpu/drm/sysfb/efidrm.c
index 46912924636a..a8b1305b6e13 100644
--- a/drivers/gpu/drm/sysfb/efidrm.c
+++ b/drivers/gpu/drm/sysfb/efidrm.c
@@ -202,7 +202,7 @@ static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
 	drm_dbg(dev, "framebuffer format=%p4cc, size=%dx%d, stride=%d bytes\n",
 		&format->format, width, height, stride);
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_FIRMWARE_EDID)
 	if (drm_edid_header_is_valid(edid_info.dummy) == 8)
 		sysfb->edid = edid_info.dummy;
 #endif
diff --git a/drivers/gpu/drm/sysfb/vesadrm.c b/drivers/gpu/drm/sysfb/vesadrm.c
index 7945544ba73e..c5216dbe21ec 100644
--- a/drivers/gpu/drm/sysfb/vesadrm.c
+++ b/drivers/gpu/drm/sysfb/vesadrm.c
@@ -344,7 +344,7 @@ static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
 #endif
 	}
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_FIRMWARE_EDID)
 	if (drm_edid_header_is_valid(edid_info.dummy) == 8)
 		sysfb->edid = edid_info.dummy;
 #endif
diff --git a/include/video/edid.h b/include/video/edid.h
index f614371e9116..c2b186b1933a 100644
--- a/include/video/edid.h
+++ b/include/video/edid.h
@@ -4,7 +4,8 @@
 
 #include <uapi/video/edid.h>
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_FIRMWARE_EDID)
 extern struct edid_info edid_info;
 #endif
+
 #endif /* __linux_video_edid_h__ */
-- 
2.49.0

