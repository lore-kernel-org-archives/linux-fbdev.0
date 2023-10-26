Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D7AC25B6B
	for <linux-fbdev@archiver.kernel.org>; Thu, 26 Oct 2023 12:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjJZMva (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 26 Oct 2023 08:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjJZMv3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 26 Oct 2023 08:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5428F1AB
        for <linux-fbdev@vger.kernel.org>; Thu, 26 Oct 2023 05:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698324635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VNS0qZB7xwdwYKLmEUgJqL2UxmSoqvnXnlTzs1wzYns=;
        b=ZOGaGPaxulPf1rRMUNhu7c3L31K2ThMRHBTyISPgw0F2vH3uPvuXzazyjhv48wLziBMsWp
        BOfxwUCZuDLWcHH/FcowbPtcs12KST+3OMl8C75mRwuUMKNmxo5L229bvC7oqzUTD8dqlz
        vO8HgeRE6qzf/4UCI9PVoJ3cgD+ROaY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-Pkfy8BkGNBm7M6sU38-P_Q-1; Thu, 26 Oct 2023 08:50:33 -0400
X-MC-Unique: Pkfy8BkGNBm7M6sU38-P_Q-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50483ed1172so956983e87.2
        for <linux-fbdev@vger.kernel.org>; Thu, 26 Oct 2023 05:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698324629; x=1698929429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNS0qZB7xwdwYKLmEUgJqL2UxmSoqvnXnlTzs1wzYns=;
        b=Q8jrtUXr2SUAFLqnquj8iyGC5fsOiiCVGf3wqHoqaQgc79KXo0e/iaCe7RQzzcB+qP
         gtTY/hLEizO4/CfmILln0/FaNhFnnm5bp0DcZjCl0w+IuxnnNoVLF4uhZ33ZJ4zAK0l2
         haamb+NaNKnKTnxgzjRVf796MnqiNMojLjuyQ6jNQojqG/hX5ejSu5pBdb7Rj13/8Q/U
         NVfWHdKMp7w1oS28+CPVrwmZsZ4YFbWkxIXbPMrDWZPCeVMsGHyMO8Y2qwyrPC62BKVZ
         ahqTRSgbdd6YdyrR/eFUO0h2eq4xRT3CaFpT2QF4ASJLR8jIZhbX2BwzkDWB0hmr1+/9
         4V5Q==
X-Gm-Message-State: AOJu0YwMJZ9wS7OxU9fHhluMSwWLJu3sVu/+SwDoaLX9clOQLbwAJLvV
        YwkoeBrKqPyc4/LYmcJqIUFyxQbdtKEWoXzrmdL5qiSZe6ipN8DhehYQKUlDkUE7fkFkkpm/E0q
        C1NXN5N88EzavDc4dGRu6cm81/8aQIOM=
X-Received: by 2002:ac2:4287:0:b0:506:9c0a:17d9 with SMTP id m7-20020ac24287000000b005069c0a17d9mr13841053lfh.40.1698324629554;
        Thu, 26 Oct 2023 05:50:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdoY0mq6sWcnaYNJ1m+5BXAxCxv+e8jZMXYeNjT4JhTMJSzq5LvtlL0i9AyCar1kV8/HULPw==
X-Received: by 2002:ac2:4287:0:b0:506:9c0a:17d9 with SMTP id m7-20020ac24287000000b005069c0a17d9mr13841035lfh.40.1698324629123;
        Thu, 26 Oct 2023 05:50:29 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:6c4:9fb2:fbc:7029? (2001-1c00-2a07-3a01-06c4-9fb2-0fbc-7029.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:6c4:9fb2:fbc:7029])
        by smtp.gmail.com with ESMTPSA id ee8-20020a056402290800b00537666d307csm11164487edb.32.2023.10.26.05.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 05:50:28 -0700 (PDT)
Message-ID: <0bc4aac4-817a-4a6d-8e7c-d19269c47a40@redhat.com>
Date:   Thu, 26 Oct 2023 14:50:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fbdev/simplefb: Add support for generic power-domains
To:     Thierry Reding <thierry.reding@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     Robert Foss <rfoss@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20231011143809.1108034-1-thierry.reding@gmail.com>
 <20231011143809.1108034-3-thierry.reding@gmail.com>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231011143809.1108034-3-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

Thank you for your patches.

