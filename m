Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C1CEB64DC
	for <linux-fbdev@archiver.kernel.org>; Fri, 30 Jun 2023 17:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjF3Rn7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 30 Jun 2023 13:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjF3Rn6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 30 Jun 2023 13:43:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA58199B;
        Fri, 30 Jun 2023 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688147036; x=1719683036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I1kCbYOYtU84AgQILFjkzypl9YavoPrVMeRutm6k2fc=;
  b=Yhdo5qP/2KeuUEfmewR633linpvmiaUQkba311QmcQLgsJxUfVkVKLd+
   hh+ZtZHmXAHSb0KodpsrOu/SpeaCDjtFe5GSuKfLpGPJ4/DE+nPes8tBx
   DZX1ons/dwMLgIBuZSX2Ybn1UHdNPdgPh6fNkVu1cxWtRuMXpDBS6fwAw
   swbdpbdgvoMaBx6BgAyb2iFhlhzrzxWhfmT0YWMqoK2rm0MMbu7Hpo8AF
   4jApWgiABH0GBqhU3rjrPxjXX0p3ZPjvj1Ams3mEAq8TUvjZqOWW2JkbD
   tGIY5zYUGusWPedLtuCwjcKHRbZ5kYwKLpcB4hWh6S8PB6TifbuFX7pPX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="352273548"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="352273548"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 10:43:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="787790740"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="787790740"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jun 2023 10:43:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qFI9s-001AXB-1Z;
        Fri, 30 Jun 2023 20:43:48 +0300
Date:   Fri, 30 Jun 2023 20:43:48 +0300
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
Message-ID: <ZJ8UVHEWXu1Jrg+I@smile.fi.intel.com>
References: <20230629225113.297512-1-javierm@redhat.com>
 <ZJ8RY7ZUlryrPB50@smile.fi.intel.com>
 <878rc0etqe.fsf@minerva.mail-host-address-is-not-set>
 <ZJ8T/Fexkr9wEZoP@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJ8T/Fexkr9wEZoP@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jun 30, 2023 at 08:42:21PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 30, 2023 at 07:38:01PM +0200, Javier Martinez Canillas wrote:
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > > On Fri, Jun 30, 2023 at 12:51:02AM +0200, Javier Martinez Canillas wrote:

...

> > >> The reason for doing this is that now with simpledrm, there's no need for
> > >> the legacy fbdev (e.g: efifb or vesafb) drivers anymore and many distros
> > >
> > > How does simpledrm works with earlycon=efi?
> > >
> > 
> > simpledrm isn't for earlycon. For that you use a different driver (i.e:
> > drivers/firmware/efi/earlycon.c). I'm just talking about fbdev drivers
> > here that could be replaced by simpledrm.
> 
> So, efifb can't be replaced. Please, fix your cover letter to reduce false
> impression of the scope of usage of the simpledrm.

Or tell how it can be used for earlycon on EFI platforms (if it can be).

-- 
With Best Regards,
Andy Shevchenko


