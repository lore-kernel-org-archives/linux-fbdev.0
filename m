Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5B4C0502C
	for <linux-fbdev@archiver.kernel.org>; Sat, 27 Aug 2022 17:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiH0RDZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 27 Aug 2022 13:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbiH0RDV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 27 Aug 2022 13:03:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1363C29C8C;
        Sat, 27 Aug 2022 10:03:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E965D60DDB;
        Sat, 27 Aug 2022 17:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CFE8C433D6;
        Sat, 27 Aug 2022 17:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661619800;
        bh=Of7PCswaC3yU56t+vb5YYpZvtN+Wu46qqvVhYI4FK3Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b8ay1DNeoR/aMCbTKfRZelbOmYpyhNSyqxwoW2lVmb7pI2Pbr0SXJdE9rpmFctL8f
         M5YSzl4BnVefhlsLUgcpgHVWTjH3kGNg7Mhdz4Tr+WYdvgIYAYRMVLNDxNUToMHO9m
         mGdOqyx5MbCTu9MVGx7RCf5Eknz41+h7ORV0mv+UJPX0DlwePAkfeRW1VBlmwMiD3s
         vNXAaqAG4y0R4c7d0sJ6O5ARTq90dONEEcZCY7Cl0MaPKjQet0qL/9q1WBJWWz8Vn4
         PRq4UVvWn0WgnoDY5f9mia6VtXosELMYcNGcb33YT+6Bctvlz8bmA0qL1/Oo8emCzg
         g33gZQ9V7cooA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 486EFE2A03B;
        Sat, 27 Aug 2022 17:03:20 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev updates & fixes for v6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YwkRD5hWd4F02dxc@ls3530>
References: <YwkRD5hWd4F02dxc@ls3530>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <YwkRD5hWd4F02dxc@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.0-rc3
X-PR-Tracked-Commit-Id: a5a923038d70d2d4a86cb4e3f32625a5ee6e7e24
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89b749d8552d78c4dd86dea86e2e6ba8aafab9fe
Message-Id: <166161980028.20520.16122693737421245098.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Aug 2022 17:03:20 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The pull request you sent on Fri, 26 Aug 2022 20:29:35 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89b749d8552d78c4dd86dea86e2e6ba8aafab9fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
