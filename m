Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14352DE213
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Jun 2025 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249660; cv=none; b=ZubO9kT08KXfkSh6Y/jzIupP60FL6meC1z1F26kVDcTkvGdG3icndfQBBocCcC4oYfqS1PB0orf6/nUISplhWgDH5thDuaUYrF1/dwzjFrgfUcnglHO4bbnOIsfr0h1R1xUZVcFGieWrImJnr2zAcG4yUgKbM0ALH4d5RV5aClc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249660; c=relaxed/simple;
	bh=i7/hnNw5c++OBHc6IA/sHyBhpOgyst1fV50GdP7HM8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWhO1ZxZnaq0hsDxyHezAqUjyhC/vl05tts0AsulM8tN9rzYouZ4CRcCf+ioM+eSVKivfaORz2iPF+spKXlWpLfIwNKrnCgZ9g6b9QxmvoUHzLorxlnpQqUdAp91+oYUlbN4vybj3Rq2exVnPQ1LVOKCbWOv6KbZJl1udnL6bWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m3h7N/+3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0NJUUfNK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=djV8lyUS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4I7MMLe1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m3h7N/+3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0NJUUfNK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="djV8lyUS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4I7MMLe1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E6FFD21228;
	Wed, 18 Jun 2025 12:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750249656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgxvOM6Ho5oWRK1Vd10sNgdzMMaMfCz8Gox7H6IrX4I=;
	b=m3h7N/+3Hi+Ot18RH8G7ftKEVptBqyQmiXvrX5Cm+YPf/h+ROWgwk09rSWinaBIn7SMxV3
	vI6SjiAcWAsTalx94pQEGp6eyCf+kNsQCEzdPql6NU6l0jOZ8fynZ0YuJ4ui/Uh55Hn0EC
	fIQ83zbKeaDZTflMJawxHWnHoZZNp38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750249656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgxvOM6Ho5oWRK1Vd10sNgdzMMaMfCz8Gox7H6IrX4I=;
	b=0NJUUfNKWKOuYU23CQxcAdwDf6cv2F6IoeheKmqOHvaO8g26uJGVDE81Vlhi/sCMCNFDUZ
	AGOYfdxgCikV2KDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750249655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgxvOM6Ho5oWRK1Vd10sNgdzMMaMfCz8Gox7H6IrX4I=;
	b=djV8lyUSI99mL2NgVQ0ADmUqF7JqGzxRbOsfLvSeZ7rTt0TJsB3KmrGwXf9RjGABZQBCWH
	5hq3+wordMOEz0kEaMSxuixy8w5k7rrOzQPoRUA3Hkt+fJ1kZ3oW37XsUUl3NTGDXiz6Mn
	H3vNjQ7KrLDmJN6y31Tj6A4Nz6wH7/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750249655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgxvOM6Ho5oWRK1Vd10sNgdzMMaMfCz8Gox7H6IrX4I=;
	b=4I7MMLe1RwCco2XTvKDnHaO2ZTsX/ccnqpjJFVgU8cQFrVNKvL8sqX+u6uZcMKlDzAQVcY
	eJszW1GVCPFQliCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C53B13721;
	Wed, 18 Jun 2025 12:27:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8IlQDbewUmg4UgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 18 Jun 2025 12:27:35 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	fnkl.kernel@gmail.com,
	j@jannau.net,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	sven@kernel.org,
	alyssa@rosenzweig.io,
	neal@gompa.dev,
	deller@gmx.de,
	support.opensource@diasemi.com,
	duje.mihanovic@skole.hr
Cc: dri-devel@lists.freedesktop.org,
	asahi@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 02/12] drm/panel: panel-samsung-s6e63m0: Include <linux/of.h>
Date: Wed, 18 Jun 2025 14:16:34 +0200
Message-ID: <20250618122436.379013-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618122436.379013-1-tzimmermann@suse.de>
References: <20250618122436.379013-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.30
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,oss.qualcomm.com,linux.intel.com,ffwll.ch,jannau.net,redhat.com,rosenzweig.io,gompa.dev,gmx.de,diasemi.com,skole.hr];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLc48bcaq7qz9wekwjsx9fywoc)];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Spam-Level: 

Include <linux/of.h> to declare device_property_read_u32(). Avoids
dependency on backlight header to include it.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
index ea241c89593b..930948cb615f 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/media-bus-format.h>
-- 
2.49.0

