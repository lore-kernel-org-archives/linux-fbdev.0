Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064A1C25B04
	for <linux-fbdev@archiver.kernel.org>; Thu, 15 Dec 2022 18:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLOSas (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 15 Dec 2022 13:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiLOS3h (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 15 Dec 2022 13:29:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FFF4D5C7;
        Thu, 15 Dec 2022 10:28:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17261B81C3A;
        Thu, 15 Dec 2022 18:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0E08C433F1;
        Thu, 15 Dec 2022 18:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671128932;
        bh=o/lJVVfYF1CQM7Pc7X6zwQ/oI0nMuE4BjxkyMqQje6M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bh6bzz96YF9hink1RfAqNHvhjrksrSuBMsZ1a0aetLyzOrkwknbFyl5cpfimPJB0T
         fDI4vfI8gmSrynVmmOUjfRr0id9xhhGXgWNwQpQTcvOsV7aOAbajITL3IfEGNigfbR
         4UtN8pl1I4KJuq2ESaI/wWPrBw0hJMYaBRNYknsDiAhyrBdHff3EQZATnCxDvif+xA
         OeboNAAbAkM2p5lsuvAT2QtqgzyDs9LLxV8eEoeFj6RJ5AnwQ+mP7GmySaG6iLLQ59
         06FV15lDlbH+g0g1aGStd1Izg3fIRrVUxuyz7dZ+MzKv3dl2zB+oR3LFpOdYg1ZMvG
         6GHJXWiGOMJJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF75FE4D00F;
        Thu, 15 Dec 2022 18:28:52 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and updates for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5rN6CT8genL6wQc@ls3530>
References: <Y5rN6CT8genL6wQc@ls3530>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5rN6CT8genL6wQc@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.2-rc1
X-PR-Tracked-Commit-Id: 3c3bfb8586f848317ceba5d777e11204ba3e5758
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fa4abc9ad2a18410a7087e6cea15ad1ffb172c6
Message-Id: <167112893271.20649.4028018170717789009.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Dec 2022 18:28:52 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The pull request you sent on Thu, 15 Dec 2022 08:34:00 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fa4abc9ad2a18410a7087e6cea15ad1ffb172c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
