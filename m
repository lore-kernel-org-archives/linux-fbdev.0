Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D461EA74
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jan 2024 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496132; cv=none; b=q0K86I+eJZpvgnMEuXbFsbt/f0RU3dN3ySuOCocqnTcL1AV7QM5jkgYePelSC3Nt9xRNrWVlSP03q7OrQYS3N35X61+3tnDlFTOm5sQidESnQvfmpuSzmUfW20oIDRFqDKhdA4UIEiK0+HZKs52OU1p9gXBKTOrcKsThwvoxVrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496132; c=relaxed/simple;
	bh=0h+v5Zt3Z8/MmxxYnBDc7fh+HYKJmNU5WOkTCuKhSak=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spamd-Result:X-Spam-Level:X-Spam-Score:X-Spam-Flag; b=oNE51RypQop06eXGYRJ7YMXN294KMiqt/WF/Sk9vQ8JOLI4gdBR+xplih5raLFnJbDA31FfMvpzE7FVC0FQzSAkg++tB7x/bgthsiLk7gE5cbNIt6xjFUFpGsoVRAcVxLhd5ezasqoMFDetK2P38GIPiCmoJEnGCoAjSfR1JHdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LftI7W83; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+4scsQUX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LftI7W83; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+4scsQUX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LftI7W83";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+4scsQUX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LftI7W83";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+4scsQUX"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5067C21F1E;
	Wed, 17 Jan 2024 12:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705496129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=N9NOrtGcWe/7OoAPY9wKEXhutF0rwa6sGozRWEnsGio=;
	b=LftI7W83kz1x7ZVbOJtqNZCgMZclBamhzIIt/rjzOA3A1QSvRQRIDOZWMzDf/JlTtrZNUd
	Su2kXWY9s8/biVDQ0fX9PLmWG5AoF56si6u2b32iiK7WJjV+Gv/aMcwMKfmkprb65wX/uf
	uLYS93sHJL3rT2GuC0M177lL/x0tCQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705496129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=N9NOrtGcWe/7OoAPY9wKEXhutF0rwa6sGozRWEnsGio=;
	b=+4scsQUXx2stkIWSRjwCicW4Opzmwcp3MuAz2FUFQFG9D05Br2gDAq5eedQnWrp40+RFdA
	OVireYxHsLpMfXBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705496129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=N9NOrtGcWe/7OoAPY9wKEXhutF0rwa6sGozRWEnsGio=;
	b=LftI7W83kz1x7ZVbOJtqNZCgMZclBamhzIIt/rjzOA3A1QSvRQRIDOZWMzDf/JlTtrZNUd
	Su2kXWY9s8/biVDQ0fX9PLmWG5AoF56si6u2b32iiK7WJjV+Gv/aMcwMKfmkprb65wX/uf
	uLYS93sHJL3rT2GuC0M177lL/x0tCQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705496129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=N9NOrtGcWe/7OoAPY9wKEXhutF0rwa6sGozRWEnsGio=;
	b=+4scsQUXx2stkIWSRjwCicW4Opzmwcp3MuAz2FUFQFG9D05Br2gDAq5eedQnWrp40+RFdA
	OVireYxHsLpMfXBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15F3513800;
	Wed, 17 Jan 2024 12:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jtAwBEHOp2X1YQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 17 Jan 2024 12:55:29 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	pjones@redhat.com,
	deller@gmx.de,
	ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/8] firmware/sysfb: Track parent device for screen_info
Date: Wed, 17 Jan 2024 13:39:04 +0100
Message-ID: <20240117125527.23324-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[redhat.com,gmx.de,kernel.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: ****
X-Spam-Score: 4.90
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
 drivers/firmware/sysfb.c            |  37 ++++++-
 drivers/firmware/sysfb_simplefb.c   |   5 +-
 drivers/video/Kconfig               |   4 +
 drivers/video/Makefile              |   4 +
 drivers/video/fbdev/efifb.c         |  97 +-----------------
 drivers/video/screen_info_generic.c | 148 ++++++++++++++++++++++++++++
 drivers/video/screen_info_pci.c     | 142 ++++++++++++++++++++++++++
 include/linux/screen_info.h         | 126 +++++++++++++++++++++++
 include/linux/sysfb.h               |   3 +-
 10 files changed, 472 insertions(+), 95 deletions(-)
 create mode 100644 drivers/video/screen_info_generic.c
 create mode 100644 drivers/video/screen_info_pci.c

-- 
2.43.0

