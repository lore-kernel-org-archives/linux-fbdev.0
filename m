Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886E033EB1C
	for <linux-fbdev@vger.kernel.org>; Tue,  9 Sep 2025 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422153; cv=none; b=F9brCJFuCKl3lF3T7zgCDtj1M4sN/wtNA+wYg3T9D7Qr+SSG1lzwllqNxIdUAj2Skb5KFTQEo6oFm8dAjTpPtVZQ/PTRhqha49b6F6oSY0Z++fx+HUgoTbDWToj8x6pX7Bgl5oAW4m4359IcJPbWO8cZUx1mWdnCMPFoXvtU+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422153; c=relaxed/simple;
	bh=jFTFkBdeUmrgMiNd5kCssdxObQfxExXXABln9vTuyG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABfbjSDG3iFEGiLUkQg4a1qes/sKNlSjQ9oJEvgVuvQw6Pi/AQUmEIKKXEiQALrTqFYHu8gJbyen0ocYjUI9c4xEvcbZ2rd+Ybn6hPIBoX8MBlMDclY15cuFvXJsr7ocDXM1F8zT70Jl9Y/b/8Rbfz42wLZQ6FenGsgfnYXbpXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MY4zDBU/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3e6eDYNZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MY4zDBU/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3e6eDYNZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MY4zDBU/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3e6eDYNZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MY4zDBU/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3e6eDYNZ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3608920AC2;
	Tue,  9 Sep 2025 12:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757422144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0HvIyf9fblBRJJsPTgmzAyP2FHmBSKfV09sfj/n55A=;
	b=MY4zDBU/pm0M8yGjL7mhWamUc8chewhM2UN0E8AueCuwGB8Z7/52lWo9Et94wwTH1PVe1u
	9RAOKWZvM4C1QQb8NHF/xnyFElFTQGtI1x91ynGSc+ugl2+aFafJ9wtL1poxwgh7NFzu22
	nv4uZupKOwfmIdTW+c/4H4NndnOqIYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757422144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0HvIyf9fblBRJJsPTgmzAyP2FHmBSKfV09sfj/n55A=;
	b=3e6eDYNZ/nGkoMHXPcX18f8vsalZ4zuxB1G9waIIO6NGRs/J4tKutbP1P8K6tTljAyHNhL
	e231ExLbFXLf+kDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="MY4zDBU/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3e6eDYNZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757422144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0HvIyf9fblBRJJsPTgmzAyP2FHmBSKfV09sfj/n55A=;
	b=MY4zDBU/pm0M8yGjL7mhWamUc8chewhM2UN0E8AueCuwGB8Z7/52lWo9Et94wwTH1PVe1u
	9RAOKWZvM4C1QQb8NHF/xnyFElFTQGtI1x91ynGSc+ugl2+aFafJ9wtL1poxwgh7NFzu22
	nv4uZupKOwfmIdTW+c/4H4NndnOqIYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757422144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0HvIyf9fblBRJJsPTgmzAyP2FHmBSKfV09sfj/n55A=;
	b=3e6eDYNZ/nGkoMHXPcX18f8vsalZ4zuxB1G9waIIO6NGRs/J4tKutbP1P8K6tTljAyHNhL
	e231ExLbFXLf+kDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F18A513A56;
	Tue,  9 Sep 2025 12:49:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eBTBOT8iwGilUAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 09 Sep 2025 12:49:03 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: sam@ravnborg.org,
	simona@ffwll.ch,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 1/5] fbcon: Fix empty lines in fbcon.h
Date: Tue,  9 Sep 2025 14:44:41 +0200
Message-ID: <20250909124616.143365-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909124616.143365-1-tzimmermann@suse.de>
References: <20250909124616.143365-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3608920AC2
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[ravnborg.org,ffwll.ch,gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Score: -3.01

Add and remove empty lines as necessary to fix coding style. No
functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/video/fbdev/core/fbcon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 4d97e6d8a16a..c535d8f84356 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -87,6 +87,7 @@ struct fbcon_ops {
 	u32    cursor_size;
 	u32    fd_size;
 };
+
     /*
      *  Attribute Decoding
      */
@@ -106,7 +107,6 @@ struct fbcon_ops {
 	((s) & 0x400)
 #define attr_blink(s) \
 	((s) & 0x8000)
-	
 
 static inline int mono_col(const struct fb_info *info)
 {
-- 
2.51.0

