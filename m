Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A2FEB64DD
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Aug 2023 08:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjHAIyR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Aug 2023 04:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHAIyR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 1 Aug 2023 04:54:17 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F1F173E
        for <linux-fbdev@vger.kernel.org>; Tue,  1 Aug 2023 01:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690880056; x=1722416056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EKSoYDU6IXxYCJo28EURUtu2SqmiJ/aT5mkoCr+f2hc=;
  b=OrVBTzmDgmU+6rxQGdq2HooYrvTKsKDh+LZh5ZvvhD3cQzT16pojrieY
   GsPYz2anAEOxPMJDcO919wZjFIAZkK6udxb5HlMGz04W1UFhwMetBDXcA
   a2XpMmFRUieNtbK48lxbRVLgx2Z/eaQUxqYHzzKPcF0/7zgeKteocw8tr
   2xl/aMgViqtwRbnwcwvHcoaGd6awHw5/aBotd3Rc7aonARh/abA6rO/Vs
   LLr8fF8dDaQij5G9LNEI8lioziFPsXoZUVcuQy++yVFpuCjG+sCi3X9S3
   8nRm+rVDZmF77GXP2gYwfY2h8TSbdi61fMHT5s0nu+xCltw1pfNEpW41j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="400194817"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="400194817"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 01:54:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="728616131"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="728616131"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 01 Aug 2023 01:54:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qQl8r-00CcK6-38;
        Tue, 01 Aug 2023 11:54:09 +0300
Date:   Tue, 1 Aug 2023 11:54:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jilin Yuan <yuanjilin@cdjrlc.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel@pengutronix.de
Subject: Re: [PATCH 2/3] video: fbdev: ssd1307fb: Print the PWM's label
 instead of its number
Message-ID: <ZMjIMU+tb9mbwHwl@smile.fi.intel.com>
References: <20230728145824.616687-1-u.kleine-koenig@pengutronix.de>
 <20230728145824.616687-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230728145824.616687-3-u.kleine-koenig@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jul 28, 2023 at 04:58:23PM +0200, Uwe Kleine-König wrote:
> struct pwm_device::pwm is a write-only variable in the pwm core and used
> nowhere apart from this and another dev_dbg. So it isn't useful to
> identify the used PWM. Emit the PWM's label instead in the debug
> message.

Do we have firmware node of PWM available? I would print it rather than some
(possibly non-unique) string.

-- 
With Best Regards,
Andy Shevchenko


