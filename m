Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0184346A0D
	for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063692; cv=none; b=Lx0P5kZyfho0a61RFRlAKDs0BKZV6iUg7jzBtlUwHw5cLVERYxeUDFD5lPwdUKh1kZ6R/6S1fd14+7xskzN8hCH4CcUcjdac/Y39IXx4jtZ9HOZoSe31GFKr83bu6/R9fkg/K/MoMcYw722u1IypEF5jot952JOn21tBxt522Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063692; c=relaxed/simple;
	bh=+OmBzl3zbS5jsPoLJ8D6C0yKZ9xFDUINQ7Y81CNS7bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuEJpxIdJM2RN+3qDocL/5g4gMfl7TG1b+zMTEW3CrCwBPNp4OgQtbG7jx9bx9oLLkCGOd4iuSngaEIUwJP16MKy6VahrrBNUCqYUG0K2Idw7qiNH1lwcA2BDIhT9N7iRBgX6/PIX2prKT/NljkCnM8w7CFNXi2o20Edvmyo5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cz/ILdQ0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g+3mLFG1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cz/ILdQ0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g+3mLFG1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cz/ILdQ0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g+3mLFG1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cz/ILdQ0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g+3mLFG1"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6ABA36AD77;
	Fri, 29 May 2026 14:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780063684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XqeIkKhg3iLXG98oLAZmvKZstFgR2UqUAG/0vaT0+Ak=;
	b=cz/ILdQ0U8xlwX9GYdI9opakwbCAo2cfDPEli1rStTM3O06mbRyyamTj+vvmDKlyP69cfz
	X0zbn5Gbb52pVq2AW9uW0gpMXpxkMO2yn7OcrZkjAIcRbjxHglrJNWk8zKVNr1JcwoA5lB
	Z8vwF7zQJ3DP+/0Yusyz8CxasovRGCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780063684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XqeIkKhg3iLXG98oLAZmvKZstFgR2UqUAG/0vaT0+Ak=;
	b=g+3mLFG1LOmQGpIVsoG4+QKma0zB6tDnyos+2VMQ4Gm1pVIWywqxMzZzXpko2d40oubdOQ
	L8S3ro6APRsEGoDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="cz/ILdQ0";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=g+3mLFG1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780063684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XqeIkKhg3iLXG98oLAZmvKZstFgR2UqUAG/0vaT0+Ak=;
	b=cz/ILdQ0U8xlwX9GYdI9opakwbCAo2cfDPEli1rStTM3O06mbRyyamTj+vvmDKlyP69cfz
	X0zbn5Gbb52pVq2AW9uW0gpMXpxkMO2yn7OcrZkjAIcRbjxHglrJNWk8zKVNr1JcwoA5lB
	Z8vwF7zQJ3DP+/0Yusyz8CxasovRGCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780063684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XqeIkKhg3iLXG98oLAZmvKZstFgR2UqUAG/0vaT0+Ak=;
	b=g+3mLFG1LOmQGpIVsoG4+QKma0zB6tDnyos+2VMQ4Gm1pVIWywqxMzZzXpko2d40oubdOQ
	L8S3ro6APRsEGoDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26D8B779A7;
	Fri, 29 May 2026 14:08:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cMYbCMSdGWoybAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 29 May 2026 14:08:04 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com,
	javierm@redhat.com,
	deller@gmx.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/4] drm/client: log: Look up glyph shape with font helper
Date: Fri, 29 May 2026 16:01:24 +0200
Message-ID: <20260529140759.529929-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529140759.529929-1-tzimmermann@suse.de>
References: <20260529140759.529929-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6ABA36AD77
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmx.de,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,suse.de:mid];
	RCPT_COUNT_SEVEN(0.00)[10];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -3.01

Look up glyph shapes with font_data_glyph_buf(). Handle non-existing
glyphs gracefully. Enable extended ASCII by casting to unsigned char.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/clients/drm_log.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
index 8d21b785bead..e3e02c84a4cf 100644
--- a/drivers/gpu/drm/clients/drm_log.c
+++ b/drivers/gpu/drm/clients/drm_log.c
@@ -122,10 +122,12 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
 	iosys_map_incr(&map, r.y1 * fb->pitches[0]);
 	for (i = 0; i < len && i < scanout->columns; i++) {
 		u32 color = (i < prefix_len) ? scanout->prefix_color : scanout->front_color;
-		src = drm_draw_get_char_bitmap(font, s[i], font_pitch);
-		drm_log_blit(&map, fb->pitches[0], src, font_pitch,
-			     scanout->scaled_font_h, scanout->scaled_font_w,
-			     px_width, color);
+		src = font_data_glyph_buf(font->data, font->width, font->height,
+					  (unsigned char)s[i]);
+		if (src)
+			drm_log_blit(&map, fb->pitches[0], src, font_pitch,
+				     scanout->scaled_font_h, scanout->scaled_font_w,
+				     px_width, color);
 		iosys_map_incr(&map, scanout->scaled_font_w * px_width);
 	}
 
-- 
2.54.0

