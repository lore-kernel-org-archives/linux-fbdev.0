Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D547A7A
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710344944; cv=none; b=CAixLA23uQGty3I7rvvqWslus7QTphLlObYAFUAM+9daH6CcrioV/HcmTl8AJhL/rtiEok+DqM8R/H5hXrF/X1ge4S4e1jQ7jjawKHa7ZXi5Mx0RRIn9SLNvroL1j/hhbvYN1ijIopvP4NrdGHt4PPYsoM3j7zYiiQQSMFhlbfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710344944; c=relaxed/simple;
	bh=EwM7OqdBgjdSWtTplbo/nPF5evLKhoODgMhWnLBfglY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ozos7z9CtL4V+filEsArjrmFkTSsWdRXwy++ndfpgOgt1LnLrUCvlMYaVqCL9ljlDfi++nJfC+0T/h4PtlVkK7WSg8IjeKr01aMqKfElPEbuaG6O1WS56w3vLWrz5na2XDSY1WPhHtJF1yYZB+S0ueWwWHTZTCNRyTTAX1aMRig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 265C51F7CC;
	Wed, 13 Mar 2024 15:49:01 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC33B1397F;
	Wed, 13 Mar 2024 15:49:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QJppNOzK8WUhfQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 13 Mar 2024 15:49:00 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/6] backlight/omap1-bl: Remove unused struct omap_backlight_config.set_power
Date: Wed, 13 Mar 2024 16:45:01 +0100
Message-ID: <20240313154857.12949-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313154857.12949-1-tzimmermann@suse.de>
References: <20240313154857.12949-1-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 265C51F7CC
X-Spam-Flag: NO

The callback set_power in struct omap_backlight_config is not
implemented anywhere. Remove it from the structure and driver.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
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

