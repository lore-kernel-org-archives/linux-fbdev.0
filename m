Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685E27C6F0
	for <linux-fbdev@vger.kernel.org>; Tue, 12 Mar 2024 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258522; cv=none; b=uYi53We6BOX7lvl9aVy5AzMXzDhRx5Feno41yAwiqMsvHQ8WD7+8kJrYCmD9MdaD9U9UkfOYiZqLrZeHjx3ySGsjF6aJt/JqwPK/ivPSIwOPKgHgmLqZ2lfHRh4A7BIxxAZhRSTTsdySmtg+rxbLV9q4/dMpKLV1RA+gjbuwuKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258522; c=relaxed/simple;
	bh=YwhQpNixaMuZZkqm6e25evyLDZJhsyCyeTtxDpFsy2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhxeWcPaO6ZY1HDHGUdN+IfwCf6tlz1kn7EcJz+L1Kbs1gKNEJoPIRJ75yvsE4GwpmCX0zs8muxj67/aFnUHptXNkq1EQ9BFu2Vc1qv6NAVdX+Fzhf5HfpcIwFOM8+mzH1VyDgsOLnYjo2nCuyqrmE+XgZB3VsE5Sauj+2QeLr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n3lEUqo+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U80IhNzN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n3lEUqo+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U80IhNzN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n3lEUqo+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U80IhNzN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n3lEUqo+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U80IhNzN"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88F9337876;
	Tue, 12 Mar 2024 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QnMdUxfi0xN/eOzVELWrTkxojcelKMPil/HGmRkpxM=;
	b=n3lEUqo+JZtGTNygIAYo7JDerQ+r6zINgsfLPhI3XfNlqd4neO1FjS2s0tlxdm6xa2hVSX
	kZvBic92Q4H7gdJc7tw8I/T316ff/UpmGo7U5IdDi44K4MIVKLWENFUF46HU6sXU5ls4Y+
	/Jje2vEDSflJDALdewSafsMWInmqrTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QnMdUxfi0xN/eOzVELWrTkxojcelKMPil/HGmRkpxM=;
	b=U80IhNzNBIMWc9MH4HQMF/b2JP/yBppzvRXKnIWXIoEt+shO8z9oM+zvhrQvvWwR8byg3x
	OQleEOwt83F/koAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710258518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QnMdUxfi0xN/eOzVELWrTkxojcelKMPil/HGmRkpxM=;
	b=n3lEUqo+JZtGTNygIAYo7JDerQ+r6zINgsfLPhI3XfNlqd4neO1FjS2s0tlxdm6xa2hVSX
	kZvBic92Q4H7gdJc7tw8I/T316ff/UpmGo7U5IdDi44K4MIVKLWENFUF46HU6sXU5ls4Y+
	/Jje2vEDSflJDALdewSafsMWInmqrTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710258518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QnMdUxfi0xN/eOzVELWrTkxojcelKMPil/HGmRkpxM=;
	b=U80IhNzNBIMWc9MH4HQMF/b2JP/yBppzvRXKnIWXIoEt+shO8z9oM+zvhrQvvWwR8byg3x
	OQleEOwt83F/koAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4ED331364F;
	Tue, 12 Mar 2024 15:48:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aKXCEVZ58GUhPwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 12 Mar 2024 15:48:38 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch,
	airlied@gmail.com,
	deller@gmx.de,
	javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 05/43] fbdev/deferred-io: Test smem_start for I/O memory
Date: Tue, 12 Mar 2024 16:45:00 +0100
Message-ID: <20240312154834.26178-6-tzimmermann@suse.de>
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
X-Spam-Score: -0.38
X-Spamd-Result: default: False [-0.38 / 50.00];
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
	 BAYES_HAM(-0.08)[63.17%]
X-Spam-Flag: NO

Test smem_start before looking up pages from its value. Return
NULL if it is unset. This will result in a SIGBUS signal.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fb_defio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index b38f775cd39dd..fe84218ded457 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -26,11 +26,11 @@
 static struct page *fb_deferred_io_page(struct fb_info *info, unsigned long offs)
 {
 	const void *screen_buffer = info->screen_buffer;
-	struct page *page;
+	struct page *page = NULL;
 
 	if (is_vmalloc_addr(screen_buffer + offs))
 		page = vmalloc_to_page(screen_buffer + offs);
-	else
+	else if (info->fix.smem_start)
 		page = pfn_to_page((info->fix.smem_start + offs) >> PAGE_SHIFT);
 
 	return page;
-- 
2.44.0

