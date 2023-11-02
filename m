Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38CCC4332F
	for <linux-fbdev@archiver.kernel.org>; Thu,  2 Nov 2023 19:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjKBTZH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 2 Nov 2023 15:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjKBTZH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 2 Nov 2023 15:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80B0186
        for <linux-fbdev@vger.kernel.org>; Thu,  2 Nov 2023 12:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698953056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=p5/AYOFpMtipyX3yVNE3RQ2sBJUpaSLLWRc4pCufaM4=;
        b=PISWMasEA+/cGOyaiqmN54OtG0KDP5HxLmcr3QdWeEckS0gUKM6bu/fTslszFg9TNgklmV
        3FNjoWAMGh5RI/SRDpZKuvCAAlNxHcuOETmMHpVGE2D/GQ1GLBkEEDK6sIUXcLAqkHfYvO
        MWnwQE8/k82Z2OpTuQiuR96pKDTgw1A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-OIsWlKFSM5eOAxnhvORcjg-1; Thu, 02 Nov 2023 15:24:14 -0400
X-MC-Unique: OIsWlKFSM5eOAxnhvORcjg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32fabf96aa5so170395f8f.0
        for <linux-fbdev@vger.kernel.org>; Thu, 02 Nov 2023 12:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698953053; x=1699557853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5/AYOFpMtipyX3yVNE3RQ2sBJUpaSLLWRc4pCufaM4=;
        b=vHTnNjtYGtgH8E284BG7vZV9sPiI4wfRGNSUCiQd5mx7nSiCCQWZqXxlF880EWnsh9
         aYEnZicFxWtBYuoVR5T/+MB2wcPLl1turrShfszAGP9vCNorhe4STUIkDAc/4ZBWD7kM
         /k6rwNzudzdSdolweVZrV+LStIrrySYRooOlhZ3Ej2vBqiMDlNg+myS3v/UMlUw/vBE3
         VLGtA6tuM8tU9knLuUHMImPkxPVe9ft0Hzsu5oQfZXqJlx9BAMX5wqrfH82NmMUrDFB9
         hN3SS7ZK4m3tVqGdl9cdFHzeto+NVgqxpoDhL+4BiLWReLb/NH/jMFBFCYfmcc7+Tanf
         lTrA==
X-Gm-Message-State: AOJu0Yzw2p7eCbh6/ex1Y+aiJ21M/x+U0+BLGrAz7PmkVnyVh1EMAZJ6
        3fiZOlncy2+gBsQzpJZ0HlexxhrjtiCCxZXvl7huU7Rgg16+xS8gs3pL21WwEgi0XixZw5r1ddp
        uCIM2nY2jNVIjg4C25eedbxw=
X-Received: by 2002:a05:600c:350c:b0:405:39bb:38a8 with SMTP id h12-20020a05600c350c00b0040539bb38a8mr15776529wmq.2.1698953053682;
        Thu, 02 Nov 2023 12:24:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEUyUDco60L/5B6mfJp7cXtWCHrP4XE4BNQJlgxAUqDulZh/VHu2Gj0WecmI7xbtoZDCWUmA==
X-Received: by 2002:a05:600c:350c:b0:405:39bb:38a8 with SMTP id h12-20020a05600c350c00b0040539bb38a8mr15776516wmq.2.1698953053326;
        Thu, 02 Nov 2023 12:24:13 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id gw21-20020a05600c851500b004064741f855sm66371wmb.47.2023.11.02.12.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 12:24:12 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH] drivers/video/fbdev: use new array-copying-wrapper
Date:   Thu,  2 Nov 2023 20:24:03 +0100
Message-ID: <20231102192402.53721-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

viafbdev.c utilizes memdup_user() to copy an array from userspace.

There is a new wrapper, specifically designed for copying arrays. Use
this one instead.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/video/fbdev/via/viafbdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index 58868f8880d6..a52b1ba43a48 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -574,7 +574,7 @@ static int viafb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 		break;
 
 	case VIAFB_SET_GAMMA_LUT:
-		viafb_gamma_table = memdup_user(argp, 256 * sizeof(u32));
+		viafb_gamma_table = memdup_array_user(argp, 256, sizeof(u32));
 		if (IS_ERR(viafb_gamma_table))
 			return PTR_ERR(viafb_gamma_table);
 		viafb_set_gamma_table(viafb_bpp, viafb_gamma_table);
-- 
2.41.0

