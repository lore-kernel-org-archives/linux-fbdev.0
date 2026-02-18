Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B302FE57B
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Feb 2026 08:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403951; cv=none; b=HolzL5AU339ZOU63bsmMCa3+eROKab5tAZUKaVzQ3kn6SKujzU8xrnjY7Qo/ucljZQoKDcOZMPWadVrH7l8C5132YIIxCsNuTp8rgPgWJYx1WvK37eLGxb4PPEXjPgy0FKw9QelFw2lxu49YI2gUWwxiEgLdNHRwhmgsYV1s8Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403951; c=relaxed/simple;
	bh=00id+AxL3uPm1Slbk6uY/CeVnAVCxRcjTBO6uXeNY3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MO7BD/8uM+z6XwDVE/lkC3YRprLIuZsevVZRZkpQIFiFPqB1ZCrjxYd6oJgIfoWtxISRk19yYIdhQy5YkKjW2eKzEH4Fdoaa04Wi2olK9YYpkWIkBOF47DYG75XqNvsjk6w4D6N/V2d3ep1ARnUt7GI8uQO0h3XTr3EHFaBSrds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bB1uGvDG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mMAEt0q5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bB1uGvDG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mMAEt0q5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bB1uGvDG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mMAEt0q5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bB1uGvDG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mMAEt0q5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2151B3E6F3;
	Wed, 18 Feb 2026 08:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHTcLFDIDFmcbV8Dnl4TDKco30itr077plX6MeCLa9A=;
	b=bB1uGvDGOIys4IUzjQaZs3w4t8tl4BjKb+c1VNqxpCps1D6JVtzeUmj90cPQJEgzSrwy0H
	qQnL+5QWIWI63gMxIrEHGk+EK/lmjKHl8zcU50NSCYlNvLKgRRiAegyP6fcVi4YQfpz4Ys
	f4gCs1ZQruhs6F8eJuN39CXFtw4a1RI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHTcLFDIDFmcbV8Dnl4TDKco30itr077plX6MeCLa9A=;
	b=mMAEt0q5THvMQV2uNOQRwiI4VK05HdlXJ7N0Favn1dDa20aYSw2mD3/73USV9X7+KVj+90
	bfocoGHu4NAb7SAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bB1uGvDG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mMAEt0q5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHTcLFDIDFmcbV8Dnl4TDKco30itr077plX6MeCLa9A=;
	b=bB1uGvDGOIys4IUzjQaZs3w4t8tl4BjKb+c1VNqxpCps1D6JVtzeUmj90cPQJEgzSrwy0H
	qQnL+5QWIWI63gMxIrEHGk+EK/lmjKHl8zcU50NSCYlNvLKgRRiAegyP6fcVi4YQfpz4Ys
	f4gCs1ZQruhs6F8eJuN39CXFtw4a1RI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHTcLFDIDFmcbV8Dnl4TDKco30itr077plX6MeCLa9A=;
	b=mMAEt0q5THvMQV2uNOQRwiI4VK05HdlXJ7N0Favn1dDa20aYSw2mD3/73USV9X7+KVj+90
	bfocoGHu4NAb7SAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF44A3EA67;
	Wed, 18 Feb 2026 08:39:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +PAwMad6lWn8LwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 18 Feb 2026 08:39:03 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 02/13] vt: Remove trailing whitespaces
Date: Wed, 18 Feb 2026 09:15:53 +0100
Message-ID: <20260218083855.10743-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260218083855.10743-1-tzimmermann@suse.de>
References: <20260218083855.10743-1-tzimmermann@suse.de>
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
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de,ravnborg.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 2151B3E6F3
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
2.52.0

