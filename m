Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524483FBEA4
	for <linux-fbdev@vger.kernel.org>; Thu,  9 Jul 2026 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588946; cv=none; b=FEFm0qZHus1KDVfQAsFCrcOjvlxs4E5vV3QQxV2bDnwap4/1hCahMA6JrdUgQOp4dONJo024FFAxjQOIJWfVuBcKoWOS+5d2IjlxGG9ojib424q0HyKXkuyOjo8cnerJXTAPS8PAwTn14zMnUkwyoGS+RDpyY2Tet8LOUHDk3F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588946; c=relaxed/simple;
	bh=Minn94sXir64EaOIwn4ArV3Rq6I8A3TGmukGJqJdnXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pf8p8julxGGHdyftx8zY5wYmwc+IfeyAduZ1Jgqdj51qDKgKYET5qXQxza/5IZR6YdBr2lhTtK4b5sgkMs+yAjPJNFafGj9FeZTzFvA4Eb/Z3xCpqVNkPmefxkephR3P1zpAFr31zmt/jq8bdvfg0AeWu4yZJ1Fi8upBBRxq/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x4RLZ1mo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d5aOST+A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x4RLZ1mo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d5aOST+A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x4RLZ1mo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d5aOST+A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x4RLZ1mo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d5aOST+A"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9859676093;
	Thu,  9 Jul 2026 09:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783588942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YifDnmK82gFn50n9gIPI//YYkdL4JukIrrg2Jw2g5D0=;
	b=x4RLZ1moKkZzWedgucWHIplFLmsxF0SVhh+Mzgb3YN1pgbSXhUhm2N/uMa7Sn5tHruqdUw
	s389FThUPCarFF5up8GgnvjwrL+ojOKf17TblFj0UKwTjJV22ll0CyacpzR+L9GTw5nZTU
	TAh+1p4YQSo8Yyhmok3cTY5EkcrKtek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783588942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YifDnmK82gFn50n9gIPI//YYkdL4JukIrrg2Jw2g5D0=;
	b=d5aOST+A7803KAD75GLkgU6/Bi8ilwqkJtSkrfq0e/rUDZL6hrX+N4JE9EHSDVmPSJa4qa
	V23Hwt6hhV3H+fCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783588942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YifDnmK82gFn50n9gIPI//YYkdL4JukIrrg2Jw2g5D0=;
	b=x4RLZ1moKkZzWedgucWHIplFLmsxF0SVhh+Mzgb3YN1pgbSXhUhm2N/uMa7Sn5tHruqdUw
	s389FThUPCarFF5up8GgnvjwrL+ojOKf17TblFj0UKwTjJV22ll0CyacpzR+L9GTw5nZTU
	TAh+1p4YQSo8Yyhmok3cTY5EkcrKtek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783588942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YifDnmK82gFn50n9gIPI//YYkdL4JukIrrg2Jw2g5D0=;
	b=d5aOST+A7803KAD75GLkgU6/Bi8ilwqkJtSkrfq0e/rUDZL6hrX+N4JE9EHSDVmPSJa4qa
	V23Hwt6hhV3H+fCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09677779AD;
	Thu,  9 Jul 2026 09:22:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4NoHAU5oT2q6OQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 09 Jul 2026 09:22:22 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lukas@wunner.de,
	jfalempe@redhat.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	lyude@redhat.com,
	dakr@kernel.org,
	deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 2/7] drm/client: Add acquire_outputs callback; implement for fbdev emulation
Date: Thu,  9 Jul 2026 11:15:58 +0200
Message-ID: <20260709092215.168172-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709092215.168172-1-tzimmermann@suse.de>
References: <20260709092215.168172-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[wunner.de,redhat.com,amd.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,intel.com,ursulin.net,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Spam-Level: 
X-Spam-Score: -2.80

Add the callback acquire_outputs to drm_client_funcs to inform an internal
DRM client that vga-switcheroo is about to switch the physical outputs to
the client's device. Allows the client to prepare its internal state for
the upcoming switch.

Wire up the DRM client helpers to invoke the helper for a device's
clients.

Implement acquire_outputs for fbdev emulation. Invoke fb_switch_outputs(),
which remaps framebuffers to virtual terminals in fbcon. Currently this
is still being done by vga-switcheroo. With more DRM clients becoming
available, vga-switcheroo needs to become client agonostic.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/clients/drm_fbdev_client.c | 23 +++++++++++++++-------
 drivers/gpu/drm/drm_client_event.c         | 18 +++++++++++++++++
 include/drm/drm_client.h                   | 14 +++++++++++++
 include/drm/drm_client_event.h             |  3 +++
 4 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_fbdev_client.c b/drivers/gpu/drm/clients/drm_fbdev_client.c
index 91d196a397cf..827f32668714 100644
--- a/drivers/gpu/drm/clients/drm_fbdev_client.c
+++ b/drivers/gpu/drm/clients/drm_fbdev_client.c
@@ -47,6 +47,14 @@ static int drm_fbdev_client_restore(struct drm_client_dev *client, bool force)
 	return 0;
 }
 
