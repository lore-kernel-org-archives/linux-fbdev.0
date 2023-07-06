Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFD3EB64DC
	for <linux-fbdev@archiver.kernel.org>; Thu,  6 Jul 2023 15:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjGFPOj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 6 Jul 2023 11:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjGFPOi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 6 Jul 2023 11:14:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C238E173F
        for <linux-fbdev@vger.kernel.org>; Thu,  6 Jul 2023 08:14:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 71A4B22858;
        Thu,  6 Jul 2023 15:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688656475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=44HRkRuEyibkGd0p7+sOBcABlE9d9l6W5NynsyfUK9s=;
        b=DMm8SADzaWvpZUUHo4/+oLLJbPNUqxMhE2QP0UxWrcuQxMCt+7Wkk4ylGtSkFy15nsB+2l
        3nPd71gnj1We3rLgTy+8msSmGPGINmJwlKkJSbpl66eLuGDgVmXBgsbXwRAP7LVxsvIbLe
        NiHgglHIqpK2NN8XdUmT0milaL27WWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688656475;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=44HRkRuEyibkGd0p7+sOBcABlE9d9l6W5NynsyfUK9s=;
        b=b/Kk/dlK6/twgUeDZv6CzuPSK2WtbrgQd2KPvwuEGGImsxxz/lx+4uZW0VUEbTBOarhNxd
        vsaXyVS51d+mnSAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F0D7138FC;
        Thu,  6 Jul 2023 15:14:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CEJnElvapmRvDgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 06 Jul 2023 15:14:35 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 05/10] fbdev/metronomefb: Select FB_SYS_HELPERS_DEFERRED
Date:   Thu,  6 Jul 2023 17:08:48 +0200
Message-ID: <20230706151432.20674-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706151432.20674-1-tzimmermann@suse.de>
References: <20230706151432.20674-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The Kconfig token FB_SYS_HELPERS_DEFERRED selects everything that
is required for deferred I/O on system-memory framebuffers. Select
it from FB_METRONOME in favor of the existing identical selection.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/Kconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 7587f06cb793..1155d7aa0917 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2088,11 +2088,7 @@ config XEN_FBDEV_FRONTEND
 config FB_METRONOME
 	tristate "E-Ink Metronome/8track controller support"
 	depends on FB
-	select FB_SYS_FILLRECT
-	select FB_SYS_COPYAREA
-	select FB_SYS_IMAGEBLIT
-	select FB_SYS_FOPS
-	select FB_DEFERRED_IO
+	select FB_SYS_HELPERS_DEFERRED
 	help
 	  This driver implements support for the E-Ink Metronome
 	  controller. The pre-release name for this device was 8track
-- 
2.41.0

