Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108216;
	b=TgAP21V1siw0B4ehoG3NIoILhqaGZHQnGwG7Pw0/Eax3zVE/HxR3Yowl10UZarnfA/bm
	 0SgPyRsF9uLk7BRv2XMBbZTQW6Us2b3prpnvbK0CK4y2SwHG2Q91KYn0Gu2PP+fjWmLz8
	 NPXV9/zk4+VrdnVuKiNOXz0X6GfFYHnfCfMc1pQDVotQ8gyaVzgMNh/1M/bI9sKSLWuao
	 m7sVtHFfxWoNqUaM1sb5pbTvzuhsUmrt7fcMbBWKGGP1luo93EgGTwa8128qv5YGZtMjm
	 o4WICHzCp1DQiexL2xiSG6mMd9DD1UWRCfWpf3kVFb1WxZpm3tinOajamq1oW8IJu9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108216;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Spam-Flag:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=gg6aR7KxYa7HADZSZwVdPxH+tm3LLgRgSzh99g2OM+w=;
	b=Bh59ChGMeOeJ5e0hVgIW82a8Mtjy4D4k+3orMqa4RPpMIKijwmA7WXDeg6PDcbmqBAIr
	 JO++CNyN2/cJpcvJFr2gUmkISgut8SWOGacC1Ey+F0JnAZhP3+VIX/u75McYdeDLFruCU
	 b9mVHrsEJHVd3R3icGBYliyav9/IQAezGuzle20UrCTkCwIjFdnitaVvP8bhx6SnzIniK
	 EyBLp8pv7emVd4z2TlWR59UeIFpC+tRtgpVvwTw+HUxwa5NktZFHqEmL+WasqkZDPEi53
	 BoamXBtKG32Mucou5qAZfFN5Vl8TB/IkRaApVTrpVZa3yv2Z0YREMRB2OaFjEltYAhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SP5YiMcE;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=luUWcEzF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SP5YiMcE;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=luUWcEzF;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66661606A31E
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 13:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66661606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SP5YiMcE;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=luUWcEzF;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SP5YiMcE;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=luUWcEzF
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C8DC21E23;
	Tue, 27 Oct 2026 13:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793108213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gg6aR7KxYa7HADZSZwVdPxH+tm3LLgRgSzh99g2OM+w=;
	b=SP5YiMcEv8nBUSl2tEtKkAYRuFWY3atd88VhXwu3hT7QHTPg4qE390qhjivNH4XqWE75wJ
	HblCGcnvpDJlkbEaxF4W0YWe4tFg0Hp1LXmZPaSaX+4h55q+isMsPKtOKnyUETcCAZiu7M
	YXEwcJ+mVtcJul0RmlQ71C/hH7v4VkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793108213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gg6aR7KxYa7HADZSZwVdPxH+tm3LLgRgSzh99g2OM+w=;
	b=luUWcEzF71fEzE05p/FHKAqxE+pDZOBg0bzRIeiLTHKfuNKeFYk7L5u4IWqSbnKvKQHA2t
	WuRbQtsGtWMXfRAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793108213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gg6aR7KxYa7HADZSZwVdPxH+tm3LLgRgSzh99g2OM+w=;
	b=SP5YiMcEv8nBUSl2tEtKkAYRuFWY3atd88VhXwu3hT7QHTPg4qE390qhjivNH4XqWE75wJ
	HblCGcnvpDJlkbEaxF4W0YWe4tFg0Hp1LXmZPaSaX+4h55q+isMsPKtOKnyUETcCAZiu7M
	YXEwcJ+mVtcJul0RmlQ71C/hH7v4VkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793108213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gg6aR7KxYa7HADZSZwVdPxH+tm3LLgRgSzh99g2OM+w=;
	b=luUWcEzF71fEzE05p/FHKAqxE+pDZOBg0bzRIeiLTHKfuNKeFYk7L5u4IWqSbnKvKQHA2t
	WuRbQtsGtWMXfRAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 466E313319;
	Tue, 27 Oct 2026 13:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wbs7OfSo4GoWVAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 27 Oct 2026 13:36:53 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/6] fbcon: Clean up glyph handling on redraws
Date: Tue, 27 Oct 2026 14:27:15 +0100
Message-ID: <20261027133646.297856-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmx.de,ffwll.ch];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Score: -11.80

Fbcon's drawing functions open-code much of the glyph handling. Use
font helpers instead. Makes fbcon more consistent and easier to
understand.

Patch 1 updates fbcon to use unsigned char for glyph buffers. This
is consistent with the font code and font_data_t.

Patches 2 and 3 update font rotation to return rotated glyphs as
font_data_t. A rotated font can now use the same interfaces as the
unrotated source font. Fbcon uses this to ref count the font buffer.

Patches 4 to 6 update various parts of fbcon to use font helpers
instead of open-coding access to font_data_t. Having the rotated
font as font_data_t makes this convenient.

Tested with fbcon on DRM's bochs driver (qemu).

Thomas Zimmermann (6):
  fbcon: Use unsigned char for glyph data
  lib/fonts: Provide internal helpers for allocating font_data_t
  lib/fonts, fbcon: Use font_data_t for rotated fonts
  fbcon: Refactor size calculation for cursor buffers
  fbcon: Look up glyphs using the font interface
  fbcon: Handle characters with no glyph defined in a consistent way

 drivers/video/fbdev/core/bitblit.c      | 82 +++++++++++++++----------
 drivers/video/fbdev/core/fbcon.c        |  3 +-
 drivers/video/fbdev/core/fbcon.h        |  5 +-
 drivers/video/fbdev/core/fbcon_ccw.c    | 56 +++++++++++------
 drivers/video/fbdev/core/fbcon_cw.c     | 57 ++++++++++-------
 drivers/video/fbdev/core/fbcon_rotate.c | 19 +++---
 drivers/video/fbdev/core/fbcon_ud.c     | 77 +++++++++++++++--------
 include/linux/font.h                    |  5 +-
 lib/fonts/font.h                        | 12 ++++
 lib/fonts/font_rotate.c                 | 32 ++++------
 lib/fonts/fonts.c                       | 63 ++++++++++++-------
 11 files changed, 254 insertions(+), 157 deletions(-)

-- 
2.56.0

