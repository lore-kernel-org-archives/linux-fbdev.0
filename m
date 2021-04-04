Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1229EC433ED
	for <linux-fbdev@archiver.kernel.org>; Sun,  4 Apr 2021 11:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A0461385
	for <linux-fbdev@archiver.kernel.org>; Sun,  4 Apr 2021 11:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhDDLLG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 4 Apr 2021 07:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhDDLLG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 4 Apr 2021 07:11:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA37C061756;
        Sun,  4 Apr 2021 04:11:01 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 12so13543067lfq.13;
        Sun, 04 Apr 2021 04:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=RWPDQxxgV2nTCNL1FAYclu9roEAzSAdEQg2xga59ELs=;
        b=Z0Z5Y+0DJmoXupHa9zQfPZT3kCZ4shfboOOlC58PCdOUhtjmsJDx/nI3uHa99/n1Nz
         ZkKBDPyQZl1ZmIehGFxtGs6b38Ktn/TttjCGlt36dNBvEuZydjuX4OwjGtUV1b64wfl+
         YXVWjiw57CPZ85SoX1pHp9JxDKoBqQ/aN45bvoKqFT224liyy2Nbu3jLP60l2RURwRvn
         kp2vjF+9HekaHBqsdFz5oQVrh9jr4dz7ApPD9VO52VfR2IPhWllfsmQfOn8dCB8L4IEb
         VWuOTvZQdfKUcLe9XPgpbc9GRLmzkdiXxyR6LsLv78D3aAzN5MSSIU+MSrC6IR3YAOrc
         VYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RWPDQxxgV2nTCNL1FAYclu9roEAzSAdEQg2xga59ELs=;
        b=QmSyeMAnughu/AqLdZ4QBVTUyA8LRMPmqLCCgzHjmSFJuNN096tvgYJiCG9R00Pc2m
         QD0r/mVfDHwC0BdqSXqTweHu6FEzPoaYZUiF9l9zuP2smyK296BQdF7I/iMr/Y+dOv6T
         zqrN+DcEqKKW3fVie5A8PNmwM1nATzXB93m8jdLl6PkTAeR6yzHB+LShshocqem4AgOz
         OvZLoxjnaV3LCJ/khntona57AZFKDsJXOY0bDm/Le0yf5xHl52VsOiMBdmii0ZY3hp6q
         oqhoHMU2Sg753z9ccQIg69vRTDDy5Arnv3d46Rgip22ib5KhPqGAkqwcYGa4B962k4Xo
         s0Yg==
X-Gm-Message-State: AOAM530emk4NcGPqVtA/8v4PytrYuAZUAqbRYe0gZuAGLg+9dQ+JlNsc
        Fh3zRruV7Mr3dXg12kqz0ZWRIBI0spqGn4p8
X-Google-Smtp-Source: ABdhPJzVjmPkRcr6H6lgc+7U+TNzNsYW6ZhZshonW16IImKJlv6D0zR9/s+zoD/jHVvUX1Ie5j+Xcw==
X-Received: by 2002:ac2:5a5b:: with SMTP id r27mr13957725lfn.255.1617534657168;
        Sun, 04 Apr 2021 04:10:57 -0700 (PDT)
Received: from zhans ([37.151.32.231])
        by smtp.gmail.com with ESMTPSA id i184sm1412263lfd.205.2021.04.04.04.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 04:10:56 -0700 (PDT)
Date:   Sun, 4 Apr 2021 17:10:55 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel][PATCH] staging: sm750fb: Remove unnecessary blank
 line
Message-ID: <20210404111055.GA22626@zhans>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Remove unnecessary extra blank line to improve readability.
Reported by checkpatch.

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
 drivers/staging/sm750fb/sm750.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 1b3f5f649c52..23eefd019ec9 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -64,7 +64,6 @@ struct lynx_accel {
 			   u32 x, u32 y, u32 width, u32 height,
 			   u32 color, u32 rop);
 
-
 	int (*de_copyarea)(struct lynx_accel *accel,
 			   u32 s_base, u32 s_pitch,
 			   u32 sx, u32 sy,
-- 
2.25.1

