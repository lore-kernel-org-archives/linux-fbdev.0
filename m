Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D0368264
	for <linux-fbdev@vger.kernel.org>; Tue, 24 Feb 2026 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921633; cv=none; b=h2do+EFT3h60XeKS+H2akS4yDvB1Ehh+G0GBO1GmVUISkEveXsSgWUL/U9aE59vMDdcKqMGDdzuxHkfPF5pyQH2c8HF2H1vTOKYyUf17wvkdMUc/kj3GiKh8HB20ZxPwRaZHP73D/Nn07t6OlnWRP+L2O01WGUtr163gDTopoJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921633; c=relaxed/simple;
	bh=TMBBO3mUAOIjSjcp620ni+XUmwNMyFzQs54LCmf1Txk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJstKNtmuAntp82avFT9+sFdrRFxFwzZ8XXcR3fcgUTgwblQWdhsulI9oovB17dd7WnUUpCKK+biULxQf4oP5rXySlwU3cqXJSvo/Fwpfe5cPdQ68JnsZaMTigl3Hb2DvfWu5wizH9UY5/kEvU8BEfiCRsOYgwM28Yc8d3mN9/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LjYlSUgA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JA/FUlew; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q3uhmZ5h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3PIsUzK8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LjYlSUgA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JA/FUlew";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q3uhmZ5h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3PIsUzK8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB1185BCD8;
	Tue, 24 Feb 2026 08:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771921623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zKgv6GmScnxBwgsoBKm1eRaTV6wy+Bj6bYhpX3Me+f0=;
	b=LjYlSUgAHelb7HTn5lt/TnB5i5POfPSpZv7iVdGfhiXh0TJNMt0FLocAUZYbire8RlLYmX
	tdJovBqbt+fAIijwwTXZTrSMVEAHm4JnAYnPTPFpm2z/aOk7PcX/F6YrrJBBDdI4xZBy2q
	xraVcRr9FCGIIHxYFYjRWuph+iqFV7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771921623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zKgv6GmScnxBwgsoBKm1eRaTV6wy+Bj6bYhpX3Me+f0=;
	b=JA/FUlewt0pC4uMsBOPeAfEsQWgyTOvLi1DJHondI/iXjahqpVAfPr6XoE7pieP5R6TI59
	ChgdVd8LmP8YDrAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771921622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zKgv6GmScnxBwgsoBKm1eRaTV6wy+Bj6bYhpX3Me+f0=;
	b=Q3uhmZ5hNP549csTnZYOzhACH+ICgPgFa6M2oWNaDGuZho5X5jDonk9ENtgwG1N2HBG9u4
	7TRDY0sbXK2W4Qabf7a7CngYSOqXXimrIJQuZmk73upeXgKpZTTBSNCH9+UCYP8zIjkDak
	HXH2vb34PtH5kUFkbEE2I3GK7kngjbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771921622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zKgv6GmScnxBwgsoBKm1eRaTV6wy+Bj6bYhpX3Me+f0=;
	b=3PIsUzK80PpQyF/a708aQQ6orpXC4b425kwA7dF9L30dspRmB0gy0V5tcM/b0BlTQsbFF1
	J6S3oWyFJAx76aAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99E7A3EA6B;
	Tue, 24 Feb 2026 08:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2N9fJNZgnWnVQAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 24 Feb 2026 08:27:02 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch,
	jayalk@intworks.biz
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 3/4] fbdev: defio: Move variable state into struct fb_deferred_io_state
Date: Tue, 24 Feb 2026 09:25:56 +0100
Message-ID: <20260224082657.207284-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224082657.207284-1-tzimmermann@suse.de>
References: <20260224082657.207284-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmx.de,ffwll.ch,intworks.biz];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO

Move variable fields from struct fb_deferred_io into struct
fb_deferred_io_state. These fields are internal to the defio code
and should not be exposed to drivers. At some later point, struct
fb_defered_io might become const in all defio code.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fb_defio.c | 37 +++++++++++++++++------------
 include/linux/fb.h                  |  3 ---
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index 56030eb42f71..35ac13727da1 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -25,6 +25,8 @@
 #include <linux/rmap.h>
 #include <linux/pagemap.h>
 
+struct address_space;
+
 /*
  * struct fb_deferred_io_state
  */
@@ -32,9 +34,13 @@
 struct fb_deferred_io_state {
 	struct kref ref;
 
+	int open_count; /* number of opened files; protected by fb_info lock */
+	struct address_space *mapping; /* page cache object for fb device */
+
 	struct mutex lock; /* mutex that protects the pageref list */
 	/* fields protected by lock */
 	struct fb_info *info;
+	struct list_head pagereflist; /* list of pagerefs for touched pages */
 };
 
 static struct fb_deferred_io_state *fb_deferred_io_state_alloc(void)
@@ -48,11 +54,14 @@ static struct fb_deferred_io_state *fb_deferred_io_state_alloc(void)
 	kref_init(&fbdefio_state->ref);
 	mutex_init(&fbdefio_state->lock);
 