On 10/11/23 16:38, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The simple-framebuffer device tree bindings document the power-domains
> property, so make sure that simplefb supports it. This ensures that the
> power domains remain enabled as long as simplefb is active.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/video/fbdev/simplefb.c | 93 +++++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index 18025f34fde7..e69fb0ad2d54 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -25,6 +25,7 @@
>  #include <linux/of_clk.h>
>  #include <linux/of_platform.h>
>  #include <linux/parser.h>
> +#include <linux/pm_domain.h>
>  #include <linux/regulator/consumer.h>
>  
>  static const struct fb_fix_screeninfo simplefb_fix = {
> @@ -78,6 +79,11 @@ struct simplefb_par {
>  	unsigned int clk_count;
>  	struct clk **clks;
>  #endif
> +#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
> +	unsigned int num_genpds;
> +	struct device **genpds;
> +	struct device_link **genpd_links;
> +#endif
>  #if defined CONFIG_OF && defined CONFIG_REGULATOR
>  	bool regulators_enabled;
>  	u32 regulator_count;
> @@ -432,6 +438,83 @@ static void simplefb_regulators_enable(struct simplefb_par *par,
>  static void simplefb_regulators_destroy(struct simplefb_par *par) { }
>  #endif
>  
> +#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
> +static void simplefb_detach_genpds(void *res)
> +{
> +	struct simplefb_par *par = res;
> +	unsigned int i = par->num_genpds;
> +
> +	if (par->num_genpds <= 1)
> +		return;
> +
> +	while (i--) {
> +		if (par->genpd_links[i])
> +			device_link_del(par->genpd_links[i]);
> +
> +		if (!IS_ERR_OR_NULL(par->genpds[i]))
> +			dev_pm_domain_detach(par->genpds[i], true);
> +	}

Using this i-- construct means that genpd at index 0 will
not be cleaned up.

I think it would be best to instead use the same construct
as the simpledrm version of this which makes i signed
(and does not initialize it) and then does:


	for (i = sdev->pwr_dom_count - 1; i >= 0; i--) { .. }


> +}
> +
> +static int simplefb_attach_genpd(struct simplefb_par *par,
> +				 struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	unsigned int i;
> +	int err;
> +
> +	par->num_genpds = of_count_phandle_with_args(dev->of_node,
> +						     "power-domains",
> +						     "#power-domain-cells");
> +	/*
> +	 * Single power-domain devices are handled by the driver core, so
> +	 * nothing to do here.
> +	 */
> +	if (par->num_genpds <= 1)
> +		return 0;
> +
> +	par->genpds = devm_kcalloc(dev, par->num_genpds, sizeof(*par->genpds),
> +				   GFP_KERNEL);
> +	if (!par->genpds)
> +		return -ENOMEM;
> +
> +	par->genpd_links = devm_kcalloc(dev, par->num_genpds,
> +					sizeof(*par->genpd_links),
> +					GFP_KERNEL);
> +	if (!par->genpd_links)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < par->num_genpds; i++) {
> +		par->genpds[i] = dev_pm_domain_attach_by_id(dev, i);
> +		if (IS_ERR(par->genpds[i])) {
> +			err = PTR_ERR(par->genpds[i]);
> +			if (err == -EPROBE_DEFER) {
> +				simplefb_detach_genpds(par);
> +				return err;
> +			}
> +
> +			dev_warn(dev, "failed to attach domain %u: %d\n", i, err);
> +			continue;
> +		}
> +
> +		par->genpd_links[i] = device_link_add(dev, par->genpds[i],
> +						      DL_FLAG_STATELESS |
> +						      DL_FLAG_PM_RUNTIME |
> +						      DL_FLAG_RPM_ACTIVE);
> +		if (!par->genpd_links[i])
> +			dev_warn(dev, "failed to link power-domain %u\n", i);
> +	}
> +
> +	return devm_add_action_or_reset(dev, simplefb_detach_genpds, par);
> +}
> +#else
> +static int simplefb_attach_genpd(struct simplefb_par *par,
> +				 struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int simplefb_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -518,6 +601,10 @@ static int simplefb_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto error_clocks;
>  
> +	ret = simplefb_attach_genpd(par, pdev);
> +	if (ret < 0)
> +		goto error_regulators;
> +
>  	simplefb_clocks_enable(par, pdev);
>  	simplefb_regulators_enable(par, pdev);
>  
> @@ -534,18 +621,20 @@ static int simplefb_probe(struct platform_device *pdev)
>  	ret = devm_aperture_acquire_for_platform_device(pdev, par->base, par->size);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Unable to acquire aperture: %d\n", ret);
> -		goto error_regulators;
> +		goto error_genpds;

This is not necessary since simplefb_attach_genpd() ends with:

	devm_add_action_or_reset(dev, simplefb_detach_genpds, par)

Which causes simplefb_detach_genpds() to run when probe() fails.     

>  	}
>  	ret = register_framebuffer(info);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);
> -		goto error_regulators;
> +		goto error_genpds;
>  	}
>  
>  	dev_info(&pdev->dev, "fb%d: simplefb registered!\n", info->node);
>  
>  	return 0;
>  
> +error_genpds:
> +	simplefb_detach_genpds(par);

As the kernel test robot (LKP) already pointed out this is causing
compile errors when #if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
evaluates as false.

Since there is no simplefb_detach_genpds() stub in the #else, but as
mentioned above this is not necessary so just remove it.

>  error_regulators:
>  	simplefb_regulators_destroy(par);
>  error_clocks:

Regards,

Hans

