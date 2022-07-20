Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3842FCCA480
	for <linux-fbdev@archiver.kernel.org>; Wed, 20 Jul 2022 14:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiGTO1p (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbiGTO1k (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 20 Jul 2022 10:27:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9B340BD1
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Jul 2022 07:27:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 163F134BD3;
        Wed, 20 Jul 2022 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658327255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fgiN7z9+9zB9YTeGLcPpiK7RM90kttbOGsdqpb0wZFk=;
        b=nPBA1T6/KDqeHxRxqNuZd1tUvXBnz3wKxXMdMhX0oBSZ2V1JqczbIGJfTxJHGOt9tLgu4+
        Ldh7x3QxY95JW1Ckmu+hP4hJdbK0Ot/FSCz+JLOvMjeglQ8cnu40+1582ggC7D7Ft0SOBl
        BHEPCKpiEW1HUHjZMKioU8nwu+clg0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658327255;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fgiN7z9+9zB9YTeGLcPpiK7RM90kttbOGsdqpb0wZFk=;
        b=9BX9eQ0liWmAht7ZNu6yOfLIj5SUU1YDr6qNcEnHozhIPFjifbW20sdjCSdgS0LyIlyzpX
        SJ+N6+KlmuyvlaCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C78F513ABB;
        Wed, 20 Jul 2022 14:27:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QFrlL9YQ2GLfHgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 20 Jul 2022 14:27:34 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        deller@gmx.de, maxime@cerno.tech, sam@ravnborg.org,
        msuchanek@suse.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk
Cc:     linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 03/10] drm/simpledrm: Remove pdev field from device structure
Date:   Wed, 20 Jul 2022 16:27:25 +0200
Message-Id: <20220720142732.32041-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720142732.32041-1-tzimmermann@suse.de>
References: <20220720142732.32041-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Replace the remaining uses of the field pdev by upcasts from the Linux
device and remove the field.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/simpledrm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 9bc9ecf6d964..7de477835d44 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -198,7 +198,6 @@ simplefb_get_format_of(struct drm_device *dev, struct device_node *of_node)
 
 struct simpledrm_device {
 	struct drm_device dev;
-	struct platform_device *pdev;
 
 	/* clocks */
 #if defined CONFIG_OF && defined CONFIG_COMMON_CLK
@@ -271,7 +270,7 @@ static void simpledrm_device_release_clocks(void *res)
 static int simpledrm_device_init_clocks(struct simpledrm_device *sdev)
 {
 	struct drm_device *dev = &sdev->dev;
-	struct platform_device *pdev = sdev->pdev;
+	struct platform_device *pdev = to_platform_device(dev->dev);
 	struct device_node *of_node = pdev->dev.of_node;
 	struct clk *clock;
 	unsigned int i;
@@ -369,7 +368,7 @@ static void simpledrm_device_release_regulators(void *res)
 static int simpledrm_device_init_regulators(struct simpledrm_device *sdev)
 {
 	struct drm_device *dev = &sdev->dev;
-	struct platform_device *pdev = sdev->pdev;
+	struct platform_device *pdev = to_platform_device(dev->dev);
 	struct device_node *of_node = pdev->dev.of_node;
 	struct property *prop;
 	struct regulator *regulator;
@@ -701,7 +700,6 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 	if (IS_ERR(sdev))
 		return ERR_CAST(sdev);
 	dev = &sdev->dev;
-	sdev->pdev = pdev;
 	platform_set_drvdata(pdev, sdev);
 
 	/*
-- 
2.36.1

