Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71AFEB64DD
	for <linux-fbdev@archiver.kernel.org>; Thu, 29 Jun 2023 17:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjF2Re4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 29 Jun 2023 13:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjF2Rem (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 29 Jun 2023 13:34:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154B335A5;
        Thu, 29 Jun 2023 10:34:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A232B615C8;
        Thu, 29 Jun 2023 17:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1623BC433C0;
        Thu, 29 Jun 2023 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688060080;
        bh=6fDzS8S6GJhX0BHRKcZ+yXdaSTKoh7FAFJWjWKouEDc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iJY3NdbQ+VEqwusgtRaGx2dNHsVkvFzyqBJT+fDTeFxGVwrR6NeTtIUQA4QaLNCt8
         5dHPQuWKWsXk5xKgaYplBhka6LesgZvnubiHX6oyUKBxpqH89+Fm88giwStNbLjEAc
         DG/AU5qF0c0mdeQa3FFMdLhtIbX7XGNdrfgyq5RTSZM90/PX5bmf5a1ARBkG4NBQ66
         zH3BFFhJNUg4TgAYq9Xtr11rUoflqt1yA0ZDxr3lrJNQsmHrdL0r0eQ0wxtUzdyB+w
         xRiv+3sDnj+IXZuA2rXoVVkqXStzsmuVx2ZVIbyyNYTKIxI461eP6e4ypG8hTYB7nm
         iJj+1AL2sBWBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04FBDC41671;
        Thu, 29 Jun 2023 17:34:40 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJp/DpaLeYq6s3hB@ls3530>
References: <ZJp/DpaLeYq6s3hB@ls3530>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJp/DpaLeYq6s3hB@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.5-rc1
X-PR-Tracked-Commit-Id: c2d22806aecb24e2de55c30a06e5d6eb297d161d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 675285ad819293844018aa8096ba9a6d7c77b90b
Message-Id: <168806008001.7356.17414940393085478476.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Jun 2023 17:34:40 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 08:17:50 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/675285ad819293844018aa8096ba9a6d7c77b90b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
