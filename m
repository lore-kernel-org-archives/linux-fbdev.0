Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802111CAA6F
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jan 2025 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738332077; cv=none; b=TuSLbEJvLFl/q5sG0/7iofUD6fMIgRuqMQS4BDGncMrKHCcbrFFkYDE/ML9TFxvztZkxzczRZcD8WpeaEu0bO1+cyCAgcN41cfkgX+Z1TINYQFBHUXTz2FCbpCBHX+NQo5y97QCJWM3FXaRSwnwqY0f38BuaG8rfZ3iGHP7kSBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738332077; c=relaxed/simple;
	bh=wd0o7Jvb540sYnEe3p4KYDebv36YVvHr2cjhczyd2h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kbb9WR/eH7AQxvooI5fLgf4OjfNDjlz4jRxehbTI1CULl2FqyA45Js4ChEcf1CR8RpSasOaaCW4gRcJQK6g28Ji0br15rBEtWMk9VJxGRpxNwzvtPvqz4hxlebBUHmr+9uUEQw1yPxqKM6zWjS2+1Z6pnzwNVmwudoKSkzbuCU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zr8M+KhR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rIdAqksO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zr8M+KhR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rIdAqksO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zr8M+KhR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rIdAqksO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zr8M+KhR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rIdAqksO"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 692EB1F395;
	Fri, 31 Jan 2025 14:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738332070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQXfkTKYHmCU52v6o2Jlu7GlE9D86aXEUevnnOUdkaM=;
	b=zr8M+KhRtoQNLyC0QKKXURj6qWD1F8uSQeBm2bgylDVE/fbqdgZvsZOKGQbg8hHaZYiV/p
	ESxOJQjdQGQm5E/zEMqvda662VohR0900BQSBwWmWj+ez5QozzI75JyrQlBiABTmQP9DGd
	xFwlsnngSLaWRXGLf8jEkGHSZMKMDBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738332070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQXfkTKYHmCU52v6o2Jlu7GlE9D86aXEUevnnOUdkaM=;
	b=rIdAqksOW55+HZm1p1Uf3qMC/kkwcAvvN31X7f4AzGwNU4bbXpCD1C4liJVb4KcuZBAihg
	5NDFl1bdcLqv/sDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738332070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQXfkTKYHmCU52v6o2Jlu7GlE9D86aXEUevnnOUdkaM=;
	b=zr8M+KhRtoQNLyC0QKKXURj6qWD1F8uSQeBm2bgylDVE/fbqdgZvsZOKGQbg8hHaZYiV/p
	ESxOJQjdQGQm5E/zEMqvda662VohR0900BQSBwWmWj+ez5QozzI75JyrQlBiABTmQP9DGd
	xFwlsnngSLaWRXGLf8jEkGHSZMKMDBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738332070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQXfkTKYHmCU52v6o2Jlu7GlE9D86aXEUevnnOUdkaM=;
	b=rIdAqksOW55+HZm1p1Uf3qMC/kkwcAvvN31X7f4AzGwNU4bbXpCD1C4liJVb4KcuZBAihg
	5NDFl1bdcLqv/sDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25B69133A6;
	Fri, 31 Jan 2025 14:01:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0A3PB6bXnGfbcQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 31 Jan 2025 14:01:10 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	michael.hennerich@analog.com,
	support.opensource@diasemi.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 08/16] backlight: da9052_bl: Do not include <linux/fb.h>
Date: Fri, 31 Jan 2025 14:58:39 +0100
Message-ID: <20250131140103.278158-9-tzimmermann@suse.de>
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
	BAYES_HAM(-3.00)[99.99%];
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
 drivers/video/backlight/da9052_bl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/da9052_bl.c b/drivers/video/backlight/da9052_bl.c
index 5e13ef96b717c..f41523d78121b 100644
--- a/drivers/video/backlight/da9052_bl.c
+++ b/drivers/video/backlight/da9052_bl.c
@@ -9,7 +9,6 @@
 
 #include <linux/backlight.h>
 #include <linux/delay.h>
-#include <linux/fb.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-- 
2.48.1

