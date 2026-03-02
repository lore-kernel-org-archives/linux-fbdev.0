Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D4D383C6B
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Mar 2026 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460789; cv=none; b=YLL7QyyJvtItXkQfb0iBdK4Latd3zSSKHpVSbCOTsNECYjp8nXzGyERUAxWas939zWJ94KWw3tN45LHwPEyB3Hu99VlK9lTdb1vpzf/Z1z+UNVBYRufyl6g2rRY2Q3FWs/FAlVyJC3N0Lg8IoU5xYKgWlkjwkw6N55yP8rNMVdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460789; c=relaxed/simple;
	bh=y5XmvC6gfj9Y6OOeaLySFj7KBmblfrGrs0BAJ/FBFH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzocjIaxx5hK6JSkGwIctztEMm/TQnydZViE/Td6jGP/gDFKM8wWxcAahkPticFAZZgILxyZIgcUYHMM3qzkcRDFmJWwD5/5MhlEvjlvj5mBhZxVdm4Y0cKUqE/vKBXkGZFYoVQs1f7Mu/+N4R1y6/Mqw1Cb+C6VF/A2zdRIKAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b/u9Tzrl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2bzrEPAw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b/u9Tzrl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2bzrEPAw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b/u9Tzrl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2bzrEPAw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b/u9Tzrl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2bzrEPAw"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 509533F7F5;
	Mon,  2 Mar 2026 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772460781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDq/cW2yhQBHf4nLvdY7/6+Jg/oVSc5PEO9Oi8OztLE=;
	b=b/u9Tzrl23HDfTAr90zvkPHr63R035p7r+FyICMT8ZQumcqWU7eL5ecb8SV9Qj707+IxWd
	0mG2lZPPuPv7AWQ+RFmu9jqwilsqx2tnYrQnFQnL3q59u+iJe7RfoxlnjS77aYfgSpilN/
	8F1+6GWa42fXkNqlOaeAtjY0TTco9Tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772460781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDq/cW2yhQBHf4nLvdY7/6+Jg/oVSc5PEO9Oi8OztLE=;
	b=2bzrEPAw0didfkJOyLaWaBHQqwWbt6TQuxMZyJFJg7tRuKaPumkoNQnUl9UElDqZMcuxS9
	2yJmNa3twN6Rq/Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="b/u9Tzrl";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2bzrEPAw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772460781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDq/cW2yhQBHf4nLvdY7/6+Jg/oVSc5PEO9Oi8OztLE=;
	b=b/u9Tzrl23HDfTAr90zvkPHr63R035p7r+FyICMT8ZQumcqWU7eL5ecb8SV9Qj707+IxWd
	0mG2lZPPuPv7AWQ+RFmu9jqwilsqx2tnYrQnFQnL3q59u+iJe7RfoxlnjS77aYfgSpilN/
	8F1+6GWa42fXkNqlOaeAtjY0TTco9Tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772460781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDq/cW2yhQBHf4nLvdY7/6+Jg/oVSc5PEO9Oi8OztLE=;
	b=2bzrEPAw0didfkJOyLaWaBHQqwWbt6TQuxMZyJFJg7tRuKaPumkoNQnUl9UElDqZMcuxS9
	2yJmNa3twN6Rq/Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E39B3EA6C;
	Mon,  2 Mar 2026 14:13:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QND9Be2apWleKQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Mar 2026 14:13:01 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 05/13] lib/fonts: Remove trailing whitespaces
Date: Mon,  2 Mar 2026 15:08:39 +0100
Message-ID: <20260302141255.518657-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302141255.518657-1-tzimmermann@suse.de>
References: <20260302141255.518657-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de,ravnborg.org];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_RATELIMIT(0.00)[to_ip_from(RLf7er7x8tqp4b41gsueb7z9k6)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Rspamd-Queue-Id: 509533F7F5
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Fix coding style. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 lib/fonts/font_acorn_8x8.c | 2 +-
 lib/fonts/font_mini_4x6.c  | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/fonts/font_acorn_8x8.c b/lib/fonts/font_acorn_8x8.c
index 18755c33d249..af5fa72aa8b7 100644
--- a/lib/fonts/font_acorn_8x8.c
+++ b/lib/fonts/font_acorn_8x8.c
@@ -68,7 +68,7 @@ static const struct font_data acorndata_8x8 = {
 /* 3A */  0x00, 0x00, 0x18, 0x18, 0x00, 0x18, 0x18, 0x00, /* : */
 /* 3B */  0x00, 0x00, 0x18, 0x18, 0x00, 0x18, 0x18, 0x30, /* ; */
 /* 3C */  0x0C, 0x18, 0x30, 0x60, 0x30, 0x18, 0x0C, 0x00, /* < */
-/* 3D */  0x00, 0x00, 0x7E, 0x00, 0x7E, 0x00, 0x00, 0x00, /* = */ 
+/* 3D */  0x00, 0x00, 0x7E, 0x00, 0x7E, 0x00, 0x00, 0x00, /* = */
 /* 3E */  0x30, 0x18, 0x0C, 0x06, 0x0C, 0x18, 0x30, 0x00, /* > */
 /* 3F */  0x3C, 0x66, 0x0C, 0x18, 0x18, 0x00, 0x18, 0x00, /* ? */
 /* 40 */  0x3C, 0x66, 0x6E, 0x6A, 0x6E, 0x60, 0x3C, 0x00, /* @ */
diff --git a/lib/fonts/font_mini_4x6.c b/lib/fonts/font_mini_4x6.c
index 8d39fd447952..cc21dc70cfd1 100644
--- a/lib/fonts/font_mini_4x6.c
+++ b/lib/fonts/font_mini_4x6.c
@@ -18,15 +18,15 @@
 s{((0x)?[0-9a-fA-F]+)(.*\[([\*\ ]{4})\])}{
 
 	($num,$pat,$bits) = ($1,$3,$4);
-	
+
 	$bits =~ s/([^\s0])|(.)/ defined($1) + 0 /ge;
-	
+
 	$num = ord(pack("B8", $bits));
 	$num |= $num >> 4;
 	$num = sprintf("0x%.2x", $num);
-	
+
 	#print "$num,$pat,$bits\n";
-	
+
 	$num . $pat;
 }ge;
 
-- 
2.53.0

