Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71224EB845;
	Fri,  9 Oct 2026 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562717; cv=none; b=ew/PIO1idHBECwmV50gmwbLJ7ZTJG4VD8tihgddwUkvBm4Kyy6bEqHBTAARV87iHph/oX2Qjbv8+blgG1MibV6Sv5ufIWtl8QG9wMFRufie2agcgQH6D2R0o0Q9v/p0mAIpXTHlb5Rkqd/9BSdC0f25Hyk99BcYNl14UM9lHS3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562717; c=relaxed/simple;
	bh=evJrrx6rmEr7PiaOe4V/yvVJBwFnSEHX9PXsRgfKGA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZcU8+eORC9Evn1YmlS7AM2rJNGsIYgUHvJIUh2HmUrnMnw+sOFzXhZ/kAgEXwAwvdH5mW2+QQUXWBF9cOS7TEq05TPKQqaarI8mYnmQcoPZYIBelDqymBQtFZyFbswVqWxd+blMJYiyl2eyCDWpx3XialUbKSgTXVn9g5Ncbtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8824721C28;
	Fri,  9 Oct 2026 16:18:17 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 342A11368B;
	Fri,  9 Oct 2026 16:18:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +fTjLccTyWrkFwAAD6G6ig:T5
	(envelope-from <tzimmermann@suse.de>); Fri, 09 Oct 2026 16:18:17 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	adaplas@gmail.com,
	michal.simek@amd.com
Cc: linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 4/5] fbdev/platinumfb: Use FB blanking constants
Date: Fri,  9 Oct 2026 18:05:38 +0200
Message-ID: <20261009161814.120480-5-tzimmermann@suse.de>
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
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 8824721C28
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 0.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.00 / 50.00]

Fbdev and its drivers use FB_BLANK constants for controlling the
display's blanking state. Semantics differ to similar VESA blanking
constants.

Replace the VESA constants with FB_BLANK in platinumfb. The VESA
constants can be interpreted bitwise, while the FB_BLANK constants
can not. Therefore turn the bit tests in an if-else sequence that
handles the individual cases. By default, the display is unblanked.

The modified code is within a comment block, so it will not run. I
still changed it to keep the driver up to standard. This might also
resolve the nearby TODO comment on incorrect hardware blanking.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/platinumfb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/platinumfb.c
index 81fdaa3541db..b55a7b70d31d 100644
--- a/drivers/video/fbdev/platinumfb.c
+++ b/drivers/video/fbdev/platinumfb.c
@@ -167,10 +167,12 @@ static int platinumfb_blank(int blank,  struct fb_info *fb)
 	ctrl = le32_to_cpup(&info->platinum_regs->ctrl.r) | 0x33;
 	if (blank)
 		--blank_mode;
-	if (blank & VESA_VSYNC_SUSPEND)
-		ctrl &= ~3;
-	if (blank & VESA_HSYNC_SUSPEND)
+	if (blank == FB_BLANK_VSYNC_SUSPEND)
+		ctrl &= ~0x03;
+	else if (blank == FB_BLANK_HSYNC_SUSPEND)
 		ctrl &= ~0x30;
+	else if (blank == FB_BLANK_POWERDOWN)
+		ctrl &= ~0x33;
 	out_le32(&info->platinum_regs->ctrl.r, ctrl);
 */
 /* TODO: Figure out how the heck to powerdown this thing! */
-- 
2.55.0