+	INIT_LIST_HEAD(&fbdefio_state->pagereflist);
+
 	return fbdefio_state;
 }
 
 static void fb_deferred_io_state_release(struct fb_deferred_io_state *fbdefio_state)
 {
+	WARN_ON(!list_empty(&fbdefio_state->pagereflist));
 	mutex_destroy(&fbdefio_state->lock);
 
 	kfree(fbdefio_state);
@@ -147,7 +156,8 @@ static struct fb_deferred_io_pageref *fb_deferred_io_pageref_get(struct fb_info
 								 struct page *page)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
-	struct list_head *pos = &fbdefio->pagereflist;
+	struct fb_deferred_io_state *fbdefio_state = info->fbdefio_state;
+	struct list_head *pos = &fbdefio_state->pagereflist;
 	struct fb_deferred_io_pageref *pageref, *cur;
 
 	pageref = fb_deferred_io_pageref_lookup(info, offset, page);
@@ -171,7 +181,7 @@ static struct fb_deferred_io_pageref *fb_deferred_io_pageref_get(struct fb_info
 		 * pages. If possible, drivers should try to work with
 		 * unsorted page lists instead.
 		 */
-		list_for_each_entry(cur, &fbdefio->pagereflist, list) {
+		list_for_each_entry(cur, &fbdefio_state->pagereflist, list) {
 			if (cur->offset > pageref->offset)
 				break;
 		}
@@ -222,7 +232,7 @@ static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
 	if (!vmf->vma->vm_file)
 		fb_err(info, "no mapping available\n");
 
-	BUG_ON(!info->fbdefio->mapping);
+	fb_WARN_ON_ONCE(info, !fbdefio_state->mapping);
 
 	mutex_unlock(&fbdefio_state->lock);
 
@@ -364,20 +374,20 @@ static void fb_deferred_io_work(struct work_struct *work)
 	/* here we wrprotect the page's mappings, then do all deferred IO. */
 	mutex_lock(&fbdefio_state->lock);
 #ifdef CONFIG_MMU
-	list_for_each_entry(pageref, &fbdefio->pagereflist, list) {
+	list_for_each_entry(pageref, &fbdefio_state->pagereflist, list) {
 		struct page *page = pageref->page;
 		pgoff_t pgoff = pageref->offset >> PAGE_SHIFT;
 
-		mapping_wrprotect_range(fbdefio->mapping, pgoff,
+		mapping_wrprotect_range(fbdefio_state->mapping, pgoff,
 					page_to_pfn(page), 1);
 	}
 #endif
 
 	/* driver's callback with pagereflist */
-	fbdefio->deferred_io(info, &fbdefio->pagereflist);
+	fbdefio->deferred_io(info, &fbdefio_state->pagereflist);
 
 	/* clear the list */
-	list_for_each_entry_safe(pageref, next, &fbdefio->pagereflist, list)
+	list_for_each_entry_safe(pageref, next, &fbdefio_state->pagereflist, list)
 		fb_deferred_io_pageref_put(pageref, info);
 
 	mutex_unlock(&fbdefio_state->lock);
@@ -402,7 +412,6 @@ int fb_deferred_io_init(struct fb_info *info)
 	fbdefio_state->info = info;
 
 	INIT_DELAYED_WORK(&info->deferred_work, fb_deferred_io_work);
-	INIT_LIST_HEAD(&fbdefio->pagereflist);
 	if (fbdefio->delay == 0) /* set a default of 1 s */
 		fbdefio->delay = HZ;
 
@@ -431,11 +440,11 @@ void fb_deferred_io_open(struct fb_info *info,
 			 struct inode *inode,
 			 struct file *file)
 {
-	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_deferred_io_state *fbdefio_state = info->fbdefio_state;
 
-	fbdefio->mapping = file->f_mapping;
+	fbdefio_state->mapping = file->f_mapping;
 	file->f_mapping->a_ops = &fb_deferred_io_aops;
-	fbdefio->open_count++;
+	fbdefio_state->open_count++;
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_open);
 
@@ -446,16 +455,15 @@ static void fb_deferred_io_lastclose(struct fb_info *info)
 
 void fb_deferred_io_release(struct fb_info *info)
 {
-	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_deferred_io_state *fbdefio_state = info->fbdefio_state;
 
-	if (!--fbdefio->open_count)
+	if (!--fbdefio_state->open_count)
 		fb_deferred_io_lastclose(info);
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_release);
 
 void fb_deferred_io_cleanup(struct fb_info *info)
 {
-	struct fb_deferred_io *fbdefio = info->fbdefio;
 	struct fb_deferred_io_state *fbdefio_state = info->fbdefio_state;
 
 	fb_deferred_io_lastclose(info);
@@ -469,6 +477,5 @@ void fb_deferred_io_cleanup(struct fb_info *info)
 	fb_deferred_io_state_put(fbdefio_state);
 
 	kvfree(info->pagerefs);
-	fbdefio->mapping = NULL;
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_cleanup);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index aed17567fe50..2791777f3a50 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -217,9 +217,6 @@ struct fb_deferred_io {
 	/* delay between mkwrite and deferred handler */
 	unsigned long delay;
 	bool sort_pagereflist; /* sort pagelist by offset */
-	int open_count; /* number of opened files; protected by fb_info lock */
-	struct list_head pagereflist; /* list of pagerefs for touched pages */
-	struct address_space *mapping; /* page cache object for fb device */
 	/* callback */
 	struct page *(*get_page)(struct fb_info *info, unsigned long offset);
 	void (*deferred_io)(struct fb_info *info, struct list_head *pagelist);
-- 
2.52.0

