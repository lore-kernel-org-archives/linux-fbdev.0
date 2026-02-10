Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B0F34106D
	for <linux-fbdev@vger.kernel.org>; Tue, 10 Feb 2026 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716643; cv=none; b=WX9jL/ehrBpsiLFCxlDbx6j3FDfaTtYoLR5AITWKRkJKOz77NJg5qphoG9xdw7jyd8esmbbkw9CYyqhYB+6+Ae0IZqVDul1wch4ys3VU7sQM4W+ydppgCBE4wgZOX6ONy8x0fScRKeyPnt6ZGnIdZJqPSI37ecjqKa/vbBE+OcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716643; c=relaxed/simple;
	bh=e4oBOAIejDgivozAVtemprr8ZCD5VIA7jqH2Q0cKBYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DghlWWSb31FcncmEySvmVvf+SlxKzMponMuMbFvsliACvu5YHZT2lIIRIF5OAL2BM7MoN5Gfc3fO9V8F+tuEjJ9z7ZHlqEbz8VFFuSKHsg6FPqP6o6LPrKkvCiVJxv8ZMbLVa+6r1gRCMwg45McTpoms55dz0ggWBAaEXEUZvq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hcDEE08C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NmLPCIom; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hcDEE08C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NmLPCIom; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hcDEE08C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NmLPCIom";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hcDEE08C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NmLPCIom"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D94953E71A;
	Tue, 10 Feb 2026 09:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770716640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tp3/7kKxJDVlRvvsjIgvoPaEEEKscWloYkrvsVEjZHE=;
	b=hcDEE08C1a3jFjodQfaDRnjcuN0J+P4rySv94+rMLfv+dF/aQTWKSYa6SyhpwTT78lAURP
	0TItJ4I0/nE+bfPqf/sM7VCXcbz2+gcggL//B714Ea/3559juWCE7KDf7ke9oMk0eHC5mK
	P3JodqwGO09oKBRhBjiWRDJEoayF4c4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770716640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tp3/7kKxJDVlRvvsjIgvoPaEEEKscWloYkrvsVEjZHE=;
	b=NmLPCIomJCnWzsQ8lacx4be3R8WAuL51yRIPlSjT5tcdaIJXVHMT6PJMAoMBxTAEwAdDQS
	ncMcjzpe3FEiPyCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hcDEE08C;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NmLPCIom
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770716640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tp3/7kKxJDVlRvvsjIgvoPaEEEKscWloYkrvsVEjZHE=;
	b=hcDEE08C1a3jFjodQfaDRnjcuN0J+P4rySv94+rMLfv+dF/aQTWKSYa6SyhpwTT78lAURP
	0TItJ4I0/nE+bfPqf/sM7VCXcbz2+gcggL//B714Ea/3559juWCE7KDf7ke9oMk0eHC5mK
	P3JodqwGO09oKBRhBjiWRDJEoayF4c4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770716640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tp3/7kKxJDVlRvvsjIgvoPaEEEKscWloYkrvsVEjZHE=;
	b=NmLPCIomJCnWzsQ8lacx4be3R8WAuL51yRIPlSjT5tcdaIJXVHMT6PJMAoMBxTAEwAdDQS
	ncMcjzpe3FEiPyCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A77DE3EA62;
	Tue, 10 Feb 2026 09:44:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tvCqJ+D9imlbMAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 10 Feb 2026 09:44:00 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] fbcon: Declare struct fb_info.fbcon_par as of type struct fbcon_par
Date: Tue, 10 Feb 2026 10:43:32 +0100
Message-ID: <20260210094356.23645-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.de];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D94953E71A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

The only correct type for the field fbcon_par in struct fb_info
is struct fbcon_par. Declare is as such. The field is a pointer
to fbcon-private data.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/linux/fb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 65fb70382675..b8b6f54f3312 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -18,6 +18,7 @@ struct backlight_device;
 struct device;
 struct device_node;
 struct fb_info;
+struct fbcon_par;
 struct file;
 struct i2c_adapter;
 struct inode;
@@ -506,7 +507,7 @@ struct fb_info {
 #define FBINFO_STATE_RUNNING	0
 #define FBINFO_STATE_SUSPENDED	1
 	u32 state;			/* Hardware state i.e suspend */
-	void *fbcon_par;                /* fbcon use-only private area */
+	struct fbcon_par *fbcon_par;    /* fbcon use-only private area */
 	/* From here on everything is device dependent */
 	void *par;
 
-- 
2.52.0

