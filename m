Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F3F38BF8C
	for <linux-fbdev@vger.kernel.org>; Mon,  9 Mar 2026 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065868; cv=none; b=Mc+A7goFQTRGCaAyJdqeuxH90I8dxXveNrHFFrUdVg4vlNr3OewaVnG3khHyIAIditAjniQyDySGERSOHbNxik71ev121XYL3DZ4Li1iSvN6HEOeH4Jl4w4XHZjqKPsJyD9qjaaWB/HUkw8vOsfjY0WkPW565+mS5xB42f1OeKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065868; c=relaxed/simple;
	bh=X7ZXt/Tvldpttx1rTGbhAfIensbsUVb6ys+73i6I5kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJTgXRHEL5oO/atO5K9gnJr+B4dAGZXnHEj6s4ZMlwAqpzr7F0kaGh0qpLK72L4LuGchOHAmFrGlZ5fKfF4J/FpphFHANccbddyZP95+zhOli1AP9FlFuPEnvY6uaK9rPRhB/4iWPKHKqoLRSxTx0GxIAFeKqUerM+df4kKkc38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gc+vRF31; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ahWOs3Hf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gc+vRF31; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ahWOs3Hf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gc+vRF31";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ahWOs3Hf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gc+vRF31";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ahWOs3Hf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 157534D240;
	Mon,  9 Mar 2026 14:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773065850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDdFaZ33ivCVSgFIvrCH2YTfOSd7wSVCMvjOyrWj3aI=;
	b=gc+vRF31JuC9HYI6e+4f+cTPYtMoJQtzKt2VJ/8KxsgYY0dj/Bv9HMQitirhq+BODlZTqF
	x2cnwUqOxQ0uuMyrdW5tPdChFRg+gzZh8RhBlDhOCPztsCi3cxDRItgZWGK65Ov3f1Nyus
	XeUdTXSyvMjFq/juiQQInFtRd/ujBz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773065850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDdFaZ33ivCVSgFIvrCH2YTfOSd7wSVCMvjOyrWj3aI=;
	b=ahWOs3HfUZeTv7C/4gW65AMbtrIc9x13oZgLixlbxtHIF6xLGwI5M/w7uIWp2XlFlkwN4J
	tg+TROozh4PWvNAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gc+vRF31;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ahWOs3Hf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773065850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDdFaZ33ivCVSgFIvrCH2YTfOSd7wSVCMvjOyrWj3aI=;
	b=gc+vRF31JuC9HYI6e+4f+cTPYtMoJQtzKt2VJ/8KxsgYY0dj/Bv9HMQitirhq+BODlZTqF
	x2cnwUqOxQ0uuMyrdW5tPdChFRg+gzZh8RhBlDhOCPztsCi3cxDRItgZWGK65Ov3f1Nyus
	XeUdTXSyvMjFq/juiQQInFtRd/ujBz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773065850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDdFaZ33ivCVSgFIvrCH2YTfOSd7wSVCMvjOyrWj3aI=;
	b=ahWOs3HfUZeTv7C/4gW65AMbtrIc9x13oZgLixlbxtHIF6xLGwI5M/w7uIWp2XlFlkwN4J
	tg+TROozh4PWvNAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF8C93EF3C;
	Mon,  9 Mar 2026 14:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8Nx5MXnWrmldPAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 09 Mar 2026 14:17:29 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 02/13] vt: Remove trailing whitespaces
Date: Mon,  9 Mar 2026 15:14:44 +0100
Message-ID: <20260309141723.137364-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309141723.137364-1-tzimmermann@suse.de>
References: <20260309141723.137364-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de,ravnborg.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Rspamd-Queue-Id: 157534D240
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Fix coding style. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/linux/console_struct.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 13b35637bd5a..ebdb9750d348 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -120,7 +120,7 @@ struct vc_data {
 	unsigned short	vc_complement_mask;	/* [#] Xor mask for mouse pointer */
 	unsigned short	vc_s_complement_mask;	/* Saved mouse pointer mask */
 	unsigned long	vc_pos;			/* Cursor address */
-	/* fonts */	
+	/* fonts */
 	unsigned short	vc_hi_font_mask;	/* [#] Attribute set for upper 256 chars of font or 0 if not supported */
 	struct console_font vc_font;		/* Current VC font set */
 	unsigned short	vc_video_erase_char;	/* Background erase character */
-- 
2.53.0

