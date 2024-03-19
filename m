Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9197D06B
	for <linux-fbdev@vger.kernel.org>; Tue, 19 Mar 2024 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841162; cv=none; b=evlpqOWEPlW25mo3S1ZWLNcxXNorZd+SGIysU1lJDF4izzIhEH1uH8aENoSnEc3z1EYh7Ell1s5zRRpuyUmfJiBERRrZJweW3Po2EVuweFbd9q95dJYFl+Y7EymyaE8YNTMdM4xyFxijeG7nzCq5HKmNfSrzFJk4KO/Cl4ytRrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841162; c=relaxed/simple;
	bh=MDfilVIl7daH5Kcq2D+3yq3JcOFEQvcxqUd2x4jchmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0fJoOvDHgD2iQCwMZkPfYLKlXe0VlHc5eMeVK1RahFvlAwOz9DKwMfHbBRAZnGB/dT8TN89/S2ulvb7tT5W7d9d2m8yCp7wltY3Mj49CHqWsZNDFnb0nuMEC5mVq8SNdroU2IHgJF2NVIgbUOfywcFj2bg7CbRsTcb2nvvSk/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=udaekWZp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZLiviilM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=udaekWZp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZLiviilM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="udaekWZp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZLiviilM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="udaekWZp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZLiviilM"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3311D37617;
	Tue, 19 Mar 2024 09:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710841159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/k2Wu79j5YoxwvEpkDnkCxLMZfLnw7DCJcpK6VvKv9k=;
	b=udaekWZpqPiColuydRyOG0vuE5VeTVGUKs4+r5jLKd8/Ps/MSUwZxk1Fb/LXHpPU3oMuKO
	EVbg8HkrbhI1uT59N97eE0s9a6Hrcg7MkauhAbejvaEjL97QNf9eYtsfaN/bE9O/J/Ol8p
	HzScvspIc50hV6USYCsRIu6o6x5Iy/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710841159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/k2Wu79j5YoxwvEpkDnkCxLMZfLnw7DCJcpK6VvKv9k=;
	b=ZLiviilMEsBiDJm+avWUVRa5LhmjoSXtyLLbQ2YOCFCRqmpRlycohwSSQnPnwoKUgcCOHm
	pSgm0Y+fiArLX9Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710841159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/k2Wu79j5YoxwvEpkDnkCxLMZfLnw7DCJcpK6VvKv9k=;
	b=udaekWZpqPiColuydRyOG0vuE5VeTVGUKs4+r5jLKd8/Ps/MSUwZxk1Fb/LXHpPU3oMuKO
	EVbg8HkrbhI1uT59N97eE0s9a6Hrcg7MkauhAbejvaEjL97QNf9eYtsfaN/bE9O/J/Ol8p
	HzScvspIc50hV6USYCsRIu6o6x5Iy/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710841159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/k2Wu79j5YoxwvEpkDnkCxLMZfLnw7DCJcpK6VvKv9k=;
	b=ZLiviilMEsBiDJm+avWUVRa5LhmjoSXtyLLbQ2YOCFCRqmpRlycohwSSQnPnwoKUgcCOHm
	pSgm0Y+fiArLX9Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF42C136A5;
	Tue, 19 Mar 2024 09:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SClFNUZd+WU6GAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 19 Mar 2024 09:39:18 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	andy@kernel.org,
	geert@linux-m68k.org,
	dan.carpenter@linaro.org,
	sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 4/6] fbdev: omap2/omapfb: Replace use of fb_blank with backlight helpers
Date: Tue, 19 Mar 2024 10:37:23 +0100
Message-ID: <20240319093915.31778-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319093915.31778-1-tzimmermann@suse.de>
References: <20240319093915.31778-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.59
X-Spamd-Result: default: False [-0.59 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLe6e1dyhqp7xrfznmmjiny17d)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linaro.org:email];
	 FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,linux-m68k.org,ravnborg.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.29)[74.64%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

Replace the use of struct backlight_properties.fb_blank with backlight
helpers. This effects testing if the backlight is blanked and reading
the backlight's brightness level.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

---

v2:
- update commit-message style according to subsystem (Lee)
---
 drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c | 6 +-----
 .../fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c   | 9 ++-------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
index adb8881bac285..47683a6c00767 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
@@ -356,11 +356,7 @@ static int dsicm_bl_update_status(struct backlight_device *dev)
 
 static int dsicm_bl_get_intensity(struct backlight_device *dev)
 {
-	if (dev->props.fb_blank == FB_BLANK_UNBLANK &&
-			dev->props.power == FB_BLANK_UNBLANK)
-		return dev->props.brightness;
-
-	return 0;
+	return backlight_get_brightness(dev);
 }
 
 static const struct backlight_ops dsicm_bl_ops = {
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
index 685c63aa4e030..9d3ce234a7874 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
@@ -340,11 +340,7 @@ static int acx565akm_bl_update_status(struct backlight_device *dev)
 
 	dev_dbg(&ddata->spi->dev, "%s\n", __func__);
 
-	if (dev->props.fb_blank == FB_BLANK_UNBLANK &&
-			dev->props.power == FB_BLANK_UNBLANK)
-		level = dev->props.brightness;
-	else
-		level = 0;
+	level = backlight_get_brightness(dev);
 
 	if (ddata->has_bc)
 		acx565akm_set_brightness(ddata, level);
@@ -363,8 +359,7 @@ static int acx565akm_bl_get_intensity(struct backlight_device *dev)
 	if (!ddata->has_bc)
 		return -ENODEV;
 
-	if (dev->props.fb_blank == FB_BLANK_UNBLANK &&
-			dev->props.power == FB_BLANK_UNBLANK) {
+	if (!backlight_is_blank(dev)) {
 		if (ddata->has_bc)
 			return acx565akm_get_actual_brightness(ddata);
 		else
-- 
2.44.0

