Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82C8C38142
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Jan 2023 14:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjA1OOW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Jan 2023 09:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjA1OOV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Jan 2023 09:14:21 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5260822DE8
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Jan 2023 06:14:18 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so7295486pjl.0
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Jan 2023 06:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vcgL8SdpnxRsXHVcNTMAFxs4sTzc2o5ZQi6m3PVqUzI=;
        b=MvVYsT2ll7BqSiHFoXFdmjtRJlIYjvOZ3Tw0MD1ie55Ld04C6LqnyY2Is+GZmAKX59
         0Be39rasBg6kmi6TygnzNCks2eelJ+9/zV2x49Iq8+oP/RH8hwZLzt5d4zlgvC8/1Ps5
         gQlC5QUPMZaxt/4qQIelVnL9ipULadnVPLk9KSHOqoEPLhj4DaO9zeHZZJSx/6tVAqxj
         02arQwEpI5hXPEdp4TlOITrh0+XY8PXbWhnyBd/+UJ5aDAGVM23dnDIzhSACYbo1KNUh
         E3wwVyq+uwnVGhQJBp+jCLQfPr9AqFuWR1QXnfxIWaQSbGN/u6A7En8I8acUPfTQzyDm
         G+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcgL8SdpnxRsXHVcNTMAFxs4sTzc2o5ZQi6m3PVqUzI=;
        b=XNFGh42515RY6T1oBC8U76Dnsxq33dH/egjsr5EZ1xN2ULTZoieFqgfkxHkv0tS0FT
         G1AF/y0Y25HgnkCvFonqZETzIFsRyluzuIm2NF+zYO1k2YYFHrDDJoGO/rmdK03o/SO3
         YJREk43XJ0EYvDMwkJ8bfX4pk3KsLsDrb2Y0mmKbOJ5DgVqoUBWq/ChQyrPIoKsTsb/m
         G6pzKYDicpGpsdaSXoKvfebAUhL9YzPqeacP2eA37EhhwINntQVNnJ4Glz2kIQbK5FZu
         VMsqDVEJmEdASQCgfk2/eItGIEwqoZggJvVLAJnBMQEb5+viqcf8n63J4MHQVRPS3+XW
         dNpQ==
X-Gm-Message-State: AFqh2koPhaLycqw+rPEGHaxhVSswyNB6TdZ72ELPCRa5ahoPUJTkvoS8
        wrmSrBfyxK9CI3Jv3Cd+RdgrDLQD+GD+xg==
X-Google-Smtp-Source: AMrXdXsXWzoBxbwbN7xeHbxeAhi+J3eAuA7zq84kXi9P8o8Rrp64f2ipuiw/n1L/mXacwxSx0GOLRw==
X-Received: by 2002:a05:6a20:4657:b0:b8:8208:a837 with SMTP id eb23-20020a056a20465700b000b88208a837mr40088810pzb.22.1674915257780;
        Sat, 28 Jan 2023 06:14:17 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id x189-20020a6386c6000000b004a281fb63c3sm3958223pgd.87.2023.01.28.06.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 06:14:17 -0800 (PST)
Date:   Sat, 28 Jan 2023 22:14:09 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee@kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] backlight: ktz8866: Convert to i2c's .probe_new()
Message-ID: <Y9Utsbi5PYZ26m9j@Gentoo>
References: <20230127152639.1347229-1-u.kleine-koenig@pengutronix.de>
 <Y9RuDM9VAMBzj4vd@Gentoo>
 <20230128133239.ndanz4gzm73wwaiv@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230128133239.ndanz4gzm73wwaiv@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Jan 28, 2023 at 02:32:39PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Sat, Jan 28, 2023 at 08:36:28AM +0800, Jianhua Lu wrote:
> > On Fri, Jan 27, 2023 at 04:26:39PM +0100, Uwe Kleine-König wrote:
> > > The probe function doesn't make use of the i2c_device_id * parameter so
> > > it can be trivially converted.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello,
> > > 
> > > there is an ongoing effort to convert all drivers to .probe_new to
> > > eventually drop .probe with the i2c_device_id parameter. This driver
> > > currently sits in next so wasn't on my radar before.
> > > 
> > > My plan is to tackle that after the next merge window. So I ask you to
> > > either apply this patch during the next merge window or accept that it
> > > will go in via the i2c tree together with the patch that drops .probe().
> > > 
> > > Best regards
> > > Uwe
> > > 
> > >  drivers/video/backlight/ktz8866.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/video/backlight/ktz8866.c b/drivers/video/backlight/ktz8866.c
> > > index 97b723719e13..d38c13ad39c7 100644
> > > --- a/drivers/video/backlight/ktz8866.c
> > > +++ b/drivers/video/backlight/ktz8866.c
> > > @@ -124,8 +124,7 @@ static void ktz8866_init(struct ktz8866 *ktz)
> > >  		ktz8866_write(ktz, LCD_BIAS_CFG1, LCD_BIAS_EN);
> > >  }
> > >  
> > > -static int ktz8866_probe(struct i2c_client *client,
> > > -			 const struct i2c_device_id *id)
> > > +static int ktz8866_probe(struct i2c_client *client)
> > >  {
> > >  	struct backlight_device *backlight_dev;
> > >  	struct backlight_properties props;
> > > @@ -197,7 +196,7 @@ static struct i2c_driver ktz8866_driver = {
> > >  		.name = "ktz8866",
> > >  		.of_match_table = ktz8866_match_table,
> > >  	},
> > > -	.probe = ktz8866_probe,
> > > +	.probe_new = ktz8866_probe,
> > 
> > I think .probe_new() will be renamed to new .probe() again when there are
> > patches dropping old .probe().
> 
> Right, the plan is to reintroduce .probe with the prototype that
> .probe_new has today.
> 
> > I prefer that you pack this commit to the i2c-tree commit that drops
> > old .probe(). 
> 
> That's fine for me. Can I interpret this as an Ack for this patch?
Yes, but can't get my A-b directly, this patch should be ignored and 
resend it within the i2c-tree patch series or split it to two patch
series.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


