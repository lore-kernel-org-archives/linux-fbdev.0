Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97877C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 23 Mar 2022 23:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345691AbiCWXhu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 23 Mar 2022 19:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345968AbiCWXht (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 23 Mar 2022 19:37:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FC26E781;
        Wed, 23 Mar 2022 16:36:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4F55B8217F;
        Wed, 23 Mar 2022 23:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8342BC340EE;
        Wed, 23 Mar 2022 23:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648078576;
        bh=OhUtQJJcoj3Jnk+YaF08+vf4O/Og/N3qZbD+HriaA6o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FxYxD7nCVLDq6hbcb3BiqybyqBqZNuMPjqlSSwRXchs5bpYJ/FdHkokYDmMRSwtg8
         Emnn3ie0xYYJyPLLiHISd5/3FvuPX5i8WLGJ1g3Hq0qe2D4N2skzt3SLdgNR+aD1S6
         SmJehFYCaRYRVDw2wAulnS1y6Fxyl/4LpozIeUXzLThQ2UdG3Li8XlejVFYtvRL+vL
         2dFoZedKeCHigpzmKnBrQ3Np2dbspRdXcEs5dHgl6QL3ECRO1jELBgYqQWf+jVfCsS
         FRO050UwMzvGWg2WaT6z+6898bli1aiZOo8m5LKDmWc9EFRiVxicJ7VY5Q904ID3z8
         msZeTBvnX7DLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71078E6D402;
        Wed, 23 Mar 2022 23:36:16 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev updates & fixes for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjokKxSLtqMwyLyB@ls3530>
References: <YjokKxSLtqMwyLyB@ls3530>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <YjokKxSLtqMwyLyB@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/for-5.18/fbdev-1
X-PR-Tracked-Commit-Id: e445c8b2aa2df0e49f6037886c32d54a5e3960b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c4b86ebf5bfdaceba4bedbaf76e4ff745db17ef
Message-Id: <164807857645.14397.13955122823620181053.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Mar 2022 23:36:16 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The pull request you sent on Tue, 22 Mar 2022 20:31:55 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/for-5.18/fbdev-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c4b86ebf5bfdaceba4bedbaf76e4ff745db17ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
