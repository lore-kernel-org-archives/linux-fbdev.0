Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB921EA87
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jan 2024 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496133; cv=none; b=Wh3zmZDZj/sVksf5I+S/pMZCqY+MerBp+ZPRRdEsQPWKrcv1lR5WUtESW2wHl20230PG8LRwATFllO3TwjYlwzauVYk6b3u0GM/SNZuEPCbS0Na1+o4MmN6MlAWxFXzo5Mo8k7OvOkv4vTEIm0KWMuL641+FWFEFDZuFZPEHtvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496133; c=relaxed/simple;
	bh=WmenprsAlUlMN5xj9cYSExZwrjiX69u0tcPLjavzdd4=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Level:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Flag; b=FvDzQGHnzqxK+6iT67iDql398HHeMVR1qL9jJCZtZzLPZM8Vv3etFc5fEJM5PXlDEJkPFMJk3Aqbxj62m6WnV3ea274+749U3wA4GVO6YhZakfCTzX6jZExCu3lf0i49xZsMNnYnBZ1t25B3cqbPRjzDcnk75ciArJH36YhkBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9EF11FC25;
	Wed, 17 Jan 2024 12:55:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8243D13800;
	Wed, 17 Jan 2024 12:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eKakHkHOp2X1YQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 17 Jan 2024 12:55:29 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	pjones@redhat.com,
	deller@gmx.de,
	ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/8] video: Provide screen_info_get_pci_dev() to find screen_info's PCI device
Date: Wed, 17 Jan 2024 13:39:06 +0100
Message-ID: <20240117125527.23324-3-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: B9EF11FC25
X-Spam-Flag: NO

Add screen_info_get_pci_dev() to find the PCI device of an instance
of screen_info. Does nothing on systems without PCI bus.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/Makefile          |  1 +
 drivers/video/screen_info_pci.c | 54 +++++++++++++++++++++++++++++++++
 include/linux/screen_info.h     | 10 ++++++
 3 files changed, 65 insertions(+)
 create mode 100644 drivers/video/screen_info_pci.c

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index b929b664d52c..6bbf87c1b579 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_VIDEO_NOMODESET)     += nomodeset.o
 obj-$(CONFIG_HDMI)                += hdmi.o
 
 screen_info-y			  := screen_info_generic.o
+screen_info-$(CONFIG_PCI)         += screen_info_pci.o
 
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_FB_STI)		  += console/
diff --git a/drivers/video/screen_info_pci.c b/drivers/video/screen_info_pci.c
new file mode 100644
index 000000000000..16fe4afa3377
--- /dev/null
+++ b/drivers/video/screen_info_pci.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/pci.h>
+#include <linux/screen_info.h>
+
+static struct pci_dev *__screen_info_pci_dev(struct resource *res)
+{
+	struct pci_dev *pdev;
+
+	if (!(res->flags & IORESOURCE_MEM))
+		return NULL;
+
+	for_each_pci_dev(pdev) {
+		const struct resource *r;
+
+		if ((pdev->class >> 16) != PCI_BASE_CLASS_DISPLAY)
+			continue;
+
+		r = pci_find_resource(pdev, res);
+		if (r)
+			return pdev;
+	}
+
+	return NULL;
+}
+
+/**
+ * screen_info_pci_dev() - Return PCI parent device that contains screen_info's framebuffer
+ * @si: the screen_info
+ *
+ * Returns:
+ * The screen_info's parent device on success, or NULL otherwise.
+ */
+struct pci_dev *screen_info_pci_dev(const struct screen_info *si)
+{
+	struct resource res[SCREEN_INFO_MAX_RESOURCES];
+	size_t i, numres;
+	int ret;
+
+	ret = screen_info_resources(si, res, ARRAY_SIZE(res));
+	if (ret < 0)
+		return ERR_PTR(ret);
+	numres = ret;
+
+	for (i = 0; i < numres; ++i) {
+		struct pci_dev *pdev = __screen_info_pci_dev(&res[i]);
+
+		if (pdev)
+			return pdev;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(screen_info_pci_dev);
diff --git a/include/linux/screen_info.h b/include/linux/screen_info.h
index d4d45395df19..746645b8ee83 100644
--- a/include/linux/screen_info.h
+++ b/include/linux/screen_info.h
@@ -9,6 +9,7 @@
  */
 #define SCREEN_INFO_MAX_RESOURCES	3
 
+struct pci_dev;
 struct resource;
 
 static inline bool __screen_info_has_lfb(unsigned int type)
@@ -104,6 +105,15 @@ static inline unsigned int screen_info_video_type(const struct screen_info *si)
 
 int screen_info_resources(const struct screen_info *si, struct resource *r, size_t num);
 
+#if defined(CONFIG_PCI)
+struct pci_dev *screen_info_pci_dev(const struct screen_info *si);
+#else
+static inline struct pci_dev *screen_info_pci_dev(const struct screen_info *si)
+{
+	return NULL;
+}
+#endif
+
 extern struct screen_info screen_info;
 
 #endif /* _SCREEN_INFO_H */
-- 
2.43.0

