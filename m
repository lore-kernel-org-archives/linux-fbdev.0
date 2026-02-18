Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49373329E60
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Feb 2026 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403968; cv=none; b=UDGktBxgRUWyVsfxgG261HmvjZtDK9NyxBU4Z11xGOjPib0/rx8xTEshk6s77xU3RXgIHdOeSY1V5zXI5TYqFlkvPy2iZf3IqIGax19z1uTMY5Jj2t0ZbTZPdEXTdCASwmvtgAGxx9WtxU2MsMwMWGtYRPnktYFhDMq+xRRgCw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403968; c=relaxed/simple;
	bh=/Pswo3sVRK5U6GR/xBDZyJKJHLDw/miTuP5+9/w6DB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYIehwhK3lsVxJX4Y5EvdoAb0MffYQZu13akCmlzV/WZOg5K0cztrctUp1vhGJ8tsh2yiZ8TMH7xH0Xvc55PgpfHDirDXIMT1AHej41gwwGrt/EISlS5g1CAaIh6HIGNQD14sRXjA9UknFmUoGRcs5ffrw+JjCDZxh6BsBrsii0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MZAlZLLl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m0TIHxy4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MZAlZLLl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m0TIHxy4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MZAlZLLl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m0TIHxy4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MZAlZLLl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m0TIHxy4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 244BD3E6FA;
	Wed, 18 Feb 2026 08:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aomxNFQXVshb7d7YZZSQ/RbBFSjsS+YpZCnHEOnjtDU=;
	b=MZAlZLLlYY4uc4FaSN+zvv3aFWksyIxjTohOihOxegOjHy/2tlBeoDyRZV+ckpQ8Pot63j
	ozSt+U7XrJ1+jsZxwxe4CW/iRWE7mL9DilaYA1imilotwola9q5ng6XfwNApZA5l5Wz90s
	tVdkYCfXzYdgvTK0jyFDCRn2DTyb9gA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aomxNFQXVshb7d7YZZSQ/RbBFSjsS+YpZCnHEOnjtDU=;
	b=m0TIHxy4nA0fjyL5DAnnOLdiWYe1IxUn5VT/wbuPJUFPy3SPwsm8Lqo+eOt8rwA83d6bAy
	CZ912bmrRBXY91CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aomxNFQXVshb7d7YZZSQ/RbBFSjsS+YpZCnHEOnjtDU=;
	b=MZAlZLLlYY4uc4FaSN+zvv3aFWksyIxjTohOihOxegOjHy/2tlBeoDyRZV+ckpQ8Pot63j
	ozSt+U7XrJ1+jsZxwxe4CW/iRWE7mL9DilaYA1imilotwola9q5ng6XfwNApZA5l5Wz90s
	tVdkYCfXzYdgvTK0jyFDCRn2DTyb9gA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aomxNFQXVshb7d7YZZSQ/RbBFSjsS+YpZCnHEOnjtDU=;
	b=m0TIHxy4nA0fjyL5DAnnOLdiWYe1IxUn5VT/wbuPJUFPy3SPwsm8Lqo+eOt8rwA83d6bAy
	CZ912bmrRBXY91CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D66483EA67;
	Wed, 18 Feb 2026 08:39:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CG/YMqh6lWn8LwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 18 Feb 2026 08:39:04 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 06/13] lib/fonts: Remove FNTCHARCNT()
Date: Wed, 18 Feb 2026 09:15:57 +0100
Message-ID: <20260218083855.10743-7-tzimmermann@suse.de>
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
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de,ravnborg.org];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO

The character count in the font data is unused. The internal fonts also
do not set it. Remove FNTCHARCNT().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/console/newport_con.c | 1 -
 include/linux/font.h                | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index a474c5e8e97e..6e9d61791888 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -516,7 +516,6 @@ static int newport_set_font(int unit, const struct console_font *op,
 
 	new_data += FONT_EXTRA_WORDS * sizeof(int);
 	FNTSIZE(new_data) = size;
-	FNTCHARCNT(new_data) = op->charcount;
 	REFCOUNT(new_data) = 0;	/* usage counter */
 	FNTSUM(new_data) = 0;
 
diff --git a/include/linux/font.h b/include/linux/font.h
index fd8625cd76b2..d929c5fa32ca 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -68,7 +68,6 @@ extern const struct font_desc *get_default_font(int xres, int yres,
 /* Extra word getters */
 #define REFCOUNT(fd)	(((int *)(fd))[-1])
 #define FNTSIZE(fd)	(((int *)(fd))[-2])
-#define FNTCHARCNT(fd)	(((int *)(fd))[-3])
 #define FNTSUM(fd)	(((int *)(fd))[-4])
 
 #define FONT_EXTRA_WORDS 4
-- 
2.52.0

