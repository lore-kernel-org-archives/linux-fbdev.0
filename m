Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7638A23777
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Feb 2024 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335592; cv=none; b=tfZNYeDgwoMXLDnrKxe1eZS3Y9hxo24tBTZLEtLxqYRJwHelzF5n+J8i+u/EuoiwZCcllca5C+n9jCyPHmgIQdk/4MthB/Imby9g95WdAEoDpSqWhLnn74RY5aGpYYcx8ew/kxH38UbJ47xLQ4moXPopORDryPEudSBvaPQv4O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335592; c=relaxed/simple;
	bh=KSjAVTfi1N7pvoCW3QmVV8842ryvWk2f7NPu0hwLDrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NssYqSnYHoTKNfuA5jAFV/3IAHNpwNrJAqDCei6BuemuKtIUI+7ydjiqCMWQLGnxMc5tGX46pnNn3k5jvQLJOw/wUk7pA/gEAZdvk6EGmlUiQ2AUhXr5+YdJAr1Pcm9T7uh1VpqkngLP1gG3sMQGo9gUY3yw6Bkw2Sr12UwIL5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZqlnzQ/b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sMjcpPVH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZqlnzQ/b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sMjcpPVH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZqlnzQ/b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sMjcpPVH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZqlnzQ/b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sMjcpPVH"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 616BE22012;
	Mon, 19 Feb 2024 09:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708335588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7X0X+S6zb9A0uMYd1l9evfKYcT7tvk1W2NRM9K9t/s=;
	b=ZqlnzQ/bNwkJiJjdeVc2BZbs0d+q1y1wZiTXoZGXKlX+LDgxo3J4PTUwr7t5gy2qpC1MEv
	b775EItseOJbSoGVx48CEgllflpw/JgalCfJ/fp0MN9RrualtzD5eh7j5BaCXnuoLQMA7t
	JRa1em+nBIMPXCPCGwWXM+oRUyAGN34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708335588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7X0X+S6zb9A0uMYd1l9evfKYcT7tvk1W2NRM9K9t/s=;
	b=sMjcpPVHqK/7oiYvZbSFcSelZcOsQw6kEaDNR38w966GCkTr0gBGJEsD1OIV42N4U7O+87
	5TgrNeuBaPU1BwCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708335588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7X0X+S6zb9A0uMYd1l9evfKYcT7tvk1W2NRM9K9t/s=;
	b=ZqlnzQ/bNwkJiJjdeVc2BZbs0d+q1y1wZiTXoZGXKlX+LDgxo3J4PTUwr7t5gy2qpC1MEv
	b775EItseOJbSoGVx48CEgllflpw/JgalCfJ/fp0MN9RrualtzD5eh7j5BaCXnuoLQMA7t
	JRa1em+nBIMPXCPCGwWXM+oRUyAGN34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708335588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7X0X+S6zb9A0uMYd1l9evfKYcT7tvk1W2NRM9K9t/s=;
	b=sMjcpPVHqK/7oiYvZbSFcSelZcOsQw6kEaDNR38w966GCkTr0gBGJEsD1OIV42N4U7O+87
	5TgrNeuBaPU1BwCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 07A9E13A2C;
	Mon, 19 Feb 2024 09:39:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ONy4AOQh02XlUAAAn2gu4w
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
Subject: [PATCH v3 4/9] fbdev: Do not include <linux/backlight.h> in header
Date: Mon, 19 Feb 2024 10:37:29 +0100
Message-ID: <20240219093941.3684-5-tzimmermann@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ZqlnzQ/b";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sMjcpPVH
X-Spamd-Result: default: False [2.68 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 R_RATELIMIT(0.00)[to_ip_from(RLw1715dab7ink4c1kuyfofm5y)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[gmx.de,redhat.com,linux.intel.com,ffwll.ch,gmail.com,linuxfoundation.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[49.68%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.68
X-Rspamd-Queue-Id: 616BE22012
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

Forward declare struct backlight_device and remove the include
statement.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Helge Deller <deller@gmx.de>
---
 include/linux/fb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 2ce2f5c2fca9a..7380d959c5d53 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -13,11 +13,11 @@
 #include <linux/workqueue.h>
 #include <linux/notifier.h>
 #include <linux/list.h>
-#include <linux/backlight.h>
 #include <linux/slab.h>
 
 #include <asm/fb.h>
 
+struct backlight_device;
 struct vm_area_struct;
 struct fb_info;
 struct device;
-- 
2.43.0

