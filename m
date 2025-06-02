Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79D21B0F2C
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Jun 2025 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748851156; cv=none; b=TvQZ+n8AoIroMRQAgHjgH2GyXyfWrGgldq1M1LzlS7Hz3pz6/QXDbfIdhlftw2E+si2ujm/B58thw5fME8U1TqkRP/m1+m3HPnln5k4O6HOPtdGf0ha+v571ZMMjInku8/VOY5vpgqQv+1q/nr3rM78+eOg6azXM9PU/cAjmNds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748851156; c=relaxed/simple;
	bh=t7D00wBLQbVb0m4M3ArzR4zqZ+xRk2MZHNPpvlN/vTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rx96B5IMS1p1EGkld75fKn46I0PU66v/t9HjIzOefq5VUgeTa548BHuB2SN0KevO42hQWSrG18H9Dnp8qFl9/43EXvCYzI8bEI9yp83YvubUPLtZZLozovbqfjZOidoj4/JhVk8oGYPoeF9gz85xVlCTKTFCm1o1edh6Qg/sRnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A03EC21263;
	Mon,  2 Jun 2025 07:59:06 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62C6513AE0;
	Mon,  2 Jun 2025 07:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wKzRFspZPWhuYQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Jun 2025 07:59:06 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: arnd@arndb.de,
	javierm@redhat.com,
	deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/2] video: Make CONFIG_FIRMWARE_EDID generally available
Date: Mon,  2 Jun 2025 09:51:43 +0200
Message-ID: <20250602075537.137759-2-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:9498, ipnet:::/1, country:IN]
X-Rspamd-Queue-Id: A03EC21263
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.00

DRM drivers such as efidrm and vesadrm can export firmware EDID
data to userspace. Make the related option CONFIG_FIRMWARE_EDID
available without CONFIG_FB. Make it depend on X86, which is
currently the only architecture providing EDID information.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/Kconfig            | 18 +++++++++++++++++-
 drivers/video/fbdev/core/Kconfig | 15 ---------------
 drivers/video/fbdev/core/fbmon.c |  3 +--
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 5df981920a94..c3da6c0bfca6 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -61,6 +61,23 @@ config HDMI
 
 endif # HAS_IOMEM
 
+config FIRMWARE_EDID
+	bool "Enable firmware EDID"
+	depends on X86
+	help
+	  This enables access to the EDID transferred from the firmware.
+	  On x86, this is from the VESA BIOS. DRM display drivers will
+	  be able to export the information to userspace.
+
+	  Also enable this if DDC/I2C transfers do not work for your driver
+	  and if you are using nvidiafb, i810fb or savagefb.
+
+	  In general, choosing Y for this option is safe.  If you
+	  experience extremely long delays while booting before you get
+	  something on your display, try setting this to N.  Matrox cards in
+	  combination with certain motherboards and monitors are known to
+	  suffer from this problem.
+
 if VT
 	source "drivers/video/console/Kconfig"
 endif
@@ -70,5 +87,4 @@ if FB_CORE || SGI_NEWPORT_CONSOLE
 
 endif
 
-
 endmenu
diff --git a/drivers/video/fbdev/core/Kconfig b/drivers/video/fbdev/core/Kconfig
index 4abe12db7594..b38c3b776bce 100644
--- a/drivers/video/fbdev/core/Kconfig
+++ b/drivers/video/fbdev/core/Kconfig
@@ -10,21 +10,6 @@ config FB_CORE
 config FB_NOTIFY
 	bool
 
-config FIRMWARE_EDID
-	bool "Enable firmware EDID"
-	depends on FB
-	help
-	  This enables access to the EDID transferred from the firmware.
-	  On the i386, this is from the Video BIOS. Enable this if DDC/I2C
-	  transfers do not work for your driver and if you are using
-	  nvidiafb, i810fb or savagefb.
-
-	  In general, choosing Y for this option is safe.  If you
-	  experience extremely long delays while booting before you get
-	  something on your display, try setting this to N.  Matrox cards in
-	  combination with certain motherboards and monitors are known to
-	  suffer from this problem.
-
 config FB_DEVICE
 	bool "Provide legacy /dev/fb* device"
 	depends on FB_CORE
diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 0a26399dbc89..7762ad0284fa 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1482,13 +1482,12 @@ int fb_validate_mode(const struct fb_var_screeninfo *var, struct fb_info *info)
 		-EINVAL : 0;
 }
 
-#if defined(CONFIG_FIRMWARE_EDID) && defined(CONFIG_X86)
-
 /*
  * We need to ensure that the EDID block is only returned for
  * the primary graphics adapter.
  */
 
+#if defined(CONFIG_FIRMWARE_EDID)
 const unsigned char *fb_firmware_edid(struct device *device)
 {
 	struct pci_dev *dev = NULL;
-- 
2.49.0

