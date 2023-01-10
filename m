Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DBBC54EBC
	for <linux-fbdev@archiver.kernel.org>; Tue, 10 Jan 2023 16:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbjAJQ0h (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 10 Jan 2023 11:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238975AbjAJQ0T (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 10 Jan 2023 11:26:19 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DC26458
        for <linux-fbdev@vger.kernel.org>; Tue, 10 Jan 2023 08:26:18 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w1so12373088wrt.8
        for <linux-fbdev@vger.kernel.org>; Tue, 10 Jan 2023 08:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Th71AAKmDZ5QLm9LWP/MGYPBbhSZ+FFSLF2yOB7TE2s=;
        b=kpE4Zcq1gu13wpwafvb2i6Z0u9wBYGLLWrrhNQIKxDPIa5C1OHDMXC+fFg9Vu2BrEr
         1PGdJR28gVhSlvWiEupF5gfHOtFmFyF3/bxbr8A4SsNB4iJx+Uc5zgTbvfWhZnZyPJgV
         RHWeGs3TluEjF9qgDAf/+Ep2OxX3pkfMwvpwxyET8qdO/srKqwBN5JkwS1/btNLI/zHU
         i2yK9CbkM6JOHGJk6tz/+HNRHD+x4G9z3uy+r+tlxqOQ0QreXtqutMDmEx+1mpgbkbfo
         B4svbjnliFLjKrCGEzdh5UjV8mY8nhKK7EAO7dbLjtokxu4kAjAzybqMu4XnJ2nYg9wd
         papA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Th71AAKmDZ5QLm9LWP/MGYPBbhSZ+FFSLF2yOB7TE2s=;
        b=BX43sB82Zbhcb8g8il6GBbCVDuTWJyo7PPzEcpOqpfNi0MzkraNXMclF7O2HwM8OPI
         QyZRkNchFDRfmKjoKo4AdBfBkcOwAqY+flwAyAzPcNqSWorP3Eb1pOVWEotMbs2+zDId
         Tx7LMLeKgg3pM8uP+NxN38gdcfupn292a1h501UtbzzBVZpBV67q7jXQaAj57SiDLLO+
         /qdHM8dag73lZNIPE6JEN90Vhtz6Qs6kyOFj/0qKF4JSryCTF+KnpBC/DkW46aCwXEmu
         d3bDnRBjItDFvAQquMSqLNKQTbfaN2rILPza/27XDCQSUQwTYYMryY5vf2+YsGNxQb3i
         kd5A==
X-Gm-Message-State: AFqh2kpQ6s6cX8b48A3fxxpGsiJMSrk+dckvIA/R67PNM2UD4QvOzUh5
        plvCWZG4kgbn7GvRxTulpwJfj1U+wHp60DKeR0Y=
X-Google-Smtp-Source: AMrXdXv5EJHECoPiR0GtM9s69kjB61W0jLB4YsP0QuX7myrYiYxMtrdgJv+azKjI26FYQwGZ3348mw==
X-Received: by 2002:a05:6000:a19:b0:2b1:c393:cbe with SMTP id co25-20020a0560000a1900b002b1c3930cbemr14799719wrb.11.1673367977022;
        Tue, 10 Jan 2023 08:26:17 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4010000000b002bbed1388a5sm6276513wrp.15.2023.01.10.08.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:26:16 -0800 (PST)
Date:   Tue, 10 Jan 2023 16:26:14 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 2/2] backlight: pwm_bl: Don't disable the PWM to disable
 the backlight
Message-ID: <Y72RpjK4T2VEoIVI@aspen.lan>
References: <20230109204758.610400-1-u.kleine-koenig@pengutronix.de>
 <20230109204758.610400-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230109204758.610400-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jan 09, 2023 at 09:47:58PM +0100, Uwe Kleine-König wrote:
> Most but not all PWMs drive the PWM pin to its inactive state when
> disabled. Rely on the lowlevel PWM implementation to implement
> duty_cycle = 0 in an energy efficient way and don't disable the PWM.

I'm a little worried about this one.

I thought the PWM APIs allow the duty cycle to be rounded up or down
slightly during the apply.

So when you say "rely on the lowlevel to implement duty_cycle = 0 to..."
is it confirmed that this is true (and that all PWMs *can* implement
a duty_cycle of 0 without rounding up)?


Daniel.


> This fixes backlight disabling e.g. on i.MX6 when an inverted PWM is
> used.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/backlight/pwm_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 0509fecd5715..7bdc5d570a12 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -109,7 +109,7 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>  		pwm_backlight_power_off(pb);
>
>  		pwm_get_state(pb->pwm, &state);
> -		state.enabled = false;
> +		state.enabled = true;
>  		state.duty_cycle = 0;
>  		pwm_apply_state(pb->pwm, &state);
>  	}
> --
> 2.39.0
>
