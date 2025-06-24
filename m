Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9152BE7BC
	for <linux-fbdev@vger.kernel.org>; Tue, 24 Jun 2025 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773129; cv=none; b=e+WZ6S3DV29bN5mm81DpHR3zPFbLUL6R0goOyEDKljDciy9khNe9TOR20O7/K9hiBFACjsb3H5YxZpGhArTvPAjO5L9ZLOoM/C3flf/LBY8ogo0FaKQ6Y+SOXJodKMW3qt+VfsflvtjqwYi2LgA1ZcNnkzPPU6ZZKDbHM6+k2vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773129; c=relaxed/simple;
	bh=y6uj9ijB8lvnpqO0nkSz6d5EhhxemppPcJ/JshiT0uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDb6km3EKsTDbGjKLOmHmKm89LqP29THPfAK+YGHWW/vljBjxlDnzKGOTaKr5Pa93gzIO8xwtftoX+TcWl/SKquYY8Q0sLFIk9D6EuJZ7e+9sD7YtFC7lzz+ah4LTkrsWcQuWHQBiJzrDKLn3sh0F2a0rdIEyGODAVm5BZTI5qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=adXqqHkh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zdvcj6eU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=adXqqHkh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zdvcj6eU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="adXqqHkh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zdvcj6eU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="adXqqHkh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zdvcj6eU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 883CD2118F;
	Tue, 24 Jun 2025 13:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750773116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCm2YElLOxyPZdvbgI5q6uWBdMdbl3YtVkvPWEDIyC0=;
	b=adXqqHkhmZqpMI5CeUmhytFXvX2LAK/iqYULZGEGrO0h11BGvM+rFcheWr855S5c2V9Bbz
	gIll8iiWGfwTIJjjV1uOee5cDs3DesjlTHVwDGX66eS27S0pdSSfmyn/TxmcsgCcNNHXOw
	WH4EzH8izu+bEUmapSTEeO1UB5zFxZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750773116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCm2YElLOxyPZdvbgI5q6uWBdMdbl3YtVkvPWEDIyC0=;
	b=Zdvcj6eU/SEXAmYzcuD4Mx8hchWuSAstHU054z4LElS5rTGMZszmkXg7/tsybvBwfYVdjL
	V2Y31R0V1WIkaSDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750773116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCm2YElLOxyPZdvbgI5q6uWBdMdbl3YtVkvPWEDIyC0=;
	b=adXqqHkhmZqpMI5CeUmhytFXvX2LAK/iqYULZGEGrO0h11BGvM+rFcheWr855S5c2V9Bbz
	gIll8iiWGfwTIJjjV1uOee5cDs3DesjlTHVwDGX66eS27S0pdSSfmyn/TxmcsgCcNNHXOw
	WH4EzH8izu+bEUmapSTEeO1UB5zFxZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750773116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCm2YElLOxyPZdvbgI5q6uWBdMdbl3YtVkvPWEDIyC0=;
	b=Zdvcj6eU/SEXAmYzcuD4Mx8hchWuSAstHU054z4LElS5rTGMZszmkXg7/tsybvBwfYVdjL
	V2Y31R0V1WIkaSDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D313E13A96;
	Tue, 24 Jun 2025 13:51:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OEAjMnutWmjFcQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 24 Jun 2025 13:51:55 +0000
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
Subject: [PATCH v2 09/15] backlight: da9052_bl: Include <linux/mod_devicetable.h>
Date: Tue, 24 Jun 2025 15:45:49 +0200
Message-ID: <20250624134858.1736090-10-tzimmermann@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -5.30
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,oss.qualcomm.com,linux.intel.com,ffwll.ch,jannau.net,redhat.com,rosenzweig.io,gompa.dev,gmx.de,diasemi.com,skole.hr];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLc48bcaq7qz9wekwjsx9fywoc)];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Spam-Level: 

Include <linux/mod_devicetable.h> to declare struct platform_device_id.
Avoids dependency on backlight header to include it.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/da9052_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/da9052_bl.c b/drivers/video/backlight/da9052_bl.c
index f41523d78121..2493138febfa 100644
--- a/drivers/video/backlight/da9052_bl.c
+++ b/drivers/video/backlight/da9052_bl.c
@@ -9,6 +9,7 @@
 
 #include <linux/backlight.h>
 #include <linux/delay.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-- 
2.50.0

