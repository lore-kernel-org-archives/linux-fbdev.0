Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C0C15B990
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Apr 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754365; cv=none; b=Pfk29plWqQgl55WScbFeZnul3vatJRDTvtE52t40gZyhkLm2JSbPrHwinI1YisBS8ekToVjuLRgib8GqrZh6DKtWEW5EPOsLlNHDe7Q4RoO6tYrDecB2RPDg1iDhqMxiqZaXsM4qAbLRYQcTc5T/d4T1FhTxohA7FmlyoeqGSCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754365; c=relaxed/simple;
	bh=6NHhI1/f36d9+0rpkVWqt23p9nfGPylkEaPSwhRQz1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4E5squuQy6pGbsxqJIKDOQ4do/6kT+uEbo4YRKwcadRYNKFsdZYN5V1H4X+ay80PEdgDgIwgpdjBn/nvLANwEsUgevnDov7U1EVntEzTRl5qty7BKHsCZY0itJ7GciGO+cuxkidiONd6TZKT5tfJkCAD3jYQb2oxSmO2McOYTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xLLDlWr1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L6AeWC0N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xLLDlWr1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L6AeWC0N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xLLDlWr1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L6AeWC0N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xLLDlWr1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L6AeWC0N"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 60B80351E6;
	Wed, 10 Apr 2024 13:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712754360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6oNAN117oUsDvrSMdXnfdZZrJ5BgRROAhbs+ZdDMtKU=;
	b=xLLDlWr1mpxQe9XjaH8scDRlb+6dZrA4vcIUCRZ+dgIKFKK33Uo3YxPPU01bbnQBAM/tNI
	QuYJO07GdScuo4KOlPD3QXzzSCSJ+H7ODwkOscT5qgZ4lIqVzh5cIa3tBNE8sgeZW4FK/X
	OzKMmYRhzgcU51Z0IQ9PIBc3ko2BrSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712754360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6oNAN117oUsDvrSMdXnfdZZrJ5BgRROAhbs+ZdDMtKU=;
	b=L6AeWC0NPfjnxOV4KRMarH345/4Gn1leJPXLSB0fR+Gaa77IAGYtMUW1yij2ID7kcEdhjn
	TdzRy08IRxOiQxDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xLLDlWr1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=L6AeWC0N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712754360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6oNAN117oUsDvrSMdXnfdZZrJ5BgRROAhbs+ZdDMtKU=;
	b=xLLDlWr1mpxQe9XjaH8scDRlb+6dZrA4vcIUCRZ+dgIKFKK33Uo3YxPPU01bbnQBAM/tNI
	QuYJO07GdScuo4KOlPD3QXzzSCSJ+H7ODwkOscT5qgZ4lIqVzh5cIa3tBNE8sgeZW4FK/X
	OzKMmYRhzgcU51Z0IQ9PIBc3ko2BrSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712754360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6oNAN117oUsDvrSMdXnfdZZrJ5BgRROAhbs+ZdDMtKU=;
	b=L6AeWC0NPfjnxOV4KRMarH345/4Gn1leJPXLSB0fR+Gaa77IAGYtMUW1yij2ID7kcEdhjn
	TdzRy08IRxOiQxDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 29A1013AB8;
	Wed, 10 Apr 2024 13:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QJXgCLiOFmYdEgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Apr 2024 13:06:00 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 04/43] fbdev/deferred-io: Test screen_buffer for vmalloc'ed memory
Date: Wed, 10 Apr 2024 15:02:00 +0200
Message-ID: <20240410130557.31572-5-tzimmermann@suse.de>
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
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-0.62 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	BAYES_HAM(-0.61)[82.00%];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[redhat.com,gmx.de,gmail.com,ffwll.ch];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	RCPT_COUNT_SEVEN(0.00)[7];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Rspamd-Queue-Id: 60B80351E6
X-Spam-Flag: NO
X-Spam-Score: -0.62
X-Spamd-Bar: /

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

