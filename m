Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB03EB64DC
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 Jul 2023 08:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjGCIVq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 3 Jul 2023 04:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjGCIVn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 3 Jul 2023 04:21:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0503AB2;
        Mon,  3 Jul 2023 01:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688372502; x=1719908502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tv0UDvKju0GbZ5KiKlAN1E7wvkV4ONRaMHUw+7Se7Hg=;
  b=Le2JDLs6wlw5yaTgQM2n2nfH2TgwMKoUGqv40PmZXlusjQK5Ip1zBYx+
   TLPpCt/uiSAjE+tZ4lvm6tv2fvYlnKWJPcdcczAU4PG6bzmXGOVseTQeX
   Wve0xGHcG7tbpVCa8dnfmbOrQAHDLZHe22dEB2+Quglf6kMLbD8qyKtWF
   fpZKficjuSL3QfhczWnkRg16eer0LrfiVdEVIfpv1JRF9w53ph6gLWJdg
   JTHXhC9r748d66wKthTdEPcbw4KNYpI4p4DdzTu6VBvelNUMsELJwdCSz
   Qi84EtnEPGsH6eWM86G4FBRDxI9XXMSdKXrYBZsK0P6wMAXzp7bNQC27f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="361683487"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="361683487"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:21:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="753663631"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="753663631"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 03 Jul 2023 01:21:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qGEoP-001nv3-0M;
        Mon, 03 Jul 2023 11:21:33 +0300
Date:   Mon, 3 Jul 2023 11:21:32 +0300
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
Message-ID: <ZKKFDECBXfQF+n8Z@smile.fi.intel.com>
References: <20230629225113.297512-1-javierm@redhat.com>
 <ZJ8RY7ZUlryrPB50@smile.fi.intel.com>
 <878rc0etqe.fsf@minerva.mail-host-address-is-not-set>
 <ZJ8T/Fexkr9wEZoP@smile.fi.intel.com>
 <875y74elsv.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y74elsv.fsf@minerva.mail-host-address-is-not-set>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jun 30, 2023 at 10:29:20PM +0200, Javier Martinez Canillas wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Fri, Jun 30, 2023 at 07:38:01PM +0200, Javier Martinez Canillas wrote:
> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> >> > On Fri, Jun 30, 2023 at 12:51:02AM +0200, Javier Martinez Canillas wrote:
> >> >> This patch series splits the fbdev core support in two different Kconfig
> >> >> symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
> >> >> be disabled, while still having the the core fbdev support needed for the
> >> >> CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
> >> >> disabling all fbdev drivers instead of having to be disabled individually.
> >> >> 
> >> >> The reason for doing this is that now with simpledrm, there's no need for
> >> >> the legacy fbdev (e.g: efifb or vesafb) drivers anymore and many distros
> >> >
> >> > How does simpledrm works with earlycon=efi?
> >> >
> >> 
> >> simpledrm isn't for earlycon. For that you use a different driver (i.e:
> >> drivers/firmware/efi/earlycon.c). I'm just talking about fbdev drivers
> >> here that could be replaced by simpledrm.
> >
> > So, efifb can't be replaced. Please, fix your cover letter to reduce false
> > impression of the scope of usage of the simpledrm.
> >
> 
> Nothing to fixup.
> 
> You are conflating the efifb fbdev driver (drivers/video/fbdev/efifb.c)
> with the efifb earlycon driver (drivers/firmware/efi/earlycon.c). I'm
> talking about the former (which can be replaced by simpledrm) while you
> are talking about the latter.

Ah, this makes sense!

I remember now that it was (still is?) an attempt to move from efifb to
simpledrm, but have no idea what the status of that series is.

-- 
With Best Regards,
Andy Shevchenko


