Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE415445D
	for <linux-fbdev@vger.kernel.org>; Thu,  6 Mar 2025 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270401; cv=none; b=HDAkx29lK5g77C7rcnyJWNh0Bus0lqwG682iJ9HefT7QVGWM6myQj5WXn4W/PeV0WtZSQGDHfqreFFquFIIF8TkLnVq2G/frgQG/f7A1iPEedygYSG5oBDLK3tSgq1ESTaOT7jxwBsPAaep3aqE0KDoybfEg4cC+I6XqQ2uM3CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270401; c=relaxed/simple;
	bh=KHUA6zoaPMlvYn6h6tjDE4dEHKvvRy1I2RIJD3pBxdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5o8Li8pWx0WTRPAQBurUH7XAEzrO+T2OBHWRuIVqMjkWbDjw1eNIray0tiL+R8I2Mu8f5S/X6qo8d0HOwoHm/A58MUFQEIDVAGRrsjbON+abt5QPB1dD4MO9ke0qU3safmRo2R6vrwmGJdYuKbzRZY4SQ09wj5iK5GWF4PCUy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ddva6WTd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j7QLhG7H; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ddva6WTd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j7QLhG7H"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7FE22211C4;
	Thu,  6 Mar 2025 14:13:10 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741270390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWTOYrufwiAbc5O6fcIIPW0hK7s4rdre+ZjYKolcnDE=;
	b=Ddva6WTdmBu5hUVKGU08pt5MTNYQWAILn262VbFL+XVHJu5Si1MNTU40JMQC+hSEUdwifx
	Gn/VOfnXJXkNiiWYNhrSJ0EvIlxfUhv+G8HNGUa/UPONz2hgWfvHfnfO7m5nA1t9JOBftQ
	Pn7a4CMLBeHEnoB6VlBiYGYKHH7lsU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741270390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWTOYrufwiAbc5O6fcIIPW0hK7s4rdre+ZjYKolcnDE=;
	b=j7QLhG7HapB5oV0sDrRKV0+YiCh7OiVGKyrJuh5vSfCQC8t4kBW9zkwcWGJ44crXwWlQBA
	fmRqOH+eOUCN2EDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3397913AC3;
	Thu,  6 Mar 2025 14:13:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wBVHC3atyWeveQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 06 Mar 2025 14:13:10 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	pavel@ucw.cz,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	simona@ffwll.ch
Cc: linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 03/11] fbdev: Send old blank state in FB_EVENT_BLANK
Date: Thu,  6 Mar 2025 15:05:45 +0100
Message-ID: <20250306140947.580324-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306140947.580324-1-tzimmermann@suse.de>
References: <20250306140947.580324-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7FE22211C4
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

The event FB_EVENT_BLANK sends the new blank state in the event's
data field. Also send the old state. It's an additional field in the
data array; existing receivers won't notice the difference.

The backlight subsystem currently tracks blank state per display per
backlight. That is not optimal as it ties backlight code to fbdev. A
subsystem should not track internal state of another subsystem. With
both, new and old, blank state in FB_EVENT_BLANK, the backlight code
will not require its own state tracker any longer.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 5d1529d300b7..9650b641d8e8 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -343,6 +343,7 @@ int fb_blank(struct fb_info *info, int blank)
 {
 	int old_blank = info->blank;
 	struct fb_event event;
+	int data[2];
 	int ret;
 
 	if (!info->fbops->fb_blank)
@@ -351,8 +352,10 @@ int fb_blank(struct fb_info *info, int blank)
 	if (blank > FB_BLANK_POWERDOWN)
 		blank = FB_BLANK_POWERDOWN;
 
+	data[0] = blank;
+	data[1] = old_blank;
 	event.info = info;
-	event.data = &blank;
+	event.data = data;
 
 	info->blank = blank;
 
-- 
2.48.1

