Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6DD15DBB7
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Apr 2024 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754371; cv=none; b=a/kbB/bjkebByClKls3FSPZgbFdG4SpHsFtF5mHvouMs9BV9BwbiOmbu9/sIZYI6GvxBW4xsD73WOxI00ioXs/DA477b5DP4y2nfdkM8tKO1szXcuLBf4g8WWEdAlwrOYkR+5VYugtEeUfg/OQN2HwIgPzTjNbeeJvjanrbANnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754371; c=relaxed/simple;
	bh=x+OCqQsRTZ3F1QgGOPKUCWAJvD1cjq50EGlmHiuEDXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OojAqJw9Le8mdK+vk+FQA9NtcraKCFWMJo5Pyh/akCeMxonm/QQK5jamDWZTcSB6BBCqHkAUvoAZmjR3Nugzi35Udce0tIoX5di9JdqHM1sZ5bMliNKLhAld4+pcak1+JWM7ym1Tbkp7VdKdi5303xg+LgHIq9sQuQr8q/nnVLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bPlg4yUT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w2RbKcgB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bPlg4yUT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w2RbKcgB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bPlg4yUT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w2RbKcgB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bPlg4yUT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w2RbKcgB"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F7BF5CDA7;
	Wed, 10 Apr 2024 13:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712754368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hpPdUGnw+xpvGmk4DPAD+Z6Kgn5w4FD/5bGOcgkG4YM=;
	b=bPlg4yUTkiZjKceq4EaFdRnSzdAhv9GGYJ0Fx0e3w1R1yFexykkN87/RO90QpOpCLO6HGr
	T9AgFfh63JNiuwts/exi0sytTE83WkSnGRt5ngOguTZdHGZSI5bO0/vY4ZYqw18dKdwhwd
	slj584W7Sh9VX5TGBhwfeEjmE/V0wGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712754368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hpPdUGnw+xpvGmk4DPAD+Z6Kgn5w4FD/5bGOcgkG4YM=;
	b=w2RbKcgBGCbZDCD+xRuO1G8iFRVw28r22l6MN95SG4XGJ1CCh6s6QT2l/G6c/XxB48GSyZ
	Pu8oSI0R+7abPjDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712754368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hpPdUGnw+xpvGmk4DPAD+Z6Kgn5w4FD/5bGOcgkG4YM=;
	b=bPlg4yUTkiZjKceq4EaFdRnSzdAhv9GGYJ0Fx0e3w1R1yFexykkN87/RO90QpOpCLO6HGr
	T9AgFfh63JNiuwts/exi0sytTE83WkSnGRt5ngOguTZdHGZSI5bO0/vY4ZYqw18dKdwhwd
	slj584W7Sh9VX5TGBhwfeEjmE/V0wGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712754368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hpPdUGnw+xpvGmk4DPAD+Z6Kgn5w4FD/5bGOcgkG4YM=;
	b=w2RbKcgBGCbZDCD+xRuO1G8iFRVw28r22l6MN95SG4XGJ1CCh6s6QT2l/G6c/XxB48GSyZ
	Pu8oSI0R+7abPjDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 392DA13AA4;
	Wed, 10 Apr 2024 13:06:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ACSsDMCOFmYdEgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Apr 2024 13:06:08 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
Subject: [PATCH v2 35/43] drm/tiny/ili9341: Use fbdev-dma
Date: Wed, 10 Apr 2024 15:02:31 +0200
Message-ID: <20240410130557.31572-36-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410130557.31572-1-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,suse.de,gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmx.de,gmail.com,ffwll.ch];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Spam-Score: -5.30
X-Spam-Flag: NO

Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
damage handling, which is required by ili9341. Avoids the overhead of
fbdev-generic's additional shadow buffering. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
---
 drivers/gpu/drm/tiny/ili9341.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/ili9341.c b/drivers/gpu/drm/tiny/ili9341.c
index 47b61c3bf1457..8bcada30af717 100644
--- a/drivers/gpu/drm/tiny/ili9341.c
+++ b/drivers/gpu/drm/tiny/ili9341.c
@@ -17,7 +17,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_managed.h>
@@ -218,7 +218,7 @@ static int ili9341_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, drm);
 
-	drm_fbdev_generic_setup(drm, 0);
+	drm_fbdev_dma_setup(drm, 0);
 
 	return 0;
 }
-- 
2.44.0

