Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37804C5479D
	for <linux-fbdev@archiver.kernel.org>; Mon,  9 Jan 2023 10:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjAIK1k (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 9 Jan 2023 05:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbjAIK1X (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 9 Jan 2023 05:27:23 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1362CCE38
        for <linux-fbdev@vger.kernel.org>; Mon,  9 Jan 2023 02:27:18 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ja17so5897526wmb.3
        for <linux-fbdev@vger.kernel.org>; Mon, 09 Jan 2023 02:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SR4xg/8vRGqoBJiSpvGD2Rl2ghk9VGEtuelbvA5hJfk=;
        b=aT3ss8O+Gsu9jCN8YuL3TDXjKyNWf4nB21P7RR9Th1b+8mZp8kz3LPZ9G8Ug/9sSbr
         JmeDD4GvprLSePBUp4a0A5MB7ZzURamGMbAjnAq7iF3USgE9Kv0+e28Kt3qHCsN8NGN9
         21WASmcnew4Cd/TZS+qup11illvEBYs18hjBTbG+EVySqrihxge0+iZqjKyWIaMKb59I
         zqRx0kU5xQvogoAUaleQhVB/eG0XEIup+csXL5dIT9wK1/BTQlL7L98iLAVNHJSRJWbt
         SVLxKaJrSs6/0qwW/Fo7d9ghv0DVJMQsmZOj6b13qqG7Uh25bJyFTyQH2iKv0bt8jP9I
         uSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR4xg/8vRGqoBJiSpvGD2Rl2ghk9VGEtuelbvA5hJfk=;
        b=rhUNyI+iIBzUSyCD3JyNEEsCiPsQ9GTqAVy3QgrVlywxK2Tcv0yqziaAY+xlLCpp67
         msfFp1WklOXG2X4oE3dMBTan13KFj7orC8S6Y92zBWTsm839nM2ekd2Yg8vb7YBjVCet
         JojXI38FHL7fEhsgURUbBgjKijkUi4/loa6I1H6hBKJ7H60XdXmvxfRr7FlQI/K9wZ9c
         GOe5Dp3kqkjuQ2LqSChPb50lzvKKpXPecCIM1yjqI6rh8Hy8gZr6UbyXZdV4tsaZNz9G
         Qq1lnI79xN5t2FPhvXbZolyk8Ah+zQgbA/sJFiSEY2UYyjOXEu1qpye1zZOWWm8DaQe+
         8MOg==
X-Gm-Message-State: AFqh2kqGsgliihd6LQsM7GNmRKZ0ObQ3laW4rMAWMLTa014Eh0MKmsm4
        VqHzlXVI6oFZVRliswsqVtgJCkPOStr3IfWEo28=
X-Google-Smtp-Source: AMrXdXvlCiyiCuzHJg/WG8LUCp3wL2rzbSPwtjvrHVXTysfocLK7IGL9XmfsmXW4Llcem1k1rdDJBA==
X-Received: by 2002:a05:600c:4e90:b0:3cf:894f:964b with SMTP id f16-20020a05600c4e9000b003cf894f964bmr47444559wmq.16.1673260036605;
        Mon, 09 Jan 2023 02:27:16 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c469000b003d9b87296a9sm16796137wmo.25.2023.01.09.02.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:27:15 -0800 (PST)
Date:   Mon, 9 Jan 2023 10:27:13 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH RESEND 1/4] backlight: aat2870: Use backlight helper
Message-ID: <Y7vsAdMqGNgYS/m9@aspen.lan>
References: <20230106164856.1453819-2-steve@sk2.org>
 <Y7hdyPAKBYv+gAzf@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7hdyPAKBYv+gAzf@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jan 06, 2023 at 06:43:36PM +0100, Daniel Vetter wrote:
> On Fri, Jan 06, 2023 at 05:48:52PM +0100, Stephen Kitt wrote:
> > Instead of retrieving the backlight brightness in struct
> > backlight_properties manually, and then checking whether the backlight
> > should be on at all, use backlight_get_brightness() which does all
> > this and insulates this from future changes.
> >
> > Signed-off-by: Stephen Kitt <steve@sk2.org>
>
> Lee/Daniel, will you pick these up, or should I smash them all into
> drm-misc-next for 6.3?

Outside of holiday, Lee usually hoovers up the backlight patches (and
negotiates about who merges what).


Daniel.


> > ---
> >  drivers/video/backlight/aat2870_bl.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
> > index a7af9adafad6..1cbb303e9c88 100644
> > --- a/drivers/video/backlight/aat2870_bl.c
> > +++ b/drivers/video/backlight/aat2870_bl.c
> > @@ -59,7 +59,7 @@ static int aat2870_bl_update_status(struct backlight_device *bd)
> >  	struct aat2870_bl_driver_data *aat2870_bl = bl_get_data(bd);
> >  	struct aat2870_data *aat2870 =
> >  			dev_get_drvdata(aat2870_bl->pdev->dev.parent);
> > -	int brightness = bd->props.brightness;
> > +	int brightness = backlight_get_brightness(bd);
> >  	int ret;
> >
> >  	if ((brightness < 0) || (bd->props.max_brightness < brightness)) {
> > @@ -70,11 +70,6 @@ static int aat2870_bl_update_status(struct backlight_device *bd)
> >  	dev_dbg(&bd->dev, "brightness=%d, power=%d, state=%d\n",
> >  		 bd->props.brightness, bd->props.power, bd->props.state);
> >
> > -	if ((bd->props.power != FB_BLANK_UNBLANK) ||
> > -			(bd->props.state & BL_CORE_FBBLANK) ||
> > -			(bd->props.state & BL_CORE_SUSPENDED))
> > -		brightness = 0;
> > -
> >  	ret = aat2870->write(aat2870, AAT2870_BLM,
> >  			     (u8)aat2870_brightness(aat2870_bl, brightness));
> >  	if (ret < 0)
> > --
> > 2.30.2
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
