Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2CBC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu,  2 Jun 2022 10:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiFBKu4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 2 Jun 2022 06:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbiFBKuz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 2 Jun 2022 06:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 211643E0DC
        for <linux-fbdev@vger.kernel.org>; Thu,  2 Jun 2022 03:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654167052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DrhV5vnxv6SRuKZJ5gBXpRv/4ZhVI+1PkR2Fak5zt3E=;
        b=XGW6OybQKr7WW7ZUufJ8uWwJ/cjufbaYirYbTvg8Crchr5RbSCpOJsL5h6PdBlxXarHq2Y
        3L2zFRF0UsSZ9MKqK8b0tpScMD0d0k1sETaVKwHjVqta9Fhuz3Ew3tzsIb/5bhsLP6Rdir
        6O/akHnJ1asAnlN6yEHcPAxkO+tbBqc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619--X8185MANUGQ9Kl2QbobFA-1; Thu, 02 Jun 2022 06:50:41 -0400
X-MC-Unique: -X8185MANUGQ9Kl2QbobFA-1
Received: by mail-ed1-f70.google.com with SMTP id q12-20020a056402040c00b0042a84f9939dso3232961edv.7
        for <linux-fbdev@vger.kernel.org>; Thu, 02 Jun 2022 03:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DrhV5vnxv6SRuKZJ5gBXpRv/4ZhVI+1PkR2Fak5zt3E=;
        b=xyJblgM0Hew1tz2IZScsjUvDI2WYFf5yRQvbXKwf5aIko/lylCIp55YRYdLhdjaA4C
         s22CQFtcDHTabBAdSERglZZChljYazsbcOeOvWNdBfebqjQITREW9vrkx1wG94hzxcBM
         ZRXO2MyMCeqy1cbNnJ989Zb6jsgkoIO1NCAo5GY8Yx9QDmGLSsWQxM48X2OxpQ2rv7mL
         WnNyQj577RKPDpTzFQ9Mk52YMkAPiFE0V9PwOcK4AsWctWBPtXk2S3ZyGdzVryxXUNVe
         EgYWZn5l58k54cTpLJBLkIU6ok6yHOskz0NKWeKVh5JEzk3IWToBNtOIj1A83J0Mzh90
         vVVg==
X-Gm-Message-State: AOAM532oBfgnR4nzUa0v+R0GK/RqqEnirI/OOI1q+aS/43plcVOx2w5U
        1QHvKElBisl2m0UqcQGAFeyiNTGFfZ1D2idU/UDTVL/cKrAQdTsms9s76SNKat4rKfDIRV1o07d
        kZ0ezHDabUp9oETOqSd9dACA=
X-Received: by 2002:aa7:c852:0:b0:42d:70d8:2864 with SMTP id g18-20020aa7c852000000b0042d70d82864mr4622043edt.379.1654167038352;
        Thu, 02 Jun 2022 03:50:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxagkCoICyD4tyHlyBtfQJTn2p3Yp2BOSbtulSpElsl0xzECJsO+qskjhWefExGoeHv99aQBQ==
X-Received: by 2002:aa7:c852:0:b0:42d:70d8:2864 with SMTP id g18-20020aa7c852000000b0042d70d82864mr4622024edt.379.1654167038205;
        Thu, 02 Jun 2022 03:50:38 -0700 (PDT)
Received: from [192.168.42.54] ([109.38.144.46])
        by smtp.gmail.com with ESMTPSA id e1-20020a170906374100b006f3ef214da8sm1651719ejc.14.2022.06.02.03.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 03:50:37 -0700 (PDT)
Message-ID: <84aa3225-d514-4c08-f6d3-ed8f0423e513@redhat.com>
Date:   Thu, 2 Jun 2022 12:50:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fbdev: simplefb: Check before clk_put() not needed
Content-Language: en-US
To:     Yihao Han <hanyihao@vivo.com>, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220602094219.13024-1-hanyihao@vivo.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220602094219.13024-1-hanyihao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

On 6/2/22 11:42, Yihao Han wrote:
> clk_put() already checks the clk ptr using !clk and IS_ERR()
> so there is no need to check it again before calling it.
> 
> Signed-off-by: Yihao Han <hanyihao@vivo.com>
> ---
>  drivers/video/fbdev/simplefb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index 2c198561c338..f96ce8801be4 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -237,8 +237,7 @@ static int simplefb_clocks_get(struct simplefb_par *par,
>  		if (IS_ERR(clock)) {
>  			if (PTR_ERR(clock) == -EPROBE_DEFER) {
>  				while (--i >= 0) {
> -					if (par->clks[i])
> -						clk_put(par->clks[i]);
> +					clk_put(par->clks[i]);
>  				}
>  				kfree(par->clks);
>  				return -EPROBE_DEFER;

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

