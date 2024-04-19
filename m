Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CFF6A8A4
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515624; cv=none; b=g7TOoY8Sbjg7gvFTemf2lQuU4rxh///0SiA6SyMz1M1ZyqsjFMb9tEIeEcvtm7xsaNBuv58ahBjC1NTEH8Btpk4YfHo3YKYwCpJD+6SMrBXjdl62ynSmb+xJwt/81vtwe6tqb7LyTJU02zkPnCbL0YJvz0YCvQrxyG3+EWHnAgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515624; c=relaxed/simple;
	bh=5CH7wMvjC2c7olRAXUGIfqcxcN0LuPY4+PVriFmG+vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McsVeJ+Zvpds2lxijIV94FAhWpw69pov/nVxefXdklRqKO6OwHWLa1bjj2ZNAFnbDZLsVNHrK66ar0okicyauPS98GtfFpwh4wVQ5+ibNIl6LKGFcdnGYowhJtANxBZRtUVvhnLOwO/8i66jOypgsipKkFJhyn6bxJQl+za809k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w0sHfMZc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7pEXFyDa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w0sHfMZc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7pEXFyDa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w0sHfMZc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7pEXFyDa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w0sHfMZc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7pEXFyDa"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 94B015D484;
	Fri, 19 Apr 2024 08:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713515619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afbPvgm0yNfC6+CogF1+0fj4xVRYC9xZOg2s9EyHJhU=;
	b=w0sHfMZca6J5aEEYI1wFM3NzFotM5dnqP2pww0gGkXS0LWbdjVkUufdPIBxPTwSpN2VCA7
	Tg6AdK9ZdVtPQrDDlNGAg15UKRnXkZVZf8GFnbvg1LHgbRvvTiRzWqtyHOFkIrvZ1W9j0L
	OYIbJF6b5Ry6/TOPAd0+g4bihM5P59c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713515619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afbPvgm0yNfC6+CogF1+0fj4xVRYC9xZOg2s9EyHJhU=;
	b=7pEXFyDazTypWDzEp+HnKu+qcILYVC4rJNjmV+LSLJtqB8PyAiULRhtgWFv5ucgGjG6gE2
	R2eqEdyywfqvAtBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713515619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afbPvgm0yNfC6+CogF1+0fj4xVRYC9xZOg2s9EyHJhU=;
	b=w0sHfMZca6J5aEEYI1wFM3NzFotM5dnqP2pww0gGkXS0LWbdjVkUufdPIBxPTwSpN2VCA7
	Tg6AdK9ZdVtPQrDDlNGAg15UKRnXkZVZf8GFnbvg1LHgbRvvTiRzWqtyHOFkIrvZ1W9j0L
	OYIbJF6b5Ry6/TOPAd0+g4bihM5P59c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713515619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afbPvgm0yNfC6+CogF1+0fj4xVRYC9xZOg2s9EyHJhU=;
	b=7pEXFyDazTypWDzEp+HnKu+qcILYVC4rJNjmV+LSLJtqB8PyAiULRhtgWFv5ucgGjG6gE2
	R2eqEdyywfqvAtBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6404D1395B;
	Fri, 19 Apr 2024 08:33:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iPI2F2MsImb9agAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 19 Apr 2024 08:33:39 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 14/43] drm/tiny/cirrus: Use fbdev-shmem
Date: Fri, 19 Apr 2024 10:29:07 +0200
Message-ID: <20240419083331.7761-15-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419083331.7761-1-tzimmermann@suse.de>
References: <20240419083331.7761-1-tzimmermann@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmx.de,gmail.com,ffwll.ch];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLw9gjjhh8cousxs3wi4trssza)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Spam-Score: -6.80
X-Spam-Flag: NO

Implement fbdev emulation with fbdev-shmem. Avoids the overhead of
fbdev-generic's additional shadow buffering. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/tiny/cirrus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
index 4e3a152f897ac..3ac4f310aa2ad 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -31,7 +31,7 @@
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_shmem.h>
 #include <drm/drm_file.h>
 #include <drm/drm_format_helper.h>
 #include <drm/drm_fourcc.h>
@@ -716,7 +716,7 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	drm_fbdev_generic_setup(dev, 16);
+	drm_fbdev_shmem_setup(dev, 16);
 	return 0;
 }
 
-- 
2.44.0

