Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9178124B39
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Feb 2024 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335593; cv=none; b=GeOR1h/NdyHmnAUj27qUK3bJPCVQJ8BRRZEMy3QY4H98WScxgXxtTrcGr1ZS+3mRWrH5AXgWYa1Dm7DlcdpjgtTgHQKoJb4GknytN2PghKUvGLdXwWf6M5wxt5lqfTqCXgoxTFC+sh8EB3Lj0wdax2QkO01XCSxQ25vyc05orM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335593; c=relaxed/simple;
	bh=7ZfRDVIia+bYNHnJxeiaGLSPRzlNaPnTdQ1sGU6v6Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaAEDmUuZ0nJM+mOVY6z00jxuI3ixwGSrIsWQceCHCKUlDGxHejSeKU8NkqaAqHZBwLJjkDYcMFnnxUhEUj2gS5FQALNParDzhDzjAwy7Qkw9yoTeuUyfNjTt6HK4P0PjG0V8/3OdHtWUmXKHhh3rfraJGz/WL8ZwON2mPhgb14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ngp+VuW9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b+mSTXYJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ngp+VuW9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b+mSTXYJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ngp+VuW9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b+mSTXYJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ngp+VuW9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b+mSTXYJ"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B843C22075;
	Mon, 19 Feb 2024 09:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708335588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABDSD/vw3vVeLe7PKubHdRGSgqHRnPniLYR6FDl2yS8=;
	b=ngp+VuW9XDJGQ8VSs+9lkxE+1Hj/idsf8OHJnVB4Xg4kj0pawfYkiSktBWRpU0uUQWMkAj
	Ywf9kLj3dbRVqZW4+miHavkt/vBC7275lZ64Mb7L9nUyVylYgONmPpcjxKLNEPIqR/cvYv
	XL4Uag+42OCEXE59Jv4lkN3vX4sFJQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708335588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABDSD/vw3vVeLe7PKubHdRGSgqHRnPniLYR6FDl2yS8=;
	b=b+mSTXYJSiorDEBAtjTBqTZz7hZl3pi7roJkfNLGFS5nrquve+6qQYiOqnwAIM7CXrKy6e
	1JiSUcFBSUFjlhAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708335588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABDSD/vw3vVeLe7PKubHdRGSgqHRnPniLYR6FDl2yS8=;
	b=ngp+VuW9XDJGQ8VSs+9lkxE+1Hj/idsf8OHJnVB4Xg4kj0pawfYkiSktBWRpU0uUQWMkAj
	Ywf9kLj3dbRVqZW4+miHavkt/vBC7275lZ64Mb7L9nUyVylYgONmPpcjxKLNEPIqR/cvYv
	XL4Uag+42OCEXE59Jv4lkN3vX4sFJQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708335588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABDSD/vw3vVeLe7PKubHdRGSgqHRnPniLYR6FDl2yS8=;
	b=b+mSTXYJSiorDEBAtjTBqTZz7hZl3pi7roJkfNLGFS5nrquve+6qQYiOqnwAIM7CXrKy6e
	1JiSUcFBSUFjlhAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 61CF413A3C;
	Mon, 19 Feb 2024 09:39:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id AEq9FuQh02XlUAAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 19 Feb 2024 09:39:48 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	kherbst@redhat.com,
	lyude@redhat.com,
	dakr@redhat.com,
	jani.nikula@linux.intel.com,
	daniel@ffwll.ch,
	airlied@gmail.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-staging@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v3 5/9] fbdev: Do not include <linux/fs.h> in header
Date: Mon, 19 Feb 2024 10:37:30 +0100
Message-ID: <20240219093941.3684-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219093941.3684-1-tzimmermann@suse.de>
References: <20240219093941.3684-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ngp+VuW9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=b+mSTXYJ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.48 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLw1715dab7ink4c1kuyfofm5y)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmx.de,redhat.com,linux.intel.com,ffwll.ch,gmail.com,linuxfoundation.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.01)[46.93%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,intel.com:email,gmx.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 1.48
X-Rspamd-Queue-Id: B843C22075
X-Spam-Flag: NO

Forward declare struct inode and remove the include statement.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Helge Deller <deller@gmx.de>
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

