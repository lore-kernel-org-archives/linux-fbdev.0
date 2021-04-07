Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350BAC433B4
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 08:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02EB461363
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 08:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhDGIjr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 04:39:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231909AbhDGIjr (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 7 Apr 2021 04:39:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6469B61177;
        Wed,  7 Apr 2021 08:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617784778;
        bh=f4c3ezjYH23cJMIbwrMMR0u7/xkmBRyfpVCol87Gd6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o9NhKvHdDc6hrVG3JwQf+J8PrYuUEy1DiNKkWcsDoacJxBNkBkLA6W0V3i9Qse9Cl
         5Jpi+ksbUqPb1Q4G6my3HlOot3VMZz5j505PLMKRC/m2vhxjSxjHwptoCLiaMtGGIm
         F1f/7Ms8nceHeChzLqLDiTyD8/AQ9A0QtsTE+ESo=
Date:   Wed, 7 Apr 2021 10:39:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavle Rohalj <pavle.rohalj@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/49]  staging: sm750fb: Update enum values in dpms
 to snake case
Message-ID: <YG1vx/9FGXcApNEZ@kroah.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
 <16693e7cc62f84ea1ec34b7d5cbd77c4cd1965e8.1617776878.git.pavle.rohalj@gmail.com>
 <YG1eFxQDP6dITlXA@kroah.com>
 <YG1tBSqVTwKQChHV@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG1tBSqVTwKQChHV@localhost.localdomain>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Apr 07, 2021 at 01:27:49AM -0700, Pavle Rohalj wrote:
> On Wed, Apr 07, 2021 at 09:24:07AM +0200, Greg KH wrote:
> > On Tue, Apr 06, 2021 at 11:36:16PM -0700, Pavle Rohalj wrote:
> > > Fix "Avoid CamelCase" checkpatch.pl checks for values in
> > > enum dpms.
> > > 
> > > Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
> > > ---
> > >  drivers/staging/sm750fb/ddk750_power.h | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
> > > index 7002567a47d2..4756db1ccb9c 100644
> > > --- a/drivers/staging/sm750fb/ddk750_power.h
> > > +++ b/drivers/staging/sm750fb/ddk750_power.h
> > > @@ -3,10 +3,10 @@
> > >  #define DDK750_POWER_H__
> > >  
> > >  enum dpms {
> > > -	crtDPMS_ON = 0x0,
> > > -	crtDPMS_STANDBY = 0x1,
> > > -	crtDPMS_SUSPEND = 0x2,
> > > -	crtDPMS_OFF = 0x3,
> > > +	CRT_DPMS_ON = 0x0,
> > > +	CRT_DPMS_STANDBY = 0x1,
> > > +	CRT_DPMS_SUSPEND = 0x2,
> > > +	CRT_DPMS_OFF = 0x3,
> > >  };
> > 
> > And the build does not break with this change?  If so, then why are
> > these here at all?
> > 
> > thanks,
> > 
> > greg k-h
> 
> I do not think so, I was able to build and load the driver with these
> changes. It looks like this enum is used as a type of the state parameter of
> ddk750_set_dpms function, but the three defined constants are never referenced. 
> Should we get rid of dpms enum and change the type of the parameter to an unsigned integer?

If the enum is used, but the names are not used, that's not good and
should be fixed up.

thanks,

greg k-h
