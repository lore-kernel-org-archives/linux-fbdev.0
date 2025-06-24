Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6642BD035
	for <linux-fbdev@vger.kernel.org>; Tue, 24 Jun 2025 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773120; cv=none; b=dcl/qRSLeJsJNceDbmKyG1g+DhoVZzVt3QeSsD6Wa3ok3A/aJBT0xOx+ltXT1js5vZqJYYnOai6BgS8ctyENd+6+eiN5B/QBqhb2CMjG6oMq83S4FMnu3OG9672G/s1Uqp1OaF6rhYmomPSiUhjNmK1iEjA/dqRoE6ZbcD+2aKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773120; c=relaxed/simple;
	bh=XNZa8kdgsi/LebFHKiYdHCId1njAHooPccZ/KCWwzk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgdNUMnIiz3sUy4ykDkvKFM4DtAaNgFR4SgchPSGP57D/7RdZ5uoU1rYXNGDUxHKUHh1OINFBwAkdC44h5N6fBeDg0Sm08RsoSD0LJbMkcCwPS3LOw3khIHO7y+PFWXbClAvEnQGIOelvc/0wvf/v7qrrlFfqbDAdg10qRJEMgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C9D101F745;
	Tue, 24 Jun 2025 13:51:50 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2203813A96;
	Tue, 24 Jun 2025 13:51:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2LsZB3atWmjFcQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 24 Jun 2025 13:51:50 +0000
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
	Hans de Goede <hansg@kernel.org>
Subject: [PATCH v2 01/15] platform/x86: dell-uart-backlight: Use blacklight power constant
Date: Tue, 24 Jun 2025 15:45:41 +0200
Message-ID: <20250624134858.1736090-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250624134858.1736090-1-tzimmermann@suse.de>
References: <20250624134858.1736090-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: C9D101F745
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.00

The backlight subsystem has gotten its own power constants. Replace
FB_BLANK_UNBLANK with BACKLIGHT_POWER_ON.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Hans de Goede <hansg@kernel.org>
Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/dell/dell-uart-backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/platform/x86/dell/dell-uart-backlight.c
index 8f868f845350..f323a667dc2d 100644
--- a/drivers/platform/x86/dell/dell-uart-backlight.c
+++ b/drivers/platform/x86/dell/dell-uart-backlight.c
@@ -305,7 +305,7 @@ static int dell_uart_bl_serdev_probe(struct serdev_device *serdev)
 	dev_dbg(dev, "Firmware version: %.*s\n", resp[RESP_LEN] - 3, resp + RESP_DATA);
 
 	/* Initialize bl_power to a known value */
-	ret = dell_uart_set_bl_power(dell_bl, FB_BLANK_UNBLANK);
+	ret = dell_uart_set_bl_power(dell_bl, BACKLIGHT_POWER_ON);
 	if (ret)
 		return ret;
 
-- 
2.50.0

