Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56D7C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Sep 2021 12:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DBC3611C4
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Sep 2021 12:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243788AbhIQMcd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 17 Sep 2021 08:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244126AbhIQMca (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 17 Sep 2021 08:32:30 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE65C061768
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Sep 2021 05:31:08 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u15so14912982wru.6
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Sep 2021 05:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fXWGJEAQybr4pDDlLtgHrDW/3jidDvhIRctY0I2WY0M=;
        b=qPgJLXy+HvWqdCsqUso4O/PwcACuu8RYEdyfOsmYHTWf5gT6XiAU0uzqalmKErux4/
         hUNQJMMAHx7W66PiCWmOEMtjfRWWsTWJw22JcaIlH5WwShoxgztXd5ROnhYpxcIL8pwF
         +fv2/LiW8OY8pA63ER2Rl74dkVVD6x6wIbcv2lQaxQ9m1J2u5+TCNwTSpT+DbIVKJQED
         47m+1Gi2tUy4iW6w6huQte7RrfeRdCg5qNZUZ+juh66T9lmleEDBxKPHI6I+H7YztyXy
         lCdfPW/FkEVzRhI3bTqn/vgFKom5himskuUEJ1g8LqgLoL7BlQRs1iTdkEoBUF7+JACZ
         qhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fXWGJEAQybr4pDDlLtgHrDW/3jidDvhIRctY0I2WY0M=;
        b=VctlexGj1VxjWj21i2YO28C4M0LmJwSWOfeDYfCVEx70WTWeDeQGgloKmyQLnlWz50
         QLiWYMOsG1piuxjYLywRQCCG9OCslLj2lz8PfzCu2yBHXWnDwrplGcuIyXOXN4kmDnvZ
         Ahi7NHuhbC55+lecbje4/9s5pMWPtzNxmDRvzvKxJLh5KfALFnq9zfO9P434GRWVloUe
         Gt4hSR+dFB64W4x/SUFi6RNpeYEwQLlCeytsCGVo0UQcdmc3IDcRcbdLEtSLoN6A3Oho
         dOc9gAQ4DObRNy5YyCTGgzoCZGWVG2+zMfTU6Gt3Zt8soMDxZtRkaV9jdf4T3AG93SqN
         FLwg==
X-Gm-Message-State: AOAM533KIxxtYwsMYDnJvZCxWxfW2Pk88IARNrXKZZBJuv56SVhqg4jg
        cg4EDvQSa0DgvT9e4VXwUkMcRw==
X-Google-Smtp-Source: ABdhPJw77/NaSGb8f62yLrSui7prnuk28NxJe3qzhMh/O1B6IkPo/w1O1Km+04UOAlZ78Q/3GGfrrg==
X-Received: by 2002:a5d:448d:: with SMTP id j13mr11597328wrq.212.1631881867207;
        Fri, 17 Sep 2021 05:31:07 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id q11sm10709020wmc.41.2021.09.17.05.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 05:31:05 -0700 (PDT)
Date:   Fri, 17 Sep 2021 13:31:03 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] backlight: bd6107: Make use of the helper function
 dev_err_probe()
Message-ID: <20210917123103.33oytfwhpcakdi2w@maple.lan>
References: <20210917031308.17623-1-caihuoqing@baidu.com>
 <20210917091729.elpngrzpvmp43wns@maple.lan>
 <20210917110528.GA17963@LAPTOP-UKSR4ENP.internal.baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210917110528.GA17963@LAPTOP-UKSR4ENP.internal.baidu.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Sep 17, 2021 at 07:05:28PM +0800, Cai Huoqing wrote:
> Hi
> Thanks for your feedback.
> On 17 9月 21 10:17:29, Daniel Thompson wrote:
> > On Fri, Sep 17, 2021 at 11:13:06AM +0800, Cai Huoqing wrote:
> > > When possible use dev_err_probe help to properly deal with the
> > > PROBE_DEFER error, the benefit is that DEFER issue will be logged
> > > in the devices_deferred debugfs file.
> > > Using dev_err_probe() can reduce code size, and the error value
> > > gets printed.
> > > 
> > > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> > 
> > Change seems OK but does this really need to be done one file at a time?
> > I'd prefer to see all of backlight handled in one go (given the scope of
> > this change if applied across the kernel it needs automatic tooling
> > anyway).
> Only two related patches for backlight.

Can you explain how you reach this conclusion?

I only checked two drivers (the first two when you list the drivers
an alphabetic order) but both contain code that appears to match the
pattern you are targeting.


> I try to keep one patch for a subdriver, sometimes different
> subdriver owner need to mark reviwed independently.

For mechanical patches of this nature I don't think there is any need
for acks from individual backlight driver authors. Reviews are 100%
welcome but we would not hold a single patch back until all authors
have reviewed it.


Daniel.



> > > ---
> > >  drivers/video/backlight/bd6107.c | 16 ++++++----------
> > >  1 file changed, 6 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlight/bd6107.c
> > > index 515184fbe33a..e21b793302a2 100644
> > > --- a/drivers/video/backlight/bd6107.c
> > > +++ b/drivers/video/backlight/bd6107.c
> > > @@ -120,7 +120,6 @@ static int bd6107_probe(struct i2c_client *client,
> > >  	struct backlight_device *backlight;
> > >  	struct backlight_properties props;
> > >  	struct bd6107 *bd;
> > > -	int ret;
> > >  
> > >  	if (pdata == NULL) {
> > >  		dev_err(&client->dev, "No platform data\n");
> > > @@ -148,11 +147,9 @@ static int bd6107_probe(struct i2c_client *client,
> > >  	 * the reset.
> > >  	 */
> > >  	bd->reset = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_HIGH);
> > > -	if (IS_ERR(bd->reset)) {
> > > -		dev_err(&client->dev, "unable to request reset GPIO\n");
> > > -		ret = PTR_ERR(bd->reset);
> > > -		return ret;
> > > -	}
> > > +	if (IS_ERR(bd->reset))
> > > +		return dev_err_probe(&client->dev, PTR_ERR(bd->reset),
> > > +				     "unable to request reset GPIO\n");
> > >  
> > >  	memset(&props, 0, sizeof(props));
> > >  	props.type = BACKLIGHT_RAW;
> > > @@ -164,10 +161,9 @@ static int bd6107_probe(struct i2c_client *client,
> > >  					      dev_name(&client->dev),
> > >  					      &bd->client->dev, bd,
> > >  					      &bd6107_backlight_ops, &props);
> > > -	if (IS_ERR(backlight)) {
> > > -		dev_err(&client->dev, "failed to register backlight\n");
> > > -		return PTR_ERR(backlight);
> > > -	}
> > > +	if (IS_ERR(backlight))
> > > +		return dev_err_probe(&client->dev, PTR_ERR(backlight),
> > > +				     "failed to register backlight\n");
> > >  
> > >  	backlight_update_status(backlight);
> > >  	i2c_set_clientdata(client, backlight);
> > > -- 
> > > 2.25.1
> > > 
