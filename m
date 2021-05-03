Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_TRY_3LD
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8761BC43461
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 May 2021 16:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 517EE613EB
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 May 2021 16:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhECQph (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 3 May 2021 12:45:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232719AbhECQmg (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 3 May 2021 12:42:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE54961421;
        Mon,  3 May 2021 16:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620059882;
        bh=FgwOJtjFCovh2pSSgcn5gjyb2W1gErUYbBBYra6B+qY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E720fjcPW794q/UQnyrNdOshzgpar64+cKHVg4hZqbCw+7bVwwyUkyk1kTU69Ghvu
         Pxf871kQGjthbpinZzqu7kKyA47le3kgit1sFkdhRFnIJqw8Y7PkH6Vc1MXmg+zxiz
         9+mdDO/XtFi4B3JdBqaj7kzKz50y20YVltAH8G0c=
Date:   Mon, 3 May 2021 18:38:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Phil Reid <preid@electromag.com.au>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.net>,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: Re: [PATCH v3 1/4] staging: fbtft: Rectify GPIO handling
Message-ID: <YJAm6D2LUtVz1YNa@kroah.com>
References: <20210428130415.55406-1-andriy.shevchenko@linux.intel.com>
 <20210428130415.55406-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428130415.55406-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Apr 28, 2021 at 04:04:12PM +0300, Andy Shevchenko wrote:
> The infamous commit c440eee1a7a1 ("Staging: staging: fbtft: Switch to
> the GPIO descriptor interface") broke GPIO handling completely.
> It has already four commits to rectify and it seems not enough.
> In order to fix the mess here we:
> 
>   1) Set default to "inactive" for all requested pins
> 
>   2) Fix CS#, RD#, and WR# pins polarity since it's active low
>      and GPIO descriptor interface takes it into consideration
>      from the Device Tree or ACPI
> 
>   3) Consolidate chip activation (CS# assertion) under default
>      ->reset() callback
> 
> To summarize the expectations about polarity for GPIOs:
> 
>    RD#			Low
>    WR#			Low
>    CS#			Low
>    RESET#		Low
>    DC or RS		High
>    RW			High
>    Data	0 .. 15		High
> 
> See also Adafruit learning course [1] for the example of the schematics.
> 
> While at it, drop unneeded NULL checks, since GPIO API is tolerant to that.
> 
> [1]: https://learn.adafruit.com/adafruit-2-8-and-3-2-color-tft-touchscreen-breakout-v2/downloads
> 
> Fixes: 92e3e884887c ("Staging: staging: fbtft: Fix GPIO handling")
> Fixes: b918d1c27066 ("Staging: staging: fbtft: Fix reset assertion when using gpio descriptor")
> Fixes: dbc4f989c878 ("Staging: staging: fbtft: Fix probing of gpio descriptor")
> Fixes: c440eee1a7a1 ("Staging: staging: fbtft: Switch to the gpio descriptor interface")

I get the following error when trying to apply this:

	Fixes tag: Fixes: 92e3e884887c ("Staging: staging: fbtft: Fix GPIO handling")
	Has these problem(s):
	        - Subject does not match target commit subject
	          Just use
		                git log -1 --format='Fixes: %h ("%s")'
	Fixes tag: Fixes: b918d1c27066 ("Staging: staging: fbtft: Fix reset assertion when using gpio descriptor")
	Has these problem(s):
	        - Subject does not match target commit subject
	          Just use
		                git log -1 --format='Fixes: %h ("%s")'
	Fixes tag: Fixes: dbc4f989c878 ("Staging: staging: fbtft: Fix probing of gpio descriptor")
	Has these problem(s):
	        - Subject does not match target commit subject
	          Just use
		                git log -1 --format='Fixes: %h ("%s")'
	Fixes tag: Fixes: c440eee1a7a1 ("Staging: staging: fbtft: Switch to the gpio descriptor interface")
	Has these problem(s):
	        - Subject does not match target commit subject
	          Just use
		                git log -1 --format='Fixes: %h ("%s")'

Please fix up for your next version of this series.

thanks,

greg k-h
