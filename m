Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91A530BB94
	for <linux-fbdev@vger.kernel.org>; Thu,  9 Apr 2026 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719639; cv=none; b=eILTT0w91fPIEj/pPS8uGNhjK+jJHU18ZxE7jkIS3tGLbnnllp6GRq8r0BgQC4lSsj7J5rxEKBsefvduzXvwc0sP4d9UFNz2XaPGl8EYveP2Q1ZDZ3imAfK8TUecD0zlWHZMnHcgPkhbBQ6NpdR3Mv3AaiIa9H+5NXE1fnWuDvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719639; c=relaxed/simple;
	bh=72xcIRY0RyHFugLmPzfdXG6+6oEp8my+sR82saRlGPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AbuoVn4HZ2xM3VkUezqMbvWayZ9XCJ0y9WS/SfR121hV7terC/hxOnXkxR5JFOlu8WTs7OMhJhEjdDQBH++1B9R6jsKj3GMdl0sG2wkMK0kgCeGvM2yQmORfTSaEX7bIqYXKcpSS0W3e8fgYghnI8kC0RsI0jneV7G/kmwieXa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dr9xzTk4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lu/fj+YZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W+DOzxck; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MLAPGoKM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dr9xzTk4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lu/fj+YZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W+DOzxck";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MLAPGoKM"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 062B34EDFB;
	Thu,  9 Apr 2026 07:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775719636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5l8iEbVSJ/iO+Sg9NaZxX6rd+AtK0+GSi2e9EwTIJH8=;
	b=Dr9xzTk45PbTPQFp6HAO8oLhL/smBDkNSWgMvnGrsPj6cMMnxEOgZkQVzYnX/oHHY8TkSC
	8AjQ4j1RXi42ZPNoYyneg+9YdCOlo6gmlYTbarGn8FeEW1x+ASZVJZGoki19sNp6iZdDTD
	xNnmR165NzIgqT5dXqh8FhQQhcQSJX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775719636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5l8iEbVSJ/iO+Sg9NaZxX6rd+AtK0+GSi2e9EwTIJH8=;
	b=lu/fj+YZZDHOm7S3SWmplC5rMqblfkdOH7tGqNG8N8S3NbRSXRc8Ey5gpciez6PMwwny2v
	SBnbjpFUvCcDTsBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775719635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5l8iEbVSJ/iO+Sg9NaZxX6rd+AtK0+GSi2e9EwTIJH8=;
	b=W+DOzxckF6xeD2TV+dKWH2sBQvFeW+NtTq2bF8+7OyOkSOOhcRCMSlfjYXsb6hd+byZHtW
	ocxSmRO9IFRikafPhzOViq3ZmU3MXel/ujt0QKCU80OvMPxhhj/yNdH48s6LxGkM928rR5
	9njRkWjziRO1azUE/eAt5xxKFvy9M9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775719635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5l8iEbVSJ/iO+Sg9NaZxX6rd+AtK0+GSi2e9EwTIJH8=;
	b=MLAPGoKMFg78PG3zaldxVbntnkkRTWVDAJMZlkn3fp18HGuzUYAFKeMCZsj0OPzkOIce20
	8MbpC5LLOC8/WMCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7A524A0B3;
	Thu,  9 Apr 2026 07:27:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CC1OL9JU12maUAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 09 Apr 2026 07:27:14 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2] MAINTAINERS: Add dedicated entry for fbcon
Date: Thu,  9 Apr 2026 09:26:09 +0200
Message-ID: <20260409072711.12500-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[billm.au:url,lists.freedesktop.org:email,ffwll.ch:email,suse.de:mid,suse.de:email,gitlab.freedesktop.org:url,gmx.de:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmx.de,ffwll.ch];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Add an own entry for the framebuffer console code, which is jointly
used by the fbdev and DRM drivers.

v2:
- add Helge as maintainer
- list font and include files
- update commit message (Helge)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 MAINTAINERS | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e80296449ba..66769dcf5faa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10091,6 +10091,29 @@ S:	Maintained
 W:	https://floatingpoint.billm.au/
 F:	arch/x86/math-emu/
 
+FRAMEBUFFER CONSOLE
+M:	Helge Deller <deller@gmx.de>
+M:	Thomas Zimmermann <tzimmermann@suse.de>
+L:	dri-devel@lists.freedesktop.org
+L:	linux-fbdev@vger.kernel.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/fb/fbcon.rst
+F:	drivers/video/fbdev/core/bitblit.c
+F:	drivers/video/fbdev/core/fb_logo.c
+F:	drivers/video/fbdev/core/fbcon.c
+F:	drivers/video/fbdev/core/fbcon.h
+F:	drivers/video/fbdev/core/fbcon_ccw.c
+F:	drivers/video/fbdev/core/fbcon_cw.c
+F:	drivers/video/fbdev/core/fbcon_rotate.c
+F:	drivers/video/fbdev/core/fbcon_rotate.h
+F:	drivers/video/fbdev/core/fbcon_ud.c
+F:	drivers/video/fbdev/core/softcursor.c
+F:	drivers/video/fbdev/core/tileblit.c
+F:	include/linux/fbcon.h
+F:	include/linux/font.h
+F:	lib/fonts/
+
 FRAMEBUFFER CORE
 M:	Simona Vetter <simona@ffwll.ch>
 S:	Odd Fixes
-- 
2.53.0

