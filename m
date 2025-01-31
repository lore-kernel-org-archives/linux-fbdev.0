Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF7B1C8FD4
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jan 2025 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738332076; cv=none; b=IDnjR/5Ji0a+gOE3vbHpu2mWHrbAgJP/GWFljIamSQdugotmU2EZwuWumrdh0XUeckzbY+od9A6yy8ZNXotde3ql+InYmuzqOBuIFF/iN1/fczUJMfMpKYWD4fIBjg4iH6YVSorp7jT6jC7FQUt8klxvppQv1rbdpZa4ki9xYDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738332076; c=relaxed/simple;
	bh=ofy09DuL66VPM2E6myCh0LsAT+2PECjEkO70U6dAfng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sP3IGSnp5jFVUPZKUQWKXWn7IczLCzj2lRWyaO84NdT61nAIKWFID8u83COB1iCo4YGs41Wskl+z+5XnZvxg9MhlwGqF7CuWTvrNu4/fG2nVh8h6FabdNiXeSMqq2SyoNO640fn6eFC1jRQyWuwL/FWI7/GSu5NxcMRRpqEq9ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oYow7gIX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QFUmM4RZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oYow7gIX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QFUmM4RZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oYow7gIX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QFUmM4RZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oYow7gIX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QFUmM4RZ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 965AA2116F;
	Fri, 31 Jan 2025 14:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738332072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpDd0TIYzuCeM8DUsoX8hSKVajIuHJ6nKlybjfb8xUs=;
	b=oYow7gIXOZGCWG71y3s/k9hW98/ZSvP1GUS4WZX1NzSipcOtjKanYEiAdoHoG6gVWiNtvF
	inQScQmNKGaQzCnd6/4Y560psh/pXPrpRFBdcdiA/fJoSUiJNfJ3n/amYNKwRVqJ4/0t19
	neC6r3KWf35fM+boIIN6n/+X5cbKaeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738332072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpDd0TIYzuCeM8DUsoX8hSKVajIuHJ6nKlybjfb8xUs=;
	b=QFUmM4RZwaUFxCxOPAUvkOKXQ1wRRijyPEtDbaB6BYZWgiVX0RuOwzBwbyyWTPC2yqZNDj
	R2TFRUFpPB0rgNDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738332072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpDd0TIYzuCeM8DUsoX8hSKVajIuHJ6nKlybjfb8xUs=;
	b=oYow7gIXOZGCWG71y3s/k9hW98/ZSvP1GUS4WZX1NzSipcOtjKanYEiAdoHoG6gVWiNtvF
	inQScQmNKGaQzCnd6/4Y560psh/pXPrpRFBdcdiA/fJoSUiJNfJ3n/amYNKwRVqJ4/0t19
	neC6r3KWf35fM+boIIN6n/+X5cbKaeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738332072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpDd0TIYzuCeM8DUsoX8hSKVajIuHJ6nKlybjfb8xUs=;
	b=QFUmM4RZwaUFxCxOPAUvkOKXQ1wRRijyPEtDbaB6BYZWgiVX0RuOwzBwbyyWTPC2yqZNDj
	R2TFRUFpPB0rgNDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 502AB133A6;
	Fri, 31 Jan 2025 14:01:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MGBTEqjXnGfbcQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 31 Jan 2025 14:01:12 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	michael.hennerich@analog.com,
	support.opensource@diasemi.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 15/16] backlight: vgg2432a4: Do not include <linux/fb.h>
Date: Fri, 31 Jan 2025 14:58:46 +0100
Message-ID: <20250131140103.278158-16-tzimmermann@suse.de>
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
 drivers/video/backlight/vgg2432a4.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/vgg2432a4.c b/drivers/video/backlight/vgg2432a4.c
index bfc1913e8b55e..3005eba6c82c7 100644
--- a/drivers/video/backlight/vgg2432a4.c
+++ b/drivers/video/backlight/vgg2432a4.c
@@ -10,7 +10,6 @@
 
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/lcd.h>
 #include <linux/module.h>
-- 
2.48.1

