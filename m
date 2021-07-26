Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8804CC4338F
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 13:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C76860F38
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 13:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhGZMgT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Jul 2021 08:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhGZMgS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Jul 2021 08:36:18 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D635C061757;
        Mon, 26 Jul 2021 06:16:47 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e21so7046429pla.5;
        Mon, 26 Jul 2021 06:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cHZOvvel+5d6b214Ne7sLHOgMbGoll5+GC93mwY54eA=;
        b=VaQw2NuGT2IOg1ChHETPeKXdCjDi2OdDH2BSfYPXhvPayFcWiiU7HJkEUflo7xDjH1
         aIAKNlN3V1d9aIS3K5SxU939fjofBoeV6CcPqMWqjNVOP97VgcZKTGR5TudVQr+5qWt7
         0IoJrCLkaaVkYlEdu0jf6Rn93iwUTPE4Civl//lQVe6GU8Tu7Q5RobI8Cv56e4LMIqTg
         WIr/nS9Hj11J9t/Bfx+usXBvjQQTLd+hpRkvQ87L+eSCU+agPIKp1GKIvTOFYT6gUWaL
         CYqVb83eN4vWDR/HuRxQxREgFZaLa2HcAw8JVxqEYSk2Q/thtgPTLahqIfQF0tnobfVN
         qjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cHZOvvel+5d6b214Ne7sLHOgMbGoll5+GC93mwY54eA=;
        b=j71eFV1NM8jFmWDAC+vIyXxQkSOEzokA+IGtnmpph1uWSrGrOjSNLZLCpHrvfssHEH
         MWnzuO28DePj/2oE906koLBCdMkrnXLUaklPPS8m9jVtmSGvg43M8j+lZqXmXuJr3ILF
         1Tu64fk278h31xh6PIv7UhaUUvqr62SumUwM4BAMByUn5mOIzahI8vyRoRGebHLOJoKH
         qa3VVSe0JYeJHpkF1EHfyUJUIJGEdmJvvxOlUxT7QjhxGHJqismoegnwsdC7uJZ1otlO
         q0eOOdnD/FL63cDO1cL29Y1umGUPvvLp0w4pYOND1JMCa7VV2gw2UmFLgQKGZ6mYXaLH
         gyFw==
X-Gm-Message-State: AOAM530vidATBaVVRhLj2rm1CDynA6Sao33RNA+BsRZtfgsY25Oz+q4y
        xQ7klNbwiYUgs7XtsRdyDzc=
X-Google-Smtp-Source: ABdhPJxybNRXYFGSWmauvVve1P4RAIbSKAY80gbCOdbhRJjF5MDB1qYCYCeJxKQPTxqWdB9R78N+eQ==
X-Received: by 2002:a63:c041:: with SMTP id z1mr18481840pgi.49.1627305406871;
        Mon, 26 Jul 2021 06:16:46 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2130:198:9b25:1cfb:9ff3:2a8f])
        by smtp.gmail.com with ESMTPSA id c12sm12070869pfl.56.2021.07.26.06.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 06:16:46 -0700 (PDT)
From:   Benjamin Philip <benjamin.philip495@gmail.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Benjamin Philip <benjamin.philip495@gmail.com>
Subject: [PATCH 0/2] *** staging: sm750fb: Rename maxH and maxW to max_h and max_w ***
Date:   Mon, 26 Jul 2021 18:45:00 +0530
Message-Id: <cover.1627304144.git.benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This patchset (as the subject implies) renames some struct members to follow the
snake_case naming convention from CamelCase. By doing so, it also fixes 2
checkpatch CHECKs.

To test it, I have only checked if the module builds, which it does.

Note: I am very new to the Linux Kernel. This is my first patch. I have done my best
to ensure that my patch is upto the expected standard and to research on what it is
expected by maintainers. Please forgive me if I have done something wrong.

Thanks,
Benjamin Philip

Benjamin Philip (2):
  staging: sm750fb: Rename maxH to max_h in lynx_cursor
  staging: sm750fb: Rename maxW to max_w in lynx_cursor

 drivers/staging/sm750fb/sm750.c        | 8 ++++----
 drivers/staging/sm750fb/sm750.h        | 4 ++--
 drivers/staging/sm750fb/sm750_cursor.c | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.31.1

