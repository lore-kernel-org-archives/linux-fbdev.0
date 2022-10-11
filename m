Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8458FC433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 11 Oct 2022 18:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiJKSXZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 11 Oct 2022 14:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiJKSWg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 11 Oct 2022 14:22:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82767B786;
        Tue, 11 Oct 2022 11:22:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C6D761165;
        Tue, 11 Oct 2022 18:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1517C433D6;
        Tue, 11 Oct 2022 18:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665512529;
        bh=O51qB0xMoygeA5NsyroR3G8rUzJYKfJBTzDJQROMGd4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n+cs1JsKvxM8BXT+w7auguJiIlchq8l1dZ5ykoFr6lFV78xxWTmbIK07i8pPLrdpO
         il3CDRHeVCmD8WUZa1iDRRkJgwBfFhnW4PhnTztQsVvflNLbI3In82pwPbp65hxBF0
         1tofqijzLqdJ4ySz+WBJED6FVNabP29bDz6ZaA2ShU1qFhIRfspl4et/J/fOYerFtD
         Cyixj1n6yPgvV1ZOieJ4is4Dg/qUXg5vEnv51cZDPqcdQ3rWID9yrksa9UCit2lIdE
         Pap1FWTfJld7bmST38S57yaGR/VjlWLaH6XorQo91S/ZOeHGUhwqMllrKyJ8YssaYx
         MzbGkI/fNgRog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F887E29F34;
        Tue, 11 Oct 2022 18:22:09 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and updates for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0KnIfLe8WxtXc5c@ls3530>
References: <Y0KnIfLe8WxtXc5c@ls3530>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0KnIfLe8WxtXc5c@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.1-rc1
X-PR-Tracked-Commit-Id: 29926f1cd3535f565f200430d5b6a794543fe130
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eec4ed317dccdef610b54224f45e0e1f4fdb75fb
Message-Id: <166551252964.20259.1882299445546237306.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Oct 2022 18:22:09 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The pull request you sent on Sun, 9 Oct 2022 12:49:05 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eec4ed317dccdef610b54224f45e0e1f4fdb75fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
