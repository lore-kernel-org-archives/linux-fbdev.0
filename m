Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCC62D97BB
	for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063692; cv=none; b=GHMGebF5sm8/66NBQ0UeFIEOnc3vazIG0p1Jph3q2ejdTQwgXlrgUoNsVEur2tvmeB0U9+PwEtcBpnBst8BiGYpBM6Lva/yJyAjVEzUZ9/S99UzFFgSvtiIxBdVedxN23FfCNfinbh+XEn3E6bHhjKyDd3VZNH73s+g8QoBndLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063692; c=relaxed/simple;
	bh=8M640a+O0ywnNHg3jZ7jDsnjZt4bvl0GO8nlomjVoQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pq8ws7JELJbnX3y8pUszzKUJPaS0XukYvmoQglX8dqZdg3c+WjglzdYzh9StOVhSqIWxnIWzyl2Uv9eX5yDSjI55fo35uGKtmARwovWXowhEjj0D7YREmuLIy2Kcjog/X6LoTwOyay1u9NJVkM+hXee3KzuPyfcx56TGWFKL0F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o+MJYuWC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IR8R+mah; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o+MJYuWC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IR8R+mah; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o+MJYuWC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IR8R+mah";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o+MJYuWC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IR8R+mah"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CA93567118;
	Fri, 29 May 2026 14:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780063683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+myuSAC9wnIOxSXXNauZ60Mn7mCMgJbmkjgCPL7arhU=;
	b=o+MJYuWCdmMp29gYasHTL+4wcnaVfu2K19FJIrvM/moy2w8h946K+MEoZzB9811saSOFPH
	oYi/QkUa/ecadl8aeNqsMT4yEDWXTRpsvB/cFVMQu7LeuFp/AOhoTqIPyXtr52CkShU/pb
	f6O7ahz9O30uskOggXVo3DgVcpYEn2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780063683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+myuSAC9wnIOxSXXNauZ60Mn7mCMgJbmkjgCPL7arhU=;
	b=IR8R+mahiQQSnm0voAlyj5CXLt1HMGVwHiTU2I0ahBszzF06HWfro/ciWgV8mqqakm6bhg
	MC17VfmH5E4oiXBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o+MJYuWC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IR8R+mah
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780063683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+myuSAC9wnIOxSXXNauZ60Mn7mCMgJbmkjgCPL7arhU=;
	b=o+MJYuWCdmMp29gYasHTL+4wcnaVfu2K19FJIrvM/moy2w8h946K+MEoZzB9811saSOFPH
	oYi/QkUa/ecadl8aeNqsMT4yEDWXTRpsvB/cFVMQu7LeuFp/AOhoTqIPyXtr52CkShU/pb
	f6O7ahz9O30uskOggXVo3DgVcpYEn2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780063683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+myuSAC9wnIOxSXXNauZ60Mn7mCMgJbmkjgCPL7arhU=;
	b=IR8R+mahiQQSnm0voAlyj5CXLt1HMGVwHiTU2I0ahBszzF06HWfro/ciWgV8mqqakm6bhg
	MC17VfmH5E4oiXBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88E9D779A7;
	Fri, 29 May 2026 14:08:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8Lr4H8OdGWoybAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 29 May 2026 14:08:03 +0000
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
Subject: [PATCH 0/4] drm: Safe font-data access in log/panic drawing
Date: Fri, 29 May 2026 16:01:22 +0200
Message-ID: <20260529140759.529929-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CA93567118
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_SEVEN(0.00)[10];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]

Looking up glyph shapes with a signed char in drm_draw_get_char_bitmap()
is unsafe. It also does not support extended ASCII codes with values
larger than 127.

Add the new function font_data_glyph_buf() to the font-data helpers. It
looks up the correct glyph from font data or returns NULL if no such
glyph exists. Convert DRM's log and panic code to the new function. Also
cast the character code to support all 256 ASCII characters.

Tested with drm_log on bochs.

Thomas Zimmermann (4):
  lib/fonts: Look up glyph data with font_data_glyph_buf()
  drm/client: log: Look up glyph shape with font helper
  drm/panic: Look up glyph shape with font helper
  drm/draw: Remove unused helper drm_draw_get_char_bitmap()

 drivers/gpu/drm/clients/drm_log.c   | 10 ++++++----
 drivers/gpu/drm/drm_draw_internal.h |  7 -------
 drivers/gpu/drm/drm_panic.c         |  6 ++++--
 include/linux/font.h                |  3 +++
 lib/fonts/fonts.c                   | 31 +++++++++++++++++++++++++++++
 5 files changed, 44 insertions(+), 13 deletions(-)

-- 
2.54.0

