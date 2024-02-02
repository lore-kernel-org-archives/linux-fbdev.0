Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6901F13E223
	for <linux-fbdev@vger.kernel.org>; Fri,  2 Feb 2024 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875308; cv=none; b=Nsme8NfECj03rKcmbTZ1zbJA9QFJ2KkmrWLk0TCGOl0HqBJ47WAHCuFly1WNxM5Z2vEgCaQ4X6v6Y2kHmpf6lYqsOqQn6BaGggdrK9gyzGU4CCUf+qn9D+eSbUoizKRaoq6TIoyu1G43E8o6mV9YNpCkqhAEGJuMhXNIofYq2MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875308; c=relaxed/simple;
	bh=3T1ts+m8WN9tC/U8qggNLl8uP1ew3j+e8JSNXCeSngo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFKcEL62HKH1CKWk1pGgct/omssgjAXIAhM9ev5n+I/Q20EGl/dCHMoOsMboLNwy54qZWpj1/N/ft8puXFzmVaiuUFCheLfV3B2TLfEz7z79/wNiZdFwGwHcFQxgG2IJlQRA8V6d8L878Gb1bbWKVA74kl6ehEqO9KbTmtg6WYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Khe1v+Qk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4BveOGkt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NaTjlO9c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rE3pnyGf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Khe1v+Qk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4BveOGkt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NaTjlO9c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rE3pnyGf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C405C1FCE8;
	Fri,  2 Feb 2024 12:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706875304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i77N/brqhSnaJI2Sl8T2vXsgJt8TjzkWBg8yDBu1FcU=;
	b=Khe1v+QkCFQkDBE5ISa3wyB6PGKh5KUi4upUwRn7mrwoKvTh+MeyldHTxN4SU99+/XItq9
	MrP6NSBRnEe/OoGEZB9dSO8ryzaGm4bvYvWL7Fo0JozBZo56dUvFCTS+QrL+YrMIZVFZJQ
	hJ0ngkfkh9MeqIgE8ti9UGw/WF2Izis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706875304;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i77N/brqhSnaJI2Sl8T2vXsgJt8TjzkWBg8yDBu1FcU=;
	b=4BveOGktTJjRJzpogLupLYcYuVpSyAvZHoP186s80VFTbfzNfyRM05/9hXoZTFXAcpXeEw
	RSGvO5UwbJO7quCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706875303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i77N/brqhSnaJI2Sl8T2vXsgJt8TjzkWBg8yDBu1FcU=;
	b=NaTjlO9cxIhQuqHn1PUBmXM1R8xnmsWnJ0zqvnvLb1hH2+FT33tlDdZ65OuEyJMP3+QZLi
	r8ZsUGJrYxgNNGJQ6QZDCb17o3s2GbojYsoSEwBl9NJF/MAGPSNbbAzkR2DHHK303UeCZR
	UnpN181xzJ+jksGt9Cz8s8Oyvux9lhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706875303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i77N/brqhSnaJI2Sl8T2vXsgJt8TjzkWBg8yDBu1FcU=;
	b=rE3pnyGfh28JhhzANh8AHDXb8hRjZ4fbSqi5AwZbXcddpyLXY/1FESdAwS5jIoZydJIOT1
	cjQ6WrtExfBBb6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EAEC13A5F;
	Fri,  2 Feb 2024 12:01:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kGuwIafZvGWfeAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 02 Feb 2024 12:01:43 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	pjones@redhat.com,
	deller@gmx.de,
	ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 3/8] firmware/sysfb: Set firmware-framebuffer parent device
Date: Fri,  2 Feb 2024 12:58:44 +0100
Message-ID: <20240202120140.3517-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202120140.3517-1-tzimmermann@suse.de>
References: <20240202120140.3517-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NaTjlO9c;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rE3pnyGf
X-Spamd-Result: default: False [1.19 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FREEMAIL_TO(0.00)[redhat.com,gmx.de,kernel.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.19
X-Rspamd-Queue-Id: C405C1FCE8
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

Set the firmware framebuffer's parent device, which usually is the
graphics hardware's physical device. Integrates the framebuffer in
the Linux device hierarchy and lets Linux handle dependencies among
devices. For example, the graphics hardware won't be suspended while
the firmware device is still active.

v2:
	* detect parent device in sysfb_parent_dev()

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/firmware/sysfb.c          | 19 ++++++++++++++++++-
 drivers/firmware/sysfb_simplefb.c |  5 ++++-
 include/linux/sysfb.h             |  3 ++-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 3c197db42c9d9..d02945b0d8ea1 100644
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
@@ -69,9 +70,21 @@ void sysfb_disable(void)
 }
 EXPORT_SYMBOL_GPL(sysfb_disable);
 
+static __init struct device *sysfb_parent_dev(const struct screen_info *si)
+{
+	struct pci_dev *pdev;
+
+	pdev = screen_info_pci_dev(si);
+	if (pdev)
+		return &pdev->dev;
+
+	return NULL;
+}
+
 static __init int sysfb_init(void)
 {
 	struct screen_info *si = &screen_info;
+	struct device *parent;
 	struct simplefb_platform_data mode;
 	const char *name;
 	bool compatible;
@@ -83,10 +96,12 @@ static __init int sysfb_init(void)
 
 	sysfb_apply_efi_quirks();
 
+	parent = sysfb_parent_dev(si);
+
 	/* try to create a simple-framebuffer device */
 	compatible = sysfb_parse_mode(si, &mode);
 	if (compatible) {
-		pd = sysfb_create_simplefb(si, &mode);
+		pd = sysfb_create_simplefb(si, &mode, parent);
 		if (!IS_ERR(pd))
 			goto unlock_mutex;
 	}
@@ -109,6 +124,8 @@ static __init int sysfb_init(void)
 		goto unlock_mutex;
 	}
 
+	pd->dev.parent = parent;
+
 	sysfb_set_efifb_fwnode(pd);
 
 	ret = platform_device_add_data(pd, si, sizeof(*si));
diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index 74363ed7501f6..75a186bf8f8ec 100644
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
index 19cb803dd5ecd..6ee3ade3f8b06 100644
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

