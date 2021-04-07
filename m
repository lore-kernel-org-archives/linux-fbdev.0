Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F5EC433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 08:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD76F613A7
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 08:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbhDGI2C (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 04:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbhDGI2B (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 04:28:01 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB357C06174A;
        Wed,  7 Apr 2021 01:27:52 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id y32so9289725pga.11;
        Wed, 07 Apr 2021 01:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ntPmOtLTBQO17iO2C/J/ncPJWSh08MXYx+HubKJAAco=;
        b=DgDxwehh+Y1geD1x94gB5CIcgxFxYq2ix10Hazya1dhlitsPuWwtLaeacuzPSmgZKB
         1jDCyIESK3asjo77f01em0nRZPUJCfa3Z3n3oDJYGrzIJfVGLP4d/z1UzgZg0TsMQpp9
         F8pb6+cGVhGfTlp+UqfcS/jjuiKrOUT/oBPE7/+PUoaF2GxwIcBuW+oEyIIk43ksimfB
         rU2XzKJoEsTunZUzcS5/xH+r/p5WH9jEi4bWkCZPYEoqnrMneY6o8TfDDAkak6lQyEhm
         FUB3uu5oizynLS7Nt0tYZhTyQgOjl58C+BfveOaTxrRRM0IGwtpIu2SmlgC45wXiod+4
         ylkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ntPmOtLTBQO17iO2C/J/ncPJWSh08MXYx+HubKJAAco=;
        b=ABCF+M9T5dFSkY8fDez0yROL+pJbwG62hCB0hNVLlOjGj72m03pUBiwqulz2ZdYwtw
         dutdZLqFIscYrwGCHfakPpIk3UyXqlHgAdYKhOdiUCzilUOxcDa4wUKp+NAQ405cW2QC
         3rgs3F4ienByUvwlWmKCefWcB8v2M3q+vN6QVA1y62GzLR+/UqPmC93MuKtk6/rZSfNM
         l4HI6zGIvL/XOcvQEWwSH5Mq1qmM9PGEh3chmJea/AZhQkVZXw5r3PPRMbrnwfrjuBpj
         Xeq6cdeuUPyjF5dymDR2GD8xhMaWc2mGkdTvYJXn4y0JOuuSoZ2HAOKQCB0uB51eQzF9
         /Ikg==
X-Gm-Message-State: AOAM5313oWlKClXgzX1oBvHF1nZVqa72TMnzQcffA51XpuCspM1Q7Pq2
        gfLsT1kh2ReOTXDr4RuiOxQ=
X-Google-Smtp-Source: ABdhPJySc6gloAuTNcaXpmXnMgeewxCipjgewulWGsAiSehmJ/N0gclf05LA7y+Ge2ge6B3WJ1aMjw==
X-Received: by 2002:a65:4082:: with SMTP id t2mr2249130pgp.396.1617784072324;
        Wed, 07 Apr 2021 01:27:52 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id v25sm20484716pfn.51.2021.04.07.01.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 01:27:51 -0700 (PDT)
Date:   Wed, 7 Apr 2021 01:27:49 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/49]  staging: sm750fb: Update enum values in dpms
 to snake case
Message-ID: <YG1tBSqVTwKQChHV@localhost.localdomain>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
 <16693e7cc62f84ea1ec34b7d5cbd77c4cd1965e8.1617776878.git.pavle.rohalj@gmail.com>
 <YG1eFxQDP6dITlXA@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG1eFxQDP6dITlXA@kroah.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Apr 07, 2021 at 09:24:07AM +0200, Greg KH wrote:
> On Tue, Apr 06, 2021 at 11:36:16PM -0700, Pavle Rohalj wrote:
> > Fix "Avoid CamelCase" checkpatch.pl checks for values in
> > enum dpms.
> > 
> > Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
> > ---
> >  drivers/staging/sm750fb/ddk750_power.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
> > index 7002567a47d2..4756db1ccb9c 100644
> > --- a/drivers/staging/sm750fb/ddk750_power.h
> > +++ b/drivers/staging/sm750fb/ddk750_power.h
> > @@ -3,10 +3,10 @@
> >  #define DDK750_POWER_H__
> >  
> >  enum dpms {
> > -	crtDPMS_ON = 0x0,
> > -	crtDPMS_STANDBY = 0x1,
> > -	crtDPMS_SUSPEND = 0x2,
> > -	crtDPMS_OFF = 0x3,
> > +	CRT_DPMS_ON = 0x0,
> > +	CRT_DPMS_STANDBY = 0x1,
> > +	CRT_DPMS_SUSPEND = 0x2,
> > +	CRT_DPMS_OFF = 0x3,
> >  };
> 
> And the build does not break with this change?  If so, then why are
> these here at all?
> 
> thanks,
> 
> greg k-h

I do not think so, I was able to build and load the driver with these
changes. It looks like this enum is used as a type of the state parameter of
ddk750_set_dpms function, but the three defined constants are never referenced. 
Should we get rid of dpms enum and change the type of the parameter to an unsigned integer?

-Pavle
