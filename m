Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3099219E804;
	Wed, 20 Nov 2024 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111061; cv=none; b=qg3iV2cfmUq85zjlpfDDyZ0UnjhkajmtiGdwxM+mjs61cFu0IeCDg3Fc+Dy/crFLDk5mAHDCdiNBz4FrjWWM9U1tvKjdPTcjSjya+XUdS6uPQxsEJnX0e/mHUDGzdIpG5H9IQY0tb9U88UYATq8RCTn16S+eYdQdjQQ9srqe5Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111061; c=relaxed/simple;
	bh=1ERZ6fOi6BU8Qxio0+0d4KwScBGQan7Alj22HVwIGng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ownivJLuAG4gWt35QtkgRwtRmfTangp22mYJFjcglxwYqDdLggrNSBqxM4eFQdLVHiO4QoZ4tkNJgQFgA+lYkAP9sWo/KOlI126JxMzmmKBCP9qoadN+C2VA0JKyvXv/K6te/0lzwZaotJEYdlwi2PslZD+AWe1PrwrL7p0RUMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LVA/NzK/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ej6EaNNU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LVA/NzK/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ej6EaNNU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LVA/NzK/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ej6EaNNU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LVA/NzK/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ej6EaNNU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 826FF219E3;
	Wed, 20 Nov 2024 13:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732111057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=95q/eQjrFsjKAC4Bo3PIaetIW5NSqwy1FT+F/0l4/No=;
	b=LVA/NzK/d6lHIdZvmZtKOUyk3HZ1jMmuZ2G96qMocOdKKEDA71E6vJvg6QcDniZHNFvClk
	7gWVXgKxD6K1wW44QmWFlGY4iqUkcg3Jfoct+BvBY4df5pAq7P7d1TQPTr/KX+WLOdTR/i
	mYWL+Zt6qqa4YZlHrQxeku5JCRzTWqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732111057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=95q/eQjrFsjKAC4Bo3PIaetIW5NSqwy1FT+F/0l4/No=;
	b=ej6EaNNUZLtYG/383n37mfk9VthCTCIN6MExjROYs46/KgsyZtWEVmGhwRdWk2GnTXnbUZ
	hviyaLBcHr4BN1Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732111057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=95q/eQjrFsjKAC4Bo3PIaetIW5NSqwy1FT+F/0l4/No=;
	b=LVA/NzK/d6lHIdZvmZtKOUyk3HZ1jMmuZ2G96qMocOdKKEDA71E6vJvg6QcDniZHNFvClk
	7gWVXgKxD6K1wW44QmWFlGY4iqUkcg3Jfoct+BvBY4df5pAq7P7d1TQPTr/KX+WLOdTR/i
	mYWL+Zt6qqa4YZlHrQxeku5JCRzTWqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732111057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=95q/eQjrFsjKAC4Bo3PIaetIW5NSqwy1FT+F/0l4/No=;
	b=ej6EaNNUZLtYG/383n37mfk9VthCTCIN6MExjROYs46/KgsyZtWEVmGhwRdWk2GnTXnbUZ
	hviyaLBcHr4BN1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12E3D13297;
	Wed, 20 Nov 2024 13:57:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9WFXAtHqPWcjKQAAD6G6ig
	(envelope-from <pperego@suse.de>); Wed, 20 Nov 2024 13:57:37 +0000
From: Paolo Perego <pperego@suse.de>
To: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Paolo Perego <pperego@suse.de>,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH v2] staging:fbtft: Using str_true_false() helper instead of hardcoded strings
Date: Wed, 20 Nov 2024 14:57:27 +0100
Message-ID: <20241120135727.376556-1-pperego@suse.de>
X-Mailer: git-send-email 2.47.0
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.de,linaro.org,kernel.org,intel.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Using str_true_false() helper instead of hardcoded strings.

Signed-off-by: Paolo Perego <pperego@suse.de>
---
v2: 
* Used a shorter email subject
* Added a commit message
* The email subject now contains kernel subsytem

 drivers/staging/fbtft/fb_ssd1351.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
index f6db2933ebba..6736b09b2f45 100644
--- a/drivers/staging/fbtft/fb_ssd1351.c
+++ b/drivers/staging/fbtft/fb_ssd1351.c
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
+#include <linux/string_choices.h>
 
 #include "fbtft.h"
 
@@ -162,7 +163,7 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
 static int blank(struct fbtft_par *par, bool on)
 {
 	fbtft_par_dbg(DEBUG_BLANK, par, "(%s=%s)\n",
-		      __func__, on ? "true" : "false");
+		      __func__, str_true_false(on));
 	if (on)
 		write_reg(par, 0xAE);
 	else
-- 
2.47.0

