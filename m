Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E718C4332F
	for <linux-fbdev@archiver.kernel.org>; Wed, 12 Oct 2022 14:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJLO7x (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 12 Oct 2022 10:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJLO7w (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 12 Oct 2022 10:59:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8623D140BB
        for <linux-fbdev@vger.kernel.org>; Wed, 12 Oct 2022 07:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665586791; x=1697122791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=p5FnZ4+f6pmWst9wSfrEJB9i2nRqQShtidpftxEjnbE=;
  b=SFmfOY9lLErwMbpEHai8Q3eXnfG2Db2FLx7MN9DRX5rDj+Dc54Fm1bh1
   0/2gt372SQ6SlfBvD9XHPW3G29yquTUV+zc7MKq813uLPpmgMNzYDGZzX
   cgxCaIAzrIyiJ1K9pETQKLMdk6UTie0OlWgYm2iT8oXRpwc1P5NEit3oz
   3n3ASe9keQ0nxcCS9VuOPZ7BIhZCthaisDcd4jlGnhuUr3FiIGjvKLRSt
   5cvZNwZa++pbI7Q0Ml6RukqyuULYxZhr8UEYnxKShs1GaBJSYZl66i+P8
   VI4iiWysth4VTrX7Y4+g+Rr9XsSVfVbWVK1bRfaU4FS1MWbuP6l+Ck3Id
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="391121509"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="391121509"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 07:59:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="731455010"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="731455010"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by fmsmga002.fm.intel.com with SMTP; 12 Oct 2022 07:59:46 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 12 Oct 2022 17:59:45 +0300
Date:   Wed, 12 Oct 2022 17:59:45 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Maxime Ripard <maxime@cerno.tech>, sam@ravnborg.org,
        Michal Suchanek <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        benh@kernel.crashing.org, Paul Mackerras <paulus@samba.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        mark.cave-ayland@ilande.co.uk, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 5/5] drm/ofdrm: Support big-endian scanout buffers
Message-ID: <Y0bWYb0z1HZ2PztG@intel.com>
References: <9162f41f-28c3-493c-ab54-b1c4a2fdf494@app.fastmail.com>
 <fda959d7-1bae-716f-f01b-66d9db9096e0@suse.de>
 <654e3cfe-80d7-46c9-8e5e-461846e4df35@app.fastmail.com>
 <866c7033-0d4e-7b5d-008c-8eb16f99498b@suse.de>
 <f26ca6a1-feb1-4822-ac96-bc484b22f8a0@app.fastmail.com>
 <c80a6e2d-a3b9-8186-cc95-97c4775171ed@suse.de>
 <fc33ebf7-ecb7-4686-ac31-0118a40595f6@app.fastmail.com>
 <0a15ecf5-939d-3b00-bcde-0fc7b449cfda@suse.de>
 <76d8a408-fc3e-4bd1-91c5-8278f7469979@app.fastmail.com>
 <a81e1acf-64dd-f69d-d97f-4a1af534e8e6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a81e1acf-64dd-f69d-d97f-4a1af534e8e6@suse.de>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Oct 12, 2022 at 04:31:14PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 12.10.22 um 15:12 schrieb Arnd Bergmann:
> > On Wed, Oct 12, 2022, at 2:00 PM, Thomas Zimmermann wrote:
> >>
> >> Could well be. But ofdrm intents to replace offb and this test has
> >> worked well in offb for almost 15 yrs. If there are bug reports, I'm
> >> happy to take patches, but until then I see no reason to change it.
> > 
> > I wouldn't change the code in offb unless a user reports a bug,
> > but I don't see a point in adding the same mistake to ofdrm if we
> > know it can't work on real hardware.
> 
> As I said, this has worked with offb and apparently on real hardware. 
> For all I know, ATI hardware (before it became AMD) was used in PPC 
> Macintoshs and assumed big-endian access on those machines.

At least mach64 class hardware has two frame buffer apertures, and
byte swapping can be configured separately for each. But that means
you only get correct byte swapping for at most two bpps at the same
time (and that only if you know which aperture to access each time).
IIRC Rage 128 already has the surface register stuff where you
could byte swap a limited set of ranges independently. And old
mga hardware has just one byte swap setting for the whole frame
buffer aperture, so only one bpp at a time.

That kind of horrible limitations of the byte swappers is the
main reason why I wanted to make drm fourcc endianness explicit.
Simply assuming host endianness would end in tears on big endian
as soon as you need to access stuff with two bpps at the same time.
Much better to just switch off those useless byte swappers and
swap by hand when necessary.

-- 
Ville Syrjälä
Intel
