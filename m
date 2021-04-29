Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B905C433B4
	for <linux-fbdev@archiver.kernel.org>; Thu, 29 Apr 2021 16:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00512613F8
	for <linux-fbdev@archiver.kernel.org>; Thu, 29 Apr 2021 16:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbhD2Q44 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 29 Apr 2021 12:56:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:7625 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240833AbhD2Q4z (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 29 Apr 2021 12:56:55 -0400
IronPort-SDR: sDukpH99KYzREJ3szo72vgWlGuJ9f9nlPPWnchrG5joec5BzM+4atX9vcMKLoJ6NwCkq5oDj3s
 26N+dG/BZZQQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="177166393"
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="177166393"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 09:56:08 -0700
IronPort-SDR: UfKVhAS4HGuIl3apXrQJCsFL3vlyN0GGn2fENaHT29ZuNVWNPey5dREwdyShiKJVKnsY7pCp2V
 ffQfvMYdQzoA==
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="527029629"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 09:56:06 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lc9xL-008C2n-Sf; Thu, 29 Apr 2021 19:56:03 +0300
Date:   Thu, 29 Apr 2021 19:56:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Phil Reid <preid@electromag.com.au>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 3/4] staging: fbtft: Don't spam logs when probe is
 deferred
Message-ID: <YIrlI+bo5Jm3orUD@smile.fi.intel.com>
References: <20210428130415.55406-1-andriy.shevchenko@linux.intel.com>
 <20210428130415.55406-4-andriy.shevchenko@linux.intel.com>
 <20210429144244.GE1981@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429144244.GE1981@kadam>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Apr 29, 2021 at 05:42:44PM +0300, Dan Carpenter wrote:
> On Wed, Apr 28, 2021 at 04:04:14PM +0300, Andy Shevchenko wrote:

> > +	if (IS_ERR(*gpiop))
> > +		dev_err_probe(dev, PTR_ERR(*gpiop), "Failed to request %s GPIO\n", name);
> 
> This should be a return statement:
> 
> 		return dev_err_probe(dev, PTR_ERR(*gpiop), "Failed to request %s GPIO\n", name);

Thanks!

Funny that I have trapped to this and my patch that adds __must_check to avoid
exactly this situations had been reverted :-(


-- 
With Best Regards,
Andy Shevchenko


