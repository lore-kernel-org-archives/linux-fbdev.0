Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD60C4338F
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Jul 2021 19:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9176A60F6E
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Jul 2021 19:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhG0TUK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 27 Jul 2021 15:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhG0TUK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 27 Jul 2021 15:20:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C130C061757;
        Tue, 27 Jul 2021 12:20:09 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l19so1314515pjz.0;
        Tue, 27 Jul 2021 12:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LHDDmMV915NlqVzU6Fz/0FX3KRO8YEAV5C4ehYloHEU=;
        b=tfKwMgeABBSvgWX+IvJ17zJcPJedYVLMFvoY0kv7zHDGEEVyGO1ZxXOQ/U5RygTnRh
         Ll7px7rHAT3A3JDs5Uz0SJH86MQ80+D00Hrza5J9Qh0cdtrbEZ/P6+0/2XY4BAC9bw8e
         yAEEPw016EIROUxGdVx4XkCBA4MYkhjR0kBVeC0cgB2bEYLPAMOeDk+YpPzrecRHO8En
         IsDHHk1fpf2D5jvlJxWrV2tD7QMifkxlyfeI54APeCk+tYce4s8K2HNBzN85IVwQQLxp
         yLqcjgWK88OhEAbamqwN7hc0KVDpbSSvRssb5IbY9tKxQAaQ9tzEcBTGw8kYYTMrJQuQ
         AUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LHDDmMV915NlqVzU6Fz/0FX3KRO8YEAV5C4ehYloHEU=;
        b=H5ON1Q6he5VqPprQEoL1npfEFN6ePpz/Fkq+N2/V/J2kA5NB9NBhntZb7T9jLrRyqp
         a0Fr8E8ARNijHS473b2A0meWqR+s5MjIeCG+elreGpUah1u15ilPx1eU4b/if09eyWiY
         Nv5MxJov10sjp67Vzxo5Aj3N3XrIy3PI4TvJJJgPKYB0bWc+aq/Rb4mPTe1UA67shkt0
         +acY133xPAfmA6nSMJlv8ojBDlj9BOM9AQvsv7xDRmDzY7l3HKECiClBR/15s07eBGS1
         zWna5exboNtnskR+9AwtEklsVf7Mon9fzdg9PPZFwyQ4I2szRR8kjn4ii/hB0Ghbw3+s
         0QmQ==
X-Gm-Message-State: AOAM530421lZQgZ5zvdiLCOA1K8KQ87v3aeAKHY9qkOTIaatPzh+HXsJ
        I/y3ERJ2XphAeN9cZOB0hL4=
X-Google-Smtp-Source: ABdhPJyMiOXY8pB7EwQqfVIsk+O8h5ZHty+pDmFkHEk0+/ShwQ9k7FNWEwvdBGSYHrfBKCfVQbnE+Q==
X-Received: by 2002:a63:ee06:: with SMTP id e6mr24851846pgi.374.1627413608648;
        Tue, 27 Jul 2021 12:20:08 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2130:198:9b25:1cfb:9ff3:2a8f])
        by smtp.gmail.com with ESMTPSA id f7sm4317096pfc.111.2021.07.27.12.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 12:20:08 -0700 (PDT)
From:   Benjamin Philip <benjamin.philip495@gmail.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Benjamin Philip <benjamin.philip495@gmail.com>
Subject: [PATCH 0/4] staging: sm750fb: Remove CamelCase in lynxfb_crtc
Date:   Wed, 28 Jul 2021 00:49:49 +0530
Message-Id: <cover.1627413010.git.benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This patchset (as the subject implies) renames some struct members to follow
the snake_case naming convention from CamelCase. By doing so, it also fixes
2 checkpatch CHECKs.

To test it, I have checked if the module builds, which it does. I have also
ensured that checkpatch.pl does not issue any new warnings.

Also, is this patchset fine or should I have clubbed it into one big commit,
Greg?

Thanks,
Benjamin Philip

Benjamin Philip (4):
  staging: sm750fb: Rename oScreen to o_screen in lynxfb_crtc
  staging: sm750fb: Rename oCursor to o_cursor in lynxfb_crtc
  staging: sm750fb: Rename vCursor to v_cursor in lynxfb_crtc
  staging: sm750fb: Rename vScreen to v_screen in lynxfb_crtc

 drivers/staging/sm750fb/sm750.c    | 44 ++++++++++-----------
 drivers/staging/sm750fb/sm750.h    |  8 ++--
 drivers/staging/sm750fb/sm750_hw.c | 62 +++++++++++++++---------------
 3 files changed, 57 insertions(+), 57 deletions(-)

-- 
2.31.1

