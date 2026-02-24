Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB392749E6
	for <linux-fbdev@vger.kernel.org>; Tue, 24 Feb 2026 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921639; cv=none; b=hRuMj16YsNItERzr83962S58JWyQ7QQ5lxs4dCp/y84orI3pDoVrNbB3rpgosKcVIlE0eKFPL08233ZVcRsfRwr2s+znqp0xjfrK1DuDJGsFKssbMXL2s7G0PnQOqHmfX9ODPZJQQ6gYdeqWoC5aqvLrnF2Jcr/CNvSzKwbtcLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921639; c=relaxed/simple;
	bh=CsdqzifkcApu+ukXJCIxvyqse3lGMiNjrE/sE6Oc3sM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ET0sZLPrBVywvpCe29Xf352utPsgwr2/77ZhIOKCL0nVcmOT3kJxFttPUs6Ne1+pEEQMVs3r0Kas8LhOlzeyf1x1TXUjxkIhyB3h74G3slm7Wsj8r5pdhcKoVXWEgYp0cJVXfW7jM9Lt/Zqe8C1GEZh+aSPmtPwvvcxLYm9auDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Iu5IiC+N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5keyt2N1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k7pXYi5O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BkHUQjxa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Iu5IiC+N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5keyt2N1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k7pXYi5O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BkHUQjxa"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 310795BCD5;
	Tue, 24 Feb 2026 08:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771921623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mCjkASW6ZWZUc+DPfyf02czl7AULiee7mXTsK7x2OF8=;
	b=Iu5IiC+NLsoLKGnKX956c5GNWOczNko8F20E2DnygUk+9KmAx6TLzSArD1HYV04oWUMoNF
	GqpzqVaSH6P9IdUiBXCuDpdv9jDPPJajZpEr+M+PGn3/M4nFrb2Lih+8TqAk5nAja9Zfhv
	9mhGgJ6ZC+t04TjwrnUSEUdhEVo8/to=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771921623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mCjkASW6ZWZUc+DPfyf02czl7AULiee7mXTsK7x2OF8=;
	b=5keyt2N1Wep4T5HTw1kewYqu6zNsgejP57hbs3q3VCscWoQn2VaeY45vHNVHxdvNOZ/waI
	C96E2+bCEhF3MhCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=k7pXYi5O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BkHUQjxa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771921622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mCjkASW6ZWZUc+DPfyf02czl7AULiee7mXTsK7x2OF8=;
	b=k7pXYi5Op/lZTr5OLA/H/1xI8dOD0h0PvB4FAQPbLzo0x9QYN2NsuZ9hXbPnFSbLVIQUvp
	zcjWKcO7ywbCgjMk8nLUVktSTf7e2PcdTq/o9sgN0WhnHAGUZiMQGpG049IXbspeU0V57T
	vyhaBzeJSPRhWpoqVGofUkkIs9ZBe1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771921622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mCjkASW6ZWZUc+DPfyf02czl7AULiee7mXTsK7x2OF8=;
	b=BkHUQjxag6gb2Wa7MCwQugP7gsWvTkppuWHye/D9op4aCt9Q7A81wRnLWo+D0U4jtmy3c5
	XlgENaSJL097NDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E81EC3EA68;
	Tue, 24 Feb 2026 08:27:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1pc+N9VgnWnVQAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 24 Feb 2026 08:27:01 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch,
	jayalk@intworks.biz
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/4] fbdev: defio: Protect against device/module removal
Date: Tue, 24 Feb 2026 09:25:53 +0100
Message-ID: <20260224082657.207284-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmx.de,ffwll.ch,intworks.biz];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 310795BCD5

There's a long-standing bug in defio where the framebuffer device or
module gets removed while mmap'ed areas of the framebuffer memory
persists in userspace. Page faults in the area then operate on defined
state.

Patches 1 and 2 fix these problems. Patches 3 and 4 build upon the fix
and put defio state into the correct places.

v2:
- use alloc_obj() functions

Thomas Zimmermann (4):
  fbdev: defio: Disconnect deferred I/O from the lifetime of struct
    fb_info
  fbdev: defio: Keep module reference from VMAs
  fbdev: defio: Move variable state into struct fb_deferred_io_state
  fbdev: defio: Move pageref array to struct fb_deferred_io_state

 drivers/video/fbdev/core/fb_defio.c | 266 ++++++++++++++++++++--------
 include/linux/fb.h                  |   9 +-
 2 files changed, 195 insertions(+), 80 deletions(-)


base-commit: 1c44015babd759b8e5234084dffcc08a0b784333
-- 
2.52.0

