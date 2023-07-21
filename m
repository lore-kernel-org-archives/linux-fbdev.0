Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C23DEB64DD
	for <linux-fbdev@archiver.kernel.org>; Fri, 21 Jul 2023 17:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjGUR3C (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjGUR3B (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 21 Jul 2023 13:29:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FD430EA;
        Fri, 21 Jul 2023 10:28:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02FD761D7D;
        Fri, 21 Jul 2023 17:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60A02C433C7;
        Fri, 21 Jul 2023 17:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689960528;
        bh=Yf0poGwvKsIfg9YkJVyqU9cd+0ne0lqHZui61odSa7k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jxJjm/D20Tnqh5xEgiNu0Y14YjjQC18tq2nMQoQmb8dmTyy02SpESTQnh0jyQwX9B
         dyITV7IWx+7yr4rnQIkOE7XIKSlytqGPdyBlDrbhtm4iWifBempdY4+aiN9Zi8IoRc
         4vrmx2OnSm7KzUSwjAZJa0dqndmexS1DFJaa70iKilTdteqQJN8BTAKaIxgl9x4JUJ
         E/oufOarnYMXVSiKpKZPbT/1jS4wdR4o2H4/QUefU7gSXgLK/6NbodYOR8/KjHyGp/
         XCLlvEX1GjMZx2pnjcsFFfTZUOQWQKaBb6K8I6a7bkRCQvs6XALj3cv92yQBk6YZo5
         nKsPFzvCWwJ+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CD3EC595C1;
        Fri, 21 Jul 2023 17:28:48 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and cleanups for v6.5-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZLqSYylyXm2C+aOV@ls3530>
References: <ZLqSYylyXm2C+aOV@ls3530>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <ZLqSYylyXm2C+aOV@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.5-rc3
X-PR-Tracked-Commit-Id: e8812acb5bf724f2fc23a500e590c776ebda7b0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55c225fbd8532a1bac6fd93c5085031650083a4a
Message-Id: <168996052829.13720.8455854435320544971.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jul 2023 17:28:48 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Martin Kaiser <martin@kaiser.cx>,
        Jiri Slaby <jirislaby@kernel.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The pull request you sent on Fri, 21 Jul 2023 16:12:51 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55c225fbd8532a1bac6fd93c5085031650083a4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
