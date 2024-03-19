Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3727D071
	for <linux-fbdev@vger.kernel.org>; Tue, 19 Mar 2024 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841161; cv=none; b=PBzBJCL2fFu09gXq8usJCwc3glwv71svB8cW831qvV4yxEKErHEAwFMRHBejJv5rx7D6reXsIrQbO0EAJ1kLY5F9Htxc76WP+opMxsGowuWKpdrAefS8AmFt3qGcCVM6Ik1MU7DWkSSdXBQ/iYA5dwBZmzRODd2eNtibHH5r2LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841161; c=relaxed/simple;
	bh=bNXHHmZJWa7N3lqWlNBEM+S6RX9zWS6DnfyavrrndS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwoVP439MncMLn3GupqCkrjDc6c/ERCPLKLPINcvDgQjt43DSv6FCylWNBEarjS0RyDkxf61sg7WquBLZnUiaNiJqBasv6QvBKe3bQuSjqwe69WF9Ue5P7ew2femEsvL47fXbbP6p+SpBU/qZr37JLWXyf09P+kfTV/fMXmxYVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KiM60/Gz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6XvTzvIh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KiM60/Gz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6XvTzvIh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KiM60/Gz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6XvTzvIh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KiM60/Gz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6XvTzvIh"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A2AF37613;
	Tue, 19 Mar 2024 09:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710841158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0dty1vPLuigpCpTtELGxHmUHZvuK7IRWWV7zcr3R7Y=;
	b=KiM60/GzY88C4jxMVD6cjR3zTJ0UK7EFNSDSN2njmz08CDWnvslEAJ4Hj/ij0L6pYLSM34
	YHKzOtIl7DY4LtJ1JEWHJ54wpZIr9Yv2WDWKDgK6cl7PNpwJVAYVuXj+1GdnW0rCl00VZU
	tpSAM2ZJ9WtNGAtnSSFajK8LctqCMgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710841158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0dty1vPLuigpCpTtELGxHmUHZvuK7IRWWV7zcr3R7Y=;
	b=6XvTzvIhZj0BJZbs4mE5DPeKIDRXKJm9J78AmDuA7nANHIPZr9ngvA786C9WtzlrT7lZoG
	EWdIyj6mFkRD8JBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710841158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0dty1vPLuigpCpTtELGxHmUHZvuK7IRWWV7zcr3R7Y=;
	b=KiM60/GzY88C4jxMVD6cjR3zTJ0UK7EFNSDSN2njmz08CDWnvslEAJ4Hj/ij0L6pYLSM34
	YHKzOtIl7DY4LtJ1JEWHJ54wpZIr9Yv2WDWKDgK6cl7PNpwJVAYVuXj+1GdnW0rCl00VZU
	tpSAM2ZJ9WtNGAtnSSFajK8LctqCMgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710841158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0dty1vPLuigpCpTtELGxHmUHZvuK7IRWWV7zcr3R7Y=;
	b=6XvTzvIhZj0BJZbs4mE5DPeKIDRXKJm9J78AmDuA7nANHIPZr9ngvA786C9WtzlrT7lZoG
	EWdIyj6mFkRD8JBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F671136A5;
	Tue, 19 Mar 2024 09:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SOIrDkZd+WU6GAAAD6G6ig
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
Subject: [PATCH v2 2/6] backlight: omap1: Remove unused struct omap_backlight_config.set_power
Date: Tue, 19 Mar 2024 10:37:21 +0100
Message-ID: <20240319093915.31778-3-tzimmermann@suse.de>
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
X-Spam-Score: -0.35
X-Spamd-Result: default: False [-0.35 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,linux-m68k.org,ravnborg.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.05)[60.05%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linaro.org:email,ravnborg.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

The callback set_power in struct omap_backlight_config is not
implemented anywhere. Remove it from the structure and driver.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

---

v2:
- update commit-message style according to subsystem (Lee)
---
 drivers/video/backlight/omap1_bl.c     | 3 ---
 include/linux/platform_data/omap1_bl.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/video/backlight/omap1_bl.c b/drivers/video/backlight/omap1_bl.c
index 69a49384b3de4..84d148f385951 100644
--- a/drivers/video/backlight/omap1_bl.c
+++ b/drivers/video/backlight/omap1_bl.c
@@ -39,9 +39,6 @@ static inline void omapbl_send_enable(int enable)
 
 static void omapbl_blank(struct omap_backlight *bl, int mode)
 {
-	if (bl->pdata->set_power)
-		bl->pdata->set_power(bl->dev, mode);
-
 	switch (mode) {
 	case FB_BLANK_NORMAL:
 	case FB_BLANK_VSYNC_SUSPEND:
diff --git a/include/linux/platform_data/omap1_bl.h b/include/linux/platform_data/omap1_bl.h
index 5e8b17d77a5fe..3d0bab31a0a94 100644
--- a/include/linux/platform_data/omap1_bl.h
+++ b/include/linux/platform_data/omap1_bl.h
@@ -6,7 +6,6 @@
 
 struct omap_backlight_config {
 	int default_intensity;
-	int (*set_power)(struct device *dev, int state);
 };
 
 #endif
-- 
2.44.0

