Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD508C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 14 Feb 2022 10:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348959AbiBNKsc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:48:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349011AbiBNKsF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 14 Feb 2022 05:48:05 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B59BB576
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Feb 2022 02:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644833433; x=1676369433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lx+hV5yTC+6Zm6CjYhcbfB/UYfpwjtIBoJll8ctGi6k=;
  b=Fzda4SkTaex+tngI6SpAF77E/i6baNNl494cJbp7RI6BckBBuwkfZVSg
   bs1qNhD+nm/lffva8nWaSdy3UAfRkFMeeh6sNAjDUAM4JCEeWTEGa7ZR9
   Q3O9FNJVV9WYaXuRUCUrrdjPEWJYqaHru6p3jJVui31vX5YXHNI/FNkjg
   j0BNRDH8EsNhvUJPa+6lmTDcaYGvqUs8+Yg0sWAuI+lXBOJOSQgOFKabq
   tyUtmjwSUM5HKJQBhnhVAytp7UGIFpEDXO1znR4ZWe2jnOLPuiSfeXaMs
   20vJ5BAJi6wYdRT1sVKriygLLuJbk0eFeYV31gxXZ8563gaesvxk0AAhQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="237469511"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="237469511"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 02:10:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="624098150"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 02:10:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nJYIV-004P8q-Jx;
        Mon, 14 Feb 2022 12:09:31 +0200
Date:   Mon, 14 Feb 2022 12:09:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     qianfanguijin@163.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        preid@electromag.com.au
Subject: Re: [PATCH] drivers: fbtft: Add property 'keep-bootlogo'
Message-ID: <YgoqWzZ/PYHZS9nt@smile.fi.intel.com>
References: <20220212053711.26481-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212053711.26481-1-qianfanguijin@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Feb 12, 2022 at 01:37:11PM +0800, qianfanguijin@163.com wrote:
> From: qianfan Zhao <qianfanguijin@163.com>
> 
> Keep the logo draw by bootloader

Please, Cc to fbdev maintainer. Personally I'm not sure we want this from
maintenance perspective, but I understand what you want to achieve with it.

-- 
With Best Regards,
Andy Shevchenko


