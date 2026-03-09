Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D7C3D301B
	for <linux-fbdev@vger.kernel.org>; Mon,  9 Mar 2026 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065856; cv=none; b=HLS7QKqtomeFnLKOveSgJ1BNrWLcOf8K6PH5ngVt5mpIFpR46bV9ykB+HvK/Sh17I//E5M36vKTizNXJNY5k7pLuCMgwKQAZKh6gTnzDKJSKSyLLRhqzRjRnIuJyzdWSIQqMwAMgCPqZ1Ios5eo/EWYfX0LJd0LvPPSAbybUNn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065856; c=relaxed/simple;
	bh=0nAXMYn9jfFjrmztHarbA7E+9KjugwhmeUdI+x2+wgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JobAmwHtJQllu2PKfB+/MoHS7k/Qe3fEc0ODKfXzGx8soBkmK57VjVJxqBSn2HovZezJ31Ed7vNMkpS54H2mV19ua6Rc1wFojjfU4eM8vpOFSLEMZWnAa2SBY3nTfq9pcVh3Rl+cqmqd0CVjwX8Med/FOCbbFZqxy8JgIQsHNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vo9oML9c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QRjqaCN3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vo9oML9c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QRjqaCN3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vo9oML9c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QRjqaCN3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vo9oML9c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QRjqaCN3"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A2574D220;
	Mon,  9 Mar 2026 14:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773065849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FZrIUwWCQltDjTo2FR8uM2fsEjHkHnnB6h/A/NHfRgc=;
	b=Vo9oML9czWvc/DN0PauUBsmn/YcJ+FPRhr9kJ6vFieUanELgayEzOZ8vhnNwtttql5bDpO
	4JURddLgVXFDb0LqorQjBOFOzmsT6OsCCRMIvlNp/2TZWdDkp+zA5OVJMqu+5NX/nwOfvL
	Bu2CwDtXejz8KIK4GGMwZ/zNqXBgx/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773065849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FZrIUwWCQltDjTo2FR8uM2fsEjHkHnnB6h/A/NHfRgc=;
	b=QRjqaCN3vAGslMzLxmZ1IfdFsvpv6Ke/VQLI0KkbuoBZ2FEZrBwDwKXnZe2idMRaR0/sGc
	uKOe+03IyixfkRBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Vo9oML9c;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QRjqaCN3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773065849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FZrIUwWCQltDjTo2FR8uM2fsEjHkHnnB6h/A/NHfRgc=;
	b=Vo9oML9czWvc/DN0PauUBsmn/YcJ+FPRhr9kJ6vFieUanELgayEzOZ8vhnNwtttql5bDpO
	4JURddLgVXFDb0LqorQjBOFOzmsT6OsCCRMIvlNp/2TZWdDkp+zA5OVJMqu+5NX/nwOfvL
	Bu2CwDtXejz8KIK4GGMwZ/zNqXBgx/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773065849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FZrIUwWCQltDjTo2FR8uM2fsEjHkHnnB6h/A/NHfRgc=;
	b=QRjqaCN3vAGslMzLxmZ1IfdFsvpv6Ke/VQLI0KkbuoBZ2FEZrBwDwKXnZe2idMRaR0/sGc
	uKOe+03IyixfkRBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EF9F3EF3A;
	Mon,  9 Mar 2026 14:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Li4EXnWrmldPAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 09 Mar 2026 14:17:29 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 00/13] vc,fbcon,fonts: Proper handling of font data
Date: Mon,  9 Mar 2026 15:14:42 +0100
Message-ID: <20260309141723.137364-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
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
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de,ravnborg.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,man7.org:url];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,man7.org:url,suse.de:dkim,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Rspamd-Queue-Id: 8A2574D220
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Provide helpers for handling console font data. Update consoles and VT.

VT's vc_state stores font data as a plain byte array of glphys. Fbcon,
newport_con and the kernel's internal fonts store the glyph data as an
array of plain bytes plus a hidden header for reference counting, check
sums and buffer sizes. The reference counting only works for user-space
fonts but not for internal fonts. Font-data handling is duplicated in
several places. Most of the font handling is open-coded and mixed up with
VT's plain glyph arrays.

To address these issues, add proper handling of font data to all involved
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
fonts at runtime using the setfont utility. [2] The changes to newport_con
have only been tested to compile.

v3:
- fix module font linking (Nathan, Arnd)
- fix typos (Helge)
- clarify return value of font_data_put()
v2:
- keep declaring the internal fonts in the public header file (Helge)
- rebase and clean up

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
  lib/fonts: Manage font-data lifetime with font_data_get/_put()
  lib/fonts: Compare font data for equality with font_data_is_equal()
  lib/fonts: Create font_data_t from struct console_font with
    font_data_import()
  lib/fonts: Store font data for user space with font_data_export()
  lib/fonts: Remove internal symbols and macros from public header file

 drivers/video/console/newport_con.c |  61 +++-----
 drivers/video/fbdev/core/bitblit.c  |  11 +-
 drivers/video/fbdev/core/fbcon.c    | 194 +++++++----------------
 drivers/video/fbdev/core/fbcon.h    |   8 +-
 drivers/video/fbdev/core/fbmem.c    |   6 +-
 include/linux/console_struct.h      |  59 ++++++-
 include/linux/fb.h                  |  10 +-
 include/linux/font.h                | 115 +++++++++-----
 lib/fonts/font.h                    |  38 +++++
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
 lib/fonts/fonts.c                   | 232 +++++++++++++++++++++++++++-
 24 files changed, 514 insertions(+), 267 deletions(-)
 create mode 100644 lib/fonts/font.h


base-commit: 3594e3a9ce7d4ad237f43ff907e9744446108603
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
prerequisite-patch-id: a5a973e527c88a5b47053d7a72aefe0b550197cb
prerequisite-patch-id: 719d09751d38f5da743beed6266585ee063e1e29
prerequisite-patch-id: 5030de433a01c2e99056cadb676a8e2ba35f055a
prerequisite-patch-id: f7831e8fe81681bbe7fcd7b8455753f5ab4ada2d
-- 
2.53.0

