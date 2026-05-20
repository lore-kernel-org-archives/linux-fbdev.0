Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20880356762
	for <linux-fbdev@vger.kernel.org>; Wed, 20 May 2026 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293612; cv=none; b=Hf1TCvQxiPX1E2UzNnZ49fe/AzJgC+iWNNr77MrOcxsHNQbxGfSZXuGfc1XVliGeq5OOL8aDdiEpsnJ0vGaNp0LgIM07OiF/CDcN+/xDPpaxToUJ3JXjlTEFRh+rfZ3MqBH80NEo+0Dtv0HqGYe/2USjs9jCPNRknkH46Zw7e4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293612; c=relaxed/simple;
	bh=ipvu7x73LnSGJw4QcSHnkLCb1phmOW5eORVeTCYHdLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XtPdAP/hkwOEJOIXU5o/urMMgnFbRny1kUj9uy4wW8GSK98dziiOTqtUY5vjfIpEAj100ldCaHIRmjLQ4lHlEKHsyu+JCaSStn6jKDeWuf+t8sRrDsWuN+T/GcJ7RpBDnc2VGWJYGAs2AZdvqbjB3HNyBGwmYZnho6tnqoI+4SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dwTKUIdn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Lt3vjNt0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dwTKUIdn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Lt3vjNt0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dwTKUIdn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Lt3vjNt0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dwTKUIdn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Lt3vjNt0"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A62A6BAB5;
	Wed, 20 May 2026 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779293274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BsIHtmKMljMz7z5PREYhvn3TDXWyUdpRgr9wgteuRFs=;
	b=dwTKUIdnMGhcIj5IYEaBkI0IBx6iyWGBppuPdWRhme62X8ZZ1twGD9ITsuMdBjdJtkj1ez
	ujFrXsGEnytMDtwRb6GTvGRSS5YPU+1DntFP3ccAt19CzxLAHEExY1jSm2DAn/3mcXdz0Z
	hGKK7J7OTuIu7mtoSvg6gXxxOgz69yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779293274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BsIHtmKMljMz7z5PREYhvn3TDXWyUdpRgr9wgteuRFs=;
	b=Lt3vjNt0H0Ob8JlzBUOJ//Yhp+FroFF77zOFWU/yGTs5/tBXpSYbJ3if7Z7/uIqoNU84l0
	mBhgpfUsfTo5iKAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779293274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BsIHtmKMljMz7z5PREYhvn3TDXWyUdpRgr9wgteuRFs=;
	b=dwTKUIdnMGhcIj5IYEaBkI0IBx6iyWGBppuPdWRhme62X8ZZ1twGD9ITsuMdBjdJtkj1ez
	ujFrXsGEnytMDtwRb6GTvGRSS5YPU+1DntFP3ccAt19CzxLAHEExY1jSm2DAn/3mcXdz0Z
	hGKK7J7OTuIu7mtoSvg6gXxxOgz69yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779293274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BsIHtmKMljMz7z5PREYhvn3TDXWyUdpRgr9wgteuRFs=;
	b=Lt3vjNt0H0Ob8JlzBUOJ//Yhp+FroFF77zOFWU/yGTs5/tBXpSYbJ3if7Z7/uIqoNU84l0
	mBhgpfUsfTo5iKAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E748F593AA;
	Wed, 20 May 2026 16:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DGLON1ncDWqwWgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 20 May 2026 16:07:53 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch,
	airlied@gmail.com,
	lukas@wunner.de,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/4] fbdev: Internalize fbcon
Date: Wed, 20 May 2026 18:00:35 +0200
Message-ID: <20260520160744.130841-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmx.de,ffwll.ch,gmail.com,wunner.de,linux.ibm.com,ellerman.id.au,kernel.org];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Turn fbcon into an internal client of fbdev. Manage all interactions
with graphics drivers within fbdev. Add helpers for these tasks and
convert drivers.

Fbdev's PS3 and SH-Mobile drivers update fbcon as part of user-invoked
mode changes. Call the new helpers, which also fix inconsistencies
among the various code paths.

Vga-switcheroo remaps the fbcon terminals when switching physical
outputs. For now, hide this in another helper. The call will later
move into DRM's fbdev emulation.

When all refactoring in place, fbdev manages fbcon interactions by
itself. Remove the public interfaces.

Thomas Zimmermann (4):
  fbdev: Wrap user-invoked calls to fb_set_var() in helper
  fbdev: Wrap user-invoked calls to fb_blank() in helper
  fbdev: Wrap fbcon updates from vga-switcheroo in helper
  fbdev: Do not export fbcon from fbdev

 MAINTAINERS                            |  1 -
 drivers/gpu/vga/vga_switcheroo.c       |  6 +--
 drivers/video/fbdev/core/fb_chrdev.c   | 12 ++----
 drivers/video/fbdev/core/fb_internal.h |  1 +
 drivers/video/fbdev/core/fbcon.c       |  3 --
 drivers/video/fbdev/core/fbcon.h       | 50 +++++++++++++++++++++++
 drivers/video/fbdev/core/fbmem.c       | 35 +++++++++++++++-
 drivers/video/fbdev/core/fbsysfs.c     |  9 +----
 drivers/video/fbdev/ps3fb.c            |  5 +--
 drivers/video/fbdev/sh_mobile_lcdcfb.c |  5 +--
 include/linux/fb.h                     |  3 ++
 include/linux/fbcon.h                  | 55 --------------------------
 12 files changed, 98 insertions(+), 87 deletions(-)
 delete mode 100644 include/linux/fbcon.h


base-commit: 121c16f9d8c56ea07263df84ab971cc10870fe88
-- 
2.54.0

