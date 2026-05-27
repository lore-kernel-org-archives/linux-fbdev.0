Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6CF2ECE91
	for <linux-fbdev@vger.kernel.org>; Wed, 27 May 2026 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894960; cv=none; b=FpzyFOk3zV94nchZxTplcmo0qhjK3U22kvIB1AflAElwdgTHlVDP9V0xOqbBi9wPEZj3MuU6WmPlMd5YuvPTnq+tW2Y7obk+TDppQrTDtRDTao6e6DueF3ojMmhT45tlxnWQ/QkoZjxAM6kT5R8gYYcOEzghYftDhH7vMgkHsIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894960; c=relaxed/simple;
	bh=865utLaQm01zMFhaL9ArvbQ3aue9OkJfjp6OFr0GOBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCsJiuDWUST4Rb7HoyzXzFSz0tHqFqJ6JXaF0PP5Iv5tpvKOnNNZkVHJEXzVK8WYHZAZq5IrhsCwkBqSOTo7R3ZWytqaTn2Lh9HbHbn2PMeMBVC24jecNXPQdxe/BkP5yKJT0rwIIpGMuTNUnvOKCC+Jot5+/9ubhP0Tb2bdpz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EgDs66DT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mfwVqURc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EgDs66DT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mfwVqURc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EgDs66DT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mfwVqURc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EgDs66DT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mfwVqURc"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BB596A9B1;
	Wed, 27 May 2026 15:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779894955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BwKD8u/oFzgxbvk0UW8C8FJ0orKlewT3AkmJOJgnQXw=;
	b=EgDs66DTREZMPkqpwlSW7x3i5hxMbdCzFi9MujxugNSU+OA9XEklbUXmWtCF1y+H+ikJ6Y
	uXQa47jzn+Cwbnyp7yquxz3a29yXy6CW9EqE9Jf6pmU0Z5Y+kSxasL2D503QiOZNd+sNNv
	/TgxXUQRA535R9+Fb4JcqeYuNoHHYDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779894955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BwKD8u/oFzgxbvk0UW8C8FJ0orKlewT3AkmJOJgnQXw=;
	b=mfwVqURcXjstDdXst6R+1tJatuARK/bqZoM3AR2T9cvK/Ub6zljgI/GlruyxHphJju8Zvy
	CunfSqDNRrfWptDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779894955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BwKD8u/oFzgxbvk0UW8C8FJ0orKlewT3AkmJOJgnQXw=;
	b=EgDs66DTREZMPkqpwlSW7x3i5hxMbdCzFi9MujxugNSU+OA9XEklbUXmWtCF1y+H+ikJ6Y
	uXQa47jzn+Cwbnyp7yquxz3a29yXy6CW9EqE9Jf6pmU0Z5Y+kSxasL2D503QiOZNd+sNNv
	/TgxXUQRA535R9+Fb4JcqeYuNoHHYDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779894955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BwKD8u/oFzgxbvk0UW8C8FJ0orKlewT3AkmJOJgnQXw=;
	b=mfwVqURcXjstDdXst6R+1tJatuARK/bqZoM3AR2T9cvK/Ub6zljgI/GlruyxHphJju8Zvy
	CunfSqDNRrfWptDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA48E5A8C1;
	Wed, 27 May 2026 15:15:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QMq3N6oKF2p6FQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 27 May 2026 15:15:54 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	geert@linux-m68k.org,
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
Subject: [PATCH v3 0/4] fbdev: Internalize fbcon
Date: Wed, 27 May 2026 17:14:01 +0200
Message-ID: <20260527151551.258659-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmx.de,linux-m68k.org,ffwll.ch,gmail.com,wunner.de,linux.ibm.com,ellerman.id.au,kernel.org];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]

Turn fbcon into an internal client of fbdev. Manage all interactions
with graphics drivers within fbdev. Add helpers for these tasks and
convert drivers.

Fbdev's PS3 and SH-Mobile drivers update fbcon as part of user-invoked
mode changes. Call the new helpers, which also fix inconsistencies
among the various code paths.

Vga-switcheroo remaps the fbcon terminals when switching physical
outputs. For now, hide this in another helper. The call will later
move into DRM's fbdev emulation.

With all refactoring in place, fbdev manages fbcon interactions by
itself. Remove the public interfaces.

v3:
- resolve vga-switcheroo dependencies wrt fbcon (Geert)
v2:
- use '#if defined' (Helge)

Thomas Zimmermann (4):
  fbdev: Wrap user-invoked calls to fb_set_var() in helper
  fbdev: Wrap user-invoked calls to fb_blank() in helper
  fbdev: Wrap fbcon updates from vga-switcheroo in helper
  fbdev: Do not export fbcon from fbdev

 MAINTAINERS                            |  1 -
 drivers/gpu/vga/Kconfig                |  2 +-
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
 13 files changed, 99 insertions(+), 88 deletions(-)
 delete mode 100644 include/linux/fbcon.h


base-commit: 5fb5a9a63cf5ece68e0eeb6fa397da27712bccf0
-- 
2.54.0

