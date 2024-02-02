Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2290822067
	for <linux-fbdev@vger.kernel.org>; Fri,  2 Feb 2024 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875308; cv=none; b=BkqlU2npv9x+CjSmHNAuag4PPm2WUjJfyzrlzEfV1tXvXzWeX9ZDZQTk6ECbgcy/dCKXc/p7QEr5e4V+KdCo4S8dCeScytf63LhNreeP0ovVlAEEYXQs3eKJuLjW3h89/myBVAWyWkrBRzq6kfd4s6W+ZzB9+jor1l3e/vWc/gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875308; c=relaxed/simple;
	bh=BPuyv1+QkAFGhfvH8ry0LwzZjIIeYLUzu9h3EckZANI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Du8x0S+KOvpylxN/Dwkl5ES18IYHppbhyf2FEzrbRws4H2L42m/MeMLmGje7KGkmGapmkbJcvJRQAACV7zR1fUtMUrSfSiCzqDqhc8dc+7N2zPEdMkUCrNdathWIxd5iQKos+O/d8HrPb3oJu17bV4ea7+8nxOs/J1ehnSxXNq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XF1FUfhi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2PL2445C; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XF1FUfhi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2PL2445C; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XF1FUfhi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2PL2445C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XF1FUfhi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2PL2445C"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C61321C0D;
	Fri,  2 Feb 2024 12:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706875303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZbxhHAoZ9bg8jxuHcZosFggE6/XnxqgtERLEBbxYTBQ=;
	b=XF1FUfhiBDX4sqvo3Zjn94CNbYEEnELyPaRler3Dm2WeaU72cUpE1dAdFQxrvFQq0wg6TF
	pwyqPIAQt6nLMfje0MyhnvY82DPGj7ChY4AAheRhXTm0QqbOw5xk3xhU9BfqhbR3VmXi0p
	z/KvKCSCwT1Y5HAwHlqPOMnCJml6VSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706875303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZbxhHAoZ9bg8jxuHcZosFggE6/XnxqgtERLEBbxYTBQ=;
	b=2PL2445C7lU5VbCZgivZZGB22wL4TQeptYs3MO7lRH483Go9Mr/x7aNJpH2vDYoOxK5tLP
	I3xui7f2wqi8zuCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706875303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZbxhHAoZ9bg8jxuHcZosFggE6/XnxqgtERLEBbxYTBQ=;
	b=XF1FUfhiBDX4sqvo3Zjn94CNbYEEnELyPaRler3Dm2WeaU72cUpE1dAdFQxrvFQq0wg6TF
	pwyqPIAQt6nLMfje0MyhnvY82DPGj7ChY4AAheRhXTm0QqbOw5xk3xhU9BfqhbR3VmXi0p
	z/KvKCSCwT1Y5HAwHlqPOMnCJml6VSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706875303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZbxhHAoZ9bg8jxuHcZosFggE6/XnxqgtERLEBbxYTBQ=;
	b=2PL2445C7lU5VbCZgivZZGB22wL4TQeptYs3MO7lRH483Go9Mr/x7aNJpH2vDYoOxK5tLP
	I3xui7f2wqi8zuCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF94F13A58;
	Fri,  2 Feb 2024 12:01:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id toZuNabZvGWfeAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 02 Feb 2024 12:01:42 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	pjones@redhat.com,
	deller@gmx.de,
	ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/8] firmware/sysfb: Track parent device for screen_info
Date: Fri,  2 Feb 2024 12:58:41 +0100
Message-ID: <20240202120140.3517-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XF1FUfhi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2PL2445C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[redhat.com,gmx.de,kernel.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 2C61321C0D
X-Spam-Flag: NO

Detect the firmware framebuffer's parent device from the global
screen_info state and set up the framebuffer's device accordingly.
Remove the equivalent functionality from efifb. Other drivers for
firmware framebuffers, such as simpledrm or vesafb, now add these
new features.

Patches 1 and 2 provide a set of helper functions to avoid parsing
the screen_info values manually. Decoding screen_info is fragile and
many drivers get it wrong. We should later adopt these helpers in
existing drivers, such as efifb, vesafb, as well.

Patches 3 and 4 set the firmware framebuffer's parent device. There
is code in efifb to do something similar for power management. That
is now obsolete and being cleaned up. Setting the parent device makes
Linux track the power management correctly.

Patches 5 and 6 track the parent device's enable state. We don't
create framebuffer devices if the underlying hardware device has been
disabled. Remove the functionality from efifb.

Patches 7 and 8 track the parent device's PCI BAR location. It can
happen on aarch64 that the firmware framebuffer moves its location
during the kernel's boot. We now fix up the screen_info state to
point to the correct location. Again remove such functionality from
efifb.

v2:
	* small refactorings throughout the patchset

Thomas Zimmermann (8):
  video: Add helpers for decoding screen_info
  video: Provide screen_info_get_pci_dev() to find screen_info's PCI
    device
  firmware/sysfb: Set firmware-framebuffer parent device
  fbdev/efifb: Remove PM for parent device
  firmware/sysfb: Create firmware device only for enabled PCI devices
  fbdev/efifb: Do not track parent device status
  firmware/sysfb: Update screen_info for relocated EFI framebuffers
  fbdev/efifb: Remove framebuffer relocation tracking

 drivers/firmware/Kconfig            |   1 +
 drivers/firmware/sysfb.c            |  49 +++++++++-
 drivers/firmware/sysfb_simplefb.c   |   5 +-
 drivers/video/Kconfig               |   4 +
 drivers/video/Makefile              |   4 +
 drivers/video/fbdev/efifb.c         |  97 +-----------------
 drivers/video/screen_info_generic.c | 146 ++++++++++++++++++++++++++++
 drivers/video/screen_info_pci.c     | 140 ++++++++++++++++++++++++++
 include/linux/screen_info.h         | 126 ++++++++++++++++++++++++
 include/linux/sysfb.h               |   3 +-
 10 files changed, 480 insertions(+), 95 deletions(-)
 create mode 100644 drivers/video/screen_info_generic.c
 create mode 100644 drivers/video/screen_info_pci.c

-- 
2.43.0

