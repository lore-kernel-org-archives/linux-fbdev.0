Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD74C433ED
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Apr 2021 13:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA29610FA
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Apr 2021 13:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243035AbhDPNlu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 16 Apr 2021 09:41:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:1314 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242938AbhDPNlt (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 16 Apr 2021 09:41:49 -0400
IronPort-SDR: bbJCRWwDNiCI+tv/Rc9DTmKhRAJEI3ggy/vwsM9Yc75SUKLtIs2T8VNSLqMcKnZNyRQAY4ufqs
 F4rZ/tzSqVyQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="192914740"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="192914740"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 06:41:25 -0700
IronPort-SDR: RkMy8kahDr8ADQI+2DiYA8YrkFi3PwsUZKQ1TV9m5jB970VQGpL9A8qO9Q25lNNt1BHY1Vu7yD
 sS51DkTqEcdA==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="383061321"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 06:41:22 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lXOil-004f0l-LX; Fri, 16 Apr 2021 16:41:19 +0300
Date:   Fri, 16 Apr 2021 16:41:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.net>,
        Phil Reid <preid@electromag.com.au>,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: Re: [PATCH v1 1/2] fbtft: Rectify GPIO handling
Message-ID: <YHmT/+B1Hq2baSNs@smile.fi.intel.com>
References: <20210416123117.4993-1-andriy.shevchenko@linux.intel.com>
 <YHmIb2YrwfzZa7Wh@kroah.com>
 <YHmTLPWT/BoTik/P@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHmTLPWT/BoTik/P@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Apr 16, 2021 at 04:37:48PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 16, 2021 at 02:51:59PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Apr 16, 2021 at 03:31:16PM +0300, Andy Shevchenko wrote:
> > > The infamous commit c440eee1a7a1 ("Staging: fbtft: Switch to
> > > the GPIO descriptor interface") broke GPIO handling completely.
> > > It has already four commits to rectify and it seems not enough.
> > > In order to fix the mess here we:
> > > 
> > >   1) Set default to "inactive" for all requested pins
> > > 
> > >   2) Fix CS, RD, and WR pins polarity since it's active low and
> > >      GPIO descriptor interface takes it into consideration from
> > >      the Device Tree or ACPI
> > > 
> > >   3) Fix RESET pin polarity in the places missed by the commit
> > >      b918d1c27066 ("Staging: fbtft: Fix reset assertion when using gpio descriptor")
> > > 
> > >   4) Consolidate chip activation (CS assert) under default
> > >      ->reset() callback
> > > 
> > > To summarize the expectations about polarity for GPIOs:
> > > 
> > >    #RD			Low
> > >    #WR			Low
> > >    #CS			Low
> > >    #RESET		Low
> > >    DC or RS		High
> > >    RW			High
> > >    Data	0..15		High
> > > 
> > > See also Adafruit learning course [1] for the example of the schematics.
> > > 
> > > While at it, drop unneeded NULL checks, since GPIO API is tolerant to that.
> > > At the end, update TODO to mark this job eventually done.
> > > 
> > > [1]: https://learn.adafruit.com/adafruit-2-8-and-3-2-color-tft-touchscreen-breakout-v2/downloads
> > 
> > Shouldn't this be broken up into "one patch per thing" from your list
> > above?  Feels like you did a lot of different things all in the same
> > patch :(
> 
> I am aware, but breaking to the things here will bring it to the state where
> the functionality is still broken in between. Another point is that the drop
> of unneeded checks will bring the modification of the same line in the code
> twice. Or if you look at 5), for instance, due to CS management breakage,
> fixing it w/o 5) will bring it to the weird case that previously handled CS
> due to lucky defaults from firmware or bootloader, suddenly won't work and
> nothing can help it. The split in this case would look like adding the CS
> handling to all drivers followed by removal all of them. I think it's ugly.
> And so on. Believe me, I really tried hard to split this, but it always
> becomes to undesired result.
> 
> Any ideas how to split that we fix stuff in one commit?

Okay, item 3) can be split to a separate patch.

-- 
With Best Regards,
Andy Shevchenko


