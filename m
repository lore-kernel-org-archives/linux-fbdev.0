Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2011824B41
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Feb 2024 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335588; cv=none; b=iTvI84yuxYX0LshQoRv6jLZdQTZPtnWQrMllFxlOkvssVARbcYYNlpoJ4e3q+xli8D84DpiB3kI1z29XHyx07cCmytIIxaF8j7fRjFDCsLsPKtNQ44U6BGK/Es6A64jfC5g1XSyEh1UtDdChFJ746xIj4uOMEIiU+DMk7xZ+clo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335588; c=relaxed/simple;
	bh=kZcL6iGE/puxT7534eCdQQtj8MVxBN/6zW2WZo4Gw0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GAG5nsGuOkB5lsHCSbGyywEi5JgSFur+l9JzDxXcJnFBuGLtwHrqFmBHcOrPLmGn150ugi6YwKZfsZT5zx8uFRO+wEsXIG27LS6viMRQZ2JCszBuzhncYgD+yhu1FfXrrdihKc9FkH65NBb6r/52kw8OGb4Zc8Ap9WWk6aKPQMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aAwWDS6A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wrK37o3g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aAwWDS6A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wrK37o3g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aAwWDS6A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wrK37o3g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aAwWDS6A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wrK37o3g"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B1BE21F28;
	Mon, 19 Feb 2024 09:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708335585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kwaOK6GI6Msr0F+kF9F2ZVfr6JT7D+gYl1OyAl6DMWw=;
	b=aAwWDS6ApZRVcUcETN9hkezvMENG8fupo2mkuFAqP2Os03RR9f6Y7O4/OGISz/3vTdV5WB
	Oc0xYU4uzEIHroW5V5wVjjzFhsE45H/O+7ZsPfKIqgXC7ktRSH1on7XC6M+ogY0TWVNNMm
	obhTGYYOenZ2oKui16/y3MbnWxUWUdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708335585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kwaOK6GI6Msr0F+kF9F2ZVfr6JT7D+gYl1OyAl6DMWw=;
	b=wrK37o3gMwxCZnPnGeUHiR4IfDZDKSmjGoL6hnWhIL9FJD2qYvvkzJLFpOKvgaXWLKkyoj
	M6Rtvg8PcOjlHsAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708335585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kwaOK6GI6Msr0F+kF9F2ZVfr6JT7D+gYl1OyAl6DMWw=;
	b=aAwWDS6ApZRVcUcETN9hkezvMENG8fupo2mkuFAqP2Os03RR9f6Y7O4/OGISz/3vTdV5WB
	Oc0xYU4uzEIHroW5V5wVjjzFhsE45H/O+7ZsPfKIqgXC7ktRSH1on7XC6M+ogY0TWVNNMm
	obhTGYYOenZ2oKui16/y3MbnWxUWUdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708335585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kwaOK6GI6Msr0F+kF9F2ZVfr6JT7D+gYl1OyAl6DMWw=;
	b=wrK37o3gMwxCZnPnGeUHiR4IfDZDKSmjGoL6hnWhIL9FJD2qYvvkzJLFpOKvgaXWLKkyoj
	M6Rtvg8PcOjlHsAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D88F713585;
	Mon, 19 Feb 2024 09:39:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id RGArM+Ah02XlUAAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 19 Feb 2024 09:39:44 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	kherbst@redhat.com,
	lyude@redhat.com,
	dakr@redhat.com,
	jani.nikula@linux.intel.com,
	daniel@ffwll.ch,
	airlied@gmail.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-staging@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 0/9] fbdev: Clean up include dependencies in header
Date: Mon, 19 Feb 2024 10:37:25 +0100
Message-ID: <20240219093941.3684-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aAwWDS6A;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wrK37o3g
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmx.de,redhat.com,linux.intel.com,ffwll.ch,gmail.com,linuxfoundation.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[30.03%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 1.49
X-Rspamd-Queue-Id: 3B1BE21F28
X-Spam-Flag: NO

Remove unnecessary dependencies in the include statements of the
header file <linux/fb.h>. Several files throughout the kernel include
the fbdev header, so reducing dependencies positively affects other
subsystems as well. Also fix up corgi-lcd, nouveau and fbtft, which
need backlight.h in some of their source files.

v3:
	* include backlight.h in corgi-lcd (kernel test robot)
	* grammar fixes in commit messages
v2:
	* include backlight.h in fbtft (kernel test robot)

Thomas Zimmermann (9):
  backlight/corgi-lcd: Include <linux/backlight.h>
  drm/nouveau: Include <linux/backlight.h>
  staging/fbtft: Include <linux/backlight.h>
  fbdev: Do not include <linux/backlight.h> in header
  fbdev: Do not include <linux/fs.h> in header
  fbdev: Do not include <linux/notifier.h> in header
  fbdev: Do not include <linux/slab.h> in header
  fbdev: Clean up forward declarations in header file
  fbdev: Clean up include statements in header file

 drivers/gpu/drm/nouveau/dispnv50/disp.c |  1 +
 drivers/staging/fbtft/fb_ssd1351.c      |  2 ++
 drivers/video/backlight/corgi_lcd.c     |  1 +
 include/linux/fb.h                      | 24 +++++++++++++-----------
 4 files changed, 17 insertions(+), 11 deletions(-)

-- 
2.43.0

