Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AB6338F36
	for <linux-fbdev@vger.kernel.org>; Tue,  9 Sep 2025 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422147; cv=none; b=JzXljh4yP1nEj2JO6barkqMhicgrMMaVTyF0pp5wYA1GU5afg/MXZXk1YeZzAxotvuroHkrmzJJ0Edh6LnF+TPzK+s8oL/0QPgKgrOnhay0fo6GqtmVS3TQE95eawfr6mFGMYbjAaLSaeKVbx9CruAqIW2aR1IljU31Gyi/ZKC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422147; c=relaxed/simple;
	bh=6TK7STOp7sYU+prL0f/siQC/eKrjLwEdFfxN4rugaZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cbNMMsCf+0sWvkXnYegbVNeQ12qYcLFWYXBM9wXphkW6feWlRsB2JYzkmK5ZFQN5GbuG5KT/iHln6S1UetDuP/uXPstWLjd3X7B9yA6J0zUunSx55PNebk/Vs7zO4gL93QbO5wSRo89Ux3nh7VduiG1CwGvLzWMJkQxQexKdar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZbzKiCSB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tw9itUrg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qmJUvxJL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ILUMtr8i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZbzKiCSB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tw9itUrg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qmJUvxJL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ILUMtr8i"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EAFED20C91;
	Tue,  9 Sep 2025 12:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757422144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qYaTzJuYbbm4BqbCL9GhBQDSJqv2Cy4NQB/DONIo1Gk=;
	b=ZbzKiCSBICcQ2Sr0jrdb+ZuzhYtnQqcYFxVQBkOkOp8qti1xYgyd0DvB3m2dtnUnWR3TBl
	1U/NIt9RuyNQ/do5FPdKJflL2QCipNe1lbc2pUdXTSDcxxuJ9OK6SPJ5qsKXLaEmQT4l5g
	tbKgYe2XMkRsRNm7s3sewFRWu68pX+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757422144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qYaTzJuYbbm4BqbCL9GhBQDSJqv2Cy4NQB/DONIo1Gk=;
	b=Tw9itUrgd1/aoUuzIRff0G2jSWilrMY3c7p88b6lpwOEJtirnz1lhC/SMlb18V0qchOjQp
	ce7crL4LoiB1bPAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qmJUvxJL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ILUMtr8i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757422143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qYaTzJuYbbm4BqbCL9GhBQDSJqv2Cy4NQB/DONIo1Gk=;
	b=qmJUvxJL87aMUj28eD971Eq2MnDuwOoDDfyPf0N0lV4+ScKTPhuwYE8Ic+2J3ciNdp5eDr
	/cd2A9lsqtcr0AdVqnBm4NoFPtNzO+Fc0QYuBm5MK4Cw2ebuC+516puEJNH/c1QapYEQbe
	es1b50+sLM13vrwTGoqFUgMiGYFvHM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757422143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qYaTzJuYbbm4BqbCL9GhBQDSJqv2Cy4NQB/DONIo1Gk=;
	b=ILUMtr8i5+jGisRgLDvm71Dj+u7p9hVVC7mDOkOkaOK3X6EhXJZRne0bGuIrlcc8hEdzmc
	XyEyi+IQ7ekiN0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7E0F1388C;
	Tue,  9 Sep 2025 12:49:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mnBaKz8iwGilUAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 09 Sep 2025 12:49:03 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: sam@ravnborg.org,
	simona@ffwll.ch,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/5] fbcon: Move bitops callbacks into separate struct
Date: Tue,  9 Sep 2025 14:44:40 +0200
Message-ID: <20250909124616.143365-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EAFED20C91
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Score: -3.01

Instances of fbcon use a number callbacks to support tile-based
drawing or console rotation. The fields are writeable in struct
fbcon_ops. Each case; unrotated, various rotated and tile-based
drawing; uses a set of related calbacks. Updating these 'bitops'
at runtime is spread throughout various helper functions.

This series puts related callbacks into dedicated instances of the
new type struct fbcon_bitops. Changing the callbacks at runtime
then only requires to pick the correct instance. It further allows
the various struct fbcon_bitops' to be declared 'static const', which
makes them write-protected at runtime.

v2:
- rename struct fbcon_ops to struct fbcon_par
- drop patch 6

Thomas Zimmermann (5):
  fbcon: Fix empty lines in fbcon.h
  fbcon: Rename struct fbcon_ops to struct fbcon_par
  fbcon: Set rotate_font callback with related callbacks
  fbcon: Move fbcon callbacks into struct fbcon_bitops
  fbcon: Streamline setting rotated/unrotated bitops

 drivers/video/fbdev/core/bitblit.c      | 122 +++----
 drivers/video/fbdev/core/fbcon.c        | 459 ++++++++++++------------
 drivers/video/fbdev/core/fbcon.h        |  17 +-
 drivers/video/fbdev/core/fbcon_ccw.c    | 151 ++++----
 drivers/video/fbdev/core/fbcon_cw.c     | 151 ++++----
 drivers/video/fbdev/core/fbcon_rotate.c |  47 +--
 drivers/video/fbdev/core/fbcon_rotate.h |  18 +-
 drivers/video/fbdev/core/fbcon_ud.c     | 167 ++++-----
 drivers/video/fbdev/core/softcursor.c   |  18 +-
 drivers/video/fbdev/core/tileblit.c     |  32 +-
 10 files changed, 604 insertions(+), 578 deletions(-)

-- 
2.51.0

