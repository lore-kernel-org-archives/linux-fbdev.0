Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EF1C4332E
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Feb 2021 14:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E1E164E09
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Feb 2021 14:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhBPOiG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:38:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230460AbhBPOhP (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 16 Feb 2021 09:37:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8E9064DF5;
        Tue, 16 Feb 2021 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613486194;
        bh=sjVIVcPSfd+mytOr8zCuOoRVii4+CL2lGaL/Tfw4EfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jF5NJt5t3lyIVg68iPR//foJXr+Vu9WHkfjCd/HXK4Y+Ly+W4Xu6FoP1zMLoZsKh6
         3WdpswypA7S94nH4FQyBnhFvi9GofzpxszbUE+gFp3b+SaoSRz7AIRaL0IPt73aeFO
         /Ez+VIMkyQmgmZ1ZodKVV2tdzt26EGSlQNpmdJwy4+TJ+//f93ems+VvxIRM+JsK6E
         G6Qvv3HgiTqPs1GMx52gs/YMAWUBPnuOLxb+TBo4BwHbL4KOgtnxn0O10jFDqPFucK
         TcXEPRXWuFCfw5f192M+YFzwYFToioRhdLkdYvTen0AIPG7mBdo5shSjEpOSwe29KR
         rK6ebx6MP57tw==
Date:   Tue, 16 Feb 2021 15:36:24 +0100
From:   Robert Richter <rric@kernel.org>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Marc Dietrich <marvin24@gmx.de>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Cohen <wcohen@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        greybus-dev@lists.linaro.org, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 06/13] staging: octeon: Switch from strlcpy to strscpy
Message-ID: <YCvYaGSPg4HGnCqC@rric.localdomain>
References: <20210131172838.146706-1-memxor@gmail.com>
 <20210131172838.146706-7-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210131172838.146706-7-memxor@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 31.01.21 22:58:27, Kumar Kartikeya Dwivedi wrote:
> strlcpy is marked as deprecated in Documentation/process/deprecated.rst,
> and there is no functional difference when the caller expects truncation
> (when not checking the return value). strscpy is relatively better as it
> also avoids scanning the whole source string.
> 
> This silences the related checkpatch warnings from:
> 5dbdb2d87c29 ("checkpatch: prefer strscpy to strlcpy")
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  drivers/staging/octeon/ethernet-mdio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Robert Richter <rric@kernel.org>
