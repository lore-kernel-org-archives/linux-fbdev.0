Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEA7C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 30 Sep 2021 14:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7012619FA
	for <linux-fbdev@archiver.kernel.org>; Thu, 30 Sep 2021 14:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351830AbhI3ORn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 30 Sep 2021 10:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240149AbhI3ORn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 30 Sep 2021 10:17:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEC3C06176A
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Sep 2021 07:16:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o19so4825125wms.1
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Sep 2021 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F0klS6Mh+ZU3zeDcki3mSRyrj0mwVR8r91ODxy9hdaI=;
        b=Oe+pHiBT3XrgkwFn3i2mzuCDPZI1u9ibvw4IV6w9wweo6qNa/xORjQpoBjxWAw9VYU
         3PZxeExCgy2w437FrpZE8RCpB+vHlqFbx0ZK9Zxb3mWFNCQuXj+CLNS8qbtlFXNEsYi+
         tjT26X1GlQYK5Xjuha3cYcdbxGo9EmlnENAnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F0klS6Mh+ZU3zeDcki3mSRyrj0mwVR8r91ODxy9hdaI=;
        b=Z0//jee3s3yIk74r72sTM1aaPq3TGcH0ENO2imhgrnkIqKqVj3c4VnozNZDxHC+WMX
         7/kt/g2JqUr+uKic9VUGPgNCZxiw4Yhhw6WAUGlXZDuSTQ4ZQjChPQvMxQoNviDDsnSe
         HqsipS5oELrcEFcZz7JRoGaZhqVYGsMWYVqjP+frSXPgvNAbyF/pMQVvk/m8CcoP1diK
         vQp4pMYU6zPEFvEkBEtF1lg7/Ke9ZKrnHVONgIBsZMUhhBRfAKrV6KIgiT5X5KaTjSoY
         OH+tVFmqvJMeNzp3nDKtJjAF20373YK0mlFxlxrI7YtHWEiW2QMxpDPUYQjCJcWRARwH
         N6ew==
X-Gm-Message-State: AOAM533NVfTBMAsNNPbJxZy0rgzkvkCxM1/0Ic4jRYLZ4gNl1EY7eSv8
        rUtXecVqEzUp50cwysBaJdkZ+Q==
X-Google-Smtp-Source: ABdhPJz5iqbqEADdElpUyqtKkJ0bRRhChgQTcNFJzmddUuouPRvFNYK3YDqIVGDjTlZCe3bt8QQH4g==
X-Received: by 2002:a1c:7413:: with SMTP id p19mr5743735wmc.98.1633011359070;
        Thu, 30 Sep 2021 07:15:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d1sm3671688wrr.72.2021.09.30.07.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:15:58 -0700 (PDT)
Date:   Thu, 30 Sep 2021 16:15:56 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Mark Brown <broonie@kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] video: fbdev: gbefb: Only instantiate device when built
 for IP32
Message-ID: <YVXGnDtL68MMTiFp@phenom.ffwll.local>
References: <20210921212102.30803-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921212102.30803-1-broonie@kernel.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Sep 21, 2021 at 10:21:02PM +0100, Mark Brown wrote:
> The gbefb driver not only registers a driver but also the device for that
> driver. This is all well and good when run on the IP32 machines that are
> supported by the driver but since the driver supports building with
> COMPILE_TEST we might also be building on other platforms which do not have
> this hardware and will crash instantiating the driver. Add an IS_ENABLED()
> check so we compile out the device registration if we don't have the Kconfig
> option for the machine enabled.
> 
> Fixes: 552ccf6b259d290c0c ("video: fbdev: gbefb: add COMPILE_TEST support")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Stuffed into drm-misc-fixes, thanks for the patch.
-Daniel

> ---
>  drivers/video/fbdev/gbefb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
> index c5b99a4861e8..6b4d5a7f3e15 100644
> --- a/drivers/video/fbdev/gbefb.c
> +++ b/drivers/video/fbdev/gbefb.c
> @@ -1267,7 +1267,7 @@ static struct platform_device *gbefb_device;
>  static int __init gbefb_init(void)
>  {
>  	int ret = platform_driver_register(&gbefb_driver);
> -	if (!ret) {
> +	if (IS_ENABLED(CONFIG_SGI_IP32) && !ret) {
>  		gbefb_device = platform_device_alloc("gbefb", 0);
>  		if (gbefb_device) {
>  			ret = platform_device_add(gbefb_device);
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
