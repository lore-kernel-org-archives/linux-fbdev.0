Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB7D3D4112
	for <linux-fbdev@vger.kernel.org>; Tue, 28 Apr 2026 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365040; cv=none; b=K2TFFskw2eL0VY/OeaSkaA2dl2fNz5C0Z26mzDUJzZkYHysFypURTFLLabvbmyyUNjKSne0Nh6qudmetNjFSZq/kABWcPWEtty1sUn2IvL4OVwZJp1Ki4czw5b7BMaMT9z4jupSHJYXrY4Kj0L9JqImJU++2+iGby+sy/W9rT04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365040; c=relaxed/simple;
	bh=yoDZs1lTj1dgBgldtgiEbrRFBO9bd6HkObkP4m4ox+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q7xJbepTh5S14GCVgrtj93LmWHxsc/d8cjqDiJtKU6uLbYrCM4bzm2aG8gJG6QJyLsGvFKoZyHiPlMn02+QSdrFEaNVY43HhUp4rRN7nXHZT3No11oX36TZCHeUgXKaA9YQ4Ec4NSKxnhEjQ0aGz9XwpzI6Cg/8e8O7fpQbck+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=La15iDXL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i+7il6vj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M0c5fwLy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pmS+6yVb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="La15iDXL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i+7il6vj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M0c5fwLy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pmS+6yVb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AFBAD6A82C;
	Tue, 28 Apr 2026 08:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777365032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=avm3G1/rI1tDyvC+d6vGtEifUZQ0JEUFACZWJztxcWQ=;
	b=La15iDXLw+V2yyUgQg3+rRHYkTuzlf82dRVYa1CzjIBYfrzfn8jxyfFrv/tMFsOaV4Nvdh
	CM6fMfhmk9j/9AVDqqNkcNnCS30gLr+/WlIByAgz/O1Wmq05ZdKDofamNYkPzC/CYteEeG
	f6P1YYRZ9l94JwgDI2a2zGMNDBfpsn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777365032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=avm3G1/rI1tDyvC+d6vGtEifUZQ0JEUFACZWJztxcWQ=;
	b=i+7il6vjAYxBHlaxb0ZKxxICBbE7iOPjsM6qQh19PPZwHqBIA6N2KhXZQyLWINF7/Y+fJs
	0bpBC5UWPECyd8Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777365031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=avm3G1/rI1tDyvC+d6vGtEifUZQ0JEUFACZWJztxcWQ=;
	b=M0c5fwLyj8v4JkryWbsPvBacdpl7u/E2TG+0Lnz0lZjF93d0bQNp7aooWxL/i3yHUw890h
	R6+B6dTmCXj6ORB+ACvUMlOmg/wV8ydEAd57lqsDvUTNZYS+QG6SCsp40rcYfQ5Z+uDQ8S
	UQOwBE2lJXwV2XaAPJzgJY9jzd2dszg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777365031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=avm3G1/rI1tDyvC+d6vGtEifUZQ0JEUFACZWJztxcWQ=;
	b=pmS+6yVbblX+Bv05AS951GRwYjBxtudDtLVItHtbfXUxFZjv3Nk+pVEu9TIi3cw7YdJNev
	uKxDzctQ7ap44VDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85555593B0;
	Tue, 28 Apr 2026 08:30:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nCAqHydw8GnROAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 28 Apr 2026 08:30:31 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] lib/fonts: Fix bit position when rotating by 180 degrees
Date: Tue, 28 Apr 2026 10:28:43 +0200
Message-ID: <20260428083025.63663-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,lists.freedesktop.org:email,gitlab.freedesktop.org:url]
X-Spam-Flag: NO

Fix the horizontal bit position when rotating a glyph by 180°. The
original code in rotate_ud() rounded the value in width up to a
multiple of 8, aka the bit pitch, and calculated the rotated pixel
from that value. The new code stores the glyph's pitch in bit_pitch,
but fails to update the rotated pixel's output accordingly. Simply
replacing the variable does this.

The bug can be reproduced by setting a font with an unaligned width,
such as sun12x22, like this:

 setfont sun12x22
 echo 2 > /sys/class/graphics/fbcon/rotate

Without the fix, the font looks distorted.

Fixes: a30e9e6b018f ("lib/fonts: Refactor glyph-rotation helpers")
Closes: https://lore.gitlab.freedesktop.org/drm-ai-reviews/review-patch7-20260407092555.58816-8-tzimmermann@suse.de/
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 lib/fonts/font_rotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fonts/font_rotate.c b/lib/fonts/font_rotate.c
index 065e0fc0667b..275406008823 100644
--- a/lib/fonts/font_rotate.c
+++ b/lib/fonts/font_rotate.c
@@ -106,7 +106,7 @@ static void __font_glyph_rotate_180(const unsigned char *glyph,
 	for (y = 0; y < height; y++) {
 		for (x = 0; x < width; x++) {
 			if (font_glyph_test_bit(glyph, x, y, bit_pitch)) {
-				font_glyph_set_bit(out, width - (1 + x + shift), height - (1 + y),
+				font_glyph_set_bit(out, bit_pitch - 1 - x - shift, height - 1 - y,
 						   bit_pitch);
 			}
 		}
-- 
2.54.0

