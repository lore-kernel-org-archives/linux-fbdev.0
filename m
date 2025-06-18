Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928362E8E17
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Jun 2025 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249678; cv=none; b=njP4Ax7J+8jyDivMa7pHRYSJSs5NkuacLCqXCjq7mdHpx7kwasnF58FIqWP0Gr/r+MELIWpA1CavBufiyafU/nixNcJDuJOE3L1BLThMXbPF4GCWsfh2cTNtLwzkIpB0MLkWOyzvVdy4V2U9aObv+KSH6grBKqCkbq6Cq62YmBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249678; c=relaxed/simple;
	bh=sZ+7UZpRCTPKwoC1F/eOmU+A936TlMDcu4zQAyBl/xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Op5jmKCl6h32w6jZMtDZNOfNJN1DnUReNdzVVnC2yOhtZ7XhrRcetlBp8x1iDfBNjZfgFsxmDcnmuaeEkvirRJniL0OxxQwOBKHx3QwQfetJ8JCjmN/JbrIVWMwoez9t31uyAIebER16QEsruktGzFCj+jqWyGBl55Tlc8I6GN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bPTGJpt9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7+ijGGzn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bPTGJpt9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7+ijGGzn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bPTGJpt9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7+ijGGzn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bPTGJpt9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7+ijGGzn"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4335421247;
	Wed, 18 Jun 2025 12:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750249660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RgXOq2Vm8JL4DrDgHl/mbGF/SqH+2UKsZvpUgVtjO8=;
	b=bPTGJpt9UHPwVnLrwPNauuYg1BTT9lau/wPoahl8jyYs+PBL+3tVJgvj7PRQfVVzLSrn9O
	hjpCmyebsuAxRQ3P2ZjIlRQ58+ju/+tZnh791AeQ7r1ar4KrKRG+JtYiIdBtEq2k9/Od2u
	XI6O3ggaanABqOgAlZqrF/eCuvD1U6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750249660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RgXOq2Vm8JL4DrDgHl/mbGF/SqH+2UKsZvpUgVtjO8=;
	b=7+ijGGznd8H3I1VIEeydbUqinndGyUJriA+AeANDWC/rOwZAqetpEWJUdyPjZcZSEooYAs
	a7meKP5Q2eTXS1Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750249660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RgXOq2Vm8JL4DrDgHl/mbGF/SqH+2UKsZvpUgVtjO8=;
	b=bPTGJpt9UHPwVnLrwPNauuYg1BTT9lau/wPoahl8jyYs+PBL+3tVJgvj7PRQfVVzLSrn9O
	hjpCmyebsuAxRQ3P2ZjIlRQ58+ju/+tZnh791AeQ7r1ar4KrKRG+JtYiIdBtEq2k9/Od2u
	XI6O3ggaanABqOgAlZqrF/eCuvD1U6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750249660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RgXOq2Vm8JL4DrDgHl/mbGF/SqH+2UKsZvpUgVtjO8=;
	b=7+ijGGznd8H3I1VIEeydbUqinndGyUJriA+AeANDWC/rOwZAqetpEWJUdyPjZcZSEooYAs
	a7meKP5Q2eTXS1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EF4A13721;
	Wed, 18 Jun 2025 12:27:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IDy0IbuwUmg4UgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 18 Jun 2025 12:27:39 +0000
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
Subject: [PATCH 08/12] backlight: as3711_bl: Include <linux/of.h>
Date: Wed, 18 Jun 2025 14:16:40 +0200
Message-ID: <20250618122436.379013-9-tzimmermann@suse.de>
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

Include <linux/of.h> to declare various OF helpers. Avoids dependency
on backlight header to include it.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/as3711_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/as3711_bl.c b/drivers/video/backlight/as3711_bl.c
index 9f89eb19894e..753160bbc3e7 100644
--- a/drivers/video/backlight/as3711_bl.c
+++ b/drivers/video/backlight/as3711_bl.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/as3711.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-- 
2.49.0

