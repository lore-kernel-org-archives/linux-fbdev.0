Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D822FD689
	for <linux-fbdev@vger.kernel.org>; Thu, 22 Jan 2026 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087540; cv=none; b=qLg+aOq8xkNGyGjIVeg66FBObLsdfZwalejb7cUk0KdTLfo+A4oCm3w2QAZa5luxsr6kLW6+spLe9jlppD2k/Bl9o5GGkbXzTdKjyhNd5eZbRZ9SycdG+YlwaN44ujgatBDCDgsInd+4O+Pn8w9sED5LOSKnDhz5/DOjIDveHPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087540; c=relaxed/simple;
	bh=pjZzHL+s0Z1Xekj0+7gZtl4wHocxLHBk4PSol45JHGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tt4xJJfFT3TXFiWRescPSVsAa6HP5mgs2Vo6rDKQoJzyfCMlrrbSMnRzSwXmWtlk21gesmhFFpg6z5teaGV+rdtxvtV+7EkkYj/qtgGieuz1SVMzzCIMCBusfZfgjZT9E9jPbD9qy38vqYwY/rVMqgLXFBjNgjUPdXtn1j/Ngkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aCdKwFCT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=exeNAx9G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TTb09fP0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PcJ9F+JU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aCdKwFCT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="exeNAx9G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TTb09fP0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PcJ9F+JU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0D1233717;
	Thu, 22 Jan 2026 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769087537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6PLEneN7/qHi7h1Wld0jsWaqgiXUPVpuEcgtslwiTZg=;
	b=aCdKwFCT1YgsPnmgGLyQNB293aO6RrkffG0BVrPQTP9pESCdSkwEqk6AgGmoMGTrli2ikb
	yMXGyRJpBVJkmWme1ceYWhPk8B5Hpomn0HcTmbpCOf9oj+NZl0WUYq8X+VgGoIVgK+kDWD
	PSF6aFS407tAr13u2C2Y6z9D2GMz0tQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769087537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6PLEneN7/qHi7h1Wld0jsWaqgiXUPVpuEcgtslwiTZg=;
	b=exeNAx9GVdpHsE0jiXNzZ80Pv7q9Q65j+gtgBzV4E2RxNzhhrwZumcdsW8nnxXixvhUXyO
	hB3whReCY40facCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769087536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6PLEneN7/qHi7h1Wld0jsWaqgiXUPVpuEcgtslwiTZg=;
	b=TTb09fP0pbh3hjz8FUOZfplY7SOgSNUQvtZyx8el3+ZeooqHceflhxdgV5qJkiDMw8IjlT
	aTL0xag/l3iJ31/DVg5eOdq9YK1uWjdVEUIumM98mfzt1nHNnNVEC9YauVzh40kqpgIYks
	MS7MKH5vSvv7HEE8Nkg2KjqoY6tNTUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769087536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6PLEneN7/qHi7h1Wld0jsWaqgiXUPVpuEcgtslwiTZg=;
	b=PcJ9F+JUlB5axMf9UcKHFr/cySki4gSCgz8WJ2tFTHpeOQiPvCKkoTov7NX68O6K02x29z
	ZuCknDBcHmlnz1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4E2313533;
	Thu, 22 Jan 2026 13:12:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yLrwKjAicmlgMgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 22 Jan 2026 13:12:16 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch,
	jayalk@intworks.biz
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/4] fbdev: defio: Protect against device/module removal
Date: Thu, 22 Jan 2026 14:08:28 +0100
Message-ID: <20260122131213.992810-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmx.de,ffwll.ch,intworks.biz];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Level: 
X-Spam-Flag: NO

There's a long-standing bug in defio where the framebuffer device or
module gets removed while mmap'ed areas of the framebuffer memory
persists in userspace. Page faults in the area then operate on defined
state.

Patches 1 and 2 fix these problems. Patches 3 and 4 build upon the fix
and put defio state into the correct places.

Thomas Zimmermann (4):
  fbdev: defio: Disconnect deferred I/O from the lifetime of struct
    fb_info
  fbdev: defio: Keep module reference from VMAs
  fbdev: defio: Move variable state into struct fb_deferred_io_state
  fbdev: defio: Move pageref array to struct fb_deferred_io_state

 drivers/video/fbdev/core/fb_defio.c | 266 ++++++++++++++++++++--------
 include/linux/fb.h                  |   9 +-
 2 files changed, 195 insertions(+), 80 deletions(-)


base-commit: a3ecd278f9a05323fab7471760a7ea10081251d6
-- 
2.52.0

