Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFF7C433B4
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Apr 2021 14:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69CAD61073
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Apr 2021 14:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244996AbhDPOmr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 16 Apr 2021 10:42:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:24839 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244373AbhDPOmd (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 16 Apr 2021 10:42:33 -0400
IronPort-SDR: OkcZ0s6HkwD4zKUlGKKl6+uXeq5e7sdsbyvCiZh7eL/noOThK9TOSsowGGA+ZsXXN5Gjxf+pvI
 r8ylf4zQYeAw==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="194606650"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="194606650"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:42:08 -0700
IronPort-SDR: HG4qjL1YMnW5HHQIdjfSEzfDoqyXUesZW51hWmyBeha99RNQ6nryWSzv4AI92sOWr++wOe2EW/
 w6GtmmN+UAAw==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="399925866"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:42:06 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lXPfY-004fhK-4q; Fri, 16 Apr 2021 17:42:04 +0300
Date:   Fri, 16 Apr 2021 17:42:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] video: ssd1307fb: Drop OF dependency
Message-ID: <YHmiPMcgMqHCzaur@smile.fi.intel.com>
References: <20210409164140.17337-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409164140.17337-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

+Cc: Greg.

Greg, can you pick up this one?

The subsystem seems orphaned and I see your name in the git history for the
recent submissions against that driver.

Id is 20210409164140.17337-1-andriy.shevchenko@linux.intel.com

On Fri, Apr 09, 2021 at 07:41:40PM +0300, Andy Shevchenko wrote:
> After the commit 72915994e028 ("video: ssd1307fb: Make use of device
> properties") driver does not depend on OF, drop unneeded dependency.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/video/fbdev/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 4f02db65dede..7506b5949eb0 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -2209,7 +2209,6 @@ config FB_SIMPLE
>  config FB_SSD1307
>  	tristate "Solomon SSD1307 framebuffer support"
>  	depends on FB && I2C
> -	depends on OF
>  	depends on GPIOLIB || COMPILE_TEST
>  	select FB_SYS_FOPS
>  	select FB_SYS_FILLRECT
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


