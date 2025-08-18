Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF45C30DED2
	for <linux-fbdev@vger.kernel.org>; Mon, 18 Aug 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514196; cv=none; b=L7mqU8m85Qg0eOqnL++CppsSUI3RPVLJAQBUhGZjGRPnw7sUSm4fv+WivRrw5vPD/iuA08sMF8kGEuZccDZ6cOwZNURc1rWKRzPqp4elBh6c0Bu+Ghiwddwzlw4ZZht6wWV4OnrvTHsbBliHSwiWLGOZCwAveA0juFossbjb9es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514196; c=relaxed/simple;
	bh=tyV9IBXkedlGif0DstxpIClOGSoIQZ5zLciVBG0WYNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3rynxVdbnuv8pHOJK1oG6U/g0fL6hgB14pZURTsbtAlmStan0WkgPl0RGGM1uzTNnznEkmaCXexeLPlsxMJhbW213LXsyn94fE9GozD7zHRS23V3S18+GuknR0VasoPdNYin+mnSWICAXOd4TYsVGhhKnP9LptPeFWprk4puIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B3JmU40+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P54mdeCe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B3JmU40+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P54mdeCe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B3JmU40+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P54mdeCe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B3JmU40+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P54mdeCe"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F8DB1F44E;
	Mon, 18 Aug 2025 10:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755514185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XadkrTwdTNZR/f4ID8Lrj2WkVCxvKtsABauxJ9Ar6Z4=;
	b=B3JmU40+Znrg3g2AdC9PKYk1O0RHI2AzLzu5BLgIRg3wWIiAO9ROm1R7vmb9BsxHvkymqa
	P2so8hmBKfR74rEanmkMj5fKZXm9I/MDzCXMKwDHqzZ+MeYVJZOUmkiX54tlmZ/Yrqqhsf
	8bLyfWnGDhN+5IHlY1nZVbwt4w+/1IM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755514185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XadkrTwdTNZR/f4ID8Lrj2WkVCxvKtsABauxJ9Ar6Z4=;
	b=P54mdeCeoPBRBOZ67ktk4rrVEMJLnRIR4Ps30dt4J9EkrgTDHF8MC6IcnHVn9H0OtfFwRR
	DJ0f8V7oCEskEvCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=B3JmU40+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P54mdeCe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755514185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XadkrTwdTNZR/f4ID8Lrj2WkVCxvKtsABauxJ9Ar6Z4=;
	b=B3JmU40+Znrg3g2AdC9PKYk1O0RHI2AzLzu5BLgIRg3wWIiAO9ROm1R7vmb9BsxHvkymqa
	P2so8hmBKfR74rEanmkMj5fKZXm9I/MDzCXMKwDHqzZ+MeYVJZOUmkiX54tlmZ/Yrqqhsf
	8bLyfWnGDhN+5IHlY1nZVbwt4w+/1IM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755514185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XadkrTwdTNZR/f4ID8Lrj2WkVCxvKtsABauxJ9Ar6Z4=;
	b=P54mdeCeoPBRBOZ67ktk4rrVEMJLnRIR4Ps30dt4J9EkrgTDHF8MC6IcnHVn9H0OtfFwRR
	DJ0f8V7oCEskEvCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1B7813686;
	Mon, 18 Aug 2025 10:49:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9izBMUgFo2hQVQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 18 Aug 2025 10:49:44 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch,
	deller@gmx.de,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/6] fbcon: Move bitops callbacks into separate struct
Date: Mon, 18 Aug 2025 12:36:35 +0200
Message-ID: <20250818104655.235001-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0F8DB1F44E
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
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[ffwll.ch,gmx.de,vger.kernel.org,lists.freedesktop.org];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
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

Makes the fbcon bitops easier and safer to use and modify.

Thomas Zimmermann (6):
  fbcon: Fix empty lines in fbcon.h
  fbcon: Rename struct fbcon_ops to struct fbcon
  fbcon: Set rotate_font callback with related callbacks
  fbcon: Move fbcon callbacks into struct fbcon_bitops
  fbcon: Streamline setting rotated/unrotated bitops
  fbcon: Pass struct fbcon to callbacks in struct fbcon_bitops

 drivers/video/fbdev/core/bitblit.c      | 148 ++++----
 drivers/video/fbdev/core/fb_internal.h  |   2 +
 drivers/video/fbdev/core/fbcon.c        | 459 ++++++++++++------------
 drivers/video/fbdev/core/fbcon.h        |  33 +-
 drivers/video/fbdev/core/fbcon_ccw.c    | 180 +++++-----
 drivers/video/fbdev/core/fbcon_cw.c     | 172 ++++-----
 drivers/video/fbdev/core/fbcon_rotate.c |  47 +--
 drivers/video/fbdev/core/fbcon_rotate.h |  18 +-
 drivers/video/fbdev/core/fbcon_ud.c     | 192 +++++-----
 drivers/video/fbdev/core/softcursor.c   |  18 +-
 drivers/video/fbdev/core/tileblit.c     |  49 +--
 11 files changed, 681 insertions(+), 637 deletions(-)

-- 
2.50.1

