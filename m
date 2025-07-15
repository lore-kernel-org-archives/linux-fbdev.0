Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0002DE70C
	for <linux-fbdev@vger.kernel.org>; Tue, 15 Jul 2025 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582599; cv=none; b=IAg3DNuOc679WjkveiUwXDZAZEU58KEUboPL5iafVDxi5wxzoy9/E52xQqRLT00k9l4OQ74aNsfni6a9I4A2VvlQ8jOEpm5rSqSIc6oD+HfGHXOHVip0z40RgJGZRozhuKITE/rx3pSQe3d9obJUYpWqoRWTl3XbmcExQPNlfG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582599; c=relaxed/simple;
	bh=XNZa8kdgsi/LebFHKiYdHCId1njAHooPccZ/KCWwzk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBW+cUZvuuGYRPWYP2gR2WHEUorS3fX7yJ6/k+GEDtcHOAt+zVwTPttH/KKNFNVOut5zYcNXJty1ReJnIjZYQJLtp+lPIiQxAnGOUdovvnnsecRQbHcW+dfttwW6+h13NrLTStP4jsDTGnXncj2n7LahWTnjh1+WUouwHGgtAyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QVU7nmCM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7ehudUId; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P9xNpQAb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WtYcfU3F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QVU7nmCM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7ehudUId";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P9xNpQAb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WtYcfU3F"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D9ED421202;
	Tue, 15 Jul 2025 12:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752582595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86y9r6nHahEnEZKMeYSQSkFSBgakMsJArIInMGC1XPw=;
	b=QVU7nmCMV6CH97FXemiGwor0RtUR29LcrE44SW44O7SNBWdfvAkZg3eJqNl3JkRaj1aIna
	2xKSGC/wj/nw8ifQH3/I0JiuE/GrbaaO1e2IJOJ4BWlly/NkP9/TIDDSglnllUJ2T5zuzP
	nQLX7idPLE5tmisDomDzor9lBZRwj14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752582595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86y9r6nHahEnEZKMeYSQSkFSBgakMsJArIInMGC1XPw=;
	b=7ehudUId3M6aL6eDDivK0+SLbKD5lPCd9qL21l9YeAgQSbFGXTxR2N318a8AUeuuUL2qP+
	QN0XH0wbdHoy0GCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=P9xNpQAb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WtYcfU3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752582594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86y9r6nHahEnEZKMeYSQSkFSBgakMsJArIInMGC1XPw=;
	b=P9xNpQAbirR7wOj8HB+UVBoi6/I5qMRIoC+KWR/KIFzJZq25aDeOyGwvVwyd365lvlSpOb
	64WMiFNe4qmFfsqVXXlyhXNTJWzgmnxY98wYsqz9k3QF19XsgmCRGMavua6/IjnJtukeva
	QbqboYIk6WRR9YjHIl3yfHMyvKx9G+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752582594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86y9r6nHahEnEZKMeYSQSkFSBgakMsJArIInMGC1XPw=;
	b=WtYcfU3F2VrrSZq8BPVb4MWQyGrfYizHFcwJzgbmatCvCyA2D8xl/8hTmP1gVdVKZNTmEI
	7DF2MApzgf2Q5iBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D4B313A6C;
	Tue, 15 Jul 2025 12:29:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0DvNDcJJdmgaIwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 15 Jul 2025 12:29:54 +0000
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
	Thomas Zimmermann <tzimmermann@suse.de>,
	Hans de Goede <hansg@kernel.org>
Subject: [PATCH v2 01/15] platform/x86: dell-uart-backlight: Use blacklight power constant
Date: Tue, 15 Jul 2025 14:24:38 +0200
Message-ID: <20250715122643.137027-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250715122643.137027-1-tzimmermann@suse.de>
References: <20250715122643.137027-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,oss.qualcomm.com,gmx.de,linux.intel.com,ffwll.ch,jannau.net,redhat.com,rosenzweig.io,gompa.dev,diasemi.com,skole.hr];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RL95szse9eqfwu74ziohs8j73e)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D9ED421202
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.01

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

