Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BB0CDB465
	for <linux-fbdev@archiver.kernel.org>; Thu, 19 Oct 2023 08:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjJSIGw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 19 Oct 2023 04:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjJSIGv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 19 Oct 2023 04:06:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EEA121
        for <linux-fbdev@vger.kernel.org>; Thu, 19 Oct 2023 01:06:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09A0C433C8;
        Thu, 19 Oct 2023 08:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697702808;
        bh=qmLnK61kpm7Lch/INgd/SaFSiC5I79WfNm+4Dqkvna0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ph6d2s4uonfV1kMKOY71S+/fj0HENmKeZK6wJnhtrHlbTy0nrezxKVn48gaK67pvu
         Sw4UkU1cS0wAhIz5ssxPrK92EBNDbaLupZsXtYR+aCnSLjHojKGq1H5yu+mnfRB9tM
         YZAuEXy5tTBAmiDXfZvpvcZc+eMflN1gMaLRsstN6/odWvB1ut3yWyOVDUgCkx9t0B
         3gzX1fCp3xqR4cgQN4YRBsor0Nt9xg4MJlJoGI74JfKkahlJ4ftU5WaT7PEFU3AkyJ
         FYgZABF22S+bBJWsBmPcSSFes73GtZiLhkM0SyrNxRNNCGD0ICBhtT8OU8aMFgjsn5
         ekbCmtPb9PmVw==
Date:   Thu, 19 Oct 2023 10:06:42 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Helge Deller <deller@gmx.de>,
        Robert Foss <rfoss@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 0/2] fbdev/simplefb: Add missing simple-framebuffer
 features
Message-ID: <hrfj43uaoozwbm6wqvpbnqp2axqubuuu4rlantbmmrbddtitq5@6u6y7jibmpfg>
References: <20231011143809.1108034-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011143809.1108034-1-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

On Wed, Oct 11, 2023 at 04:38:07PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> This contains two patches that bring simplefb up to feature parity with
> simpledrm. The patches add support for the "memory-region" property that
> provides an alternative to the "reg" property to describe the memory
> used for the framebuffer and allow attaching the simple-framebuffer
> device to one or more generic power domains to make sure they aren't
> turned off during the boot process and take down the display
> configuration.

I just talked with Sima about it in the hallway at XDC. I'm fine with
those patches in principle, but it looks to me that simpledrm doesn't
have support for power domains and we'll want that :)

Thanks!
Maxime
