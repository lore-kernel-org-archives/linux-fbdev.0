Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE691EA76
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jan 2024 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496134; cv=none; b=E5qb8hqo+TEPo6sFFKq9UVnO6vEODEM0bjNW7Lju1hZQ2OiaoYYPKQto4+VTZtzHIr61seRttnOYAtbxC0w44riilqyNTBm63m3bQlGg+Psdr6pv6xJR6AevcVVRnTwW8sEAmZ7PTqAWHjImhbq32j7yC+FPOPPKlgk7Mg1fFZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496134; c=relaxed/simple;
	bh=2ioc/nBUnTw+J9CSHz8leecvf/NCGCMYoPTp0hDByUA=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Level:X-Spam-Flag:
	 X-Spam-Score; b=Z4kjhDFhf44GPKu6CrKZv7dJgZVb6kzWuq1EJ7K6wK48PdU8Vpi2iRO1cPsAbmt5a18hduO+/pZ+YV6hNOBsl7KfpIqCYAoyCZXBHuFbYxWS0AcAXEez5y/hKVn8/0bwwqS+E8iu5KxUkRr1zfHhlpjEkNRe/LnqK8JMGN7oPkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VnYxQ0Jt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eg0+W26G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VnYxQ0Jt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eg0+W26G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VnYxQ0Jt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eg0+W26G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VnYxQ0Jt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eg0+W26G"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E30131FC26;
	Wed, 17 Jan 2024 12:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705496129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQcZUTO3WquCwuulOA8KUsIRasUGv4XllHdCGQ7mvHk=;
	b=VnYxQ0JtMQzS325Q50T8aZ3daTsarq39KL+2d9vilLLF2spcciEfRXUyhNtlzKBL8/EUbM
	HqARjbhiQYK1Fg+hVB+R71yQGULl5fnDMhRg3mLc3nvUXlV23HKtkZrDpojdcwGwUZJgGD
	gk1zw46lCI9htHTTPGQd7tMI3fo8jqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705496129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQcZUTO3WquCwuulOA8KUsIRasUGv4XllHdCGQ7mvHk=;
	b=eg0+W26G1DTab0lI5MWEGQ+Xpjq0n2MmweM7jWb+fs8TWXfa1jBoCT8dHsRy6BhRUAWqIh
	wN4qHkNr+HBvJmBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705496129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQcZUTO3WquCwuulOA8KUsIRasUGv4XllHdCGQ7mvHk=;
	b=VnYxQ0JtMQzS325Q50T8aZ3daTsarq39KL+2d9vilLLF2spcciEfRXUyhNtlzKBL8/EUbM
	HqARjbhiQYK1Fg+hVB+R71yQGULl5fnDMhRg3mLc3nvUXlV23HKtkZrDpojdcwGwUZJgGD
	gk1zw46lCI9htHTTPGQd7tMI3fo8jqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705496129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQcZUTO3WquCwuulOA8KUsIRasUGv4XllHdCGQ7mvHk=;
	b=eg0+W26G1DTab0lI5MWEGQ+Xpjq0n2MmweM7jWb+fs8TWXfa1jBoCT8dHsRy6BhRUAWqIh
	wN4qHkNr+HBvJmBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5E0313808;
	Wed, 17 Jan 2024 12:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qP5GK0HOp2X1YQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 17 Jan 2024 12:55:29 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	pjones@redhat.com,
	deller@gmx.de,
	ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/8] firmware/sysfb: Set firmware-framebuffer parent device
Date: Wed, 17 Jan 2024 13:39:07 +0100
Message-ID: <20240117125527.23324-4-tzimmermann@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[redhat.com,gmx.de,kernel.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

Set the firmware framebuffer's parent device, which usually is the
graphics hardware's physical device. Integrates the framebuffer in
the Linux device hierarchy and lets Linux handle dependencies among
devices. For example, the graphics hardware won't be suspended while
the firmware device is still active.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/sysfb.c          | 11 ++++++++++-
 drivers/firmware/sysfb_simplefb.c |  5 ++++-
 include/linux/sysfb.h             |  3 ++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 19706bd2642a..8a42da3f67a9 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/pci.h>
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
 #include <linux/screen_info.h>
@@ -72,6 +73,8 @@ EXPORT_SYMBOL_GPL(sysfb_disable);
 static __init int sysfb_init(void)
 {
 	const struct screen_info *si = &screen_info;
+	struct device *parent = NULL;
+	struct pci_dev *pparent;
 	struct simplefb_platform_data mode;
 	const char *name;
 	bool compatible;
@@ -83,10 +86,14 @@ static __init int sysfb_init(void)
 
 	sysfb_apply_efi_quirks();
 
+	pparent = screen_info_pci_dev(si);
+	if (pparent)
+		parent = &pparent->dev;
+
 	/* try to create a simple-framebuffer device */
 	compatible = sysfb_parse_mode(si, &mode);
 	if (compatible) {
-		pd = sysfb_create_simplefb(si, &mode);
+		pd = sysfb_create_simplefb(si, &mode, parent);
 		if (!IS_ERR(pd))
 			goto unlock_mutex;
 	}
@@ -109,6 +116,8 @@ static __init int sysfb_init(void)
 		goto unlock_mutex;
 	}
 
+	pd->dev.parent = parent;
+
 	sysfb_set_efifb_fwnode(pd);
 
 	ret = platform_device_add_data(pd, si, sizeof(*si));
diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index 74363ed7501f..75a186bf8f8e 100644
--- a/drivers/firmware/sysfb_simplefb.c
+++ b/drivers/firmware/sysfb_simplefb.c
@@ -91,7 +91,8 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
 }
 
 __init struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
-						     const struct simplefb_platform_data *mode)
+						     const struct simplefb_platform_data *mode,
+						     struct device *parent)
 {
 	struct platform_device *pd;
 	struct resource res;
@@ -143,6 +144,8 @@ __init struct platform_device *sysfb_create_simplefb(const struct screen_info *s
 	if (!pd)
 		return ERR_PTR(-ENOMEM);
 
+	pd->dev.parent = parent;
+
 	sysfb_set_efifb_fwnode(pd);
 
 	ret = platform_device_add_resources(pd, &res, 1);
diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
index 19cb803dd5ec..6ee3ade3f8b0 100644
--- a/include/linux/sysfb.h
+++ b/include/linux/sysfb.h
@@ -91,7 +91,8 @@ static inline void sysfb_set_efifb_fwnode(struct platform_device *pd)
 bool sysfb_parse_mode(const struct screen_info *si,
 		      struct simplefb_platform_data *mode);
 struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
-					      const struct simplefb_platform_data *mode);
+					      const struct simplefb_platform_data *mode,
+					      struct device *parent);
 
 #else /* CONFIG_SYSFB_SIMPLE */
 
-- 
2.43.0

