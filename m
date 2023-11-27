Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O1JjNpss";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="grMmmxpC"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3645410F
	for <linux-fbdev@vger.kernel.org>; Mon, 27 Nov 2023 05:17:05 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D782920400;
	Mon, 27 Nov 2023 13:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701091023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGoLVwJEf4w+e/zURT3FosJNovZk6VgVgDPTUb2U59c=;
	b=O1JjNpss9ves7i7VcItLgeqMICj1oW/I2GgiEb1Mmk9bi0CYhnTIDMtR18Du3CPn0BereG
	FsSwBC2o3UKEcnas7bptfGBYY6KdNWTyuPfKfF2krn/R3qNbBFYD4p+2+Rn0ZW1zesAScp
	Wgn2+DgCQpI/pkME7UiiAy6l2RFARbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701091023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGoLVwJEf4w+e/zURT3FosJNovZk6VgVgDPTUb2U59c=;
	b=grMmmxpCjfgeiJfBSTiUW8T8CFz7MPUTMl1znd8GsNXvf7HcKulrwdhP7Sk1LF0XcR35KC
	BNFs9VXQyGWJlDCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B12B313B3A;
	Mon, 27 Nov 2023 13:17:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SHUnKs+WZGUhLQAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 27 Nov 2023 13:17:03 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 16/32] fbdev/au1200fb: Set FBINFO_VIRTFB flag
Date: Mon, 27 Nov 2023 14:15:45 +0100
Message-ID: <20231127131655.4020-17-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231127131655.4020-1-tzimmermann@suse.de>
References: <20231127131655.4020-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FREEMAIL_TO(0.00)[redhat.com,gmx.de];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[37.24%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]

The au1200fb driver operates on DMA-able system memory. Mark the
framebuffer accordingly. Helpers operating on the framebuffer memory
will test for the presence of this flag.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/video/fbdev/au1200fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 98afd385c49cd..817c1ebb625b6 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1568,6 +1568,8 @@ static int au1200fb_init_fbinfo(struct au1200fb_device *fbdev)
 	fbi->fix.mmio_len = 0;
 	fbi->fix.accel = FB_ACCEL_NONE;
 
+	fbi->flags |= FBINFO_VIRTFB;
+
 	fbi->screen_buffer = fbdev->fb_mem;
 
 	au1200fb_update_fbinfo(fbi);
-- 
2.43.0

