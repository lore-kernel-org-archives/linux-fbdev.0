Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D2B7CF3A
	for <linux-fbdev@vger.kernel.org>; Tue, 19 Mar 2024 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841161; cv=none; b=J1ZElLFnc3iwDFvQornbg+zgsZtQoeYbud5tVfw6FAbZMl+ACUasL+5kkCOXG8/9Egl/aIgBf4RJjQJU51niqZonRojurmcGMs9E5e8Edkvel94FkIZKIxczG0D0Tu3jj6yvWeXUJHiR5SvFjvDFMPAK7t2lPioanQ5oAc4w2yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841161; c=relaxed/simple;
	bh=E8EZV1ToCgbH1ToBgK37C3F5uIGQkGe3GARNgFrnR2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uHHhE3/Fymt+yKl+i4XqQ12xEk/8nUlwdmqo1Lay8+ahqJfCMZpuhuy4n8TerswZvAa5UkqQcxDqzI6BwHYFXAQBt9Miq/tvvP+hBgoWsEO6AsZzCxDb1fGpRy/bnADnRvicIQUnh3RCTv5EpBkNJh4oj+BSNaN03Kv8LwfmN4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jtqU+Da7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dX5kaYRJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jtqU+Da7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dX5kaYRJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jtqU+Da7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dX5kaYRJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jtqU+Da7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dX5kaYRJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D5F8E37612;
	Tue, 19 Mar 2024 09:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710841157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JUep0UaZBgvgcjPAzjRBxeOi0HIeRPaS0YhTrsJRSj8=;
	b=jtqU+Da7sxmuevtNDRVJ9ZPNHSnqKluEVfnQGRftFIxMaY9JHH3uakKHgYMAjGvHGUOhYp
	bBVKq5CbtrX/X0WSUT9nLG6hXBE3oJi0kGrE/5reNdb6lDjwJagXiTRiJS5Z0xBdrfZpWp
	qFSikuVA31cKMNlewtUoAvhJGAyTms8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710841157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JUep0UaZBgvgcjPAzjRBxeOi0HIeRPaS0YhTrsJRSj8=;
	b=dX5kaYRJ5dJxmQBGupTa3H3uR1zlIg+wXki8m9n6gcMz0LfEW/5G/cyqbDf47cvRAdFE3k
	WKSV3QKG9c1F4wCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710841157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JUep0UaZBgvgcjPAzjRBxeOi0HIeRPaS0YhTrsJRSj8=;
	b=jtqU+Da7sxmuevtNDRVJ9ZPNHSnqKluEVfnQGRftFIxMaY9JHH3uakKHgYMAjGvHGUOhYp
	bBVKq5CbtrX/X0WSUT9nLG6hXBE3oJi0kGrE/5reNdb6lDjwJagXiTRiJS5Z0xBdrfZpWp
	qFSikuVA31cKMNlewtUoAvhJGAyTms8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710841157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JUep0UaZBgvgcjPAzjRBxeOi0HIeRPaS0YhTrsJRSj8=;
	b=dX5kaYRJ5dJxmQBGupTa3H3uR1zlIg+wXki8m9n6gcMz0LfEW/5G/cyqbDf47cvRAdFE3k
	WKSV3QKG9c1F4wCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88D3C136A5;
	Tue, 19 Mar 2024 09:39:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zUcZIEVd+WU6GAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 19 Mar 2024 09:39:17 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	andy@kernel.org,
	geert@linux-m68k.org,
	dan.carpenter@linaro.org,
	sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/6] backlight: Remove struct backlight_properties.fb_blank
Date: Tue, 19 Mar 2024 10:37:19 +0100
Message-ID: <20240319093915.31778-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 2.85
X-Spamd-Result: default: False [2.85 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,linux-m68k.org,ravnborg.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.85)[85.37%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: **
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

The field fb_blank in struct backlight_properties has been marked for
removal. Remove it in favor of the power and state fields.

Patches 1 to 5 prepare several backlight drivers. They remove fb_blank
or replace driver code with existing helpers.

Patch 6 removes fb_blank from backlight core and drivers. This resolves
another dependency between backlight nad fbdev.

v2:
- omap1: replace 'power' with 'enable'
- clarify commit messages

Thomas Zimmermann (6):
  auxdisplay: ht16k33: Replace use of fb_blank with backlight helper
  backlight: omap1: Remove unused struct omap_backlight_config.set_power
  backlight: omap1: Replace FB_BLANK_ states with simple on/off
  fbdev: omap2/omapfb: Replace use of fb_blank with backlight helpers
  staging: fbtft: Remove reference to fb_blank
  backlight: Remove fb_blank from struct backlight_properties

 drivers/auxdisplay/ht16k33.c                  |  7 +--
 drivers/staging/fbtft/fb_ssd1351.c            |  4 +-
 drivers/staging/fbtft/fbtft-core.c            |  5 +-
 drivers/video/backlight/backlight.c           |  2 -
 drivers/video/backlight/mp3309c.c             |  1 -
 drivers/video/backlight/omap1_bl.c            | 47 +++++++------------
 drivers/video/fbdev/atmel_lcdfb.c             |  1 -
 .../omap2/omapfb/displays/panel-dsi-cm.c      |  7 +--
 .../omapfb/displays/panel-sony-acx565akm.c    | 10 +---
 include/linux/backlight.h                     | 25 +---------
 include/linux/platform_data/omap1_bl.h        |  1 -
 11 files changed, 26 insertions(+), 84 deletions(-)

-- 
2.44.0

