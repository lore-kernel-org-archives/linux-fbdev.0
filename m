Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B59FBF2
	for <linux-fbdev@vger.kernel.org>; Mon, 12 Feb 2024 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707728865; cv=none; b=TB37xrtAjan0yKEC7pWFBtRV+lqITgeTLXIgTyC6ybQqL4mT++8lBJXamcX99CbAxxQZJqhyaaCFwAJuMuH2X+5itbNY/l0yNIlUCs6GjCJ7DOv3e+A4VPo5gqPbsL3ThJmHST4fr6G2IDyLvyE5n31byotLbvH2VtRpMdy1Wnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707728865; c=relaxed/simple;
	bh=8XCiqpZ7noIcATbIEGwlxoACcqgKvuqvv6p45P+gpWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dZyemNaDMm4GcWhZQXXUQEXELfROGkymdQPBl2qlxHGmgkoWABZEC2tUkJxk4kuopTAY75WhJMeyWWVooKWmm/7GsVvOnvE3gQ51bOmzrfTnMHjVQDEK1PmvZDtcqIcykI2jnfUUneGg7qVzNgUNdfe9IA9A61L0ZrHAIRsKOVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xm+dzZTE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=quJaPzB0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xm+dzZTE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=quJaPzB0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xm+dzZTE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="quJaPzB0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xm+dzZTE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="quJaPzB0"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 28CFC1F457;
	Mon, 12 Feb 2024 09:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707728861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hHBR/2KzafDsROlbPYcqYXrsN2vBfu5YNMNkVRtC9JM=;
	b=Xm+dzZTE5yxW8eFJnhZAAzI7gjUf2WdFuxoMUiMxl43bumy2o4snLe91Q3FCKchQjZNg27
	cUujjblr/LfbqaMewzXp/z99ktqKauokCpP4md2vKn6eXVOJmdWi42ygLWBGvN1KO7Vewy
	dsL3N7lGQTFJW3qyE05j5lA9ZEh2dy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707728861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hHBR/2KzafDsROlbPYcqYXrsN2vBfu5YNMNkVRtC9JM=;
	b=quJaPzB0KH4hirCbnt13ALM3muoXYpc/JDwfv3DxIraL4HzD/2jy2loED7vmYUh3eylvv6
	HXDo6tax5madHwBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707728861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hHBR/2KzafDsROlbPYcqYXrsN2vBfu5YNMNkVRtC9JM=;
	b=Xm+dzZTE5yxW8eFJnhZAAzI7gjUf2WdFuxoMUiMxl43bumy2o4snLe91Q3FCKchQjZNg27
	cUujjblr/LfbqaMewzXp/z99ktqKauokCpP4md2vKn6eXVOJmdWi42ygLWBGvN1KO7Vewy
	dsL3N7lGQTFJW3qyE05j5lA9ZEh2dy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707728861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hHBR/2KzafDsROlbPYcqYXrsN2vBfu5YNMNkVRtC9JM=;
	b=quJaPzB0KH4hirCbnt13ALM3muoXYpc/JDwfv3DxIraL4HzD/2jy2loED7vmYUh3eylvv6
	HXDo6tax5madHwBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D9BC313212;
	Mon, 12 Feb 2024 09:07:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id vOFxM9zfyWXecwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 12 Feb 2024 09:07:40 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	sui.jingfeng@linux.dev,
	pjones@redhat.com,
	deller@gmx.de,
	ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 0/8] firmware/sysfb: Track parent device for screen_info
Date: Mon, 12 Feb 2024 10:06:08 +0100
Message-ID: <20240212090736.11464-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Xm+dzZTE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=quJaPzB0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[redhat.com,linux.dev,gmx.de,kernel.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 28CFC1F457
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

v4:
	* fix sysfb.h header file
v3:
	* filter PCI device list with pci_get_base_class() (Sui)
	* fix error handling for screen_info_pci_dev() (Sui)
	* fix build for CONFIG_SYSFB_SIMPLEFB=n (Sui)
	* small cleanups
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
 drivers/firmware/sysfb.c            |  51 +++++++++-
 drivers/firmware/sysfb_simplefb.c   |   5 +-
 drivers/video/Kconfig               |   4 +
 drivers/video/Makefile              |   4 +
 drivers/video/fbdev/efifb.c         |  97 +-----------------
 drivers/video/screen_info_generic.c | 146 ++++++++++++++++++++++++++++
 drivers/video/screen_info_pci.c     | 136 ++++++++++++++++++++++++++
 include/linux/screen_info.h         | 126 ++++++++++++++++++++++++
 include/linux/sysfb.h               |   6 +-
 10 files changed, 480 insertions(+), 96 deletions(-)
 create mode 100644 drivers/video/screen_info_generic.c
 create mode 100644 drivers/video/screen_info_pci.c

-- 
2.43.0

