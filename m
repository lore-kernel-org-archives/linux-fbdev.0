Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7A3C001B0
	for <linux-fbdev@archiver.kernel.org>; Thu,  6 Jul 2023 15:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjGFPOi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 6 Jul 2023 11:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjGFPOh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 6 Jul 2023 11:14:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6779DE70
        for <linux-fbdev@vger.kernel.org>; Thu,  6 Jul 2023 08:14:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 241D321A85;
        Thu,  6 Jul 2023 15:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688656475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gykiKqsC+RIJJ1Kkk+Ae5baDTD+6GqSNQhm49BPnI0o=;
        b=xGrheN4rwXAsk9pfANJBScM+pQMEKLfUs6Okm4Xoj1ExypPj6cNEzmGhMK66uy35hrScTp
        Ic5ZkgU1w3IZiNPUx/GFFJRF3IE1y8gxbpnl8/vQ6yRd7vvrqydbyrFZq15JOK98X7jKxR
        2sO+C0kaaFcORKy1s48vM5kc/D3p0rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688656475;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gykiKqsC+RIJJ1Kkk+Ae5baDTD+6GqSNQhm49BPnI0o=;
        b=Ip2jzEQWsBlthP409CQ0y+1W6cELLYIG5zqpkwVaAN5sd9WjzMp+/GNCOnsGGatzEMvlsR
        FX2qGHrjUGtCNXAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 006DD138FC;
        Thu,  6 Jul 2023 15:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YIqoOlrapmRvDgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 06 Jul 2023 15:14:34 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 03/10] fbdev/hecubafb: Select FB_SYS_HELPERS_DEFERRED
Date:   Thu,  6 Jul 2023 17:08:46 +0200
Message-ID: <20230706151432.20674-4-tzimmermann@suse.de>
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
it from FB_HECUBA.

Deferred I/O helpers were previously selected by n411, which builds
upon hecubafb. Remove these select statements in favor of the new one.
N411 does not implement any framebuffer I/O by itself.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/Kconfig | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index fd862faafe66..7587f06cb793 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -200,7 +200,7 @@ config FB_SYS_HELPERS_DEFERRED
 config FB_HECUBA
 	tristate
 	depends on FB
-	depends on FB_DEFERRED_IO
+	select FB_SYS_HELPERS_DEFERRED
 
 config FB_SVGALIB
 	tristate
@@ -691,11 +691,6 @@ config FB_EFI
 config FB_N411
 	tristate "N411 Apollo/Hecuba devkit support"
 	depends on FB && X86 && MMU
-	select FB_SYS_FILLRECT
-	select FB_SYS_COPYAREA
-	select FB_SYS_IMAGEBLIT
-	select FB_SYS_FOPS
-	select FB_DEFERRED_IO
 	select FB_HECUBA
 	help
 	  This enables support for the Apollo display controller in its
-- 
2.41.0

