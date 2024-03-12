Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76C57C6EF
	for <linux-fbdev@vger.kernel.org>; Tue, 12 Mar 2024 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258521; cv=none; b=G8h4fFvB2xQ/tX6oPzPG0O8oYza1XqA06y24zrjTLzyG6LooHEaWItQpK2htgYj1jUhoMxfrLQC3tTF+4DoD1HzZcACghkE4hjGf6hMeDRsge0z+fHpCYcCxzzW6c7socX4KRHhHpVunnx9POR8SxWS24UCJjTijXZnztUJNhoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258521; c=relaxed/simple;
	bh=ARUvc2Uml3BMUHmEo2iovNCEi2mqUPkS/bauV17j1Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRFE/c2682UrXqX5f3/eCx+s2W7RHJjLp+wI0I8sJp9XiVJ/OJO85peTvOEk4cQ8hdUK2saC6pMiLG85+2TTZ0dL1VXy3l/8BiFCKNnVl7xXjirjNGMRG/5vOPxgLZb8XBhI3ZnFDVh8MdTjfrWDi2VJHCruNNayrHagpz1t8ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RqMcKcZA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B2/H9PaM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RqMcKcZA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B2/H9PaM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RqMcKcZA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B2/H9PaM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RqMcKcZA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B2/H9PaM"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 05D0237874;
	Tue, 12 Mar 2024 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iYwrieOkLADkBicbIsw2X7C23nK5mP439QApSR+pM0=;
	b=RqMcKcZA8CBNMWSXfJ3VbzDUgXxF8ReP35XNsORwdJIDFMdC7Gfjbp4WRZt5WvKpn+dmn9
	g0Z+Lb0N1aPc0rJStp359JCHhYlxY4cUdj7x8sPoKSoanLT09nQ7wMgMMFR02oiowTSzx2
	bbnvKOj7eeiZZXkU5TRwFyLL2c3ycuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iYwrieOkLADkBicbIsw2X7C23nK5mP439QApSR+pM0=;
	b=B2/H9PaMfpDKkjlG712xLDoDtN9NOIDTy4cVg2l/jYXhPbth89cJlEDYlIW4Gi2S9pw4Kc
	QWuvVYcxDAjQLBCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iYwrieOkLADkBicbIsw2X7C23nK5mP439QApSR+pM0=;
	b=RqMcKcZA8CBNMWSXfJ3VbzDUgXxF8ReP35XNsORwdJIDFMdC7Gfjbp4WRZt5WvKpn+dmn9
	g0Z+Lb0N1aPc0rJStp359JCHhYlxY4cUdj7x8sPoKSoanLT09nQ7wMgMMFR02oiowTSzx2
	bbnvKOj7eeiZZXkU5TRwFyLL2c3ycuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iYwrieOkLADkBicbIsw2X7C23nK5mP439QApSR+pM0=;
	b=B2/H9PaMfpDKkjlG712xLDoDtN9NOIDTy4cVg2l/jYXhPbth89cJlEDYlIW4Gi2S9pw4Kc
	QWuvVYcxDAjQLBCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE84913976;
	Tue, 12 Mar 2024 15:48:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4FUkLVV58GUhPwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 12 Mar 2024 15:48:37 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch,
	airlied@gmail.com,
	deller@gmx.de,
	javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 03/43] fbdev/deferred-io: Clean up pageref on lastclose
Date: Tue, 12 Mar 2024 16:44:58 +0100
Message-ID: <20240312154834.26178-4-tzimmermann@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
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
	 BAYES_HAM(-0.00)[24.69%]
X-Spam-Flag: NO

Clean up the pageref state as part of the lastclose helper. This
only requirs to clear the page's mapping field. The pageref and
page can stay in place for the next opened instance of the frame-
buffer file.

With the change in the clean-up logic, here's no further need
to lookup pages during the lastclose cleanup. The code instead
uses the existing pagerefs in its look-up table. It also avoids
using smem_len, which some driver might not set correctly.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
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

