Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01A4C5479D
	for <linux-fbdev@archiver.kernel.org>; Mon,  9 Jan 2023 11:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjAILTZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 9 Jan 2023 06:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbjAILSz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 9 Jan 2023 06:18:55 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA99B15F29
        for <linux-fbdev@vger.kernel.org>; Mon,  9 Jan 2023 03:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673263105; x=1704799105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hq/seFdmnkoqCIt9DfA6XX+wEq4WRTzqNNlBF8+qvFE=;
  b=ewmo/t3LcMqah+2K9x963i0RYDxvcZgApQNjG1WxN2TPudKunBYGlOhJ
   tpYtYkT8ifxyfMfgLzCINn0a1vP2VrBPgTjFT4EaI6UiewU7BXkpF8TMz
   Z7cCU+3Dc1soDigEjV5J9kn+WNlkQnunoCWK+MwRm297Je5U3Vxwe/rD2
   DAutNLiIedG9ihjFRd7a5lDUTTHe3fLnwblhHXqjFmb4W0LWxn084kKlf
   s3h6nDF36bprAUF9HOtu4uTZRB5Dkof8tXG0duDSEh0QRGyxVlTVnR2h7
   d02GiaxYmgeAR+MCbNrnAmcPrlb1SEDGyMmvP1ug24afeiYU57byAhE3s
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="324096447"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="324096447"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 03:18:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="830563319"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="830563319"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2023 03:18:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pEqAZ-006MUO-07;
        Mon, 09 Jan 2023 13:18:23 +0200
Date:   Mon, 9 Jan 2023 13:18:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 00/15] backlight: Drop use of deprecated fb_blank property
Message-ID: <Y7v3/pbQqoLgCsOc@smile.fi.intel.com>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Jan 07, 2023 at 07:26:15PM +0100, Sam Ravnborg via B4 Submission Endpoint wrote:
> This series refactor backlight users to avoid use of the
> deprecated backlight_properties.fb_blank member.
> 
> Stephen Kitt <steve@sk2.org> and others already did a lot of
> work and this is the final touches.
> 
> Patches 1-13 are independent and can be applied individually.
> Patch 14 was already sent by Stephen and included here to make
> the series complete.
> 
> The last patch may have to wait to avoid breaking the build
> as it depends on all the other patches.
> 
> The series touches several sub-systems, so with acks I could
> take them all in drm-misc. Or we can let the subsystems take
> them and wait until next merge window with the final removal.
> As new users of fb_blank do not pop up that often, waiting
> one merge cycle is fine.
> 
> Sam
> 
> To: Nicolas Ferre <nicolas.ferre@microchip.com>
> To: Helge Deller <deller@gmx.de>
> To: Alexandre Belloni <alexandre.belloni@bootlin.com>
> To: Claudiu Beznea <claudiu.beznea@microchip.com>
> To: Antonino Daplas <adaplas@gmail.com>
> To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> To: Paul Mackerras <paulus@samba.org>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> To: Robin van der Gracht <robin@protonic.nl>
> To: Miguel Ojeda <ojeda@kernel.org>
> To: Lee Jones <lee@kernel.org>
> To: Daniel Thompson <daniel.thompson@linaro.org>
> To: Jingoo Han <jingoohan1@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-staging@lists.linux.dev
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Stephen Kitt <steve@sk2.org>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

I have created a helper script [1] to send series, so it hides these long Cc
lists behind the command line parameters. Feel free to use / comment / update
/ take any ideas from it...

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh


-- 
With Best Regards,
Andy Shevchenko


