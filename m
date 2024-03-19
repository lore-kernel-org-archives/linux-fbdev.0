Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF677D084
	for <linux-fbdev@vger.kernel.org>; Tue, 19 Mar 2024 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841167; cv=none; b=D+Fa/oKpNh9W1eKiax1LHqm7UeF1HgOKVbdOtUKvVUVNRv9nXHD8XKXLyBLq1TbV4bNHyGs8rvz8e9Mf2DYpU4vaKxIjQUCtqJY/uojKtPlWhxdX2b1BuHK5cD6EpEcORdgawpgr/MT0DrGWTQGZijRFHpYIwN24/ESOCiy9VIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841167; c=relaxed/simple;
	bh=tx7ym4I8MHggnsZUJdJCIJccs/0EBm9r7yAvEhJGsH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lByQEc9tbHrp3ap0YrJ815RDI3i7iisEKc9Lwfd1cXfze9rkqLLXOt9uX0SreYt707c3GRK3Mb7dYbjh+sF8EwuNSEXjN72Ug57c3IXvl3GvY0J1J8t0Dk5t3Q7vIPNOe268tW2O54ye9qWEwZvhiQv86uQHPDqv1yrmsdDKH3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45AB55D410;
	Tue, 19 Mar 2024 09:39:18 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9D3A13700;
	Tue, 19 Mar 2024 09:39:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kM0ENEVd+WU6GAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 19 Mar 2024 09:39:17 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	andy@kernel.org,
	geert@linux-m68k.org,
	dan.carpenter@linaro.org,
	sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Robin van der Gracht <robin@protonic.nl>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH v2 1/6] auxdisplay: ht16k33: Replace use of fb_blank with backlight helper
Date: Tue, 19 Mar 2024 10:37:20 +0100
Message-ID: <20240319093915.31778-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319093915.31778-1-tzimmermann@suse.de>
References: <20240319093915.31778-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 45AB55D410
X-Spam-Flag: NO

Replace the use of struct backlight_properties.fb_blank with a call
to backlight_get_brightness(). The helper implements similar logic
as the driver's function. It also accounts for BL_CORE_SUSPENDED for
drivers that set BL_CORE_SUSPENDRESUME. Ht16k33 doesn't use this, so
there's no change in behaviour here.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Robin van der Gracht <robin@protonic.nl>
Cc: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Robin van der Gracht <robin@protonic.nl>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

---

v2:
- update commit-message style according to subsystem (Lee)
- declare local var as const (Miguel)
- clarify BL_CORE_SUSPENDED (Miguel)
- fix grammar in commit message (Dan)
---
 drivers/auxdisplay/ht16k33.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index a90430b7d07ba..9081a5797c552 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -314,14 +314,9 @@ static int ht16k33_initialize(struct ht16k33_priv *priv)
 
 static int ht16k33_bl_update_status(struct backlight_device *bl)
 {
-	int brightness = bl->props.brightness;
+	const int brightness = backlight_get_brightness(bl);
 	struct ht16k33_priv *priv = bl_get_data(bl);
 
-	if (bl->props.power != FB_BLANK_UNBLANK ||
-	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
-	    bl->props.state & BL_CORE_FBBLANK)
-		brightness = 0;
-
 	return ht16k33_brightness_set(priv, brightness);
 }
 
-- 
2.44.0

