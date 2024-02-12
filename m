Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A366182C7
	for <linux-fbdev@vger.kernel.org>; Mon, 12 Feb 2024 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733042; cv=none; b=Bjwx0p5FlkBjVStFbbPE+eJ+p+5fuwZkxkGQ+qilFHIsQLCVffoPK8yWq8axoWwnaPbdodpKbKE2N4qg1AR1DlabdboNWVzyaqf7Dh+FHlT8EDbKoqbLn7+efxd+5Lj05SZCZGD9tnh6NXrSuSc7VhbOMZRibcSpNGekgdt8mR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733042; c=relaxed/simple;
	bh=y8NlLkWJogH8RjYqKxO0H3Uls0VUcFPLjG6lbOeY7k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T928XgmTsjVSfl1BO5yUAHWfn5ZsSrsYCYvq5ovCRK3q+o7ZOZARhMHPJI3kazgooIq2zdljeav9YzMQ87qmTFyYB8YnpInvLhc8rBgQvMqbFwnfV4dEg9fDD2GEIHuQE3gFgiBQlJ2WpaYxzrCKGoY2fa9o1YqTmlhT4nlliTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IwFXgAWf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2FXHD+Uv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IwFXgAWf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2FXHD+Uv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IwFXgAWf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2FXHD+Uv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IwFXgAWf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2FXHD+Uv"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A59DC1FBAF;
	Mon, 12 Feb 2024 10:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707733038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QN030QYaRpfYRe/S6wSSFSLTCs6hNMZTw/sXktfVQWE=;
	b=IwFXgAWfQOz8aIC478e1rKYtrHYF24evXEHLrQilqav58IlMeBcqfn6g/MzjEDeDTrLX8K
	ybDro6gSpJZV9YrqYSbaLSoVRruIctZaK/sgIbPa5cxWnMLfDB71dcadzMT4KkUSj0JCBe
	1n0Gzdrelk22qBQ0EEVBkTmmeKVd08Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707733038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QN030QYaRpfYRe/S6wSSFSLTCs6hNMZTw/sXktfVQWE=;
	b=2FXHD+Uv6YkmHBsAoVfmmgz3R0Bb0C9dn/2zdoVIBv2NXz9q52pL6CfmJVGBbc0k3WdLY+
	QKM6YRSCNAk2a+AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707733038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QN030QYaRpfYRe/S6wSSFSLTCs6hNMZTw/sXktfVQWE=;
	b=IwFXgAWfQOz8aIC478e1rKYtrHYF24evXEHLrQilqav58IlMeBcqfn6g/MzjEDeDTrLX8K
	ybDro6gSpJZV9YrqYSbaLSoVRruIctZaK/sgIbPa5cxWnMLfDB71dcadzMT4KkUSj0JCBe
	1n0Gzdrelk22qBQ0EEVBkTmmeKVd08Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707733038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QN030QYaRpfYRe/S6wSSFSLTCs6hNMZTw/sXktfVQWE=;
	b=2FXHD+Uv6YkmHBsAoVfmmgz3R0Bb0C9dn/2zdoVIBv2NXz9q52pL6CfmJVGBbc0k3WdLY+
	QKM6YRSCNAk2a+AA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 61D2113A2D;
	Mon, 12 Feb 2024 10:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id eNOOFi7wyWVdBgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 12 Feb 2024 10:17:18 +0000
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
Subject: [PATCH 7/7] fbdev: Clean up include statements in header file
Date: Mon, 12 Feb 2024 11:13:19 +0100
Message-ID: <20240212101712.23675-8-tzimmermann@suse.de>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IwFXgAWf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2FXHD+Uv
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.06 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLw1715dab7ink4c1kuyfofm5y)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmx.de,redhat.com,ffwll.ch,gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.43)[78.43%];
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
X-Spam-Score: 1.06
X-Rspamd-Queue-Id: A59DC1FBAF
X-Spam-Flag: NO

Include mutex.h, printk.h and types.h, remove several unnecessary
include statements, and sort the list alphabetically.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/linux/fb.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 8f70ca727a30d..708e6a177b1be 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -2,15 +2,15 @@
 #ifndef _LINUX_FB_H
 #define _LINUX_FB_H
 
-#include <linux/refcount.h>
-#include <linux/kgdb.h>
 #include <uapi/linux/fb.h>
 
 #define FBIO_CURSOR            _IOWR('F', 0x08, struct fb_cursor_user)
 
-#include <linux/init.h>
+#include <linux/mutex.h>
+#include <linux/printk.h>
+#include <linux/refcount.h>
+#include <linux/types.h>
 #include <linux/workqueue.h>
-#include <linux/list.h>
 
 #include <asm/fb.h>
 
-- 
2.43.0

