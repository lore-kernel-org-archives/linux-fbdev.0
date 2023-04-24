Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D82C77B7C
	for <linux-fbdev@archiver.kernel.org>; Mon, 24 Apr 2023 08:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjDXI6c (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 24 Apr 2023 04:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjDXI6a (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 24 Apr 2023 04:58:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C480E67
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Apr 2023 01:58:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 47FBB21A86;
        Mon, 24 Apr 2023 08:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682326708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZrDTfxtWLjoZEcJN4FsYXknUeP3lmzV76e+pGZzG7s=;
        b=y5WaMM06EDUQts5WacBzV316d0l13FC88YFG94yT5OXo9TF/9MzDfRuVHswxBM85TvvmZw
        JPcSFKMoruya80xLvNZ2Li3PK9FcEpsQUGU62yoZ73rzu9n57pYGgI+9VanWwY41HGOrqE
        MknAocBCxuM+qPHO/tsrgdlwmroPlR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682326708;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZrDTfxtWLjoZEcJN4FsYXknUeP3lmzV76e+pGZzG7s=;
        b=pWDGW+5ezIDTMngphTpUN00q6IOCdNonCT5fFG9bQ2PGktFaJLYaJ0owpFtt9/7wMq9Usm
        MqsV7JksF+rlx7Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D62C13780;
        Mon, 24 Apr 2023 08:58:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sPBSArRERmQneQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 24 Apr 2023 08:58:28 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, geert@linux-m68k.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/3] fbdev/vfb: Init owner field of struct fb_ops
Date:   Mon, 24 Apr 2023 10:58:25 +0200
Message-Id: <20230424085825.18287-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424085825.18287-1-tzimmermann@suse.de>
References: <20230424085825.18287-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Initialize the owner field of struct fb_ops. Required to prevent
module unloading while the driver is in use.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/vfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index 680c88267ef4..a0a2009e003e 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -79,6 +79,7 @@ static int vfb_mmap(struct fb_info *info,
 		    struct vm_area_struct *vma);
 
 static const struct fb_ops vfb_ops = {
+	.owner		= THIS_MODULE,
 	.fb_read        = fb_sys_read,
 	.fb_write       = fb_sys_write,
 	.fb_check_var	= vfb_check_var,
-- 
2.40.0

