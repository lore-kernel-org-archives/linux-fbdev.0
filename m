Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A50CCA47A
	for <linux-fbdev@archiver.kernel.org>; Thu, 16 Jun 2022 20:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378367AbiFPUjH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378739AbiFPUjC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 16 Jun 2022 16:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D50AF5EBD5
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Jun 2022 13:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655411938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0dGui2spriv3iAulrwiNMcWwONMItPuBxb3qL7Yeusw=;
        b=IaZmfVRapUm/yHTdz/671zJoPAmk+PDT55vkhedL6/iR7J8K9ny/2iRMrChIUyHDmZlcMI
        4utdMK+mkfFuNzkQRErEvPTLeAVmW9t8LVKcnVOA9lx3N1rox++OitWEzbdMrhVKSEg/bm
        polokoJ2oAy5mhfGB1J9N2O79/mHdRA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-B7Qv_YbCPYOC5_bqB-dG9A-1; Thu, 16 Jun 2022 16:38:54 -0400
X-MC-Unique: B7Qv_YbCPYOC5_bqB-dG9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F354F101AA47;
        Thu, 16 Jun 2022 20:38:53 +0000 (UTC)
Received: from [172.30.41.16] (unknown [10.22.35.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F37241415108;
        Thu, 16 Jun 2022 20:38:52 +0000 (UTC)
Subject: [PATCH v2 2/2] vfio/pci: Remove console drivers
From:   Alex Williamson <alex.williamson@redhat.com>
To:     corbet@lwn.net, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch, deller@gmx.de, gregkh@linuxfoundation.org
Cc:     Laszlo Ersek <lersek@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Date:   Thu, 16 Jun 2022 14:38:52 -0600
Message-ID: <165541193265.1955826.8778757616438743090.stgit@omen>
In-Reply-To: <165541020563.1955826.16350888595945658159.stgit@omen>
References: <165541020563.1955826.16350888595945658159.stgit@omen>
User-Agent: StGit/1.5.dev2+g9ce680a52bd9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Console drivers can create conflicts with PCI resources resulting in
userspace getting mmap failures to memory BARs.  This is especially
evident when trying to re-use the system primary console for userspace
drivers.  Use the aperture helpers to remove these conflicts.

Reported-by: Laszlo Ersek <lersek@redhat.com>
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci_core.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a0d69ddaf90d..5b2a6e9f7cf7 100644
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
 
+	ret = remove_conflicting_pci_devices(pdev, vdev->vdev.ops->name);
+	if (ret)
+		return ret;
+
 	ret = vga_client_register(pdev, vfio_pci_set_decode);
 	if (ret)
 		return ret;


