Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8615E29C335
	for <linux-fbdev@vger.kernel.org>; Tue, 24 Jun 2025 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773144; cv=none; b=By2dgJOMBPuzfkvC4wDSHNVepb4hRgwptjNKut4BnXo0JIx/pEtbumY5NNwOGikLAjKYRkE+O2h1AhpEa1NoUtqlZdBaqY8fhHrll629XlM3rrcPgdec3WyVROy04EqY/d5PngcBJrScTY4qooOAHz5Xe4CkL2RQW1u5YHnvYis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773144; c=relaxed/simple;
	bh=87g+/hi2+pSlzkG8Z4HBCKjpoC7zTkXQWdbGWhQj23M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rd2QnEEAl6K7HffBGgZQA823HYi/osVsqBlVHlqfszmclv9PRW+cMpOEn92slpKHts31upiZUyXeAEJadCYpT2ni8YRso1/vMn18r/gmaGT1i8mmsEKZL5z1a9qZZwpbppftKE3KT/KX/SxshKZ8arwm5+ZZbK1luAh9j1ZS4yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sGQt9ivI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N4pRkMtN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sGQt9ivI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N4pRkMtN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sGQt9ivI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N4pRkMtN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sGQt9ivI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N4pRkMtN"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C2DE1F455;
	Tue, 24 Jun 2025 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750773115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8wzZXGt+85YEwlAMG5VOp8LmFtja9yulci1nGA1bZU=;
	b=sGQt9ivIL+isVgAV/1GkEKGBG2q2PjGcLUHKOaKLUF/l2Kn3gr4Dk1V2Vf0yuxtkqbCE7t
	WE3SNdd73D/NpBipz8uwuVIFaY8+6I6mbLircT6oPlfC3Ps7BLME0XzzDuAFEb3lZgQCbW
	/dCioD8ZSfooYHJb+N3s7Gs8UzQ+c5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750773115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8wzZXGt+85YEwlAMG5VOp8LmFtja9yulci1nGA1bZU=;
	b=N4pRkMtN5q1u4I4Dy8gxrSK/ogTwiX6DdeKYp/+80pGk0xcaRQh1Yoh3pDPqoFAFF9xfqT
	U6b8URZcWJBvlQAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750773115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8wzZXGt+85YEwlAMG5VOp8LmFtja9yulci1nGA1bZU=;
	b=sGQt9ivIL+isVgAV/1GkEKGBG2q2PjGcLUHKOaKLUF/l2Kn3gr4Dk1V2Vf0yuxtkqbCE7t
	WE3SNdd73D/NpBipz8uwuVIFaY8+6I6mbLircT6oPlfC3Ps7BLME0XzzDuAFEb3lZgQCbW
	/dCioD8ZSfooYHJb+N3s7Gs8UzQ+c5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750773115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8wzZXGt+85YEwlAMG5VOp8LmFtja9yulci1nGA1bZU=;
	b=N4pRkMtN5q1u4I4Dy8gxrSK/ogTwiX6DdeKYp/+80pGk0xcaRQh1Yoh3pDPqoFAFF9xfqT
	U6b8URZcWJBvlQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F12513A96;
	Tue, 24 Jun 2025 13:51:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WG4AFnqtWmjFcQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 24 Jun 2025 13:51:54 +0000
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
Subject: [PATCH v2 07/15] backlight: apple_dwi_bl: Include <linux/mod_devicetable.h>
Date: Tue, 24 Jun 2025 15:45:47 +0200
Message-ID: <20250624134858.1736090-8-tzimmermann@suse.de>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,oss.qualcomm.com,linux.intel.com,ffwll.ch,jannau.net,redhat.com,rosenzweig.io,gompa.dev,gmx.de,diasemi.com,skole.hr];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,lists.linux.dev,vger.kernel.org,lists.infradead.org,suse.de,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLc48bcaq7qz9wekwjsx9fywoc)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

Include <linux/mod_devicetable.h> to declare struct of_device_id.
Avoids dependency on backlight header to include it.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/video/backlight/apple_dwi_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/apple_dwi_bl.c b/drivers/video/backlight/apple_dwi_bl.c
index 93bd744972d6..ed8bf13d3f51 100644
--- a/drivers/video/backlight/apple_dwi_bl.c
+++ b/drivers/video/backlight/apple_dwi_bl.c
@@ -9,6 +9,7 @@
 #include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-- 
2.50.0

