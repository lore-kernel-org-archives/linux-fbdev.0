Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A82EB64DC
	for <linux-fbdev@archiver.kernel.org>; Fri, 30 Jun 2023 17:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjF3Rb1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 30 Jun 2023 13:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjF3Rb0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 30 Jun 2023 13:31:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87063199B;
        Fri, 30 Jun 2023 10:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688146284; x=1719682284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cubLHaU/IvjeEY3WTxrpyCHJrSKe0stKwV3Mqt6qqD0=;
  b=OLSW4oCiBQiOrAAAl9DR/v9LPYH8kdheTbdEJl5k4diQS+QyIL4SiJ2z
   YCyq/ZHOKbG1sI735LJbe2alZlg+QMl7q0mSUL3NKVvrx+l7fblEyc471
   K1r0A1mluRkGJrVKcLV/0EcLgNTBPAQS4+mtkG5/zXgUTr4LwXXYb+0BK
   VCcZZWspLcRWMQT1d+jF4vbUa15RDpWpTNgiSFj/sn4mDOlS+Q8mL5CRz
   bCGE3BU9UWClFliHiXNZ+qNRU85MnKSiws5qxKN+41Nj/+EuzNAANMKY9
   B5Ld38mcC/a+cKMlVAB9oSPfBkmWK4gUcDeCi0OEV11kUvVbHh0VMAkIS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="365027334"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="365027334"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 10:31:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="862359847"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="862359847"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jun 2023 10:31:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qFHxj-001ALs-2v;
        Fri, 30 Jun 2023 20:31:15 +0300
Date:   Fri, 30 Jun 2023 20:31:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 0/2] Allow disabling all native fbdev drivers and only
 keeping DRM emulation
Message-ID: <ZJ8RY7ZUlryrPB50@smile.fi.intel.com>
References: <20230629225113.297512-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629225113.297512-1-javierm@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jun 30, 2023 at 12:51:02AM +0200, Javier Martinez Canillas wrote:
> This patch series splits the fbdev core support in two different Kconfig
> symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
> be disabled, while still having the the core fbdev support needed for the
> CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
> disabling all fbdev drivers instead of having to be disabled individually.
> 
> The reason for doing this is that now with simpledrm, there's no need for
> the legacy fbdev (e.g: efifb or vesafb) drivers anymore and many distros

How does simpledrm works with earlycon=efi?

> now disable them. But it would simplify the config a lot fo have a single
> Kconfig symbol to disable all fbdev drivers.
> 
> I've build tested with possible combinations of CONFIG_FB, CONFIG_FB_CORE,
> CONFIG_DRM_FBDEV_EMULATION and CONFIG_FB_DEVICE symbols set to 'y' or 'n'.
> 
> Patch 1/2 makes the CONFIG_FB split that is mentioned above and patch 2/2
> makes DRM fbdev emulation depend on the new FB_CORE symbol instead of FB.

-- 
With Best Regards,
Andy Shevchenko