+static void drm_fbdev_client_acquire_outputs(struct drm_client_dev *client)
+{
+	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
+
+	if (fb_helper->info)
+		fb_switch_outputs(fb_helper->info);
+}
+
 static int drm_fbdev_client_hotplug(struct drm_client_dev *client)
 {
 	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
@@ -95,13 +103,14 @@ static int drm_fbdev_client_resume(struct drm_client_dev *client)
 }
 
 static const struct drm_client_funcs drm_fbdev_client_funcs = {
-	.owner		= THIS_MODULE,
-	.free		= drm_fbdev_client_free,
-	.unregister	= drm_fbdev_client_unregister,
-	.restore	= drm_fbdev_client_restore,
-	.hotplug	= drm_fbdev_client_hotplug,
-	.suspend	= drm_fbdev_client_suspend,
-	.resume		= drm_fbdev_client_resume,
+	.owner		 = THIS_MODULE,
+	.free		 = drm_fbdev_client_free,
+	.unregister	 = drm_fbdev_client_unregister,
+	.restore	 = drm_fbdev_client_restore,
+	.acquire_outputs = drm_fbdev_client_acquire_outputs,
+	.hotplug	 = drm_fbdev_client_hotplug,
+	.suspend	 = drm_fbdev_client_suspend,
+	.resume		 = drm_fbdev_client_resume,
 };
 
 /**
diff --git a/drivers/gpu/drm/drm_client_event.c b/drivers/gpu/drm/drm_client_event.c
index 7b3e362f7926..f0af584da23c 100644
--- a/drivers/gpu/drm/drm_client_event.c
+++ b/drivers/gpu/drm/drm_client_event.c
@@ -123,6 +123,24 @@ void drm_client_dev_restore(struct drm_device *dev, bool force)
 	mutex_unlock(&dev->clientlist_mutex);
 }
 
+void drm_client_dev_acquire_outputs(struct drm_device *dev)
+{
+	struct drm_client_dev *client;
+
+	if (!drm_core_check_feature(dev, DRIVER_MODESET))
+		return;
+
+	mutex_lock(&dev->clientlist_mutex);
+	list_for_each_entry(client, &dev->clientlist, list) {
+		if (!client->funcs || !client->funcs->acquire_outputs)
+			continue;
+
+		client->funcs->acquire_outputs(client);
+	}
+	mutex_unlock(&dev->clientlist_mutex);
+}
+EXPORT_SYMBOL(drm_client_dev_acquire_outputs);
+
 static int drm_client_suspend(struct drm_client_dev *client)
 {
 	struct drm_device *dev = client->dev;
diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
index 49a21f3dcb36..10a0cae3e48f 100644
--- a/include/drm/drm_client.h
+++ b/include/drm/drm_client.h
@@ -66,6 +66,20 @@ struct drm_client_funcs {
 	 */
 	int (*restore)(struct drm_client_dev *client, bool force);
 
+	/**
+	 * @acquire_outputs:
+	 *
+	 * Called by vga-switcheroo. Informs the client that the outputs will
+	 * be switched to its device. When @acquire_outputs runs, the outputs
+	 * have not been switched yet. The client should only prepare the software
+	 * state. After the switch happened, the client might get a hotplug
+	 * event to update the hardware state.
+	 *
+	 * This callback exists for remapping framebuffers to virtual terminals
+	 * in fbcon.
+	 */
+	void (*acquire_outputs)(struct drm_client_dev *client);
+
 	/**
 	 * @hotplug:
 	 *
diff --git a/include/drm/drm_client_event.h b/include/drm/drm_client_event.h
index 79369c755bc9..c93f404bae1d 100644
--- a/include/drm/drm_client_event.h
+++ b/include/drm/drm_client_event.h
@@ -11,6 +11,7 @@ struct drm_device;
 void drm_client_dev_unregister(struct drm_device *dev);
 void drm_client_dev_hotplug(struct drm_device *dev);
 void drm_client_dev_restore(struct drm_device *dev, bool force);
+void drm_client_dev_acquire_outputs(struct drm_device *dev);
 void drm_client_dev_suspend(struct drm_device *dev);
 void drm_client_dev_resume(struct drm_device *dev);
 #else
@@ -20,6 +21,8 @@ static inline void drm_client_dev_hotplug(struct drm_device *dev)
 { }
 static inline void drm_client_dev_restore(struct drm_device *dev, bool force)
 { }
+static inline void drm_client_dev_acquire_outputs(struct drm_device *dev)
+{ }
 static inline void drm_client_dev_suspend(struct drm_device *dev)
 { }
 static inline void drm_client_dev_resume(struct drm_device *dev)
-- 
2.54.0

