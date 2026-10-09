Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E084E781A;
	Fri,  9 Oct 2026 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562700; cv=none; b=ml4nFg++AvXdmyNE9z3Nt9j8a3WQl8SvMzADzMd8hZ5nFJWkJsz8SFZROoKE2/He3Jk9SmrVn9izTJAKwiuAviYTmhHKJNZViw9mIIqltBXNZqy1giT7mWvvb0kfjwBODZjam0mLfftka09w1ZWXoBSdvbbGtZQvIw26Bq8GAM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562700; c=relaxed/simple;
	bh=kUp5Xgh0QT6CO2aCHf+gDl7CP39VATL+auT/glQwgB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lWpeNxRrlI5+Og3taZ99oxEdaJP+tDA06Assd7fncr0QKsrnetCQ6j2GmzcS6T0WrorbBh3QjRbxJmPKfEyXEqlyA4Aff9dGwfzOjNrk9JiQqtkhCs1Mxa6p4Mo5eggh0Y4KgYKsw+eQ1UnwWilX+FP/winFsMf/51GeNGaKJGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7C17921C0F;
	Fri,  9 Oct 2026 16:18:16 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 235281368B;
	Fri,  9 Oct 2026 16:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +fTjLccTyWrkFwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 09 Oct 2026 16:18:15 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	adaplas@gmail.com,
	michal.simek@amd.com
Cc: linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/5] fbdev: Remove use of VESA constants
Date: Fri,  9 Oct 2026 18:05:34 +0200
Message-ID: <20261009161814.120480-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
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
X-Rspamd-Queue-Id: 7C17921C0F
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [0.00 / 50.00]
X-Spam-Score: 0.00

Fbdev and its drivers use FB_BLANK constants for controlling the display
blanking state in the fb_blank callback. Several drivers implement the
callback with VESA constants; thus mixing up semantics.

Update the drivers to use VESA constants instead.

Some background: the VESA constants describe DPMS levels for monitor
singal generation. VESA_NO_BLANKING means that the sync signals are on,
although the display adapter might not transfer meaningful pixel data.
The constants FB_BLANK_NORMAL represents this case in fbdev, while
FB_BLANK_UNBLANK represents enabled sync signal generation plus pixel
data. Fbdev drivers using VESA constants therefore often contain
off-by-one errors.

Thomas Zimmermann (5):
  fbdev/au1100fb: Use FB blanking constants
  fbdev/i810fb: Use FB blanking constants
  fbdev/sa1100fb: Remove comment on VESA DPMS modes
  fbdev/platinumfb: Use FB blanking constants
  fbdev/xilinxfb: Use FB blanking constants

 drivers/video/fbdev/au1100fb.c       | 18 ++++++++---------
 drivers/video/fbdev/i810/i810_main.c |  2 +-
 drivers/video/fbdev/platinumfb.c     |  8 +++++---
 drivers/video/fbdev/sa1100fb.c       | 29 ----------------------------
 drivers/video/fbdev/xilinxfb.c       |  2 +-
 5 files changed, 16 insertions(+), 43 deletions(-)

-- 
2.55.0

