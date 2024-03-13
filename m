Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F6D47A64
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710344945; cv=none; b=eAcdYf+cx++6My78cIHs7uW925nG8w+bh9yk0W60JiEXXW+uHVNHVsAkpnS3PzDvfH5G5ZZO236t8ScYIXA6nWAV/XP8dyS9gJ9qJYyleEuOfMObw0R+CwDYZSJ0FeO5rSoSXAic0arA0TUMwD1Trt4enBwzeU0eqgXfjHRqLE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710344945; c=relaxed/simple;
	bh=6jtMupn0duZFMu+LVmT90WuesrqiqdTYw42c+bvUfss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaTUVgIv8+KS7c8yPuXmsZ2KVeJFqVYMTWBmVe5J5wK7h+L92s8Uv4W29tD4HP0Le7C7gyUE/HxjVtFIT5y3W0Wj2+5hh5nH+wK8N6KgP4SvEqSLJYkl5rWkXcg1VcbMz7pFi/Ck3A3DvigQQ4bxYFCYGvkJjVEKbO4LnstEVig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D716921C8F;
	Wed, 13 Mar 2024 15:49:00 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85D88139B1;
	Wed, 13 Mar 2024 15:49:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YB9NH+zK8WUhfQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 13 Mar 2024 15:49:00 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Robin van der Gracht <robin@protonic.nl>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 1/6] auxdisplay/ht16k33: Replace use of fb_blank with backlight helper
Date: Wed, 13 Mar 2024 16:45:00 +0100
Message-ID: <20240313154857.12949-2-tzimmermann@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: D716921C8F
X-Spam-Flag: NO

Replace the use of struct backlight_properties.fb_blank with a
call to backlight_get_brightness(). The helper implement the same
logic as the driver's function.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Robin van der Gracht <robin@protonic.nl>
Cc: Miguel Ojeda <ojeda@kernel.org>
---
 drivers/auxdisplay/ht16k33.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index a90430b7d07ba..83db829b97a5e 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -314,14 +314,9 @@ static int ht16k33_initialize(struct ht16k33_priv *priv)
 
 static int ht16k33_bl_update_status(struct backlight_device *bl)
 {
-	int brightness = bl->props.brightness;
+	int brightness = backlight_get_brightness(bl);
 	struct ht16k33_priv *priv = bl_get_data(bl);
 
-	if (bl->props.power != FB_BLANK_UNBLANK ||
-	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
-	    bl->props.state & BL_CORE_FBBLANK)
-		brightness = 0;
-
 	return ht16k33_brightness_set(priv, brightness);
 }
 
-- 
2.44.0

