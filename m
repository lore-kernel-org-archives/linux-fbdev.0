Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17A815E219
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Apr 2024 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754368; cv=none; b=Z4y4nQ5g8zgOQyMF+V0cfz9YphZbpr+NblPWx1NypJTdKNug1y7cdqh1yTspoAK8+5mP8DZh41iHh3CT7jh3BNkInetbtzq/XrhUGJDH+Az79KR3SVy08tmjiCOaQFksgHNthZpeX8kCFpGlpvr5Uezk22c0ZBgbEovSEQy0lm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754368; c=relaxed/simple;
	bh=IFhD+5LGE4alpHniELdYqbd4kMMEbHZyf2k0sw6vTEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJVszJBvswbzZifO+ZhhmOctmVg4ewnDoFQLvqFeAiN6GhDj6HJ2mytiK5bbdkOm3vSQM/QrnuPm/LKAZwoFmgpudd+CxqRfJSnlmtu14NpJ0dS51oZnlZ/FiUcRKK4TwVwbT3dIL5oEHcjlcC5FJgvyJTtILibIl5HGSJFYrU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RmLG5+1O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YFfcrrK1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RmLG5+1O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YFfcrrK1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RmLG5+1O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YFfcrrK1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RmLG5+1O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YFfcrrK1"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 424C8351EE;
	Wed, 10 Apr 2024 13:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712754363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2jHIkDmzWvavk2BwDCb9/9KF5s8gyqWL5O8YJiha34=;
	b=RmLG5+1OY1928iC7N83KXTnJo70yEvWQdy71khmYaKYO9a/55AcZVZzTCGPuSkMNJeTVZA
	eEgWsBR62f+65N7cpIP7x44qy5g/kDtWk/7NMXeEaeVsQJU843OKdS229n6v+J6EDqgauh
	bSvDUiXbQK27BW9/M8kwHB40pzhI268=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712754363;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2jHIkDmzWvavk2BwDCb9/9KF5s8gyqWL5O8YJiha34=;
	b=YFfcrrK19UX6WDov8jhPHI00rd+KfEgJ36+L4nl31TsI0kP/2/DUXW3g84rc4/5SmuYkqx
	5vBAZ6Ee+uPIw4Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712754363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2jHIkDmzWvavk2BwDCb9/9KF5s8gyqWL5O8YJiha34=;
	b=RmLG5+1OY1928iC7N83KXTnJo70yEvWQdy71khmYaKYO9a/55AcZVZzTCGPuSkMNJeTVZA
	eEgWsBR62f+65N7cpIP7x44qy5g/kDtWk/7NMXeEaeVsQJU843OKdS229n6v+J6EDqgauh
	bSvDUiXbQK27BW9/M8kwHB40pzhI268=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712754363;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2jHIkDmzWvavk2BwDCb9/9KF5s8gyqWL5O8YJiha34=;
	b=YFfcrrK19UX6WDov8jhPHI00rd+KfEgJ36+L4nl31TsI0kP/2/DUXW3g84rc4/5SmuYkqx
	5vBAZ6Ee+uPIw4Bg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 104FD13A94;
	Wed, 10 Apr 2024 13:06:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GDnPAruOFmYdEgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Apr 2024 13:06:03 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 16/43] drm/tiny/ofdrm: Use fbdev-shmem
Date: Wed, 10 Apr 2024 15:02:12 +0200
Message-ID: <20240410130557.31572-17-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[redhat.com,gmx.de,gmail.com,ffwll.ch];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:email];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Spam-Score: -6.80
X-Spam-Flag: NO

Implement fbdev emulation with fbdev-shmem. Avoids the overhead of
fbdev-generic's additional shadow buffering. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/tiny/ofdrm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/ofdrm.c b/drivers/gpu/drm/tiny/ofdrm.c
index ab89b7fc7bf61..35996f7eedac0 100644
--- a/drivers/gpu/drm/tiny/ofdrm.c
+++ b/drivers/gpu/drm/tiny/ofdrm.c
@@ -11,7 +11,7 @@
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_shmem.h>
 #include <drm/drm_format_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -1377,7 +1377,7 @@ static int ofdrm_probe(struct platform_device *pdev)
 	if (color_mode == 16)
 		color_mode = odev->format->depth; // can be 15 or 16
 
-	drm_fbdev_generic_setup(dev, color_mode);
+	drm_fbdev_shmem_setup(dev, color_mode);
 
 	return 0;
 }
-- 
2.44.0

