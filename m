Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A67C4320E
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 10:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBCF603E7
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 10:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhGZJXv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Jul 2021 05:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhGZJXs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Jul 2021 05:23:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843D7C061757;
        Mon, 26 Jul 2021 03:04:09 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k1so10825095plt.12;
        Mon, 26 Jul 2021 03:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iTthFeXuLSiIUMa3m+4Ohdcl4oADyXk96wm5bV/p9oU=;
        b=vJIdihC+g2Azx04o9rgoCp7rnMd632rNxshuywo9qNg5Wy055TCu8SPgXGacBtOKwg
         /YG7QLuuuZpp697xTiltPGa9+1p2yxkbTHktCC5avzFW9YLjjCrxwMAVQ6JhGinRXyxx
         znUuws0MdbPwxYGTj7UhhUDARdSJdeQjEpCoESByilP/ji12jRu+ubKxNZpeMLOgKsUZ
         iNojZFYEY8OOZX4OsH8htGq3f7pxhup4sz5jOd/j9GzBSBVbSBAGYL22kBfyvIRcgqvu
         a0HqMttUJVK2JyARnGwiUGOOxUmCuN9RlL6y2C6lmiN3m2k9ro37ecVX26DBs3BR274g
         kSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iTthFeXuLSiIUMa3m+4Ohdcl4oADyXk96wm5bV/p9oU=;
        b=GbEmAIjwJyYuTKKa+tN+PW7wSTE8j0HBxmDnVLT+p5jMaRwG+siXj0A5zSk1wzUUcl
         7nrGE7Ka0eBgk/1VcWG+tnjIVtd5iLDzgjawGMhEcbakMuOj5H/QLsoSe98/a6YDHj/J
         eihOziECTgSzdOc+bvEpU7I5QPmf6e/MjGEN2Kx0ypftL643VQp9Ke/2QIOwByRU6RM7
         SRZuOqu2FPadzfhobGNfu3tcRPswoOjlIxV694NcNvm79VkIFUH9KWmOd0cNKUL8wgB0
         Sf7MCivy2rKXFgdMqyxD0ie44k5z2oc+9kVE1VxeX0xY3TLcLcASzcZnaMOi7qHzdsQC
         2ngg==
X-Gm-Message-State: AOAM531+NiCWrxVbbnPTfXZveKO9Smv1c2I3w0EjPpFGA1avJJ0nPMlk
        v1Vlq7Qom+AqJWis2LrZsQ==
X-Google-Smtp-Source: ABdhPJzrNNFsW1crC5/beByynKLR7eFw1C9JM/3djwpzVQGlwUVN78ImeoktPNI+9MZkIGv1dY5/vA==
X-Received: by 2002:a17:90b:46c9:: with SMTP id jx9mr5665906pjb.70.1627293848939;
        Mon, 26 Jul 2021 03:04:08 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id ft7sm13504530pjb.32.2021.07.26.03.04.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 03:04:08 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     adaplas@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2 0/3] Error out if 'pixclock' equals zero
Date:   Mon, 26 Jul 2021 10:03:52 +0000
Message-Id: <1627293835-17441-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Zheyu Ma (3):
  video: fbdev: asiliantfb: Error out if 'pixclock' equals zero
  video: fbdev: kyro: Error out if 'pixclock' equals zero
  video: fbdev: riva: Error out if 'pixclock' equals zero

 drivers/video/fbdev/asiliantfb.c | 3 +++
 drivers/video/fbdev/kyro/fbdev.c | 3 +++
 drivers/video/fbdev/riva/fbdev.c | 3 +++
 3 files changed, 9 insertions(+)

-- 
2.17.6

