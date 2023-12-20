Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43A364C0;
	Wed, 20 Dec 2023 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VXzUkhVc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zfqIxVt6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VXzUkhVc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zfqIxVt6"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0DF51F832;
	Wed, 20 Dec 2023 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703080007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3eAv9E6qr6EXTkKeEDMFcGocoOXyIA6N2GExstlwndY=;
	b=VXzUkhVcB6NE/V3xy0ECYg/h0kQXwpdevATL7yTEfpXlk1RS17qGBRdX7Q54kRYzaZS0mS
	rOSWnKULaTnVbHOxKN4PnsjDeDAzzSyUJPJivfaH/B5bQe31KcK14Mye3mNx968ZXKapvr
	uEgQR/JR2axEr1+umWn7coss18Q8LH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703080007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3eAv9E6qr6EXTkKeEDMFcGocoOXyIA6N2GExstlwndY=;
	b=zfqIxVt6yzIdNG8rwwWJV2z5FycqIhjh2VKSuu5UsWpCm8enTibaPDAR8Tr5BSQ++wOuWg
	6RsLnXRnN/fhrMCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703080007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3eAv9E6qr6EXTkKeEDMFcGocoOXyIA6N2GExstlwndY=;
	b=VXzUkhVcB6NE/V3xy0ECYg/h0kQXwpdevATL7yTEfpXlk1RS17qGBRdX7Q54kRYzaZS0mS
	rOSWnKULaTnVbHOxKN4PnsjDeDAzzSyUJPJivfaH/B5bQe31KcK14Mye3mNx968ZXKapvr
	uEgQR/JR2axEr1+umWn7coss18Q8LH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703080007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3eAv9E6qr6EXTkKeEDMFcGocoOXyIA6N2GExstlwndY=;
	b=zfqIxVt6yzIdNG8rwwWJV2z5FycqIhjh2VKSuu5UsWpCm8enTibaPDAR8Tr5BSQ++wOuWg
	6RsLnXRnN/fhrMCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 95A7713BA8;
	Wed, 20 Dec 2023 13:46:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id mHNdI0fwgmWZJwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 20 Dec 2023 13:46:47 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	James.Bottomley@HansenPartnership.com,
	arnd@arndb.de
Cc: linux-parisc@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/4] arch/parisc: Detect primary video device from device instance
Date: Wed, 20 Dec 2023 14:22:56 +0100
Message-ID: <20231220134639.8190-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220134639.8190-1-tzimmermann@suse.de>
References: <20231220134639.8190-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VXzUkhVc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zfqIxVt6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.16 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmx.de,HansenPartnership.com,arndb.de];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.33)[76.01%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 3.16
X-Rspamd-Queue-Id: D0DF51F832
X-Spam-Flag: NO

Update fb_is_primary device() on parisc to detect the primary display
device from the Linux device instance. Aligns the code with the other
architectures. A later patch will remove the fbdev dependency from the
function's interface.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/parisc/video/fbdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/video/fbdev.c b/arch/parisc/video/fbdev.c
index 137561d98246..e4f8ac99fc9e 100644
--- a/arch/parisc/video/fbdev.c
+++ b/arch/parisc/video/fbdev.c
@@ -21,6 +21,6 @@ int fb_is_primary_device(struct fb_info *info)
 		return true;
 
 	/* return true if it's the default built-in framebuffer driver */
-	return (sti->info == info);
+	return (sti->dev == info->device);
 }
 EXPORT_SYMBOL(fb_is_primary_device);
-- 
2.43.0

