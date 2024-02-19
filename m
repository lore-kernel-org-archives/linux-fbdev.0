Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF0724B5B
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Feb 2024 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335593; cv=none; b=VduBZtbBbyut7/xxgcI+Mrh7g6t5TVZfVshfRgtusIiemZ9rnYzMl84pCxiv73Tudr+Vnhe+ml5IN85pGjhdKJfVRsEvir7lg9B2aPjppeJ/4AXqj7giSOAKoi1Ysr/9d/ivhXPwJhqu8q2fZmbDgv14q4no6nzvNsA2HF2KXJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335593; c=relaxed/simple;
	bh=XLM6r7Be1SFw6Yza8YVPzh5Cd0h4BrXOYI7vE1LJWeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiN3dV9pvFZ89aPoJZzpc+6qm+8GgmaaqgOgN6q0pzBpbAZLo+ftiQmmZTIICGCMBw1tMoqDrsxMXZKpSO62yzY0qZ//vNLbcqT2Y4LFAX39nMjTMwAqjmLqWPqty2MKvavSaGLlMVyPaMzmk76EmJOtQPRIo87pi1XWyyO4OTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zD55Id7N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5Z4HGiqK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cXpvsKxq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6PA2F+dk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zD55Id7N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5Z4HGiqK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cXpvsKxq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6PA2F+dk"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 09A881F7E9;
	Mon, 19 Feb 2024 09:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708335589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HRf/3AucYIeKB4F+BU4YJYGITxGyGqrk4NFBPqfOPk=;
	b=zD55Id7NPYkzGZJp6TgT3ECGAAfEm8kke55vQoLntj17XJZycHSVdcxEdgOftJY18V6i5N
	3S90uppdadNa1hs8ICmH/iTx63sRitoRMz4LupCqQfxXeNdztqQ/lcdZj+YdG3AUFFOh7S
	mCEIHoiQ++LeUn6j2DU9n1yz61mWAR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708335589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HRf/3AucYIeKB4F+BU4YJYGITxGyGqrk4NFBPqfOPk=;
	b=5Z4HGiqKVCztSFzTyIUr04f97NkuX58m+yoanU4h7qbQyGbyuyOhDo5n6ENCuX+OOGw+6/
	HNHrQ84+z8uplyDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708335588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HRf/3AucYIeKB4F+BU4YJYGITxGyGqrk4NFBPqfOPk=;
	b=cXpvsKxqvcZNLIdxYOJiCXCS6EBHhuPqYGncgBOFJqNrcVcftmX/a+Bfy9KMZBirOBFEod
	RZ2npZOKTjFbrT+RuzDR7gz19KszNYN8376LWWsDPHQ0dOZL8CIhHQZiltyc4qWx1QNuFG
	+b9s64yPZVTVzVvCFx8W81CJen1zD/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708335588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HRf/3AucYIeKB4F+BU4YJYGITxGyGqrk4NFBPqfOPk=;
	b=6PA2F+dkpNq9eXYTH5K2BjHX28ZMHRfyCDuF/rLrJ50+EFrHwLb2dVNqiSO3SX758QYPfa
	e+8kB9CnxEgUIoBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FB0113A25;
	Mon, 19 Feb 2024 09:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ULXFJeMh02XlUAAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 19 Feb 2024 09:39:47 +0000
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
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v3 3/9] staging/fbtft: Include <linux/backlight.h>
Date: Mon, 19 Feb 2024 10:37:28 +0100
Message-ID: <20240219093941.3684-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219093941.3684-1-tzimmermann@suse.de>
References: <20240219093941.3684-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cXpvsKxq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6PA2F+dk
X-Spamd-Result: default: False [0.57 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 R_RATELIMIT(0.00)[to_ip_from(RLw1715dab7ink4c1kuyfofm5y)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[gmx.de,redhat.com,linux.intel.com,ffwll.ch,gmail.com,linuxfoundation.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.12)[95.77%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.57
X-Rspamd-Queue-Id: 09A881F7E9
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

Resolves the proxy include via <linux/fb.h>, which does not require the
backlight header.

v3:
	* fix grammar in commit message

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Helge Deller <deller@gmx.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/fbtft/fb_ssd1351.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
index b8d55aa8c5c75..72172e870007e 100644
--- a/drivers/staging/fbtft/fb_ssd1351.c
+++ b/drivers/staging/fbtft/fb_ssd1351.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#include <linux/backlight.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-- 
2.43.0

