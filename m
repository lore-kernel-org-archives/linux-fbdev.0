Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A984E4C3D;
	Fri,  9 Oct 2026 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562709; cv=none; b=uuVrduQpOKSSbADzQ5FO5xEfjSs8EXwUmvKLXJWaz6IDmM8ZPTzIGO1G7zA5o1jQRtvnjzgsISVqGOGHcqYSol3PV54u3J+U8G3gjBtapvOhAchNmAL+FKt70nmZqa9uohHkRyvZ/kMXBLs9/Vw36x4sBhFxAtOf/4K3f/C0rcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562709; c=relaxed/simple;
	bh=Oz7hpJnp/lZQtLuta8tPeybNFunQTSdkR9IfsVowbt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8cp8al+6dHmN94T60wHF6ghgBcCFSHAxpu8TbYdaiSCwT5z60qULFgcZaf9lh0eHn19MkRWjDDBbiuRsRQUyoVqaH3XsKXQp7E3tNX9l3By9mwEjeWr9SyFvCzC2cw5USFZk+mIWcI6sEd73/oAGsVBDoOc5KDxN/8O4BeJY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45CD61F7E4;
	Fri,  9 Oct 2026 16:18:17 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7A2C13978;
	Fri,  9 Oct 2026 16:18:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +fTjLccTyWrkFwAAD6G6ig:T4
	(envelope-from <tzimmermann@suse.de>); Fri, 09 Oct 2026 16:18:16 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	adaplas@gmail.com,
	michal.simek@amd.com
Cc: linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/5] fbdev/sa1100fb: Remove comment on VESA DPMS modes
Date: Fri,  9 Oct 2026 18:05:37 +0200
Message-ID: <20261009161814.120480-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009161814.120480-1-tzimmermann@suse.de>
References: <20261009161814.120480-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spam-Flag: NO
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 45CD61F7E4
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [0.00 / 50.00]
X-Spam-Score: 0.00

Fbdev and its drivers use FB_BLANK constants for controlling the
display's blanking state. Semantics differ to similar VESA blanking
constants.

Remove the comment on VESA constants from sa1100fb. It's misleading at
best, as the driver should never use the VESA constants for blanking.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/sa1100fb.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index fea0172c45b5..8102ab7d51e6 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -491,35 +491,6 @@ sa1100fb_set_cmap(struct fb_cmap *cmap, int kspc, int con,
 }
 #endif
 
-/*
- * Formal definition of the VESA spec:
- *  On
- *  	This refers to the state of the display when it is in full operation
- *  Stand-By
- *  	This defines an optional operating state of minimal power reduction with
- *  	the shortest recovery time
- *  Suspend
- *  	This refers to a level of power management in which substantial power
- *  	reduction is achieved by the display.  The display can have a longer
- *  	recovery time from this state than from the Stand-by state
- *  Off
- *  	This indicates that the display is consuming the lowest level of power
- *  	and is non-operational. Recovery from this state may optionally require
- *  	the user to manually power on the monitor
- *
- *  Now, the fbdev driver adds an additional state, (blank), where they
- *  turn off the video (maybe by colormap tricks), but don't mess with the
- *  video itself: think of it semantically between on and Stand-By.
- *
- *  So here's what we should do in our fbdev blank routine:
- *
- *  	VESA_NO_BLANKING (mode 0)	Video on,  front/back light on
- *  	VESA_VSYNC_SUSPEND (mode 1)  	Video on,  front/back light off
- *  	VESA_HSYNC_SUSPEND (mode 2)  	Video on,  front/back light off
- *  	VESA_POWERDOWN (mode 3)		Video off, front/back light off
- *
- *  This will match the matrox implementation.
- */
 /*
  * sa1100fb_blank():
  *	Blank the display by setting all palette values to zero.  Note, the
-- 
2.55.0

