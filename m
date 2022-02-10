Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085CEC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 10 Feb 2022 14:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbiBJOLZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 10 Feb 2022 09:11:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbiBJOLY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 10 Feb 2022 09:11:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D135C1
        for <linux-fbdev@vger.kernel.org>; Thu, 10 Feb 2022 06:11:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 05C2921114;
        Thu, 10 Feb 2022 14:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644502285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2m0LxcQyStkLKfwrGKW8CTnydl47YLuxekTjHFPor3k=;
        b=p3eeCS/JtdPquyZV0tmRg/kuPMQ3S/X0zZMON8eA2agA7jU4PBpgyd+Jya0v2EhYUXZSsC
        IZ+/zwAAu9OC283sGY4qzdtynFR+Yota83D29n4GnOLHcHL2poKR1SqVQ8xGBPNDxv4/mE
        NKPqKFWXRLJoJelWRsP6ZcNSs7aaOKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644502285;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2m0LxcQyStkLKfwrGKW8CTnydl47YLuxekTjHFPor3k=;
        b=wZ0jBTAVWnHk37m+aYTSRrx/sJMEchtxBXEeMhAt4v2O1eBNqJfP4wp+GGKmy/JAISQfTP
        aBZYLG60w5pIUdCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C05C913B9E;
        Thu, 10 Feb 2022 14:11:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IP8HLgwdBWIPaQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 10 Feb 2022 14:11:24 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, javierm@redhat.com, noralf@tronnes.org,
        andriy.shevchenko@linux.intel.com, deller@gmx.de,
        bernie@plugable.com, jayalk@intworks.biz
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/2] fbdev/defio: Early-out if page is already enlisted
Date:   Thu, 10 Feb 2022 15:11:11 +0100
Message-Id: <20220210141111.5231-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210141111.5231-1-tzimmermann@suse.de>
References: <20220210141111.5231-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Return early if a page is already in the list of dirty pages for
deferred I/O. This can be detected if the page's list head is not
empty. Keep the list head initialized while the page is not enlisted
to make this work reliably.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fb_defio.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index a591d291b231..3727b1ca87b1 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -59,6 +59,7 @@ static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
 		printk(KERN_ERR "no mapping available\n");
 
 	BUG_ON(!page->mapping);
+	INIT_LIST_HEAD(&page->lru);
 	page->index = vmf->pgoff;
 
 	vmf->page = page;
@@ -122,17 +123,19 @@ static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
 	 */
 	lock_page(page);
 
+	/*
+	 * This check is to catch the case where a new process could start
+	 * writing to the same page through a new pte. this new access
+	 * can cause the mkwrite even when the original ps's pte is marked
+	 * writable.
+	 */
+	if (!list_empty(&page->lru))
+		goto page_already_added;
+
 	/* we loop through the pagelist before adding in order
 	to keep the pagelist sorted */
 	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
-		/* this check is to catch the case where a new
-		process could start writing to the same page
-		through a new pte. this new access can cause the
-		mkwrite even when the original ps's pte is marked
-		writable */
-		if (unlikely(cur == page))
-			goto page_already_added;
-		else if (cur->index > page->index)
+		if (cur->index > page->index)
 			break;
 	}
 
@@ -194,7 +197,7 @@ static void fb_deferred_io_work(struct work_struct *work)
 
 	/* clear the list */
 	list_for_each_safe(node, next, &fbdefio->pagelist) {
-		list_del(node);
+		list_del_init(node);
 	}
 	mutex_unlock(&fbdefio->lock);
 }
-- 
2.34.1

