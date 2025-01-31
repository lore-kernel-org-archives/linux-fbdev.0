Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2C5339A8
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jan 2025 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738332073; cv=none; b=MuWVS45RkP84+sex3NIlPtYAh+9SzzW0QXcdXxQdPj12NK7gYk/rWpgYbklQ6nUY3vBrMa8HcrykSi21D2RbrzGoryL5ln8KsxJqLbVw/tdkIZ/bsVo40wriPtDOTkoptP4l/rTxOJEkNLRmMpL4HHRINp//A69NzX38clj5aG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738332073; c=relaxed/simple;
	bh=8ikvBBuqzBKB0E25H70XoME9mz4GYa78PBFY4Livark=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpzXFEwKINMGGKw8vWZboSlU+oJwPNnRzciou3UmehZ5Hz/TV41roO5LLHsrnBjQ13YvlAuvW69HQ0lv+IKfvRO/z51833F32JKWrycNPLsWD+J35RMn1WyScbhZOBYc9Ec9AEyhYHX2VgF0T/G8s1hDib+0B9HjlNm+VYn0mfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fXajsUZC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gu1qDwWy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fXajsUZC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gu1qDwWy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fXajsUZC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gu1qDwWy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fXajsUZC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gu1qDwWy"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C6A1B2116B;
	Fri, 31 Jan 2025 14:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738332069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYKMc2A//rX8y0XzyX5jmLlgGG0hcFXpJOoHuK/sQuE=;
	b=fXajsUZC7N2GmsqksNMXf8QkNHvQ4XjzQpKXi7s6mtSibxHt8uUGjy7mHQZMFJaOwP0f+2
	Tw2BC1gHEYmy7PGH9h5v1nGvD25KBY8m4UPg4UZKk8UgipsAPfFlPKRA7Xc+fnVAdgF40q
	emM8pv0RtyHnyOX0fPGB832EN8/sfoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738332069;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYKMc2A//rX8y0XzyX5jmLlgGG0hcFXpJOoHuK/sQuE=;
	b=gu1qDwWy/n/BQRrNavxeQs/0EDEeLBzMLzkdi4Fqt6TsvrazEEdWcbtbw5WDX6+s10S+Q7
	Mp197nclF8Bv3iBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738332069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYKMc2A//rX8y0XzyX5jmLlgGG0hcFXpJOoHuK/sQuE=;
	b=fXajsUZC7N2GmsqksNMXf8QkNHvQ4XjzQpKXi7s6mtSibxHt8uUGjy7mHQZMFJaOwP0f+2
	Tw2BC1gHEYmy7PGH9h5v1nGvD25KBY8m4UPg4UZKk8UgipsAPfFlPKRA7Xc+fnVAdgF40q
	emM8pv0RtyHnyOX0fPGB832EN8/sfoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738332069;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYKMc2A//rX8y0XzyX5jmLlgGG0hcFXpJOoHuK/sQuE=;
	b=gu1qDwWy/n/BQRrNavxeQs/0EDEeLBzMLzkdi4Fqt6TsvrazEEdWcbtbw5WDX6+s10S+Q7
	Mp197nclF8Bv3iBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83056133A6;
	Fri, 31 Jan 2025 14:01:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2E3FHqXXnGfbcQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 31 Jan 2025 14:01:09 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	michael.hennerich@analog.com,
	support.opensource@diasemi.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 06/16] backlight: bd6107_bl: Do not include <linux/fb.h>
Date: Fri, 31 Jan 2025 14:58:37 +0100
Message-ID: <20250131140103.278158-7-tzimmermann@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
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
X-Spam-Score: -6.80
X-Spam-Flag: NO

This driver does not require <linux/fb.h>. Remove the include
statement.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/bd6107.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlight/bd6107.c
index 90764f83d2f12..74567af84e97f 100644
--- a/drivers/video/backlight/bd6107.c
+++ b/drivers/video/backlight/bd6107.c
@@ -10,7 +10,6 @@
 #include <linux/backlight.h>
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/fb.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-- 
2.48.1

