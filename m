Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A37D082
	for <linux-fbdev@vger.kernel.org>; Tue, 12 Mar 2024 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258528; cv=none; b=D0XvHjG2LQ9D/5Sal3cq9reN08/bw+NQTGtfIx7Sx1Tedj5386dPErlbhv/w6bBg/efCC9Hxt1Im7ASjHVzo228SeElaLZfuyCCN2XULDt5yOxzctY6LIAYYgGsjsjBK+hj3goT/2ANakycXczLeE/Mh9TyGCzeHD6ISeYU0wBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258528; c=relaxed/simple;
	bh=grfiF49c8/ZgjpztMMDXnj3IXzIjXvVfon19oYLeQYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0o6vGRxXH7T4UtazMxTbs29ntYErJ68pQrzaEvGz89Q2lZZCrErYRCy35uQaTPcrtz5/jvAMk1j6Fnq/OP1T4MKxivqRwpT8VnJy7AzOulGNZOfbqoBnjVE1tr5n77PUHVBeMVkRioIKnbnGLFPJoBLU5/PW2BPvpEYcQ8uO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d7BkL/Cu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ErLfoTp1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d7BkL/Cu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ErLfoTp1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d7BkL/Cu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ErLfoTp1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d7BkL/Cu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ErLfoTp1"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 091C537880;
	Tue, 12 Mar 2024 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jM6OJtpI0VSHF+e3kYIJB8BPtK7t3FGNyyJBVLYyDnM=;
	b=d7BkL/CuLg4b6bUOGcpn+LobSC8JqfK7BsE3p5U+GqTsp/I9tZeVIu4fBrBLzCXEFUEn9v
	avK2wFTBgrWOC3B03gqkCNO/GXL+U7Sz+s6Pk+PVqlB+QkBdkEXVXnFqNwM4N/Tdb6BepD
	UhTb8BJeVp5vAdsdu7SLrMmjpLgaAJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jM6OJtpI0VSHF+e3kYIJB8BPtK7t3FGNyyJBVLYyDnM=;
	b=ErLfoTp1n7l8qT1YbvSOjCvYl08TYj8sXEDmVxgnVJC2nCIqSt2I7FNjarJwNcZpfV13qh
	cU8VGOrDQeD+tPDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jM6OJtpI0VSHF+e3kYIJB8BPtK7t3FGNyyJBVLYyDnM=;
	b=d7BkL/CuLg4b6bUOGcpn+LobSC8JqfK7BsE3p5U+GqTsp/I9tZeVIu4fBrBLzCXEFUEn9v
	avK2wFTBgrWOC3B03gqkCNO/GXL+U7Sz+s6Pk+PVqlB+QkBdkEXVXnFqNwM4N/Tdb6BepD
	UhTb8BJeVp5vAdsdu7SLrMmjpLgaAJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jM6OJtpI0VSHF+e3kYIJB8BPtK7t3FGNyyJBVLYyDnM=;
	b=ErLfoTp1n7l8qT1YbvSOjCvYl08TYj8sXEDmVxgnVJC2nCIqSt2I7FNjarJwNcZpfV13qh
	cU8VGOrDQeD+tPDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC8CA1364F;
	Tue, 12 Mar 2024 15:48:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mPGnKFp58GUhPwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 12 Mar 2024 15:48:42 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch,
	airlied@gmail.com,
	deller@gmx.de,
	javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>
Subject: [PATCH 20/43] drm/vkms: Use fbdev-shmem
Date: Tue, 12 Mar 2024 16:45:15 +0100
Message-ID: <20240312154834.26178-21-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312154834.26178-1-tzimmermann@suse.de>
References: <20240312154834.26178-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.18
X-Spamd-Result: default: False [-4.18 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-1.38)[90.76%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLw9gjjhh8cousxs3wi4trssza)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,gmx.de,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,suse.de,gmail.com,riseup.net];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

Implement fbdev emulation with fbdev-shmem. Avoids the overhead of
fbdev-generic's additional shadow buffering. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Melissa Wen <melissa.srw@gmail.com>
Cc: "Maíra Canal" <mairacanal@riseup.net>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index dd0af086e7fa9..8dc9dc13896e9 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -17,7 +17,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_shmem.h>
 #include <drm/drm_file.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_ioctl.h>
@@ -223,7 +223,7 @@ static int vkms_create(struct vkms_config *config)
 	if (ret)
 		goto out_devres;
 
-	drm_fbdev_generic_setup(&vkms_device->drm, 0);
+	drm_fbdev_shmem_setup(&vkms_device->drm, 0);
 
 	return 0;
 
-- 
2.44.0

