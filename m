Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DFF210E4
	for <linux-fbdev@vger.kernel.org>; Tue, 13 Feb 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813851; cv=none; b=EdbIe55oLyIj+aLhYfRF6O0X2z0aD6z6823PWXg233pH5/yyvqDC7Eoq/jTWPIS1IkFZBHff6mbNfSSCOc9DDeVVIO1xCXTLnt4AGzTXFF6xT5ZyrgZ3InKoKQf0D79BLH9sl/cAnYKDAUFogXY3riGg+lX5PYSPezM/JLZKZa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813851; c=relaxed/simple;
	bh=/bMmL9vbjVwxGJaT7csGYmvrN0j9CqiiIz8BwjUXZyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kt20DZgIL61aRNsZBNpf6C86ssWld05MEIelmgOC8kExmbJMq6tDHxDbah0kZ14yeeKbrWIZYm44WAdur5CdVVXptvw6Fwmq5K2uMsUXKeKsTPhqWZcf7oLRgMRA5FDIF280flqzquqvgdaps6CxGIxfNwK4qQZv3k4v7FZoBbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E7dwzeGl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l5EL0dJN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E7dwzeGl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l5EL0dJN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E7dwzeGl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l5EL0dJN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E7dwzeGl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l5EL0dJN"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E10B522177;
	Tue, 13 Feb 2024 08:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707813847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+H1rBmEPcJ9Jdg4FfafBNA2u6jHLRBEjb0k9CCbIMo8=;
	b=E7dwzeGlJ0ySYN9ACEycNdb08IEYz7JUMaSBYHWWxpIyCzKTigXFogAgMOkkoC+37AfvPZ
	tcTEnvE/7Gb+FLDfZ6fwC8ixEV8jL3vd3TK5N1sfPBXViTPNdjGNXTrFA2/8/14XwPUFGt
	7KyQln11YSqNLrSpBHcAwfQKbOYzb0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707813847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+H1rBmEPcJ9Jdg4FfafBNA2u6jHLRBEjb0k9CCbIMo8=;
	b=l5EL0dJNSoVbJ0/G2bSf0ekZHpdai8hQ/jQxtveqC8iTUseWG/OhPbsnju2gH+t10hHwcg
	+oChvrkwlyOJURCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707813847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+H1rBmEPcJ9Jdg4FfafBNA2u6jHLRBEjb0k9CCbIMo8=;
	b=E7dwzeGlJ0ySYN9ACEycNdb08IEYz7JUMaSBYHWWxpIyCzKTigXFogAgMOkkoC+37AfvPZ
	tcTEnvE/7Gb+FLDfZ6fwC8ixEV8jL3vd3TK5N1sfPBXViTPNdjGNXTrFA2/8/14XwPUFGt
	7KyQln11YSqNLrSpBHcAwfQKbOYzb0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707813847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+H1rBmEPcJ9Jdg4FfafBNA2u6jHLRBEjb0k9CCbIMo8=;
	b=l5EL0dJNSoVbJ0/G2bSf0ekZHpdai8hQ/jQxtveqC8iTUseWG/OhPbsnju2gH+t10hHwcg
	+oChvrkwlyOJURCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BBA91329E;
	Tue, 13 Feb 2024 08:44:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id kPjdINcry2VOFwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Tue, 13 Feb 2024 08:44:07 +0000
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
Subject: [PATCH v2 4/8] fbdev: Do not include <linux/fs.h> in header
Date: Tue, 13 Feb 2024 09:42:22 +0100
Message-ID: <20240213084403.20995-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213084403.20995-1-tzimmermann@suse.de>
References: <20240213084403.20995-1-tzimmermann@suse.de>
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
	 R_RATELIMIT(0.00)[to_ip_from(RL9pqk354j4esf7wsagg6iyf8a)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,intel.com:email];
	 FREEMAIL_TO(0.00)[gmx.de,redhat.com,linux.intel.com,ffwll.ch,gmail.com,linuxfoundation.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[20.64%]
X-Spam-Flag: NO

Forward declare struct inode and remove the include statement.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
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

