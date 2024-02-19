Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382D5250F2
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Feb 2024 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335593; cv=none; b=fyX6gdsNFfIfoYZCemST/f5CDBGQSfixtn7hfRjlE+dfEoYCRrqU1AYcY/41lt7IVIY3o2jg1XDIVPaf0jsv57XW0q5WgBNXf4205pg6hCMnX3iwTD4+OECndtNeBvaJXyk0O47BgpA6h0YbLWB2lXVeOLA/VigtkoZxYQ1jvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335593; c=relaxed/simple;
	bh=+N3U/ids2YXvFLlHVcSnU0JNdRJgzDnFDyTs+mIomsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwgvwAbeQnvXLXA5w5awOR3Q4d514Ifgpg0JLGFcrX7C9KUFcmR3hARXVZu5aJFxdug+4O/BubLq5EaKf20nMYM9MkIGfOZoJv29hjQfQ7pxQe0iBzhoaAcKIcIwQV5BEKbXur7MRo4kZvLcsLcqGfmgJlVbuz+yGGGCmCvvanE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o3K2+Kss; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C8C6xRJG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o3K2+Kss; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C8C6xRJG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o3K2+Kss";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C8C6xRJG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o3K2+Kss";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C8C6xRJG"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 750F821F28;
	Mon, 19 Feb 2024 09:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708335589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZHfy5UsH7wLj0rRm4agEHjkDkOahqTIcF90kJVC9vo=;
	b=o3K2+Kss5xRjPCv5slKPzx3D69cAr4RQvS5VOUhEGDmJYtPqHZnMYR5gvzJFbLL2JF8fxv
	SASoVSS3p5eNq/l/zVvLaeeF4UTJAToRB2QLpozrPa6nskT6bWA7VQFkffHWrtMoVPfF0o
	pgnnt4dpsMbE0ycdzzfHoYlfd24ezDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708335589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZHfy5UsH7wLj0rRm4agEHjkDkOahqTIcF90kJVC9vo=;
	b=C8C6xRJG2faV+VAv73XqWwLWaR+NX9U/7CkNPavLgXrRHFrnettReyRudfvT9oQjpE2T4x
	du+7pMjDSAP8qRCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708335589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZHfy5UsH7wLj0rRm4agEHjkDkOahqTIcF90kJVC9vo=;
	b=o3K2+Kss5xRjPCv5slKPzx3D69cAr4RQvS5VOUhEGDmJYtPqHZnMYR5gvzJFbLL2JF8fxv
	SASoVSS3p5eNq/l/zVvLaeeF4UTJAToRB2QLpozrPa6nskT6bWA7VQFkffHWrtMoVPfF0o
	pgnnt4dpsMbE0ycdzzfHoYlfd24ezDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708335589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZHfy5UsH7wLj0rRm4agEHjkDkOahqTIcF90kJVC9vo=;
	b=C8C6xRJG2faV+VAv73XqWwLWaR+NX9U/7CkNPavLgXrRHFrnettReyRudfvT9oQjpE2T4x
	du+7pMjDSAP8qRCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CA5E139F7;
	Mon, 19 Feb 2024 09:39:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QKjaBeUh02XlUAAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 19 Feb 2024 09:39:49 +0000
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
Subject: [PATCH v3 7/9] fbdev: Do not include <linux/slab.h> in header
Date: Mon, 19 Feb 2024 10:37:32 +0100
Message-ID: <20240219093941.3684-8-tzimmermann@suse.de>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o3K2+Kss;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=C8C6xRJG
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
	 BAYES_HAM(-0.01)[45.85%];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:dkim,suse.de:email,gmx.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 1.48
X-Rspamd-Queue-Id: 750F821F28
X-Spam-Flag: NO

Forward declare struct page and remove the include statement.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Helge Deller <deller@gmx.de>
---
 include/linux/fb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 90f348f14a490..42155898374b1 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/workqueue.h>
 #include <linux/list.h>
-#include <linux/slab.h>
 
 #include <asm/fb.h>
 
@@ -22,6 +21,7 @@ struct device;
 struct file;
 struct inode;
 struct notifier_block;
+struct page;
 struct videomode;
 struct device_node;
 
-- 
2.43.0

