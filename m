Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF8C657CE
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515629; cv=none; b=NrUuY8PEK1jvE4sESigkAvYyn24XZh+Wz7AT2FQUg+jzmlH+NDsmX+XPajwrWTCId78Jk0dMwvZvh4w76N+iquM0iZFLZiXtj4s+IqTvngCnwixnbeIZM6o3MBEYv66kcnQ8iXM6BOFY0UyfSZhcS2aqJyGjYGhv/+l/2jnv56Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515629; c=relaxed/simple;
	bh=H3jKxa66QYiUAu0BVjVYf6Wil4Pw0y+DzpSdNfLNKww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVxU2AdgtTxGjTvHUjAqLYSZdiqQhS6BsC/idueOEWaceKstXx0AAjI9mjms2c45bLfLzAUPer7I5QKCiHSfdlTEcLM3bhRzmcKWFMBmyIblsdlrSISyVu3Mzc4C9HtNhlWv2EVLGJXqPVKL2ZY5MGVjSu4zX5r6w9bCXhN/YRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k+752JON; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NyUG1Wwt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k+752JON; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NyUG1Wwt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k+752JON";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NyUG1Wwt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k+752JON";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NyUG1Wwt"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0BB925D495;
	Fri, 19 Apr 2024 08:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713515626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlX334nZd3L96bxhuw5dgpw1JQdhCDgOJq7SzWhdtqk=;
	b=k+752JONAxqXBvpjfQ0tWqxN0GCaTKx11aNgLN5v7ZvYXshySF9KqWU3HLKnx5Pp7RWDy2
	RPte5zlXpRsU4ISkmjDiToCX7yp2emllePKAdDBcMxkqs6JrKTITHtx5US72lpZRWT5oLR
	y0aaggGKthr6XkmP0qqd22029LCTlkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713515626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlX334nZd3L96bxhuw5dgpw1JQdhCDgOJq7SzWhdtqk=;
	b=NyUG1WwtweZXmZxTOFKO5QWtk/DJWnfHhcY2FuKeWrMCnA0EkWPIQViBJLYtoTZU89Sskv
	gwcGT2rupB5dI6DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713515626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlX334nZd3L96bxhuw5dgpw1JQdhCDgOJq7SzWhdtqk=;
	b=k+752JONAxqXBvpjfQ0tWqxN0GCaTKx11aNgLN5v7ZvYXshySF9KqWU3HLKnx5Pp7RWDy2
	RPte5zlXpRsU4ISkmjDiToCX7yp2emllePKAdDBcMxkqs6JrKTITHtx5US72lpZRWT5oLR
	y0aaggGKthr6XkmP0qqd22029LCTlkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713515626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlX334nZd3L96bxhuw5dgpw1JQdhCDgOJq7SzWhdtqk=;
	b=NyUG1WwtweZXmZxTOFKO5QWtk/DJWnfHhcY2FuKeWrMCnA0EkWPIQViBJLYtoTZU89Sskv
	gwcGT2rupB5dI6DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB34813687;
	Fri, 19 Apr 2024 08:33:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qJZjMGksImb9agAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 19 Apr 2024 08:33:45 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH v3 39/43] drm/tiny/repaper: Use fbdev-dma
Date: Fri, 19 Apr 2024 10:29:32 +0200
Message-ID: <20240419083331.7761-40-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419083331.7761-1-tzimmermann@suse.de>
References: <20240419083331.7761-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -7.30
X-Spam-Level: 
X-Spamd-Result: default: False [-7.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmx.de,gmail.com,ffwll.ch];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLw9gjjhh8cousxs3wi4trssza)];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
damage handling, which is required by repaper. Avoids the overhead of
fbdev-generic's additional shadow buffering. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "Noralf Trønnes" <noralf@tronnes.org>
Acked-by: Noralf Trønnes <noralf@tronnes.org>
---
 drivers/gpu/drm/tiny/repaper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index 8fd6758f5725f..1f78aa3d26bbd 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -26,7 +26,7 @@
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fb_dma_helper.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_dma.h>
 #include <drm/drm_format_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -1118,7 +1118,7 @@ static int repaper_probe(struct spi_device *spi)
 
 	DRM_DEBUG_DRIVER("SPI speed: %uMHz\n", spi->max_speed_hz / 1000000);
 
-	drm_fbdev_generic_setup(drm, 0);
+	drm_fbdev_dma_setup(drm, 0);
 
 	return 0;
 }
-- 
2.44.0

