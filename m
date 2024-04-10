Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0382515B14E
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Apr 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754364; cv=none; b=R2hVRPr5Iiy5AaymH5JjdohDdiVIDQx5IKYG+glVutyPIMijjcZ9BDIRuWnGBKX/9/fE0SkiyBsqvB51vg9/lVM3oPVDPIzxwSF0ho2CjKH3OknKFWZ9TePl7MkWPvXg4ps3BzKAhUY7wGcUtV9nfSa3/J0/V8KgIacDhfuQjYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754364; c=relaxed/simple;
	bh=aoAyl9uUBor5Ms1PjmZhxmhCuzQMuXTC9By0YNdJai8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYV7YKesGRafpTsYPLfu/h6PQsSqtTdqcg3p0bqRGfp6FZMD3zKLIs4V3k2KPTl67wT532mjImR+Wwxuve/i+kXjuLZJTRNofUElnn/B9SSWWPb8V7ehR+tIN5ZoxlxfN3ffXH1HEYELizVSMrzWVgIe/Szqx7TXFB7mKFd/BZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gKq1mHHR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GqAbux8C; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gKq1mHHR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GqAbux8C; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gKq1mHHR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GqAbux8C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gKq1mHHR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GqAbux8C"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 11E58351E8;
	Wed, 10 Apr 2024 13:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712754361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yrVBVglS97iHpP8gqzH1FRofta6fhlXrGDfZ5OHWQg=;
	b=gKq1mHHRgKOp3wIokvBSs0Joj8Mo0VRpoya2QqeRGHhosAP8OiLnYtAGKNN+2Ne0sCIahV
	ayDvQs5htVVtVIYflCxfpEpEkXEZRti9jeG6X7wfA4TQgDLffpk2SaVbwjRsYdzFB09qss
	JyMVkF9LgU1pj0jpN30YxhJGx7CTnXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712754361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yrVBVglS97iHpP8gqzH1FRofta6fhlXrGDfZ5OHWQg=;
	b=GqAbux8CGYn2s6aHcCa6+KoRSCFRo3RhYCrzqjWFULjhDxuCxpSwz88qODm49oco+kISep
	+Fa0LlIAr++IhwCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712754361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yrVBVglS97iHpP8gqzH1FRofta6fhlXrGDfZ5OHWQg=;
	b=gKq1mHHRgKOp3wIokvBSs0Joj8Mo0VRpoya2QqeRGHhosAP8OiLnYtAGKNN+2Ne0sCIahV
	ayDvQs5htVVtVIYflCxfpEpEkXEZRti9jeG6X7wfA4TQgDLffpk2SaVbwjRsYdzFB09qss
	JyMVkF9LgU1pj0jpN30YxhJGx7CTnXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712754361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yrVBVglS97iHpP8gqzH1FRofta6fhlXrGDfZ5OHWQg=;
	b=GqAbux8CGYn2s6aHcCa6+KoRSCFRo3RhYCrzqjWFULjhDxuCxpSwz88qODm49oco+kISep
	+Fa0LlIAr++IhwCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D5C3D1390D;
	Wed, 10 Apr 2024 13:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IJrlMriOFmYdEgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Apr 2024 13:06:00 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 07/43] fbdev/deferred-io: Provide get_page hook in struct fb_deferred_io
Date: Wed, 10 Apr 2024 15:02:03 +0200
Message-ID: <20240410130557.31572-8-tzimmermann@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Spam-Score: -6.80
X-Spam-Flag: NO

Add a callback for drivers to provide framebuffer pages to fbdev's
deferred-I/O helpers. Implementations need to acquire a reference on
the page before returning it. Returning NULL generates a SIGBUS
signal.

This will be useful for DRM's fbdev emulation with GEM-shmem buffer
objects.

v2:
- fix typo in commit message (Javier)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/video/fbdev/core/fb_defio.c | 4 ++++
 include/linux/fb.h                  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index 6e0bbcfdb01b5..51928ff7961a5 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -25,9 +25,13 @@
 
 static struct page *fb_deferred_io_get_page(struct fb_info *info, unsigned long offs)
 {
+	struct fb_deferred_io *fbdefio = info->fbdefio;
 	const void *screen_buffer = info->screen_buffer;
 	struct page *page = NULL;
 
+	if (fbdefio->get_page)
+		return fbdefio->get_page(info, offs);
+
 	if (is_vmalloc_addr(screen_buffer + offs))
 		page = vmalloc_to_page(screen_buffer + offs);
 	else if (info->fix.smem_start)
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 3417103885e27..4eb6afa93737c 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -225,6 +225,7 @@ struct fb_deferred_io {
 	struct mutex lock; /* mutex that protects the pageref list */
 	struct list_head pagereflist; /* list of pagerefs for touched pages */
 	/* callback */
+	struct page *(*get_page)(struct fb_info *info, unsigned long offset);
 	void (*deferred_io)(struct fb_info *info, struct list_head *pagelist);
 };
 #endif
-- 
2.44.0

