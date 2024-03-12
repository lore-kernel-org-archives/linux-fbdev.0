Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6117D3FF
	for <linux-fbdev@vger.kernel.org>; Tue, 12 Mar 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258531; cv=none; b=ebq+kOIjfAx8dEwrejbKb84m0sEZjw3OGN7DZ8KultKmPp79D1NO8edlFKJc+LArxCKquFmJLvo9VjP4XqziRJR1CPL9a7VtHwGSf+/jdJoBkyos3jwChGLe4nsju3fbUlQbvsNAqOt0jSJEIKsyahXc631NYcXxIahcFHRw+oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258531; c=relaxed/simple;
	bh=x+OCqQsRTZ3F1QgGOPKUCWAJvD1cjq50EGlmHiuEDXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKbugtCUvAGbt7CUUBxu4FPcnUN98ZnuCmaPWT4Id6ESAMVwWQ8cwU2y8MZrGfyh9Kyh83z89oMaDCa6LEHbIA+Oun0pPdMocLj33zbDW0sg7J/Vm2AyqyOjXDq/1SUl9eRIUxNpelAe7W35xchNCorNLCxQHKtqlW7NrlR/rhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A30Bu30s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zU/uYyf6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A30Bu30s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zU/uYyf6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A30Bu30s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zU/uYyf6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A30Bu30s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zU/uYyf6"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE4E43787D;
	Tue, 12 Mar 2024 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hpPdUGnw+xpvGmk4DPAD+Z6Kgn5w4FD/5bGOcgkG4YM=;
	b=A30Bu30s/7JtmcszTHZB0ABK8Sw9NXPxXwVX52Jc1GquGGGEjblYi9tuK1UFGN9zBYIQM+
	ps8xOCsiZFFvktItQ42FuCAjwct0n2btNyY5GAMLKbUXM+Rs6/2pNUhOfxdsOr+mwGxvqC
	PXXtQbArypbCxcAly9JxISr7TJn5Lnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hpPdUGnw+xpvGmk4DPAD+Z6Kgn5w4FD/5bGOcgkG4YM=;
	b=zU/uYyf6CHO9BYZbAh/mr1pukmh88QarYLD4NgbQHUj+UpbJIEGGKNTdEAMlGkyBB0IwOg
	x9h5WmZxhVDQ55Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hpPdUGnw+xpvGmk4DPAD+Z6Kgn5w4FD/5bGOcgkG4YM=;
	b=A30Bu30s/7JtmcszTHZB0ABK8Sw9NXPxXwVX52Jc1GquGGGEjblYi9tuK1UFGN9zBYIQM+
	ps8xOCsiZFFvktItQ42FuCAjwct0n2btNyY5GAMLKbUXM+Rs6/2pNUhOfxdsOr+mwGxvqC
	PXXtQbArypbCxcAly9JxISr7TJn5Lnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hpPdUGnw+xpvGmk4DPAD+Z6Kgn5w4FD/5bGOcgkG4YM=;
	b=zU/uYyf6CHO9BYZbAh/mr1pukmh88QarYLD4NgbQHUj+UpbJIEGGKNTdEAMlGkyBB0IwOg
	x9h5WmZxhVDQ55Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70C0C1364F;
	Tue, 12 Mar 2024 15:48:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4AcmGl958GUhPwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 12 Mar 2024 15:48:47 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch,
	airlied@gmail.com,
	deller@gmx.de,
	javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
Subject: [PATCH 35/43] drm/tiny/ili9341: Use fbdev-dma
Date: Tue, 12 Mar 2024 16:45:30 +0100
Message-ID: <20240312154834.26178-36-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312154834.26178-1-tzimmermann@suse.de>
References: <20240312154834.26178-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.19
X-Spamd-Result: default: False [1.19 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLw9gjjhh8cousxs3wi4trssza)];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,gmx.de,redhat.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.01)[46.86%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,suse.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
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

