Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195B6C433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 24 Jan 2022 12:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241645AbiAXMhH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 24 Jan 2022 07:37:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39062 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239723AbiAXMhH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 24 Jan 2022 07:37:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 44D461F38B;
        Mon, 24 Jan 2022 12:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643027826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/fJ6I46TmC5ehgzZqqDJcNLTjN9385V+P8YAjicLPE=;
        b=BOpvpZlVwooexh2HCI/iZ1pswkZOilqmS9qoZhL4g59hByb3l0HM6l9cQgXlWyVhqKMkaB
        m9oIX05JIvcLP67a0Gl6o66OWTb25zEZC0uGRoyl9hicSMGhh+4ZVhK33zeR3XGEDmV6ll
        9OJr6ftygI7KQrJ5/0PuQ4lKWrjPhsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643027826;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/fJ6I46TmC5ehgzZqqDJcNLTjN9385V+P8YAjicLPE=;
        b=lrT0s6Vm80rFTRs9W61LDbBTYqNziRqWHZgE95fzYRrny9Na8cfwASDxYfE3eDCRsYyppw
        0l88DNrqnMVT1KDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2B0B13B97;
        Mon, 24 Jan 2022 12:37:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QIhIOnGd7mFyNQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 24 Jan 2022 12:37:05 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     zackr@vmware.com, javierm@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, deller@gmx.de,
        hdegoede@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 2/5] drivers/firmware: Don't mark as busy the simple-framebuffer IO resource
Date:   Mon, 24 Jan 2022 13:36:56 +0100
Message-Id: <20220124123659.4692-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124123659.4692-1-tzimmermann@suse.de>
References: <20220124123659.4692-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Javier Martinez Canillas <javierm@redhat.com>

The sysfb_create_simplefb() function requests a IO memory resource for the
simple-framebuffer platform device, but it also marks it as busy which can
lead to drivers requesting the same memory resource to fail.

Let's drop the IORESOURCE_BUSY flag and let drivers to request it as busy
instead.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/firmware/sysfb_simplefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index 303a491e520d..76c4abc42a30 100644
--- a/drivers/firmware/sysfb_simplefb.c
+++ b/drivers/firmware/sysfb_simplefb.c
@@ -99,7 +99,7 @@ __init int sysfb_create_simplefb(const struct screen_info *si,
 
 	/* setup IORESOURCE_MEM as framebuffer memory */
 	memset(&res, 0, sizeof(res));
-	res.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	res.flags = IORESOURCE_MEM;
 	res.name = simplefb_resname;
 	res.start = base;
 	res.end = res.start + length - 1;
-- 
2.34.1

