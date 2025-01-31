Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21B01C8FB5
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jan 2025 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738332075; cv=none; b=clDdLz9+7uRdlhvS+Ew/4jPn2o5qOBGi/YYgDK0+JanWgGURueZi5cAF/PjFug5ohAt+lsX89FLGAK40bFn2t9DHyufBmzdTbWmOPB4f0W9hnEyLoZxcGUBpNQ5tZ2+pU8XwrDOailZwQRBY8MU1NbyFWf37ujp4i1Ps7e5kogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738332075; c=relaxed/simple;
	bh=CHqssPX8PL8UngoMl9GFJTv4WB06+qG8MYtDgdumJ/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGR4rKf4e8tz1FTlbFv2le6u9AZ1/FML7G3sKqhRIsj6RNW0WuSvvPcwdoI1X4KoNFBn2OlasjsMND6jn83fuw4uIqGBZ6hyoZLlIWdhm0KYQOO13zGeBI2sM0jXxSbtNQiaqdzwuhWn1CaXfu8BX8sC8Ov6qVowPU8Jwb+g5lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l+gb1SJq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DRoAmseB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l+gb1SJq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DRoAmseB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l+gb1SJq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DRoAmseB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l+gb1SJq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DRoAmseB"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07C2E2116E;
	Fri, 31 Jan 2025 14:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738332072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWOdgc7zPR+OXhkNKCTndOMEfg2mAAXQ7aVZpb6Yoz4=;
	b=l+gb1SJqgSbN0E0Iz8cHA/LlnKd/SW1YLc+Gw+wcTAPu6rRe8WypeQ+bbKjOWdXIKYsH39
	jkqBkuVkhs6VyZzlp/ANvdeWXv0Tvs36B66NFXEuKfXbM27IXJEW/ux0Gs2sqCXFOxNcDv
	ogg+rzpxH+Eq63TTmc0MhO/45+gId0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738332072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWOdgc7zPR+OXhkNKCTndOMEfg2mAAXQ7aVZpb6Yoz4=;
	b=DRoAmseB+1CPhlzD7dbMTZSZaEBHlK7u95O1PFDK934SUFZw9+/1ytgUxK3xTQnTR0zhTm
	YO1Mgbf2cmQIwgAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738332072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWOdgc7zPR+OXhkNKCTndOMEfg2mAAXQ7aVZpb6Yoz4=;
	b=l+gb1SJqgSbN0E0Iz8cHA/LlnKd/SW1YLc+Gw+wcTAPu6rRe8WypeQ+bbKjOWdXIKYsH39
	jkqBkuVkhs6VyZzlp/ANvdeWXv0Tvs36B66NFXEuKfXbM27IXJEW/ux0Gs2sqCXFOxNcDv
	ogg+rzpxH+Eq63TTmc0MhO/45+gId0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738332072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWOdgc7zPR+OXhkNKCTndOMEfg2mAAXQ7aVZpb6Yoz4=;
	b=DRoAmseB+1CPhlzD7dbMTZSZaEBHlK7u95O1PFDK934SUFZw9+/1ytgUxK3xTQnTR0zhTm
	YO1Mgbf2cmQIwgAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA912133A6;
	Fri, 31 Jan 2025 14:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SGhKKKfXnGfbcQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 31 Jan 2025 14:01:11 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	michael.hennerich@analog.com,
	support.opensource@diasemi.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 13/16] backlight: max8925_bl: Do not include <linux/fb.h>
Date: Fri, 31 Jan 2025 14:58:44 +0100
Message-ID: <20250131140103.278158-14-tzimmermann@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131140103.278158-1-tzimmermann@suse.de>
References: <20250131140103.278158-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,analog.com,diasemi.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLegg5g4pk98t76ga9u9jr5icm)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

This driver does not require <linux/fb.h>. Remove the include
statement.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/max8925_bl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/max8925_bl.c b/drivers/video/backlight/max8925_bl.c
index e607ec6fd4bf4..4ac20a59e007f 100644
--- a/drivers/video/backlight/max8925_bl.c
+++ b/drivers/video/backlight/max8925_bl.c
@@ -9,7 +9,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
-#include <linux/fb.h>
 #include <linux/i2c.h>
 #include <linux/backlight.h>
 #include <linux/mfd/max8925.h>
-- 
2.48.1

