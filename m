Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BDBC433ED
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Apr 2021 14:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF8B610F7
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Apr 2021 14:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244637AbhDPOV2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 16 Apr 2021 10:21:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:24109 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244572AbhDPOV2 (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 16 Apr 2021 10:21:28 -0400
IronPort-SDR: +SfvAe9xmOgw8i1hcQk0UiuBKEpjR6fx+52RSkSgDaiPMBBPa3x7R7ozn0nHb3FEwpehpWX0kE
 kgu6blHY7ZNg==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="191856036"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="191856036"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:21:03 -0700
IronPort-SDR: zmdCb34RpMljdFJ+iFsV9Zoyu2JS5v7cl2KQLOEOFPzdsUfs7jvKZ8+gpfyVdcNURMi5bs2RCa
 iCh1XdmGXiBA==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="461979133"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:21:01 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lXPL8-004fR5-6x; Fri, 16 Apr 2021 17:20:58 +0300
Date:   Fri, 16 Apr 2021 17:20:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.net>,
        Phil Reid <preid@electromag.com.au>,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: Re: [PATCH v1 1/2] fbtft: Rectify GPIO handling
Message-ID: <YHmdSpN4PIZghsgS@smile.fi.intel.com>
References: <20210416123117.4993-1-andriy.shevchenko@linux.intel.com>
 <YHmIb2YrwfzZa7Wh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHmIb2YrwfzZa7Wh@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Apr 16, 2021 at 02:51:59PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Apr 16, 2021 at 03:31:16PM +0300, Andy Shevchenko wrote:
> > The infamous commit c440eee1a7a1 ("Staging: fbtft: Switch to
> > the GPIO descriptor interface") broke GPIO handling completely.
> > It has already four commits to rectify and it seems not enough.
> > In order to fix the mess here we:
> > 
> >   1) Set default to "inactive" for all requested pins
> > 
> >   2) Fix CS, RD, and WR pins polarity since it's active low and
> >      GPIO descriptor interface takes it into consideration from
> >      the Device Tree or ACPI
> > 
> >   3) Fix RESET pin polarity in the places missed by the commit
> >      b918d1c27066 ("Staging: fbtft: Fix reset assertion when using gpio descriptor")
> > 
> >   4) Consolidate chip activation (CS assert) under default
> >      ->reset() callback
> > 
> > To summarize the expectations about polarity for GPIOs:
> > 
> >    #RD			Low
> >    #WR			Low
> >    #CS			Low
> >    #RESET		Low
> >    DC or RS		High
> >    RW			High
> >    Data	0..15		High
> > 
> > See also Adafruit learning course [1] for the example of the schematics.
> > 
> > While at it, drop unneeded NULL checks, since GPIO API is tolerant to that.
> > At the end, update TODO to mark this job eventually done.
> > 
> > [1]: https://learn.adafruit.com/adafruit-2-8-and-3-2-color-tft-touchscreen-breakout-v2/downloads
> 
> Shouldn't this be broken up into "one patch per thing" from your list
> above?  Feels like you did a lot of different things all in the same
> patch :(

Okay, I split a bit, now it's 4 patches. (See v2).

-- 
With Best Regards,
Andy Shevchenko


