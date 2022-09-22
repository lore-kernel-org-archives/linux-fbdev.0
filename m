Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9801DC6FA86
	for <linux-fbdev@archiver.kernel.org>; Thu, 22 Sep 2022 09:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIVJe0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 22 Sep 2022 05:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiIVJeZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 22 Sep 2022 05:34:25 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBFCCD1F1
        for <linux-fbdev@vger.kernel.org>; Thu, 22 Sep 2022 02:34:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c11so14501202wrp.11
        for <linux-fbdev@vger.kernel.org>; Thu, 22 Sep 2022 02:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=zP3HTuNsbUwZjniN4PiqE90iqzlaqIfqubrWsszKuPw=;
        b=Mj291PKDhuOodPsmekypQWw82MwYbfp9/55bxdN/V/WMcHt6est6fbWfDBnAn/38nB
         0RXQeNlFmww1fTZacwOhBhsDtB7godgfU6nAGF60JTxaAFIA+FIcPbn7/HvuvtSnpGdm
         abuYEHM1d8sZS8xb+ZOvfhxiv8duUJi18f/w/qoz9opT8IB1McfJ9NrMQ2pTj50v6c18
         uC6rMTo5nwzptO6KqZhkORsGDfJ/8XFjPk/Ikngnp32Lu+dfGSHTfGKUlgUX9iL5u/Nf
         1spUX2zhCB2m5WZIWgZkE714vr+6AvRKq/L1l5nEnnAFme649+bLRD9M7Be34h0+wSHY
         GKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zP3HTuNsbUwZjniN4PiqE90iqzlaqIfqubrWsszKuPw=;
        b=j75ZJ7EyENi+/pc2NHO8R1O0xzNPmXyXGNX3xHxcUbDXg5oY7wTuu1PmKJ7o1epJ1e
         7LSyXMwzxQMp08LmA276NNVwmd1sjz9cBdCN75A4z1OzT1zRfFRDOqWpW3oDFKT4tqnR
         9FN8FCZm0UGpUc5I0lHZ0nDu8UdTLOC58Kl3U35vsoLIJ2fM6QBtmeSfaT0/m8puOwbr
         uV7lKUMluhrS3BMoWcNVrfMJTgaJlUoglr1anFgcD1R/gWRj79oLodEXuA7CUqonEOuK
         iltKuZ93Z6nPwJAMW8HZivSdFOrOZPG6bAx2jJH6HSxCYPSGhqBaGz4Pk/qgvWcDFx/I
         iPYg==
X-Gm-Message-State: ACrzQf3md7fDktR6kirX8PzM8E0K17f15k/jhwwSrMUsVTdQZ16tQtl3
        9auvJQJ9iChDeew0xHgBzUibkQ==
X-Google-Smtp-Source: AMsMyM6Dvfz+MR03UNtgYlWi+PxGKpF4DjNBRcuVKwO9zY/oJyegFT5uMq7dcseodlayxqSSBfPobg==
X-Received: by 2002:a5d:5c06:0:b0:22a:7b52:cda6 with SMTP id cc6-20020a5d5c06000000b0022a7b52cda6mr1351425wrb.485.1663839262967;
        Thu, 22 Sep 2022 02:34:22 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id n185-20020a1ca4c2000000b003a682354f63sm5288711wme.11.2022.09.22.02.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 02:34:21 -0700 (PDT)
Date:   Thu, 22 Sep 2022 10:34:19 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        deller@gmx.de, jingoohan1@gmail.com, lee@kernel.org
Subject: Re: [PATCH v1] drivers:adp8870_bl: check the return value of
 adp8870_write
Message-ID: <YywsG6b/h+Mcs88y@maple.lan>
References: <20220921215049.1658796-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921215049.1658796-1-floridsleeves@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Sep 21, 2022 at 02:50:49PM -0700, Li Zhong wrote:
> Subject: [PATCH v1] drivers:adp8870_bl: check the return value of
> adp8870_write
                     ^^^^^^^^^^^^^^^^^^^^

Should be backlight: adp8870_bl.

> Check and propagate the return value of adp8870_write() when it fails,
> which is possible when SMBus writing byte fails.

This looks like a sensible change, however...

When writing patches like this please review the whole file for similar
concerns and fix all instances of the same issue. In this case there is another
unchecked call to adp8870_write() in
adp8870_bl_ambient_light_zone_store() (this function also contains
other unchecked calls).

Note that the unchecked use in adp8870_led_work() because there is no
way to propogate the error from this function (and adp8870_write()
already logged the error).

It would also be good to review and fix adp8860_bl.c at the same time
since these drivers are very similar (ideally the identical code in
these drivers should be factored out).


> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  drivers/video/backlight/adp8870_bl.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
> index 8b5213a39527..0eb4ae2ff592 100644
> --- a/drivers/video/backlight/adp8870_bl.c
> +++ b/drivers/video/backlight/adp8870_bl.c
> @@ -567,9 +567,13 @@ static ssize_t adp8870_store(struct device *dev, const char *buf,
>  		return ret;
>
>  	mutex_lock(&data->lock);
> -	adp8870_write(data->client, reg, val);
> +	ret = adp8870_write(data->client, reg, val);
>  	mutex_unlock(&data->lock);
>
> +	if (ret) {
> +		return ret;
> +	}

No need for braces here.

> +
>  	return count;
>  }
>

Thanks


Daniel.
