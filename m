Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3244C51004
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515620; cv=none; b=W3fIRzAS7mVhRnf0y8Pa4jDxR2uN6YRbgyxVukp8crxyE6jB/oCetN0vw66O9bVN7pV2AImgqUpnUyGc/khkpgmAgpmZvKz7nIW2C/C/EBhyVyRVK3niQeBIFq4QC6Z5h+cMnFLnOlVlQ0VONh19CnXz0soj/KJap4EkG+5sREo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515620; c=relaxed/simple;
	bh=6NHhI1/f36d9+0rpkVWqt23p9nfGPylkEaPSwhRQz1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7taf2Fpa7FWIjc8uVigLFGCdHOFG8CPMF+dhhb7FLIKPgq2nhaoCtAk0dufXSlzj3ahQYxLtcYilBEGCtuJ/jiGbJ+mHNAmEUg3vSphGzf4JFNxgth29dvJXiNjYPmio5UiE+adAxTXWxS9fgz1OghwKM99xf+3nZQXTzXj0hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ltKKSG50; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U34I+b7p; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ltKKSG50; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U34I+b7p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ltKKSG50";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U34I+b7p";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ltKKSG50";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U34I+b7p"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 499673757F;
	Fri, 19 Apr 2024 08:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713515617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6oNAN117oUsDvrSMdXnfdZZrJ5BgRROAhbs+ZdDMtKU=;
	b=ltKKSG50lf+JUmjugpDz1WDZqXfoU4bYwaVp5//WLvbb2Woxn29IkEoxXwA+KEzS1yvLNA
	tiMfrKANqI3sYVyJihR1fwBicb0WBzD4TDr/BpmwET1HoJ+A9SrStuj3Fkt6Ffo3NUHoCc
	uf1UhpPfeHxHeImrpG6bgIJLS6p0+Ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713515617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6oNAN117oUsDvrSMdXnfdZZrJ5BgRROAhbs+ZdDMtKU=;
	b=U34I+b7p+NcxSPh5y8lSP/f48hskvJJkpZ+jj8riAN8uPC9r1ny5JQ122VGsFgwPR4TV9K
	S/xHyjWDVfuPACAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ltKKSG50;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=U34I+b7p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713515617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6oNAN117oUsDvrSMdXnfdZZrJ5BgRROAhbs+ZdDMtKU=;
	b=ltKKSG50lf+JUmjugpDz1WDZqXfoU4bYwaVp5//WLvbb2Woxn29IkEoxXwA+KEzS1yvLNA
	tiMfrKANqI3sYVyJihR1fwBicb0WBzD4TDr/BpmwET1HoJ+A9SrStuj3Fkt6Ffo3NUHoCc
	uf1UhpPfeHxHeImrpG6bgIJLS6p0+Ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713515617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6oNAN117oUsDvrSMdXnfdZZrJ5BgRROAhbs+ZdDMtKU=;
	b=U34I+b7p+NcxSPh5y8lSP/f48hskvJJkpZ+jj8riAN8uPC9r1ny5JQ122VGsFgwPR4TV9K
	S/xHyjWDVfuPACAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 160951398D;
	Fri, 19 Apr 2024 08:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EOgwBGEsImb9agAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 19 Apr 2024 08:33:37 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 04/43] fbdev/deferred-io: Test screen_buffer for vmalloc'ed memory
Date: Fri, 19 Apr 2024 10:28:57 +0200
Message-ID: <20240419083331.7761-5-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[redhat.com,gmx.de,gmail.com,ffwll.ch];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 499673757F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

Framebuffers in virtual memory are available via screen_buffer. Use
it instead of screen_base and avoid the type casting.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/video/fbdev/core/fb_defio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index f23b1cbe67192..b38f775cd39dd 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -25,11 +25,11 @@
 
 static struct page *fb_deferred_io_page(struct fb_info *info, unsigned long offs)
 {
-	void *screen_base = (void __force *) info->screen_base;
+	const void *screen_buffer = info->screen_buffer;
 	struct page *page;
 
-	if (is_vmalloc_addr(screen_base + offs))
-		page = vmalloc_to_page(screen_base + offs);
+	if (is_vmalloc_addr(screen_buffer + offs))
+		page = vmalloc_to_page(screen_buffer + offs);
 	else
 		page = pfn_to_page((info->fix.smem_start + offs) >> PAGE_SHIFT);
 
-- 
2.44.0

