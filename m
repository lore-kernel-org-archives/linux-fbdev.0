Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324FE5339A
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515622; cv=none; b=uEv43ixNyj1GYUmnk8tEMte6xAvq+p6/2DYLlsqPstg6od3Q4NSDGKAByCrtzeWaOrps2TwupfFMsExOtmtRQZmJnd1nkcl1hDZ7zRnzecRnt5WngHazu2zCgeS1DzCMJxcn5o3lCEO7/lFyb45D5itq1NrrK7ShKe+Cy4Nd64I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515622; c=relaxed/simple;
	bh=e8MG84vumzd7E7EolyjVBlVhoDa3AZPLWjHG9N+p+dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ri+v/17WmqOGgt1rDdjyPNOsxXKx4GtWHGtEQNJLdxUzmUbsmOAeEO2DUsFSuqMi2ONh6CnW0EgRV5KZRdCWOrhWjO9/FpyM6Il6401eflElVK3FDgQOrzTMbPNm0dAHmdqQ9dNUvFY0O9b34nxy/9JuMVU21VSjSXZiyOmxxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x7Eh7DW4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d/G3PTLC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x7Eh7DW4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d/G3PTLC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x7Eh7DW4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d/G3PTLC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x7Eh7DW4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d/G3PTLC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 13E313757E;
	Fri, 19 Apr 2024 08:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713515617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lw83kzTxKgFnzeBvNYY50kx9RaxAIFUaqhtm0tLPWuE=;
	b=x7Eh7DW4kEyGZKKgW8yOwIsyKCOzgBTzKxl7kZ0+PFRD/jZu82SI1mpMYTt34Zn0+dxdIq
	maRP/TXnKqDTdFHqkgQzI+BFiXfT9M1DpPqW3b+4A1IYUjbsJoSIlJJMW3jN83U8a1TpDU
	FwHYPlx+2CI2U5xE+CBWx8hXBTDfQFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713515617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lw83kzTxKgFnzeBvNYY50kx9RaxAIFUaqhtm0tLPWuE=;
	b=d/G3PTLCKQC6ZFHynIdiXIGkxBQoewJBzhJFzyY4cTtJ4lmPj96vEijaSqCSJGpYNOQIzj
	XEc6qIhpH5r4G1CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=x7Eh7DW4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="d/G3PTLC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713515617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lw83kzTxKgFnzeBvNYY50kx9RaxAIFUaqhtm0tLPWuE=;
	b=x7Eh7DW4kEyGZKKgW8yOwIsyKCOzgBTzKxl7kZ0+PFRD/jZu82SI1mpMYTt34Zn0+dxdIq
	maRP/TXnKqDTdFHqkgQzI+BFiXfT9M1DpPqW3b+4A1IYUjbsJoSIlJJMW3jN83U8a1TpDU
	FwHYPlx+2CI2U5xE+CBWx8hXBTDfQFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713515617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lw83kzTxKgFnzeBvNYY50kx9RaxAIFUaqhtm0tLPWuE=;
	b=d/G3PTLCKQC6ZFHynIdiXIGkxBQoewJBzhJFzyY4cTtJ4lmPj96vEijaSqCSJGpYNOQIzj
	XEc6qIhpH5r4G1CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D58961398B;
	Fri, 19 Apr 2024 08:33:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UDEKM2AsImb9agAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 19 Apr 2024 08:33:36 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 03/43] fbdev/deferred-io: Clean up pageref on lastclose
Date: Fri, 19 Apr 2024 10:28:56 +0200
Message-ID: <20240419083331.7761-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419083331.7761-1-tzimmermann@suse.de>
References: <20240419083331.7761-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[redhat.com,gmx.de,gmail.com,ffwll.ch];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 13E313757E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

Clean up the pageref state as part of the lastclose helper. This
only requires to clear the page's mapping field. The pageref and
page can stay in place for the next opened instance of the frame-
buffer file.

With the change in the clean-up logic, there's no further need
to look up pages during the lastclose cleanup. The code instead
uses the existing pagerefs in its look-up table. It also avoids
using smem_len, which some driver might not set correctly.

v2:
- fix typos in commit message (Javier)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/video/fbdev/core/fb_defio.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index bff1e300ed6bb..f23b1cbe67192 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -62,6 +62,14 @@ static struct fb_deferred_io_pageref *fb_deferred_io_pageref_lookup(struct fb_in
 	return pageref;
 }
 
+static void fb_deferred_io_pageref_clear(struct fb_deferred_io_pageref *pageref)
+{
+	struct page *page = pageref->page;
+
+	if (page)
+		page->mapping = NULL;
+}
+
 static struct fb_deferred_io_pageref *fb_deferred_io_pageref_get(struct fb_info *info,
 								 unsigned long offset,
 								 struct page *page)
@@ -330,16 +338,13 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_open);
 
 static void fb_deferred_io_lastclose(struct fb_info *info)
 {
-	struct page *page;
-	int i;
+	unsigned long i;
 
 	flush_delayed_work(&info->deferred_work);
 
 	/* clear out the mapping that we setup */
-	for (i = 0 ; i < info->fix.smem_len; i += PAGE_SIZE) {
-		page = fb_deferred_io_page(info, i);
-		page->mapping = NULL;
-	}
+	for (i = 0; i < info->npagerefs; ++i)
+		fb_deferred_io_pageref_clear(&info->pagerefs[i]);
 }
 
 void fb_deferred_io_release(struct fb_info *info)
-- 
2.44.0

