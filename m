Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12D182BE
	for <linux-fbdev@vger.kernel.org>; Mon, 12 Feb 2024 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733040; cv=none; b=pE06dDJPDirnh31wBrDFRhgiBFFOtYV9mhrvZFc4fbYbOKBnXo/Rz11CSmXNwLw9qa37gOwYH9AuWFmrHGEfmB6H+bSJXh2RAOhwIboEAiy3Zd/N/gP6SyCv0Kg3hwyWqJKeqONESu9bsnqrKE4SLfDsCAXGWfuwerGzSVtntUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733040; c=relaxed/simple;
	bh=pIv856QH10wQavX5mpWYqp8reY2An2V2Ag/ZuY3XBdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyXAoWeKFU4hRrK5olg9O8Av7Q2XhbO/BuxGZMqp6vxQosKqgQ8XsL3hD+0jWbvj1dGHs4vbuxNt3eMJIX4I14Az29oKEb/+qOCwQ/t2YUoDx4rbUmJVoL3tbjBKN67CRc5Zfqhfa04DtRC/BA46lGEdRsCGqmDxtnLBoir0T4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YtF/4tai; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kN0s/vHw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YtF/4tai; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kN0s/vHw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YtF/4tai";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kN0s/vHw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YtF/4tai";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kN0s/vHw"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D60A1FBB2;
	Mon, 12 Feb 2024 10:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707733037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NTPodXe3vKKtY3GIWahnYIvNq6IfT/2HcGPXH4RaAc=;
	b=YtF/4taimLWy7xtUmo+uA3xJtPj+sp3yddQfgtdsI7SaWipIUbqUDadAbcfw1V+Z6pSSs0
	Nbg/xsanUrUv4FnRe1kVrgSfQfIzhOmo49pb5vit9kiZtj7INIzX4fj5eBC6Fk80Dxe9Sl
	aOOAmGAWpnJ91wek0cMdjzR1GUaHN9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707733037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NTPodXe3vKKtY3GIWahnYIvNq6IfT/2HcGPXH4RaAc=;
	b=kN0s/vHw7wDBNlcB7HiXMnNKS7OHYCXkX/01MPSVB0bIKQoe/OpzW2H1poHZRijKHTF04w
	VUQUjzcfF6Q2oyBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707733037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NTPodXe3vKKtY3GIWahnYIvNq6IfT/2HcGPXH4RaAc=;
	b=YtF/4taimLWy7xtUmo+uA3xJtPj+sp3yddQfgtdsI7SaWipIUbqUDadAbcfw1V+Z6pSSs0
	Nbg/xsanUrUv4FnRe1kVrgSfQfIzhOmo49pb5vit9kiZtj7INIzX4fj5eBC6Fk80Dxe9Sl
	aOOAmGAWpnJ91wek0cMdjzR1GUaHN9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707733037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NTPodXe3vKKtY3GIWahnYIvNq6IfT/2HcGPXH4RaAc=;
	b=kN0s/vHw7wDBNlcB7HiXMnNKS7OHYCXkX/01MPSVB0bIKQoe/OpzW2H1poHZRijKHTF04w
	VUQUjzcfF6Q2oyBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BF7713A2D;
	Mon, 12 Feb 2024 10:17:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id eJCvAS3wyWVdBgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 12 Feb 2024 10:17:17 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	kherbst@redhat.com,
	lyude@redhat.com,
	dakr@redhat.com,
	daniel@ffwll.ch,
	airlied@gmail.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/7] fbdev: Do not include <linux/fs.h> in header
Date: Mon, 12 Feb 2024 11:13:15 +0100
Message-ID: <20240212101712.23675-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212101712.23675-1-tzimmermann@suse.de>
References: <20240212101712.23675-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="YtF/4tai";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="kN0s/vHw"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.47 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmx.de,redhat.com,ffwll.ch,gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.02)[51.59%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 1.47
X-Rspamd-Queue-Id: 5D60A1FBB2
X-Spam-Flag: NO

Forward declare struct inode and remove the include statement.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/linux/fb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 7380d959c5d53..f269ba5202809 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -8,7 +8,6 @@
 
 #define FBIO_CURSOR            _IOWR('F', 0x08, struct fb_cursor_user)
 
-#include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/workqueue.h>
 #include <linux/notifier.h>
@@ -22,6 +21,7 @@ struct vm_area_struct;
 struct fb_info;
 struct device;
 struct file;
+struct inode;
 struct videomode;
 struct device_node;
 
-- 
2.43.0

