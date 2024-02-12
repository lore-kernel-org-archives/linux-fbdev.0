Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641CD182CC
	for <linux-fbdev@vger.kernel.org>; Mon, 12 Feb 2024 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733041; cv=none; b=ZtSNpznBPvvrcvnJaQm7ge5DhAlSfyZumY+iwkJ8Ojh1URXwunW+7T46OZ647vwn/3PQ6cDNv25Z74lHc7Kwub5dSmmLfVuS3gBUmYFYCBYaX/CZMeS8vbAHQXvms7voUFTha0peCCnJx2UDm1ned41CZ8ixmGlw5AWMBAA6Zc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733041; c=relaxed/simple;
	bh=NQHcLRJdb0swPy9cMyx7WhcsKKxXWnLhh9gJxECbQ4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWYtcZl/yFJmG2lpR1FaMCE7mOOFQX1MLgsAbURkiBkUHSQmxd01AXDBsLNTtN7Z/Y++/bHY9SjeDVzAOlkKQ83MSnDDf4PeiLNqVhHCDoTQcNpDyxxR+nG5UDdTQ2X9anhvF6q7FsB5+kTYUZkoNmMBbR7NLMlQuNfl2fsDP2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bx1B+pVk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uQpLd6bi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bx1B+pVk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uQpLd6bi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bx1B+pVk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uQpLd6bi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bx1B+pVk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uQpLd6bi"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B158421F97;
	Mon, 12 Feb 2024 10:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707733037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82PNVwQC1wA3LK+ACQw8lzz+37oMQ5jDAfi27/8FqNY=;
	b=Bx1B+pVkJS47hl0u8eGLqKePKkeKoXteUCTcfMVAyFckxkPr+kIuB4W0wXq5gACNoCzlVV
	J/GUrRGZ56h/8veE3wxhEBDjd2hX9aiAwzjfRBG/2/Y3DgL+kfSGLpziaW68rk9KWrE/to
	VqEo+76L+wjbGghxRGkBdDJvxmqj0r8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707733037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82PNVwQC1wA3LK+ACQw8lzz+37oMQ5jDAfi27/8FqNY=;
	b=uQpLd6biy2SdfV513yNyxeZrs+iHOM9Dn7mH2Lro6Se8v49lDkTtx51PzQrSpggVK5vmj1
	IzPmv6kGE0D84XDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707733037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82PNVwQC1wA3LK+ACQw8lzz+37oMQ5jDAfi27/8FqNY=;
	b=Bx1B+pVkJS47hl0u8eGLqKePKkeKoXteUCTcfMVAyFckxkPr+kIuB4W0wXq5gACNoCzlVV
	J/GUrRGZ56h/8veE3wxhEBDjd2hX9aiAwzjfRBG/2/Y3DgL+kfSGLpziaW68rk9KWrE/to
	VqEo+76L+wjbGghxRGkBdDJvxmqj0r8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707733037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82PNVwQC1wA3LK+ACQw8lzz+37oMQ5jDAfi27/8FqNY=;
	b=uQpLd6biy2SdfV513yNyxeZrs+iHOM9Dn7mH2Lro6Se8v49lDkTtx51PzQrSpggVK5vmj1
	IzPmv6kGE0D84XDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 633F013A0E;
	Mon, 12 Feb 2024 10:17:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id iDwBFy3wyWVdBgAAn2gu4w
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
Subject: [PATCH 4/7] fbdev: Do not include <linux/notifier.h> in header
Date: Mon, 12 Feb 2024 11:13:16 +0100
Message-ID: <20240212101712.23675-5-tzimmermann@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Bx1B+pVk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uQpLd6bi
X-Spamd-Result: default: False [2.69 / 50.00];
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
	 FREEMAIL_TO(0.00)[gmx.de,redhat.com,ffwll.ch,gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[42.05%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.69
X-Rspamd-Queue-Id: B158421F97
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

Forward declare struct notifier_block and remove the include
statement.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/linux/fb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index f269ba5202809..90f348f14a490 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -10,7 +10,6 @@
 
 #include <linux/init.h>
 #include <linux/workqueue.h>
-#include <linux/notifier.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 
@@ -22,6 +21,7 @@ struct fb_info;
 struct device;
 struct file;
 struct inode;
+struct notifier_block;
 struct videomode;
 struct device_node;
 
-- 
2.43.0

