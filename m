Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CDF2C325E
	for <linux-fbdev@vger.kernel.org>; Tue, 24 Jun 2025 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773159; cv=none; b=C1dwl/9TnImltcXprZsl0dNrEshPC3mSDbVvej6mYvdzFlbC4Ni+0NAAxjw5UL+vTiTH67VIvUZqB3jvZU1X4coLggjPrvfC6WQGKi5CUif05xWdV5GdSjbadfp39gVuJc2/OiuWbvMvCAK03H9W2654Y6pbBObJW8QDAaq3c0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773159; c=relaxed/simple;
	bh=QYPLN6dGC5cGmFwspvOIjLRoZStmuOFjEozWkk2g81M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDIpEaMVX8Il20s8Df2eU4cDdCa7VDrPd35TfYamiZSidgUH9mWcKxNZ9y4YdBYEaW3LSrXGrf2KuiiYCpXqRfJcgLdCoMYY2PHzHLykv1rSsKfwJ77IvYcKoYM0P92K8/8jtVsZQE92STEr4TixeyMZC6D1i96nJiPI+Tp9AUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 035601F457;
	Tue, 24 Jun 2025 13:51:58 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C7E813A96;
	Tue, 24 Jun 2025 13:51:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EEZ6EX2tWmjFcQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 24 Jun 2025 13:51:57 +0000
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
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 11/15] backlight: ktd2801: Include <linux/mod_devicetable.h>
Date: Tue, 24 Jun 2025 15:45:51 +0200
Message-ID: <20250624134858.1736090-12-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: 035601F457
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.00

Include <linux/mod_devicetable.h> to declare struct of_device_id.
Avoids dependency on backlight header to include it.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/video/backlight/ktd2801-backlight.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/ktd2801-backlight.c b/drivers/video/backlight/ktd2801-backlight.c
index 0489b0615ceb..17eac1b3bce4 100644
--- a/drivers/video/backlight/ktd2801-backlight.c
+++ b/drivers/video/backlight/ktd2801-backlight.c
@@ -6,6 +6,7 @@
 #include <linux/backlight.h>
 #include <linux/gpio/consumer.h>
 #include <linux/leds-expresswire.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 
-- 
2.50.0

