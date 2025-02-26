Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B41E1E18
	for <linux-fbdev@vger.kernel.org>; Wed, 26 Feb 2025 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562700; cv=none; b=pzgOvsAq3vZqtP1ULqy/G/rcnl3BbdJd1Dg4CkrPqwtvHSn+shkS+6GY/i4h9s3ElYV7L677olfsSS8R3entuUxQTvxMkSuy1uXoWJORATnwlwDhNZGPyRKBFBurydB96F4j7pVnougiEPZ7no55PUI7+U1H5Cvp2/PbmFR6HhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562700; c=relaxed/simple;
	bh=QljiSUtK8abn9whBbmA9UmhLSOhLC1dTcUiCTuzlOZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdS4adm0Gr3TUcortYX9tVkyU45IAmlRUQThCLDlpImMns1kLGny/QpZ6zkmbmabk4dNZNsl3HI0vL1FYrXKdc5vPd8lGt3+OnZEeleEqkYXmLKC+6QkvbhfCEua3zGzGpgsG6EA3ozctgCdiVcyDjMJBeLy05lw4+5PXeAdr0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ABF3D1F747;
	Wed, 26 Feb 2025 09:37:46 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 645FC13A82;
	Wed, 26 Feb 2025 09:37:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OLI1F+rgvmezXQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 26 Feb 2025 09:37:46 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	pavel@ucw.cz,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	simona@ffwll.ch
Cc: linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 05/11] backlight: Move blank-state handling into helper
Date: Wed, 26 Feb 2025 10:31:54 +0100
Message-ID: <20250226093456.147402-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226093456.147402-1-tzimmermann@suse.de>
References: <20250226093456.147402-1-tzimmermann@suse.de>
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
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: ABF3D1F747
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Move the handling of blank-state updates into a separate helper,
so that is can be called without the fbdev event. No functional
changes.

As a minor improvement over the original code, the update replaces
manual locking with a guard.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/backlight.c | 46 +++++++++++++++++------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index bb01f57c4683..1c43f579396f 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -80,6 +80,30 @@ static const char *const backlight_scale_types[] = {
 
 #if defined(CONFIG_FB_CORE) || (defined(CONFIG_FB_CORE_MODULE) && \
 				defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE))
+static void backlight_notify_blank(struct backlight_device *bd,
+				   struct device *display_dev,
+				   bool fb_on, bool prev_fb_on)
+{
+	guard(mutex)(&bd->ops_lock);
+
+	if (!bd->ops)
+		return;
+	if (bd->ops->controls_device && !bd->ops->controls_device(bd, display_dev))
+		return;
+
+	if (fb_on && (!prev_fb_on || !bd->use_count)) {
+		if (!bd->use_count++) {
+			bd->props.state &= ~BL_CORE_FBBLANK;
+			backlight_update_status(bd);
+		}
+	} else if (!fb_on && prev_fb_on && bd->use_count) {
+		if (!(--bd->use_count)) {
+			bd->props.state |= BL_CORE_FBBLANK;
+			backlight_update_status(bd);
+		}
+	}
+}
+
 /*
  * fb_notifier_callback
  *
@@ -107,31 +131,15 @@ static int fb_notifier_callback(struct notifier_block *self,
 		return 0;
 
 	bd = container_of(self, struct backlight_device, fb_notif);
-	mutex_lock(&bd->ops_lock);
 
-	if (!bd->ops)
-		goto out;
-	if (bd->ops->controls_device && !bd->ops->controls_device(bd, info->device))
-		goto out;
 	if (fb_bd && fb_bd != bd)
-		goto out;
+		return 0;
 
 	fb_on = fb_blank[0] == FB_BLANK_UNBLANK;
 	prev_fb_on = fb_blank[1] == FB_BLANK_UNBLANK;
 
-	if (fb_on && (!prev_fb_on || !bd->use_count)) {
-		if (!bd->use_count++) {
-			bd->props.state &= ~BL_CORE_FBBLANK;
-			backlight_update_status(bd);
-		}
-	} else if (!fb_on && prev_fb_on && bd->use_count) {
-		if (!(--bd->use_count)) {
-			bd->props.state |= BL_CORE_FBBLANK;
-			backlight_update_status(bd);
-		}
-	}
-out:
-	mutex_unlock(&bd->ops_lock);
+	backlight_notify_blank(bd, info->device, fb_on, prev_fb_on);
+
 	return 0;
 }
 
-- 
2.48.1

