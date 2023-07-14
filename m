Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B45EB64DC
	for <linux-fbdev@archiver.kernel.org>; Fri, 14 Jul 2023 17:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbjGNRRm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 14 Jul 2023 13:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbjGNRRm (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 14 Jul 2023 13:17:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FA13594
        for <linux-fbdev@vger.kernel.org>; Fri, 14 Jul 2023 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689355015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mf75CzVatbv3pQWH8r83ggHJgBXSpuprGf6QjemCQEc=;
        b=EQ4qIt1136QBA4QNpxW6KIY7vys1mhFt4qMKsZgFTx2f2nae43LGqyBhgP3QlE10aVtSq4
        7G5cVf12myaNQcqNmbySqXY85JEjXZ/wN5w/+unXRn7M76W1Lf6wRoWWn3JO8Whk9o+nQU
        L4jQ9Au+VNIeNTCUVG4JOVTM7H5PM+g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-DfGXFvWgO6S1T--6sR1Btg-1; Fri, 14 Jul 2023 13:16:54 -0400
X-MC-Unique: DfGXFvWgO6S1T--6sR1Btg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-313c930ee0eso1252206f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 14 Jul 2023 10:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689355013; x=1691947013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mf75CzVatbv3pQWH8r83ggHJgBXSpuprGf6QjemCQEc=;
        b=K/wq+tK7a5gBEDE7R19jZk9ot3YR+8TUZ878QuSUJlBab8uX86s76AXvam3jT0t5bI
         aiE+dK/UZAtIUIGovxcjHbUG4iMj2tm5LK6MRQR/VAG6M1r1BwIEI4NCa318rzFuUciU
         7Ngq4h1JpAY3uvKYDm0mso/LPvVX+UiNv4BuOwP+xByrdJoBRa9+6B4THbK0B9JEALy0
         xsA5gIhGOcmu/tU6C97/mjekC5EYCbsUBdQaKiYp4N335A06IxxuZ0rk2RXHBKgo5W2n
         xDova5Lsxh9xs2gXdd0gSJE3zu9fszyA3Nzt4BBxNPoKVUjU29J8YMxbSwNJ1hqj4H7v
         RJBg==
X-Gm-Message-State: ABy/qLa0B+buYgHqy373mFyjg7kNmVDjYq0jDO6dgSyUUmRfuHWa7nqN
        iiLAYprg8jYgN7xLLcUGFBsYDXHj4iD/4iS8xAgQ6eHVYtGUV0V5ACocIFdqX/acc4VUMpWon+q
        6LpxHVTLI6flIuEVO04VZCZc=
X-Received: by 2002:adf:e952:0:b0:30e:5bd0:21a2 with SMTP id m18-20020adfe952000000b0030e5bd021a2mr4555833wrn.52.1689355013351;
        Fri, 14 Jul 2023 10:16:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHHYMLvriZ/ew3fit58RdAJhlMPoyTBoUoDcI2u13QGKOg6uAz3m3L/7sXIDsUPeQ4e8DoUOA==
X-Received: by 2002:adf:e952:0:b0:30e:5bd0:21a2 with SMTP id m18-20020adfe952000000b0030e5bd021a2mr4555827wrn.52.1689355013182;
        Fri, 14 Jul 2023 10:16:53 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d17-20020adfe891000000b003143cdc5949sm11620842wrm.9.2023.07.14.10.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:16:52 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Melissa Wen <mwen@igalia.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v5 1/4] video: Add auxiliary display drivers to Graphics support menu
Date:   Fri, 14 Jul 2023 19:16:29 +0200
Message-ID: <20230714171642.91185-2-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714171642.91185-1-javierm@redhat.com>
References: <20230714171642.91185-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The drivers in this subsystem are for character-based LCD displays, which
can fall into the same category of the DRM/KMS and fbdev drivers that are
located under the "Graphics support" menu. Add auxdisplay there as well.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v5:
- Take the auxdisplay/Kconfig source out of "if HAS_IOMEM" (Geert Uytterhoeven).

 drivers/Kconfig       | 2 --
 drivers/video/Kconfig | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 514ae6b24cb2..496ca02ee18f 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -129,8 +129,6 @@ source "drivers/dma-buf/Kconfig"
 
 source "drivers/dca/Kconfig"
 
-source "drivers/auxdisplay/Kconfig"
-
 source "drivers/uio/Kconfig"
 
 source "drivers/vfio/Kconfig"
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 8b2b9ac37c3d..e5b1cc54cafa 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -25,6 +25,8 @@ config VIDEO_NOMODESET
 	bool
 	default n
 
+source "drivers/auxdisplay/Kconfig"
+
 if HAS_IOMEM
 
 config HAVE_FB_ATMEL
-- 
2.41.0

