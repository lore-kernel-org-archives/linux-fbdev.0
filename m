Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34866EB72
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515627; cv=none; b=r99cnQwIo9xqeDCbDrCp54S5qlkKx6XTaszjI+uoRDrE1RSQVuDuXVSy4I/XH14CxusAnmTKhbv7aGIxbxC9zMrl/QWTv6NuB7Lxg7a2AsPVI2eYdegZyFWyS0BpVD41Tzion5MFD2YXfIQZ0Nh7qTz86CMO6O4IMn9ilMlxlT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515627; c=relaxed/simple;
	bh=ziwD3gaqwndqK4F+TyPUntjJAUmuFO97ZTswkhlXCQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eb0rP6p0vNKOdC0snO42VnWcGlXRBJJVeedkFB+p2d3wQhvGyY4ye5EonaYKCQiwozzkp6Ek5MakCd4XsE0ktPbwd77ys+HQnPnhBMw+v4xcV3yckYAcaQXspJ710//j1aLjq9T6SehMdov2WG9UsyVIF405ccnAlJiTBmud1ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ohfR/Rrp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G8m1TjD5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ohfR/Rrp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G8m1TjD5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ohfR/Rrp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G8m1TjD5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ohfR/Rrp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G8m1TjD5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 120775D48E;
	Fri, 19 Apr 2024 08:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713515623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SduLfHh1/msN9DfJHhOWfMJlKX+C+uQF/p9+p2PybNo=;
	b=ohfR/RrpUhZbb5G3kd6JZqAXVJqrgu/y2VflkAhkchs/D0zmLDbr9vLjNyOr0XcSzZcVki
	LtxnJrlU+TlVf4FcF7SD/tHTV3CYAMJeG7aBxMqqCGH+RvO0iVIk15NmQsYJ8cfc3g3Rnl
	nZIzy7vQuotvrsInQHRujhKRbUrRkgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713515623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SduLfHh1/msN9DfJHhOWfMJlKX+C+uQF/p9+p2PybNo=;
	b=G8m1TjD5nQuS68d7kkrIVjSBYUb2jeg4k9Bn0Y7nqIAGBgsfcjwIsh27VgOANVYHN3/JcP
	mNzRysxkCGhY8SDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713515623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SduLfHh1/msN9DfJHhOWfMJlKX+C+uQF/p9+p2PybNo=;
	b=ohfR/RrpUhZbb5G3kd6JZqAXVJqrgu/y2VflkAhkchs/D0zmLDbr9vLjNyOr0XcSzZcVki
	LtxnJrlU+TlVf4FcF7SD/tHTV3CYAMJeG7aBxMqqCGH+RvO0iVIk15NmQsYJ8cfc3g3Rnl
	nZIzy7vQuotvrsInQHRujhKRbUrRkgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713515623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SduLfHh1/msN9DfJHhOWfMJlKX+C+uQF/p9+p2PybNo=;
	b=G8m1TjD5nQuS68d7kkrIVjSBYUb2jeg4k9Bn0Y7nqIAGBgsfcjwIsh27VgOANVYHN3/JcP
	mNzRysxkCGhY8SDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C84B413687;
	Fri, 19 Apr 2024 08:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UI+5L2YsImb9agAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 19 Apr 2024 08:33:42 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 27/43] drm/panel/panel-ilitek-9341: Use fbdev-dma
Date: Fri, 19 Apr 2024 10:29:20 +0200
Message-ID: <20240419083331.7761-28-tzimmermann@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -6.80
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLw9gjjhh8cousxs3wi4trssza)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]

Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
damage handling, which is required by panel-ilitek-9341. Avoids
the overhead of fbdev-generic's additional shadow buffering. No
functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
index 3574681891e81..89830582b5d79 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
@@ -31,7 +31,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
@@ -650,7 +650,7 @@ static int ili9341_dbi_probe(struct spi_device *spi, struct gpio_desc *dc,
 
 	spi_set_drvdata(spi, drm);
 
-	drm_fbdev_generic_setup(drm, 0);
+	drm_fbdev_dma_setup(drm, 0);
 
 	return 0;
 }
-- 
2.44.0

