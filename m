Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA5B7C6E0
	for <linux-fbdev@vger.kernel.org>; Tue, 12 Mar 2024 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258521; cv=none; b=XOgJffKnNnBawiV8Aht5JEAGsp14mj6ElFPBqbbl4b53xRLb1nFiKdPkmLgnz9xC+pwcZziYfiaFcA4WGNXZq/SGltuy0veNxV3QSjp2qYeG0UuNq9RRbhBZyar1y4jSC/TEAWQjqcpextyW3yDZUKxgcUqsS9ZKPdtXQsBXFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258521; c=relaxed/simple;
	bh=qc8J7Uv2fSJ3sf9SzQroAdZMXrWVNeNcZ/15lRH94bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUjVcpYGnmoYTo+oAM8N9hhKVl+Ou48A/M/Qs6/7QndTSsXeZ+PheXC0aAik+7ctCRWUAXYe2txVhKZsUW44TCzS5QEE8/Sv3ZnE52QzTWr0sYiQ30Zq7XenxpZMCTprN2F4WETolhqYgE1+9I4sHUYeUPWOzFmVWeyfnTRm7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jMh2K97B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/UxMd7WG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jMh2K97B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/UxMd7WG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jMh2K97B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/UxMd7WG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jMh2K97B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/UxMd7WG"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B6A965D6C7;
	Tue, 12 Mar 2024 15:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZcylyw3XLvuCP1s/00N8ZWC2q+lq3BDpPGQ/zHVbVc=;
	b=jMh2K97BxFWk6o3ED2/ormqgu+SRZTD5AY2vOVVRaBR649wu917/WRb0yDrHsY/8KIYSPY
	2RQFaTOqRHicggQ5Sb6Ky6Zl4V4yFrcyDzfzALeXPtqJcxyMFU0OkvlWu+UchubqYacFxy
	9OTp1dh/tQMEs64sitZZqBxICkxoj4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZcylyw3XLvuCP1s/00N8ZWC2q+lq3BDpPGQ/zHVbVc=;
	b=/UxMd7WGzMugX1CdNrAu376eyCKSSJsDh3zVQvEIsWN2s9PzpraF9tfqgIrysx1LCAI0yj
	VUvDase6Bf4HxBDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZcylyw3XLvuCP1s/00N8ZWC2q+lq3BDpPGQ/zHVbVc=;
	b=jMh2K97BxFWk6o3ED2/ormqgu+SRZTD5AY2vOVVRaBR649wu917/WRb0yDrHsY/8KIYSPY
	2RQFaTOqRHicggQ5Sb6Ky6Zl4V4yFrcyDzfzALeXPtqJcxyMFU0OkvlWu+UchubqYacFxy
	9OTp1dh/tQMEs64sitZZqBxICkxoj4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZcylyw3XLvuCP1s/00N8ZWC2q+lq3BDpPGQ/zHVbVc=;
	b=/UxMd7WGzMugX1CdNrAu376eyCKSSJsDh3zVQvEIsWN2s9PzpraF9tfqgIrysx1LCAI0yj
	VUvDase6Bf4HxBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CF0B1364F;
	Tue, 12 Mar 2024 15:48:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YL/rHFV58GUhPwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 12 Mar 2024 15:48:37 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch,
	airlied@gmail.com,
	deller@gmx.de,
	javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 02/43] fbdev/deferred-io: Move pageref setup into separate helper
Date: Tue, 12 Mar 2024 16:44:57 +0100
Message-ID: <20240312154834.26178-3-tzimmermann@suse.de>
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
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,gmx.de,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.90
X-Spam-Flag: NO

Set up struct fb_deferred_io_pageref in th new helper function
fb_deferred_io_pageref_lookup(), which runs when the pageref is first
taken. Remove the setup code from the rest of the code.

At first, the code allocates the memory of all pageref structs. The
setup of the various fields happens when the pageref is required.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fb_defio.c | 42 ++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index dae96c9f61cf8..bff1e300ed6bb 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -36,20 +36,43 @@ static struct page *fb_deferred_io_page(struct fb_info *info, unsigned long offs
 	return page;
 }
 
+static struct fb_deferred_io_pageref *fb_deferred_io_pageref_lookup(struct fb_info *info,
+								    unsigned long offset,
+								    struct page *page)
+{
+	unsigned long pgoff = offset >> PAGE_SHIFT;
+	struct fb_deferred_io_pageref *pageref;
+
+	if (fb_WARN_ON_ONCE(info, pgoff >= info->npagerefs))
+		return NULL; /* incorrect allocation size */
+
+	/* 1:1 mapping between pageref and page offset */
+	pageref = &info->pagerefs[pgoff];
+
+	if (pageref->page)
+		goto out;
+
+	pageref->page = page;
+	pageref->offset = pgoff << PAGE_SHIFT;
+	INIT_LIST_HEAD(&pageref->list);
+
+out:
+	if (fb_WARN_ON_ONCE(info, pageref->page != page))
+		return NULL; /* inconsistent state */
+	return pageref;
+}
+
 static struct fb_deferred_io_pageref *fb_deferred_io_pageref_get(struct fb_info *info,
 								 unsigned long offset,
 								 struct page *page)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
 	struct list_head *pos = &fbdefio->pagereflist;
-	unsigned long pgoff = offset >> PAGE_SHIFT;
 	struct fb_deferred_io_pageref *pageref, *cur;
 
-	if (WARN_ON_ONCE(pgoff >= info->npagerefs))
-		return NULL; /* incorrect allocation size */
-
-	/* 1:1 mapping between pageref and page offset */
-	pageref = &info->pagerefs[pgoff];
+	pageref = fb_deferred_io_pageref_lookup(info, offset, page);
+	if (!pageref)
+		return NULL;
 
 	/*
 	 * This check is to catch the case where a new process could start
@@ -60,9 +83,6 @@ static struct fb_deferred_io_pageref *fb_deferred_io_pageref_get(struct fb_info
 	if (!list_empty(&pageref->list))
 		goto pageref_already_added;
 
-	pageref->page = page;
-	pageref->offset = pgoff << PAGE_SHIFT;
-
 	if (unlikely(fbdefio->sort_pagereflist)) {
 		/*
 		 * We loop through the list of pagerefs before adding in
@@ -264,7 +284,7 @@ int fb_deferred_io_init(struct fb_info *info)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
 	struct fb_deferred_io_pageref *pagerefs;
-	unsigned long npagerefs, i;
+	unsigned long npagerefs;
 	int ret;
 
 	BUG_ON(!fbdefio);
@@ -286,8 +306,6 @@ int fb_deferred_io_init(struct fb_info *info)
 		ret = -ENOMEM;
 		goto err;
 	}
-	for (i = 0; i < npagerefs; ++i)
-		INIT_LIST_HEAD(&pagerefs[i].list);
 	info->npagerefs = npagerefs;
 	info->pagerefs = pagerefs;
 
-- 
2.44.0

