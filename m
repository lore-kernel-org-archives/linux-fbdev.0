Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA27286D70
	for <linux-fbdev@vger.kernel.org>; Thu, 22 Jan 2026 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087547; cv=none; b=k7EUh1Xgrh32jrCXI6AExoLeAyJt+MgLc5VcAfXMSsmUAtSmxurLyx53myU8hhobVA7xRkdp3rr86XB5uUmf9/g9HpWT/jGpylYsHG5qEAO5j2XpHgDSLcXPMZSyDVsBYUmRcjhDM0+c29ST39ncquXIb9OKrmpmRXVf9mj/vqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087547; c=relaxed/simple;
	bh=WRZ0EhXLJb29aLwhEGFqxGncGobFxQS7ZoIuhvN9DFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dH0n4VJvS25oN3Azj+2bbywXj/oFGAOXcaetdqQyZpXjPjez/SWrq/IeknTl4WVigQFLAEUcQtWhZbEjM9xtsqVO7R4FnRmGLrKVvacH9+eqUogP2XvI1t8Yly6pAAJzKLjXS5RTBgaiN74ZUCU8A03UH5o72KZ4rxNIullJoCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vsRLFaE/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=up4No6HG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vsRLFaE/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=up4No6HG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vsRLFaE/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="up4No6HG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vsRLFaE/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="up4No6HG"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A3AA5BCCC;
	Thu, 22 Jan 2026 13:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769087537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VLhTJSno1bZLuuuage2WaKWdag1/dIKALqAVIskMquk=;
	b=vsRLFaE/FkUf69cYoY5l4rfg59bweqcy2XfesC+7nduJKgTvjy15aLdi/kJOA8os/9lITN
	+gTwusE5fgIyOGSNeBYfMdwUnK+Mid569sDSDnCbyQtys63kcTpKAZWngDIBIgnSYSZaAy
	fI+du/cOxg9QkphVmDc1j0cXvTnO5Aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769087537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VLhTJSno1bZLuuuage2WaKWdag1/dIKALqAVIskMquk=;
	b=up4No6HGfuLpI4hrV7ekdo/sSGkAjnxnNLUu6QYkd2oyJpdQjed7m/x5WUMm3vFJc6v7jj
	cdQ6p97TKwu+q6BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769087537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VLhTJSno1bZLuuuage2WaKWdag1/dIKALqAVIskMquk=;
	b=vsRLFaE/FkUf69cYoY5l4rfg59bweqcy2XfesC+7nduJKgTvjy15aLdi/kJOA8os/9lITN
	+gTwusE5fgIyOGSNeBYfMdwUnK+Mid569sDSDnCbyQtys63kcTpKAZWngDIBIgnSYSZaAy
	fI+du/cOxg9QkphVmDc1j0cXvTnO5Aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769087537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VLhTJSno1bZLuuuage2WaKWdag1/dIKALqAVIskMquk=;
	b=up4No6HGfuLpI4hrV7ekdo/sSGkAjnxnNLUu6QYkd2oyJpdQjed7m/x5WUMm3vFJc6v7jj
	cdQ6p97TKwu+q6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39AAF13533;
	Thu, 22 Jan 2026 13:12:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IDTgDDEicmlgMgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 22 Jan 2026 13:12:17 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch,
	jayalk@intworks.biz
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/4] fbdev: defio: Keep module reference from VMAs
Date: Thu, 22 Jan 2026 14:08:30 +0100
Message-ID: <20260122131213.992810-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122131213.992810-1-tzimmermann@suse.de>
References: <20260122131213.992810-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.de,ffwll.ch,intworks.biz];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

Acquire a module reference on each mmap and VMA open; hold it until
the kernel closes the VMA. Protects against unloading the module
while user space still has a mapping of the graphics memory. The
VMA page-fault handling would then call into undefined code.

This situation can happen if the underlying device has been unplugged
and the driver has been unloaded. It would then be possible to trigger
the bug by unloading the fbdev core module.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fb_defio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index 0b099a89a823..331b1a9fe485 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -14,6 +14,7 @@
 #include <linux/export.h>
 #include <linux/string.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -83,6 +84,7 @@ static void fb_deferred_io_vm_open(struct vm_area_struct *vma)
 {
 	struct fb_deferred_io_state *fbdefio_state = vma->vm_private_data;
 
+	WARN_ON_ONCE(!try_module_get(THIS_MODULE));
 	fb_deferred_io_state_get(fbdefio_state);
 }
 
@@ -91,6 +93,7 @@ static void fb_deferred_io_vm_close(struct vm_area_struct *vma)
 	struct fb_deferred_io_state *fbdefio_state = vma->vm_private_data;
 
 	fb_deferred_io_state_put(fbdefio_state);
+	module_put(THIS_MODULE);
 }
 
 static struct page *fb_deferred_io_get_page(struct fb_info *info, unsigned long offs)
@@ -335,6 +338,9 @@ int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 
+	if (!try_module_get(THIS_MODULE))
+		return -EINVAL;
+
 	vma->vm_ops = &fb_deferred_io_vm_ops;
 	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
 	if (!(info->flags & FBINFO_VIRTFB))
-- 
2.52.0

