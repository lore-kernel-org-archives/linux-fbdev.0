Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F22DC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Feb 2022 19:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiBUTyj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:54:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiBUTyi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 21 Feb 2022 14:54:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97AD22536
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Feb 2022 11:54:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70D9721121;
        Mon, 21 Feb 2022 19:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645473252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s5ZN7uI6UG6Di2iSINpGQFR90gjSNoFjkDK2XKHJmb8=;
        b=yxbM0SVLrfBkRLIapojSclgCZHRESVsOnKsd8m2JbN0tFrsMJTcZs9uNDLidoNpzusO2vg
        dEYui5fHyiLYWk0S41Qexe1mne55kyfBVWOr7EyaJSQ6uIENuIrgiJptvyIE2huL4BkYHH
        ZG2rAGLgYue34oLVq6JDU6zReAYZzB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645473252;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s5ZN7uI6UG6Di2iSINpGQFR90gjSNoFjkDK2XKHJmb8=;
        b=97EbUZA1mCER9Li4qoF07sQ4zB8b1Oij4cjqsefwQI3lu2b1+al8dZknzL7ZSGlGF3oNgD
        Cq61WQIFYxrpB5DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F4C313B78;
        Mon, 21 Feb 2022 19:54:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KFSJDuTtE2KVPwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 21 Feb 2022 19:54:12 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, deller@gmx.de, javierm@redhat.com,
        geert@linux-m68k.org, sam@ravnborg.org, kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 1/5] fbdev: Improve performance of sys_fillrect()
Date:   Mon, 21 Feb 2022 20:54:06 +0100
Message-Id: <20220221195410.9172-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221195410.9172-1-tzimmermann@suse.de>
References: <20220221195410.9172-1-tzimmermann@suse.de>
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
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
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
2.35.1

