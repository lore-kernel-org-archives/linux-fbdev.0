Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12B971745
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515627; cv=none; b=FE5V4NkiObjFLMMBnmcUBv4SIIV5irJJ0J4Eunfzao3EujL3Ny3tkTUcYzfHRgumyKnWGY2NPbV5nKpTGhAnOr547LNiIXVb/8fXTV1rmuMNkHrjN5BT+/koYERYdCn0oVdx6IPr8cztDjmmHqwBUscmA/wWrq+E85Fu5QSJwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515627; c=relaxed/simple;
	bh=KNgrPp52NporGCIOPFu2We2+EIEjmph08OAs34xDc1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E43B9nqfohZfciverSSS19h99zcX2hM9e3XFAQsolTY8af0elWozz82KVGPOIU/r7xvAPx069b1C4boqZRoeb3/13FZJ7DmJXGLu/Qw0ciZ4u1D1pa53X6o102GMrCMJDxE4tWyjcvglyRAdO+PsfYOjy0DqwGcQ+TYIfqptXxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hYQs+jta; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=boHTzhIS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1gfhnpTb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bW3LYDfw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hYQs+jta";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="boHTzhIS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1gfhnpTb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bW3LYDfw"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D55963758B;
	Fri, 19 Apr 2024 08:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713515624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGGAvGbVYaB9xcptjF0Kg0QlQYzbIOxEpgon6uLe3lg=;
	b=hYQs+jtaciUHQDjcfZM+8O9YZT1cDvrtkB+Aa/UgVgXB98IjNAYYwH6jOPThileUewmbTq
	hDweWbumuIB04hCV2vLH60Bl++ZgKYncjDOD6lNzrANXME0UItFYx1jyemxVrs5cD2HX+X
	OcOH/y7vHsqVFjlGrnN2M6Vt2Bo7s9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713515624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGGAvGbVYaB9xcptjF0Kg0QlQYzbIOxEpgon6uLe3lg=;
	b=boHTzhIS/1/blmYxtgJlRTgIu/z86+W7E4R6CyuDamQInnW5wng4kfiuVWJx5nWXIwGyA7
	P61cbH9oOmCLzRCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713515623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGGAvGbVYaB9xcptjF0Kg0QlQYzbIOxEpgon6uLe3lg=;
	b=1gfhnpTbi7uBItScPY45Yi88scTEfIABnSuZPS1ORTbmI55pegbADPh25kI9MNOnjbVQq2
	z1DLIQMcbepgxfhMjDWtsOAVgMWj7FtE3Bbpq+MrxfmIDV8m6SlysMi/RKL5VhKeBzNxZP
	TOYkiEZ1Cp3RoebMXfu5+kVy6ywD3Tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713515623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGGAvGbVYaB9xcptjF0Kg0QlQYzbIOxEpgon6uLe3lg=;
	b=bW3LYDfwpPV8V7KaKb0/1vKT3XdFDzMYHJ4lpRugRFJ2ML2oq20NHnQONQMOpEtlg0q/kK
	SWAJlou9xp6ERvBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9619813687;
	Fri, 19 Apr 2024 08:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iCyMI2csImb9agAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 19 Apr 2024 08:33:43 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v3 30/43] drm/renesas/shmobile: Use fbdev-dma
Date: Fri, 19 Apr 2024 10:29:23 +0200
Message-ID: <20240419083331.7761-31-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[renesas];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[redhat.com,gmx.de,gmail.com,ffwll.ch];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLw9gjjhh8cousxs3wi4trssza)];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Spam-Score: -5.30
X-Spam-Flag: NO

Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
damage handling, which is required by shmobile. Avoids the overhead of
fbdev-generic's additional shadow buffering. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
index e83c3e52251de..890cc2f6408d6 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
@@ -19,7 +19,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_module.h>
@@ -250,7 +250,7 @@ static int shmob_drm_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_modeset_cleanup;
 
-	drm_fbdev_generic_setup(ddev, 16);
+	drm_fbdev_dma_setup(ddev, 16);
 
 	return 0;
 
-- 
2.44.0

