Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B64C4338F
	for <linux-fbdev@archiver.kernel.org>; Sun, 25 Jul 2021 02:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF18A60E8F
	for <linux-fbdev@archiver.kernel.org>; Sun, 25 Jul 2021 02:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhGYBam (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 24 Jul 2021 21:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhGYBam (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 24 Jul 2021 21:30:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F93C061757;
        Sat, 24 Jul 2021 19:11:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mt6so7915615pjb.1;
        Sat, 24 Jul 2021 19:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pPOXDqETdyx4025/ipNQtnHs947c2VAzDTy6HRdNK/c=;
        b=jwicGB0cqqTRVvCmdosEvB9nPjRYKZQzyksO6XzSIkwEaMIG3g27dD+3wDx65trvWf
         HCMO4f6+dB0m32tSWME4MWPqXng3tkxNnlEopha5d0JlcvAHKLoUZR12u5T503LXfOhg
         eXm9Yw509RnPP1NN33aChiiH4HyJa/M5tTKEocqt9lQdJgBuIhoHEH8FNpfB1Mxseu79
         WcYnt2fmNJcCNviO543qwifeozCpW+ESyZErnMUwpufFWGgd12q7UVfMU9OwIGi6BwtX
         OI2EW3Tcp7Jt59fGgXa9GU5tKHTjCPXPeleQ2E0ADRrc5FR2gmCacINDtVQyWH8m14+c
         gRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pPOXDqETdyx4025/ipNQtnHs947c2VAzDTy6HRdNK/c=;
        b=WGCdCUyCVAK2pp5MIpH2ejiPVI1dOFkyls2oq/HxK+oyEQLytS/Fu2ZhfJ+FJbfawN
         5fS1aFFAz5Pak1WdiN0bV/Iq1nXpTqjfn6I+5qR64Dd5oX7XCsQVQUQMIvsp6PT3W6CB
         Cz3OOq9vXe4eJnNPTZX+SzpI2CGqb6cRdh3adjrZ4BpKrwnUZzv5xs3AXWEShvhFKYmB
         2sus7sRWGh9wkjvBcrNR9XJelmh4vWTlug2ahKhfU3KVVho6r8+7wU8YIXMh8qs0SdV2
         a3nNE3jgZ1OU9o1iwnu+Z2YoD5Qyjoj6RfQb3I5VZregmIisgTb2ThmtGAGed1Om+i10
         q07A==
X-Gm-Message-State: AOAM531woW0/LFt+QDe0+gAof6/uCX2NYMKFqPqgCXG7fTNdZ+ru1NGz
        S8WGmYjaKTb9ZpWkOTuKAg==
X-Google-Smtp-Source: ABdhPJzIaHTgElPRpB7ItNlkm0sEIcWjuV3Ik+ePJWeAxxNQ8TxXpSC4MEdgK7CsazLdq+0uXcBlfw==
X-Received: by 2002:a17:90a:dc15:: with SMTP id i21mr11307214pjv.139.1627179071853;
        Sat, 24 Jul 2021 19:11:11 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id y139sm12122341pfb.107.2021.07.24.19.11.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Jul 2021 19:11:11 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     adaplas@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 0/3] add checks against divide error
Date:   Sun, 25 Jul 2021 02:10:51 +0000
Message-Id: <1627179054-29903-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Zheyu Ma (3):
  video: fbdev: kyro: add a check against divide error
  video: fbdev: riva: add a check against divide error
  video: fbdev: asiliantfb: add a check against divide error

 drivers/video/fbdev/asiliantfb.c | 3 +++
 drivers/video/fbdev/kyro/fbdev.c | 3 +++
 drivers/video/fbdev/riva/fbdev.c | 3 +++
 3 files changed, 9 insertions(+)

-- 
2.17.6

