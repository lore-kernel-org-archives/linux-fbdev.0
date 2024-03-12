Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB3E7D3E1
	for <linux-fbdev@vger.kernel.org>; Tue, 12 Mar 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258532; cv=none; b=GAKSW4H2KXtgn9BFIVCTLwD4SCsDC7lmY1iX8xgVSUr7VQwyt79L79FMOzjwDctCsbIYwF+EE8gI+mnBgPumdIWol3F+OYQaIefjkt4lYWeIwMEiyS5bdKMP8gTM7GyHGVmap3UYPtnpNwwTEEYrqI9KSZ/Qs90fvRl1wUTbN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258532; c=relaxed/simple;
	bh=Tt93g/dmtAQ8tixrVaXUe39cM8/ZXdD6bzvaGO0DHEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsClLxx0wNyNAlr6tBGwwFcrmBlgzguswXMNgWmv0CBZqaxzryILNR94yhyGFBmmoVh3OW35vmKEC0H4UfafmvMzXTabpQ2PVVw0RMuvYiH3+0era2zP3dFthb7guPrTn+sOV5/iLU0GEOccfLobHWxiwnpgeM538IBy+44+Oj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1lY0WVO+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=acJ0fiAk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wa1vxEW4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M+GeKsM9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1lY0WVO+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="acJ0fiAk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wa1vxEW4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="M+GeKsM9"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0D635D6DA;
	Tue, 12 Mar 2024 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmLyjBIU+sa+KC6TShmVXNvGuSHoNkmIJLCbXbUAGms=;
	b=1lY0WVO+tA74b2+IGyvyfSrng429CUsMb77wr+nRBz9/Wwl6eR5FdPElzxVfLZUscpbahE
	p0Kn7uVeXKWGXbduE5yMXRZaKL1CqVG4wz3tet84D8s4LPTAxHq78GBi4+utVuZduSKbLr
	Nr5cdyQw8N6rUgWVjHgVd0wEbt6Ju3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258528;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmLyjBIU+sa+KC6TShmVXNvGuSHoNkmIJLCbXbUAGms=;
	b=acJ0fiAkVi3XiEOVr7yxFAnIlArILER01nuE8c03SXraekAT4KO1Kfx8BeLHpQsCGFoyAl
	LpvFOZBTovLEIFBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmLyjBIU+sa+KC6TShmVXNvGuSHoNkmIJLCbXbUAGms=;
	b=Wa1vxEW43ZH5xlgwEFczTuWtBdD0YmF5j4VgCzx5NLwQWWYXK762SB9yrt96PcWdSJWiiC
	4Hw610TJkRyHz9LM04rMVZc0axgy4lw8DiJOYGJDKBEcS6DL3L9uIyqVANCvi1xSIb/yEg
	gEdHTAMeIS1ag19neIQrcrot7cA9ZFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmLyjBIU+sa+KC6TShmVXNvGuSHoNkmIJLCbXbUAGms=;
	b=M+GeKsM9SN/0MH4J2A56a6ah210LttCdG4U8rbfxmL+/fuItAEDCM055tSmOuNV6dluIPm
	MG0NzLX5EN73DXCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5F6E13976;
	Tue, 12 Mar 2024 15:48:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cI0OK1958GUhPwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 12 Mar 2024 15:48:47 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch,
	airlied@gmail.com,
	deller@gmx.de,
	javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 36/43] drm/tiny/ili9486: Use fbdev-dma
Date: Tue, 12 Mar 2024 16:45:31 +0100
Message-ID: <20240312154834.26178-37-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312154834.26178-1-tzimmermann@suse.de>
References: <20240312154834.26178-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.33
X-Spamd-Result: default: False [-0.33 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLw9gjjhh8cousxs3wi4trssza)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,gmx.de,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.03)[56.72%]
X-Spam-Flag: NO

Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
damage handling, which is required by ili9486. Avoids the overhead of
fbdev-generic's additional shadow buffering. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/ili9486.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c
index 938bceed59998..70d3662600410 100644
--- a/drivers/gpu/drm/tiny/ili9486.c
+++ b/drivers/gpu/drm/tiny/ili9486.c
@@ -16,7 +16,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_managed.h>
@@ -247,7 +247,7 @@ static int ili9486_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, drm);
 
-	drm_fbdev_generic_setup(drm, 0);
+	drm_fbdev_dma_setup(drm, 0);
 
 	return 0;
 }
-- 
2.44.0

