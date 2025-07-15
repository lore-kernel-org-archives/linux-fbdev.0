Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A72AB665
	for <linux-fbdev@vger.kernel.org>; Tue, 15 Jul 2025 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582623; cv=none; b=Hhd8sVci6OZr1eOxcLXdLxz8NQJvuvx8RvUJW58O2QQ1SPiX8P7J057k+Isb6tImreps3QtWxR9v84C/zfth3wRr39IXuv7OQTkaZ5Ihq0JLqAi7IERktsZ3CjGmnRMZQLUcGGqHE7t48g+A+Wm6czQqZ7bW5/OuCRRfNDLyBeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582623; c=relaxed/simple;
	bh=+bUs6Om91Iemd4aNlQLLeyHt4EK3O9b92SUCrVC1jUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r89PfIG0qJYFq2xxR2CUEyagrPtQ167BSHPjBm9hwFo5z2OU0gi3HgHqCGwmO88bcF5G9i3b3scn4YnIliHJ5+BLt/Fz2y9ra30CxK3JdcZukOflpkRw9ryqerz840ioHiJtR9K+tuhIzuvyakyEfjShGEHb7dY6rZfxvMUvMWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d3Ur0ggF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z0yvktK2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d3Ur0ggF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z0yvktK2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d3Ur0ggF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z0yvktK2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d3Ur0ggF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z0yvktK2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 05C0E21245;
	Tue, 15 Jul 2025 12:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752582603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfMA5jpuUju64NgKFNvWoBRdK8wrazN//HzlWpdAV1U=;
	b=d3Ur0ggFJ0Dxe4iE0Ze9MUQHdF4X48OmpY2al5Uo3i8B2YJpX0pXVECbjm4HY8kp6/2+Fk
	UmNsKx62f/yKSW542oU5LO5HEGrXyESdu+k6VSKkxpj2M9Ley1nUsbrg64nHHtSzcHJMp3
	oLuF5e/9gbKlwXdO+e2wdDtrS9lOELA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752582603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfMA5jpuUju64NgKFNvWoBRdK8wrazN//HzlWpdAV1U=;
	b=z0yvktK2iC2I/l3rMsrHLSq7BC+vipxyMu0m+RUAT9PWUYUddoIoRn7cN3joPvrA6ik3Fq
	dshIgUTkJm39FZDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752582603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfMA5jpuUju64NgKFNvWoBRdK8wrazN//HzlWpdAV1U=;
	b=d3Ur0ggFJ0Dxe4iE0Ze9MUQHdF4X48OmpY2al5Uo3i8B2YJpX0pXVECbjm4HY8kp6/2+Fk
	UmNsKx62f/yKSW542oU5LO5HEGrXyESdu+k6VSKkxpj2M9Ley1nUsbrg64nHHtSzcHJMp3
	oLuF5e/9gbKlwXdO+e2wdDtrS9lOELA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752582603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfMA5jpuUju64NgKFNvWoBRdK8wrazN//HzlWpdAV1U=;
	b=z0yvktK2iC2I/l3rMsrHLSq7BC+vipxyMu0m+RUAT9PWUYUddoIoRn7cN3joPvrA6ik3Fq
	dshIgUTkJm39FZDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A17E13306;
	Tue, 15 Jul 2025 12:30:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kL2FGMpJdmgaIwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 15 Jul 2025 12:30:02 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	deller@gmx.de,
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
	support.opensource@diasemi.com,
	duje.mihanovic@skole.hr
Cc: dri-devel@lists.freedesktop.org,
	asahi@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 13/15] backlight: rave-sp: Include <linux/of.h> and <linux/mod_devicetable.h>
Date: Tue, 15 Jul 2025 14:24:50 +0200
Message-ID: <20250715122643.137027-14-tzimmermann@suse.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250715122643.137027-1-tzimmermann@suse.de>
References: <20250715122643.137027-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,oss.qualcomm.com,gmx.de,linux.intel.com,ffwll.ch,jannau.net,redhat.com,rosenzweig.io,gompa.dev,diasemi.com,skole.hr];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to(RLpx6hatunazuh7ud675imbh78),to_ip_from(RLc48bcaq7qz9wekwjsx9fywoc)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -1.30

Include <linux/of.h> to declare struct device_node and include
<linux/mod_devicetable.h> to declare struct of_device_id. Avoids
dependency on backlight header to include it.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/rave-sp-backlight.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/rave-sp-backlight.c b/drivers/video/backlight/rave-sp-backlight.c
index e708a060a6e4..bfe01b9b9174 100644
--- a/drivers/video/backlight/rave-sp-backlight.c
+++ b/drivers/video/backlight/rave-sp-backlight.c
@@ -9,8 +9,10 @@
 
 #include <linux/backlight.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mfd/rave-sp.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 
 #define	RAVE_SP_BACKLIGHT_LCD_EN	BIT(7)
-- 
2.50.0

