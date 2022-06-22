Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29FFCCA481
	for <linux-fbdev@archiver.kernel.org>; Wed, 22 Jun 2022 14:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357783AbiFVOBo (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357163AbiFVOBj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 22 Jun 2022 10:01:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0A4369E2;
        Wed, 22 Jun 2022 07:01:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 99CEA1FD05;
        Wed, 22 Jun 2022 14:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655906497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNqejIK4XkB/g6M1yCpdVMg3lyKunZ50J756bTwwnb4=;
        b=latYMzbpEH+tp6J2mRBhpyrz5+GCu85gL3h1OlrTM2vHUkkOMGv0cv5d7k3L2z11yvijoI
        pbOnSa3eZhTgcrxdFpc6Kw+2ov8RCT7S9/lQ9SNLOwQI8o+p8mPkTUGdBeaENqkAxO99QN
        8gAqZHRSBbI0SZ424InEkwp5PbGcU3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655906497;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNqejIK4XkB/g6M1yCpdVMg3lyKunZ50J756bTwwnb4=;
        b=BmXV7YgRO9SIg/rRI4fK6Gex9oJZ6fFx426Q5WoROO/nKthZMOyCyjhWvMD5M1jP2gWZCd
        nYGSnTrwMGfiJTBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AA7713AC7;
        Wed, 22 Jun 2022 14:01:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EOhfEcEgs2IVRwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 22 Jun 2022 14:01:37 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     alex.williamson@redhat.com, corbet@lwn.net,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, deller@gmx.de,
        gregkh@linuxfoundation.org, javierm@redhat.com, lersek@redhat.com,
        kraxel@redhat.com
Cc:     linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH v3 3/3] vfio/pci: Remove console drivers
Date:   Wed, 22 Jun 2022 16:01:34 +0200
Message-Id: <20220622140134.12763-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622140134.12763-1-tzimmermann@suse.de>
References: <20220622140134.12763-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Alex Williamson <alex.williamson@redhat.com>

Console drivers can create conflicts with PCI resources resulting in
userspace getting mmap failures to memory BARs.  This is especially
evident when trying to re-use the system primary console for userspace
drivers.  Use the aperture helpers to remove these conflicts.

v3:
	* call aperture_remove_conflicting_pci_devices()

Reported-by: Laszlo Ersek <lersek@redhat.com>
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a0d69ddaf90d..756d049bd9cf 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/aperture.h>
 #include <linux/device.h>
 #include <linux/eventfd.h>
 #include <linux/file.h>
@@ -1793,6 +1794,10 @@ static int vfio_pci_vga_init(struct vfio_pci_core_device *vdev)
 	if (!vfio_pci_is_vga(pdev))
 		return 0;
 
+	ret = aperture_remove_conflicting_pci_devices(pdev, vdev->vdev.ops->name);
+	if (ret)
+		return ret;
+
 	ret = vga_client_register(pdev, vfio_pci_set_decode);
 	if (ret)
 		return ret;
-- 
2.36.1

