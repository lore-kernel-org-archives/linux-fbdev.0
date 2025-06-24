Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30112C15B2
	for <linux-fbdev@vger.kernel.org>; Tue, 24 Jun 2025 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773135; cv=none; b=mTQUcYlqMpJ2eHiGVSYPQeZzPDkZ2I5rKWBmjdbNqcHXENHoVvrM6tY/B07XdTZweMbhlpaNQQt0l1qDuguYmwNymFc3FD2FxLJMGYJjB+T5H8PDNtlUUapW+Nsna1zehtUfv7lZXum2KfSY+NCIA7B9GciX1cViWUcU4vVzFyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773135; c=relaxed/simple;
	bh=hGOHY5EqX24PHULoKaFcv7QLGg52McD4wj4R0vVCqTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CudV6MtWf+ssAgtcJ/5+FOONFQHOEQFBpJh9mhx8LuPfgDHUyt+JS70FaPMG2rVpMV9FfbzGf9k3NLQ0z4x65OovSFLBw6kTv6JGw5CyOA7vvogXf8Tb/P+9W35QOjBAqldXLU+fEJhjXrreUxFl9ApfpbNfwIxaD0Ga1gkUYG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46DC321192;
	Tue, 24 Jun 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FE5113751;
	Tue, 24 Jun 2025 13:51:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OAK9IXytWmjFcQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 24 Jun 2025 13:51:56 +0000
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
Subject: [PATCH v2 10/15] backlight: jornada720: Include <linux/io.h>
Date: Tue, 24 Jun 2025 15:45:50 +0200
Message-ID: <20250624134858.1736090-11-tzimmermann@suse.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250624134858.1736090-1-tzimmermann@suse.de>
References: <20250624134858.1736090-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 46DC321192
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00

Include <linux/io.h> to declare IOMEM(). Avoids dependency on
backlight header to include it.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/jornada720_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/jornada720_bl.c b/drivers/video/backlight/jornada720_bl.c
index e28d2c071798..bbb65fdaddc7 100644
--- a/drivers/video/backlight/jornada720_bl.c
+++ b/drivers/video/backlight/jornada720_bl.c
@@ -7,6 +7,7 @@
 
 #include <linux/backlight.h>
 #include <linux/device.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-- 
2.50.0

