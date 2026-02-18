Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787D231ED76
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Feb 2026 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403946; cv=none; b=abbSZL86B2rSTvmRFZ31ORjz0H1OCSjcygZmULAfYIl26+F5ScqtoCKeaBD6ykdIzXo0ygSnvjY9h2k0QgYIaCVk+Jd9e1QbRGpmHvprc6tef2DVRRlSxvKCUrVW7mOFukmzaWvIhWowHccP1fO4bZhO+aufQbYZK7vhx1dmhrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403946; c=relaxed/simple;
	bh=kJiL/sSSA1fLq3d3aRqFnm7ZC2AgqQJPb0Zj1TG+9A4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xzb70jAduqGNSvmEmNw/CPSgQzPXsLmWHVeg5bUmq2SYL9z18oqKrg+/vAiCW8+AEYUP7XAGCouuOADr+Twrow57w56KcxFbkJaDx8VbOm+VNdyjPJnlPMnjBD+1xub77SSNa/+i8VCMzp7iwxM40vcbLkf37HvCAklRzjy/VSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aumxGvdC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yjRK7lPX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aumxGvdC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yjRK7lPX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aumxGvdC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yjRK7lPX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aumxGvdC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yjRK7lPX"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 94EDE3E6F1;
	Wed, 18 Feb 2026 08:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hhT30ZwLGjOe3mVHKGj5Z/qZdiWqZDBbwbVjJfqoZkQ=;
	b=aumxGvdC0GOQiJDABkGSarlLP0ne8ltCrUUFiFs+4BLLbOfzPN+UgtaAJwRTbiO//5w22i
	e4hkz1XHLhfvnvGnmWHqnEHDD2GitizTMJ+7rLI0WhpqretimQaVV5VatPz+aUGqMtwz8U
	2awpFuH4sJ+Ori+oH16WDUqUxX3tKz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hhT30ZwLGjOe3mVHKGj5Z/qZdiWqZDBbwbVjJfqoZkQ=;
	b=yjRK7lPXuX72HCG6fW/JHPQyO2Jo6eyTEMVn4q0y1uu+V2IFqe7uTShG3aignueM2gdSCM
	85YOK0NDXbz+N/Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aumxGvdC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yjRK7lPX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hhT30ZwLGjOe3mVHKGj5Z/qZdiWqZDBbwbVjJfqoZkQ=;
	b=aumxGvdC0GOQiJDABkGSarlLP0ne8ltCrUUFiFs+4BLLbOfzPN+UgtaAJwRTbiO//5w22i
	e4hkz1XHLhfvnvGnmWHqnEHDD2GitizTMJ+7rLI0WhpqretimQaVV5VatPz+aUGqMtwz8U
	2awpFuH4sJ+Ori+oH16WDUqUxX3tKz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hhT30ZwLGjOe3mVHKGj5Z/qZdiWqZDBbwbVjJfqoZkQ=;
	b=yjRK7lPXuX72HCG6fW/JHPQyO2Jo6eyTEMVn4q0y1uu+V2IFqe7uTShG3aignueM2gdSCM
	85YOK0NDXbz+N/Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E8CD3EA65;
	Wed, 18 Feb 2026 08:39:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w5m8Ead6lWn8LwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 18 Feb 2026 08:39:03 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 00/13] vc,fbcon,fonts: Proper handling of font data
Date: Wed, 18 Feb 2026 09:15:51 +0100
Message-ID: <20260218083855.10743-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de,ravnborg.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 94EDE3E6F1
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Provide helpers for handling console font data. Update consoles and VT.

VT's vc_state stores fotn data as a plain byte array of glphys. Fbcon,
newport_con and the kernel's internal fonts store the glyph data as an
array of plain bytes plus a hidden header for refcounting, check sums and
buffer sizes. The refcounting only works for user-space fonts but not
for internal fonts. Font-data handling is duplicated in several places.
Most of the font handling is open-coded and mixed up with VT's plain glyph
arrays.

To addiress these issues, add proper handling of font data to all involved
components: struct vc_font for font state in VC; a font data type for the
consoles. Then implement interfaces for handling font data one by one.

Patch 1 prepares the fbdev interface.

Patches 2 to 4 prepare VT's font handling.

Patches 5 to 13 refactor fbcon and newport_con to use clean interfaces for
their fonts.

Fbcon has long been a source of problems and bug reports. [1] With its
confusing implementation, it is hard to find the cause of these bugs.
Cleaning up the fbcon code will hopefully help with resolving bug reports
in the future.

The series has been tested with fbcon under DRM's bochs driver by changing
fonts at runtime useing the setfont utility. The changes to newport_con have
only been tested to compile.

[1] https://lore.kernel.org/all/6992c84c.a70a0220.2c38d7.00e8.GAE@google.com/
[2] https://www.man7.org/linux/man-pages/man8/setfont.8.html

Thomas Zimmermann (13):
  fbdev: Declare src parameter of fb_pad_ helpers as constant
  vt: Remove trailing whitespaces
  vt: Store font in struct vc_font
  vt: Calculate font-buffer size with vc_font_size()
  lib/fonts: Remove trailing whitespaces
  lib/fonts: Remove FNTCHARCNT()
  lib/fonts: Store font data as font_data_t; update consoles
  lib/fonts: Read font size with font_data_size()
  lib/fonts: Compare font data for equality with font_data_is_equal()
  lib/fonts: Manage font-data lifetime with font_data_get/_put()
  lib/fonts: Create font_data_t from struct console_font with
    font_data_import()
  lib/fonts: Store font data for user space with font_data_export()
  lib/fonts: Remove internal symbols and macros from public header file

 drivers/video/console/newport_con.c |  61 +++----
 drivers/video/fbdev/core/bitblit.c  |  11 +-
 drivers/video/fbdev/core/fbcon.c    | 194 +++++++----------------
 drivers/video/fbdev/core/fbcon.h    |   8 +-
 drivers/video/fbdev/core/fbmem.c    |   6 +-
 include/linux/console_struct.h      |  59 ++++++-
 include/linux/fb.h                  |  10 +-
 include/linux/font.h                |  90 +++++++----
 lib/fonts/font.h                    |  52 ++++++
 lib/fonts/font_10x18.c              |   2 +-
 lib/fonts/font_6x10.c               |   3 +-
 lib/fonts/font_6x11.c               |   2 +-
 lib/fonts/font_6x8.c                |   3 +-
 lib/fonts/font_7x14.c               |   2 +-
 lib/fonts/font_8x16.c               |   3 +-
 lib/fonts/font_8x8.c                |   2 +-
 lib/fonts/font_acorn_8x8.c          |   4 +-
 lib/fonts/font_mini_4x6.c           |  10 +-
 lib/fonts/font_pearl_8x8.c          |   2 +-
 lib/fonts/font_sun12x22.c           |   3 +-
 lib/fonts/font_sun8x16.c            |   3 +-
 lib/fonts/font_ter10x18.c           |   4 +-
 lib/fonts/font_ter16x32.c           |   4 +-
 lib/fonts/fonts.c                   | 236 +++++++++++++++++++++++++++-
 24 files changed, 521 insertions(+), 253 deletions(-)
 create mode 100644 lib/fonts/font.h


base-commit: 0082025812a31eda451fb14f13f52683ed375c49
-- 
2.52.0

