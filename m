Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BA2C433FE
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Jan 2022 09:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457999AbiAYJRi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Jan 2022 04:17:38 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36642 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1456732AbiAYJMl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Jan 2022 04:12:41 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8A56F1F3B9;
        Tue, 25 Jan 2022 09:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643101946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ruVnMhEb1NMp2vEAXtzSpIMGsAYasRzNWUOMwtd8Ys=;
        b=uygmlBiNrexu/vyUPqEoNeqwk3Eqz9jOpDeFKB/sbw6gjagyLzIW5Fi6L/qV8JfXUNkW06
        cJNK0ltWlOFYcgKDALdB6QNieZEdG5yimQFEm6h5w4hMVr76sSZWsW6WtW3Jv1u2xU3WIS
        M8e5ar8QEdcT2e7Ht+Q2iYJvA8cYRII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643101946;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ruVnMhEb1NMp2vEAXtzSpIMGsAYasRzNWUOMwtd8Ys=;
        b=G0nCyYZQ3WJQQr4xPV51AK4qXO4Dru8apLtRTn8nhEqkGnh3WmxhapW5D+b2bvSGqoY8lT
        lWbqAtQ53H6vCkAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45C2213DA3;
        Tue, 25 Jan 2022 09:12:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uE0SEPq+72GGQAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 25 Jan 2022 09:12:26 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     zackr@vmware.com, javierm@redhat.com, jfalempe@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, deller@gmx.de,
        hdegoede@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 5/5] drm: Add TODO item for requesting memory regions
Date:   Tue, 25 Jan 2022 10:12:22 +0100
Message-Id: <20220125091222.21457-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125091222.21457-1-tzimmermann@suse.de>
References: <20220125091222.21457-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add a TODO item about requesting  memory regions for each driver. The
current DRM drivers don't do this consistently.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 Documentation/gpu/todo.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index da138dd39883..1b2372ef4131 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -467,6 +467,21 @@ Contact: Thomas Zimmermann <tzimmermann@suse.de>
 
 Level: Intermediate
 
+Request memory regions in all drivers
+-------------------------------------
+
+Go through all drivers and add code to request the memory regions that the
+driver uses. This requires adding calls to request_mem_region(),
+pci_request_region() or similar functions. Use helpers for managed cleanup
+where possible.
+
+Drivers are pretty bad at doing this and there used to be conflicts among
+DRM and fbdev drivers. Still, it's the correct thing to do.
+
+Contact: Thomas Zimmermann <tzimmermann@suse.de>
+
+Level: Starter
+
 
 Core refactorings
 =================
-- 
2.34.1

