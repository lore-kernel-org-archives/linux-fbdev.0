Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0EA1B29A7
	for <linux-fbdev@vger.kernel.org>; Wed, 31 Jul 2024 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430901; cv=none; b=SBep+t5ge8w0s3FzJNEKpPqr0WzNHsL/2yunib3CVDxZDWH8xZWF6jNmOkVKSnuVAfIy+bgEwdpU7yg+uwIRpMKOuCCJG9321NXJqW47/gyF1xRmCEZZKheSedTPXJKiwPSTCu5sl3EunAUOR9HDk/O1r8pUrY6RP1kuFqtm4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430901; c=relaxed/simple;
	bh=FjpIk3xiJ31l9hYfhfRpI40Sns4j36XhdcdYpe/2jeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fy9Otlnxc0Ml/vigVSqJasx/RyNi7KiDz9N4TbiOASPBGOdR1uRkfA7yhpue2Rq4bUSNRctPp5IVL7ezmKoDEEBZPkvAMbAwZRjBuy0NdzuUlc/tC2KmJ9kiJAhxQCjP2sj7ey486Jd5ZVyfprDlu0yPjh+HIEQaLCZ61ZTasZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uECZyFUN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EJIhO+Ir; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uECZyFUN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EJIhO+Ir; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uECZyFUN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EJIhO+Ir";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uECZyFUN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EJIhO+Ir"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B19C1F810;
	Wed, 31 Jul 2024 13:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JWi881wIWCASDtdn189f9cwNudmQttGuGLr5bDSNrBQ=;
	b=uECZyFUNLyQbdkKTUMqwC284KayfhCJyiRNeptAMYLeooJja28TSJlc38u27KlIpIJgmNQ
	h5A5C1i+kEz/SoKnvq/8qzHAn7TPKFQLwIsg5oZgUvNVKrwg0oaDz0CgIIJQ5KF4Llj65x
	xpHzfssfXMBaTVTwOEpMczg3PYPaNSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JWi881wIWCASDtdn189f9cwNudmQttGuGLr5bDSNrBQ=;
	b=EJIhO+IrwLLDmBk8Xb1d93TamTh1wI3jHrkLNG9NtLmJQstIcm2uETPja+cStk5UQLJYEo
	FqDhlog6lCYdPOAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JWi881wIWCASDtdn189f9cwNudmQttGuGLr5bDSNrBQ=;
	b=uECZyFUNLyQbdkKTUMqwC284KayfhCJyiRNeptAMYLeooJja28TSJlc38u27KlIpIJgmNQ
	h5A5C1i+kEz/SoKnvq/8qzHAn7TPKFQLwIsg5oZgUvNVKrwg0oaDz0CgIIJQ5KF4Llj65x
	xpHzfssfXMBaTVTwOEpMczg3PYPaNSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JWi881wIWCASDtdn189f9cwNudmQttGuGLr5bDSNrBQ=;
	b=EJIhO+IrwLLDmBk8Xb1d93TamTh1wI3jHrkLNG9NtLmJQstIcm2uETPja+cStk5UQLJYEo
	FqDhlog6lCYdPOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D0EC13297;
	Wed, 31 Jul 2024 13:01:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7ZWMEa81qmYzWQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 31 Jul 2024 13:01:35 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/2] staging: Use backlight power constants
Date: Wed, 31 Jul 2024 14:58:50 +0200
Message-ID: <20240731130130.1148153-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

Commit a1cacb8a8e70 ("backlight: Add BACKLIGHT_POWER_ constants for
power states") introduced dedicated constants for backlight power states.
Convert staging drivers to the new constants.

The new constants replace the fbdev constants. This is part of a larger
effort to make kernel subsystems more independent from fbdev code and
headers.

Thomas Zimmermann (2):
  staging: fbtft: Use backlight power constants
  staging: olpc_dcon: Use backlight power constants

 drivers/staging/fbtft/fb_ssd1351.c    | 2 +-
 drivers/staging/fbtft/fbtft-core.c    | 6 +++---
 drivers/staging/olpc_dcon/olpc_dcon.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.45.2

