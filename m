Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBDBC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Feb 2022 10:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiBQKe1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 17 Feb 2022 05:34:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiBQKeZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 17 Feb 2022 05:34:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E1010610D
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Feb 2022 02:34:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E5E3F1F383;
        Thu, 17 Feb 2022 10:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645094047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F4LK7D/i/q6AMJCHtRDXYS+MysU4b1EGJIuXtJxR1iI=;
        b=R8Mr+jVBiWde+vWeGGEgGnpmI2luBW5LXkXuBFqDdHXB3IOSryCOJ2DnsG1Pa1CSVYYzfQ
        +S2z9lY5I5dZza7wFJRd9xb8cRDMqcTxTgTdv/loQOnvywLbvdg7o3X+mpP7BBy6n8OJ4P
        6sMEFsBE+icDnWm4bgdbDl94cJbZWzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645094047;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F4LK7D/i/q6AMJCHtRDXYS+MysU4b1EGJIuXtJxR1iI=;
        b=9J04Mw3ixS1TpB/Jj2TD8ZmjsSclYtFzfe1DGti86s3VTFadJIUuvmzCK4x9CYEQtprBuJ
        h3hTF/MN5hY1ACAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B903E13DD8;
        Thu, 17 Feb 2022 10:34:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sBTOK58kDmLQQgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 17 Feb 2022 10:34:07 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, deller@gmx.de, javierm@redhat.com,
        geert@linux-m68k.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/2] fbdev: Improve performance of sys_fillrect()
Date:   Thu, 17 Feb 2022 11:34:04 +0100
Message-Id: <20220217103405.26492-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217103405.26492-1-tzimmermann@suse.de>
References: <20220217103405.26492-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Improve the performance of sys_fillrect() by using word-aligned
32/64-bit mov instructions. While the code tried to implement this,
the compiler failed to create fast instructions. The resulting
binary instructions were even slower than cfb_fillrect(), which
uses the same algorithm, but operates on I/O memory.

A microbenchmark measures the average number of CPU cycles
for sys_fillrect() after a stabilizing period of a few minutes
(i7-4790, FullHD, simpledrm, kernel with debugging). The value
for CFB is given as a reference.

  sys_fillrect(), new:  26586 cycles
  sys_fillrect(), old: 166603 cycles
  cfb_fillrect():       41012 cycles

In the optimized case, sys_fillrect() is now ~6x faster than before
and ~1.5x faster than the CFB implementation.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/sysfillrect.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/core/sysfillrect.c b/drivers/video/fbdev/core/sysfillrect.c
index 33ee3d34f9d2..bcdcaeae6538 100644
--- a/drivers/video/fbdev/core/sysfillrect.c
+++ b/drivers/video/fbdev/core/sysfillrect.c
@@ -50,19 +50,9 @@ bitfill_aligned(struct fb_info *p, unsigned long *dst, int dst_idx,
 
 		/* Main chunk */
 		n /= bits;
-		while (n >= 8) {
-			*dst++ = pat;
-			*dst++ = pat;
-			*dst++ = pat;
-			*dst++ = pat;
-			*dst++ = pat;
-			*dst++ = pat;
-			*dst++ = pat;
-			*dst++ = pat;
-			n -= 8;
-		}
-		while (n--)
-			*dst++ = pat;
+		memset_l(dst, pat, n);
+		dst += n;
+
 		/* Trailing bits */
 		if (last)
 			*dst = comp(pat, *dst, last);
-- 
2.34.1

