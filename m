Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5AB3DC87B
	for <linux-fbdev@vger.kernel.org>; Thu,  9 Jul 2026 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588958; cv=none; b=Kt92Wai8S/fJGZ4sRTYK2gPHyPh06mNYYmuvGPTUfYQkKqK0cjmagjpZvCNmhibehtw66RRxYE4GxY8fKjiKsasej1WxGvJJGfc6ETLCLKQOkvxOooYh15wOoBLJ986kHWANPoJzOeap5PM7mUqU29RrK3nXs9cvEa56aoK6iO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588958; c=relaxed/simple;
	bh=JB/4CgapkL5qiw/GGATSOkWTkOz6PiZdftY1jh6EKRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsfhXA8aJE0m437XrtkzTsDdkQfWhFjRCmhsjwxhK5Dw8Acw/D33cFj54ErkR0EDOdGjRwVZfiYBNutdA2qHpHq2J2Mi32NsG63b8rW7bi+rN5vgx5zDx7Bm0TBhjsfPN3DYQ8U5GymwG2gA2idLjJTiWSXYHHbAOgGniRqpAno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xctLxFHE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YQRQpOQx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xctLxFHE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YQRQpOQx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xctLxFHE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YQRQpOQx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xctLxFHE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YQRQpOQx"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2DB7075DD9;
	Thu,  9 Jul 2026 09:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783588943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjZOLNTa/QCQzDdlDbCVM8vYETPmODla9FesFjm4Hec=;
	b=xctLxFHEDquA16fp8mIX+NuUe6glM7pQo4gIP8EftzhzXRUOKL+pXTULWGUYFLzkgCwTKN
	xtiknw3d9ItaQURC1MxLKUOdUHWTFVAirhCqmuUf+dlhw/rOUGlwh3XQjPx2oYEysZXqxL
	+BGpCezXyZtwqSdPruwMUxIwFp4SH1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783588943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjZOLNTa/QCQzDdlDbCVM8vYETPmODla9FesFjm4Hec=;
	b=YQRQpOQx/S1MfSXpAantbWYmo+W4B+OgTjv1izF6o8qmm/EfxrtLOMh7C/NlduKi8RE46Y
	J+JRhTiYvmcVuXDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783588943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjZOLNTa/QCQzDdlDbCVM8vYETPmODla9FesFjm4Hec=;
	b=xctLxFHEDquA16fp8mIX+NuUe6glM7pQo4gIP8EftzhzXRUOKL+pXTULWGUYFLzkgCwTKN
	xtiknw3d9ItaQURC1MxLKUOdUHWTFVAirhCqmuUf+dlhw/rOUGlwh3XQjPx2oYEysZXqxL
	+BGpCezXyZtwqSdPruwMUxIwFp4SH1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783588943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjZOLNTa/QCQzDdlDbCVM8vYETPmODla9FesFjm4Hec=;
	b=YQRQpOQx/S1MfSXpAantbWYmo+W4B+OgTjv1izF6o8qmm/EfxrtLOMh7C/NlduKi8RE46Y
	J+JRhTiYvmcVuXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98A51779B4;
	Thu,  9 Jul 2026 09:22:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QIz7I05oT2q6OQAAD6G6ig
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
Subject: [PATCH v2 3/7] vga_switcheroo: Add pre_switch callback to client ops
Date: Thu,  9 Jul 2026 11:15:59 +0200
Message-ID: <20260709092215.168172-4-tzimmermann@suse.de>
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
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[wunner.de,redhat.com,amd.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,intel.com,ursulin.net,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLq3cifbxyhc6qbbynzfc6amns)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Spam-Level: 

Add pre_switch to struct vga_switcheroo_client_ops to inform the
switcheroo client about upcoming switches of the outputs.

This callback is intended to replace the hard-coded call to fbdev's
fb_switch_outputs(). With DRM supporting more clients than just fbdev
emulation, something more flexible is required.

v2:
- remove non-sensical gpu_bound documentation (Sashiko)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/vga/vga_switcheroo.c |  4 +++-
 include/linux/vga_switcheroo.h   | 11 ++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index 22cf52b78b75..bdf1e56ae891 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -733,8 +733,10 @@ static int vga_switchto_stage2(struct vga_switcheroo_client *new_client)
 	if (!active->driver_power_control)
 		set_audio_state(active->id, VGA_SWITCHEROO_OFF);
 
+	if (new_client->ops->pre_switch)
+		new_client->ops->pre_switch(new_client->pdev);
 #if defined(CONFIG_FB)
-	if (new_client->fb_info)
+	else if (new_client->fb_info)
 		fb_switch_outputs(new_client->fb_info);
 #endif
 
diff --git a/include/linux/vga_switcheroo.h b/include/linux/vga_switcheroo.h
index 7e6ac0114d55..4422daca9ceb 100644
--- a/include/linux/vga_switcheroo.h
+++ b/include/linux/vga_switcheroo.h
@@ -133,17 +133,22 @@ struct vga_switcheroo_handler {
  * @can_switch: check if the device is in a position to switch now.
  * 	Mandatory. The client should return false if a user space process
  * 	has one of its device files open
+ * @pre_switch: prepare switch
+ *	Optional. This gets called before switching the outputs to the
+ *	GPU. Allows drivers to prepare for the switch.
  * @gpu_bound: notify the client id to audio client when the GPU is bound.
  *
  * Client callbacks. A client can be either a GPU or an audio device on a GPU.
- * The @set_gpu_state and @can_switch methods are mandatory, @reprobe may be
- * set to NULL. For audio clients, the @reprobe member is bogus.
- * OTOH, @gpu_bound is only for audio clients, and not used for GPU clients.
+ * The @set_gpu_state and @can_switch methods are mandatory, @pre_switch and
+ * @reprobe may be set to NULL. For audio clients, the @pre_switch and
+ * @reprobe members are bogus. OTOH, @gpu_bound is only for audio clients,
+ * and not used for GPU clients.
  */
 struct vga_switcheroo_client_ops {
 	void (*set_gpu_state)(struct pci_dev *dev, enum vga_switcheroo_state);
 	void (*reprobe)(struct pci_dev *dev);
 	bool (*can_switch)(struct pci_dev *dev);
+	void (*pre_switch)(struct pci_dev *dev);
 	void (*gpu_bound)(struct pci_dev *dev, enum vga_switcheroo_client_id);
 };
 
-- 
2.54.0

