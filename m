Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7E215B996
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Apr 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754364; cv=none; b=qtOCNflOO7Y/25Rmfpm7gDDl25POgr3t7K+Z1lvpR/j8EyhkVexwCDq7XgD5YjyQDxIEeV3plKXkVTrk5ZNeoMAbR0waw88Wtgj6TEKH9azFQz1SzfAotRunt2i5Ab9ZgkBxViou9VpXbKBFDipe96Hq2JAuFvdxzROstcbtI5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754364; c=relaxed/simple;
	bh=hCrzEOjI0OAO5DVUT4+7MLnXx3u6Z+QHvbRz3Sn2CT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWw03eJ5xyc4aC+e6lBXNQz4fF1BfAFenfSadCq1YngF1vj9PVWzDqOQy9gBR8gUoxSCXoy6nw2YdgnDbnt6yNnjgZMnUqnY25BloTBalvquv6nIM13XYX/SgySTzZI+0jcAp+avShyRFuIXWnn5qYhmFYe9bOYcfO2GTyK/29E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NJe+pTI/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z1BzO80d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NJe+pTI/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z1BzO80d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NJe+pTI/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z1BzO80d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NJe+pTI/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z1BzO80d"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B369351E7;
	Wed, 10 Apr 2024 13:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712754360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmKTvkwY+oOfDN+5iCLZo9Eobw9ZLVNIYXh2yx6R4EE=;
	b=NJe+pTI/8X5rASVwpvZSwI/xc5gBHoBit8Lkgs3vi6zEV0TQMd0GntJbJkvQ3YxC4Y6S7c
	0EombMIaZNMccMDFRbxMGTMSbA5K38afk1H8o36aO11pUHHGwzpA+Ec/27uttfGNRUTCw9
	NR5jfQkJvgFXzXa8d+Nzrb1lskk8yVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712754360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmKTvkwY+oOfDN+5iCLZo9Eobw9ZLVNIYXh2yx6R4EE=;
	b=z1BzO80dilZEBFWucco7bYElxVGAnznH60gpy2jofGtSc1yjA8QLMpCZqs0fHFv0G9q3CE
	mFnnLGukVofNdpBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712754360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmKTvkwY+oOfDN+5iCLZo9Eobw9ZLVNIYXh2yx6R4EE=;
	b=NJe+pTI/8X5rASVwpvZSwI/xc5gBHoBit8Lkgs3vi6zEV0TQMd0GntJbJkvQ3YxC4Y6S7c
	0EombMIaZNMccMDFRbxMGTMSbA5K38afk1H8o36aO11pUHHGwzpA+Ec/27uttfGNRUTCw9
	NR5jfQkJvgFXzXa8d+Nzrb1lskk8yVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712754360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmKTvkwY+oOfDN+5iCLZo9Eobw9ZLVNIYXh2yx6R4EE=;
	b=z1BzO80dilZEBFWucco7bYElxVGAnznH60gpy2jofGtSc1yjA8QLMpCZqs0fHFv0G9q3CE
	mFnnLGukVofNdpBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6268D13AB9;
	Wed, 10 Apr 2024 13:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UOjYFriOFmYdEgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Apr 2024 13:06:00 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	deller@gmx.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 05/43] fbdev/deferred-io: Test smem_start for I/O memory
Date: Wed, 10 Apr 2024 15:02:01 +0200
Message-ID: <20240410130557.31572-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410130557.31572-1-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.33
X-Spam-Level: 
X-Spamd-Result: default: False [-4.33 / 50.00];
	REPLY(-4.00)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.53)[80.48%];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[redhat.com,gmx.de,gmail.com,ffwll.ch];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:email];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]

Test smem_start before looking up pages from its value. Return
NULL if it is unset. This will result in a SIGBUS signal.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
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

