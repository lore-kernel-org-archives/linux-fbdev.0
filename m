Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953CF2EA179
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Jun 2025 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249689; cv=none; b=X9G7hPqZG5jF24Atq5Ppyczv9ExEzpvZhpsnLBD5YSjjB3VbjqqKpcx53QhHONqTny6KfdpR2ErNxALlOnbu2Nbr0tTZN+JZ3TfV43EacF0RXJeXAbaDBiuEeFFOzvAhZGqJ4etoFTE0Ty98sraE/38NX0mTR7HD25p4lTTBBdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249689; c=relaxed/simple;
	bh=xkMRbXKM+HW2C5NdUCABt63h6BeBoXO/nVqRpcB9ltU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQTqyqmzmkK2RjWc/yj3Z5uvW6RzMJTj8THpcnMMPBRoV/AXcEAYMImpCi3Kg0tvtaBvO53Bk8bgrjuRgk9fQZLx/6zD/qy/gqKZiPRcCJw1GScVuvx9+edRcX8W9sd93aED4Q7lF+EHHeIkPx5CG6Fw1Ge/OK8UwGHfYsqNoss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5EFA1F7CA;
	Wed, 18 Jun 2025 12:27:41 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01C4413721;
	Wed, 18 Jun 2025 12:27:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cFDNOrywUmg4UgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 18 Jun 2025 12:27:40 +0000
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
Subject: [PATCH 10/12] backlight: ktd2801: Include <linux/mod_devicetable.h>
Date: Wed, 18 Jun 2025 14:16:42 +0200
Message-ID: <20250618122436.379013-11-tzimmermann@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: A5EFA1F7CA
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
2.49.0

