Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A88C433E9
	for <linux-fbdev@archiver.kernel.org>; Thu,  7 Jan 2021 15:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF10B23432
	for <linux-fbdev@archiver.kernel.org>; Thu,  7 Jan 2021 15:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbhAGPtJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 7 Jan 2021 10:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbhAGPtJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 7 Jan 2021 10:49:09 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA71C0612F4;
        Thu,  7 Jan 2021 07:48:29 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id be12so3745977plb.4;
        Thu, 07 Jan 2021 07:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUsvF0h/LF+tRZiLjS/hwsiES38Tx2dW6YMW8ai33wc=;
        b=Qa2rz7vFEIdTquyydipnsbQIhtu0hpIkDOKNOI5DAERcPyBt7KBlh0DBQwJiO9iVqR
         5F92N/iNuEYWUtkGCSq7gbeSA6cTaXUX5ZwqAJ6cH4ogwJD99PDifs7S82punPVKpb9w
         5XJVamFgGqf9MDWbXTXFrM25obB3pvVtaIZASwm8R2QO3qPXtuWLwf7o4HoeVwQPY0zz
         uvj0V0S+x+qUXdLzjqa72BjGG/JiUOb1s5BbRC85++qtTBVu4ZFcC7y3AKzQurrAwpn6
         wtX372G6j1aKq9243gNl00hSayPsVnRU9r4+iW8/9B2DJni2A4BECCAPVgq3j5Bh5Hxd
         cfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUsvF0h/LF+tRZiLjS/hwsiES38Tx2dW6YMW8ai33wc=;
        b=UuBQouhOL4W0ltsuvfnlo/p6FyEXy6X+HcGSzxCItdFn5wxiD8Q8LwlrJhfT5HiBtK
         1PlfG41XFdkDQz+lgBN1Dl0hvOvuElLVXBsahFFpNhTxVH3PTJIVvzY+pwrB5U5ogJwC
         3Y3VLAk/DDnxcDVRgcjP+xEm0k9S/wdH7Pl+BpNnktc4jhp2iuwiLt2Vg6wrUE5J1iu2
         KFD/yjk8D0gVINDGTXx9hEHtj+t6CGda3bwzn9yrHEJgvIJPe6SzWAPpWlFlXdzuBA+M
         YaC2i0iiUHsHEt8mPDdZtUTeQRg6VEGICPBT7EAtUv4oPGzxEGVb9wEpRVmOLMbtFWu2
         IjjA==
X-Gm-Message-State: AOAM531wu1bYVEZC+wHaU0RVmePPDUnB36gzkuEOBdBLmKn1Loe70fjz
        6q7dmyVbUPgTHLBlA8vDnNE=
X-Google-Smtp-Source: ABdhPJw27wPEmIjtXNz/1BN1cX/7Un60K0WXp+hPj067dw+Flf/AMObsFmqlLPCN+JtEfxi79iBQXA==
X-Received: by 2002:a17:90a:7a8e:: with SMTP id q14mr9924610pjf.200.1610034508402;
        Thu, 07 Jan 2021 07:48:28 -0800 (PST)
Received: from localhost.localdomain (ec2-13-212-86-85.ap-southeast-1.compute.amazonaws.com. [13.212.86.85])
        by smtp.gmail.com with ESMTPSA id z23sm6032154pfn.202.2021.01.07.07.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 07:48:27 -0800 (PST)
From:   xuhuijie <huijiexu295@gmail.com>
To:     gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
        jirislaby@kernel.org, yepeilin.cs@gmail.com,
        b.zolnierkie@samsung.com, penguin-kernel@I-love.SAKURA.ne.jp,
        george.kennedy@oracle.com, natechancellor@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch] fbcon: i want fbcon soft scrollback feature come back
Date:   Thu,  7 Jan 2021 23:48:01 +0800
Message-Id: <20210107154801.1997-1-huijiexu295@gmail.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This commit 50145474f6ef(fbcon: remove soft scrollback code) remove soft sc=
rollback in=0D
fbcon. So the shift+PageDown and shift+PageUp is missing. But PageUp is a v=
ary important=0D
feature when system panic or reset. I can get log by PageUp before, but now=
 there is no=0D
way to get. Especially on the server system, we always use bmc to control c=
omputer.=0D
So I hope the community can add this feature back.=
