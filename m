Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86164366831
	for <linux-fbdev@vger.kernel.org>; Tue, 24 Feb 2026 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921633; cv=none; b=bAce898w3LdfTyz2CC8fo1cWOwqHT9lPBdlrDCsmhCo98OjQuczcX1Q/h5MF4HiYJEZqMLJfz126J6fClNcpN05dpcuuOYQudYY4Ufhyz2YVcyN4+Aoz/nC7VHqxr0KWvG03Ri0k2HCImV6zT9dDL6MWKwzMw4dUAGQtZ+UOoFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921633; c=relaxed/simple;
	bh=B6K+Q7bahM3U04gvqOmjdoh/0Z2RQWKCaqI/Q+e8ars=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZwLp25orFVXkmodDThyBI4M201uxh6ou0Hp07kq9MrQtaMjCeyOMeXU7snzGAiRU07zorri60G2jyTT4+14C4Sd2bFt2UD3jJ06A661RNCGX5ZPQ0z2BuzGRJERVdDHZHh6hM6yGlKspY2wZt2Ahq5bTLB/YkPzWgSXvfIpVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q2lCbdqB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PW55RTtm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0hZuf8ps; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jVArQgqY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q2lCbdqB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PW55RTtm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0hZuf8ps";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jVArQgqY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A46C43F103;
	Tue, 24 Feb 2026 08:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771921623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OI4baw2/36ZS5OmXr1TUT1WjqsmWmX/KkcxFcE7zL80=;
	b=Q2lCbdqBkNz+FiiapOQHOioXYfXhkXmXyDTdeWg0JLjg7qI0WA0ubAU5Inasp4tTUXcSZT
	5M/bqjti+gMHNKzFqFAcXKBvl44W6JpDvM5ls5N/2XMXlhxUFsnun4YEjThXez+4+aI+t8
	ae3ADXelKQY1GWURrxkVO1IfzVJdzr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771921623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OI4baw2/36ZS5OmXr1TUT1WjqsmWmX/KkcxFcE7zL80=;
	b=PW55RTtmiFp4Mk0YumuCH1e7V3lWB7wmmzYYBXpnHOzopcIxWyqohfCoySKGgyXl5gdev9
	8/6gkPR0P0esNaBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771921622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OI4baw2/36ZS5OmXr1TUT1WjqsmWmX/KkcxFcE7zL80=;
	b=0hZuf8pssM5Z5DxySA44dV3YCbmLnI9XgY5DuF8HzAR4gTfsgToJAQnCMEaKhZVVJIeqIW
	99qLX/8aWFgTQm1hjns3tKFLTmAIMOS6//IKB2swVSqWGqQEecwqiLR0LiunSN88kofPJp
	x0Y2Yq8eEvvUCX9ImTYSVzHnum82D5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771921622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OI4baw2/36ZS5OmXr1TUT1WjqsmWmX/KkcxFcE7zL80=;
	b=jVArQgqYP5xkGTfl5YNGronxNUs4vHwsWcCTauBzQ1+8z3nE4e6yVQqcZ0ny+tNoHsuO+N
	t57CRdsj7s4MpACw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6710D3EA6A;
	Tue, 24 Feb 2026 08:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +E38F9ZgnWnVQAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 24 Feb 2026 08:27:02 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch,
	jayalk@intworks.biz
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 2/4] fbdev: defio: Keep module reference from VMAs
Date: Tue, 24 Feb 2026 09:25:55 +0100
Message-ID: <20260224082657.207284-3-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.de,ffwll.ch,intworks.biz];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -2.80
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
index 93bd2f696fa4..56030eb42f71 100644
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

