Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F844C7EE23
	for <linux-fbdev@archiver.kernel.org>; Thu,  1 Jun 2023 22:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjFAWE1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 1 Jun 2023 18:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjFAWE1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 1 Jun 2023 18:04:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5264B180;
        Thu,  1 Jun 2023 15:04:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E394C64A49;
        Thu,  1 Jun 2023 22:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54181C433D2;
        Thu,  1 Jun 2023 22:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685657065;
        bh=7YTN2WfTPgVZX2vsLyH6XjyAXtEu2bLhn1YBxDETeF8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NFtAwIsl3zebHiP/Bb+9qu5LrE9rxaomMpHZ/ELkmCUh70/eEpMVWJzF+0HBsIqC5
         KqhhdZ3xe6fJtWxTC/zTsb/NPXugHtCs83aWE7O42jyHbDEAYfvDCQOtrkzLCNaTvd
         If23d5NZf2hYb+mh10jUS/JnOUH2e9enCNVghEZkrsXzmp9HQW0IsC6nuQFwDOnBFd
         bfn12Rv0UjcdgCevxq6nqbHAuItpb9qFDPdIPGN8rh8Sa7srXyUKdeniuMhg6z9D0S
         MpPlxzEq8CHXZD4pl7pcKpvhz82qvhBHHIz5hFpGEEhkgw8A5e2W0xdoncDX4oI4D1
         2LfZ4QEdv0r0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41D25E52C02;
        Thu,  1 Jun 2023 22:04:25 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes for v6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZHjxWNRjTIk6HyT5@ls3530>
References: <ZHjxWNRjTIk6HyT5@ls3530>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <ZHjxWNRjTIk6HyT5@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.4-rc5
X-PR-Tracked-Commit-Id: d19663edc91de65ae85eea9902addc9d04b0ceb6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e87b63ed37e202c77aa17d4112da6ae0c7c097c
Message-Id: <168565706526.29061.17436079990405893976.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Jun 2023 22:04:25 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The pull request you sent on Thu, 1 Jun 2023 21:28:24 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e87b63ed37e202c77aa17d4112da6ae0c7c097c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
