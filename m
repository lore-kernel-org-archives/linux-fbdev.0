Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44524C25B48
	for <linux-fbdev@archiver.kernel.org>; Thu, 26 Oct 2023 12:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjJZMcS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 26 Oct 2023 08:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjJZMcR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 26 Oct 2023 08:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C175393
        for <linux-fbdev@vger.kernel.org>; Thu, 26 Oct 2023 05:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698323489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKGG55xL4SkRDBs895+4jlnMzdUeltk87eHzYGIHc8A=;
        b=c5trH7wwnGhxlavKqu8NMYTXNbqauqzBKcZ8dBzIptDqUig/8OBezm/xI6ojLR2D0peK4G
        XYDAjGaNsd6DIa7hZ2ccZKco/Xd8SYns0acrXjq0yoVblVP5odhxWgvRhQ/z/KIbaeS49e
        2xjRgS3FcouT89AXVOgqBC84nFry5qI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-tWBRXfS5NKOf-lKVmDhsew-1; Thu, 26 Oct 2023 08:31:27 -0400
X-MC-Unique: tWBRXfS5NKOf-lKVmDhsew-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b65c46bca8so60034766b.1
        for <linux-fbdev@vger.kernel.org>; Thu, 26 Oct 2023 05:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698323486; x=1698928286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKGG55xL4SkRDBs895+4jlnMzdUeltk87eHzYGIHc8A=;
        b=tYVbVZiKoaTDdBBp+oCwQi7wZezQNV8DbFkS2DyrnIdosPkCx+x1kOzfFM4b4Jtez0
         Kt8OrZgTatAHm0kISsJfgft4cF+LWBVtNqtbhPMDHxee402UbVLOLheLL1FDQGfGudzk
         SK8FpmmZ6YpOKMIkgWOdfVF3v9BJwbh7QRDkfzm8TBcV3TDaj9wHlpX6iuBlWC7lEH7b
         7LhlZDFmYqTBizNRC3+FamKftWyzyYtHs49KcGvQHVXB2i+nJtvzN+9rzPUu+pRa8YuC
         cb75aFpygDj9BvqwztGX4080uvHZU9tKPB5ILmvVFzapCTMg84M8Jb4WIbXwTvxkEXc8
         IjDw==
X-Gm-Message-State: AOJu0Yy/Dt40VvuZu/xG7RWjaZaTYPWxXHbtKkFJgzju6g+dWRM5KWPV
        suQY4KQ2qtYPyC7CbLEjd1jsoRE5j25gg2lwFBQH7UePQmt2KTpl/i1RyVt9IK7BeY5FcagzTBe
        Wf2fYZhahpMLzJiP2LKAQsJ4=
X-Received: by 2002:a17:907:a49:b0:9c7:4d51:af26 with SMTP id be9-20020a1709070a4900b009c74d51af26mr14251453ejc.65.1698323486455;
        Thu, 26 Oct 2023 05:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG74k2bW7kjssIRfmyHXgcC62tpG5x+ewq7BEooUQ80AOkgwgb9uZY5+LiW28cpLsafJa48eA==
X-Received: by 2002:a17:907:a49:b0:9c7:4d51:af26 with SMTP id be9-20020a1709070a4900b009c74d51af26mr14251433ejc.65.1698323486165;
        Thu, 26 Oct 2023 05:31:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:6c4:9fb2:fbc:7029? (2001-1c00-2a07-3a01-06c4-9fb2-0fbc-7029.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:6c4:9fb2:fbc:7029])
        by smtp.gmail.com with ESMTPSA id o24-20020a1709064f9800b0099cc3c7ace2sm11741225eju.140.2023.10.26.05.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 05:31:25 -0700 (PDT)
Message-ID: <3d0a70d6-f6d1-4687-8859-56ef3548fd0d@redhat.com>
Date:   Thu, 26 Oct 2023 14:31:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fbdev/simplefb: Support memory-region property
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     Robert Foss <rfoss@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20231011143809.1108034-1-thierry.reding@gmail.com>
 <20231011143809.1108034-2-thierry.reding@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231011143809.1108034-2-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

On 10/11/23 16:38, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The simple-framebuffer bindings specify that the "memory-region"
> property can be used as an alternative to the "reg" property to define
> the framebuffer memory used by the display hardware. Implement support
> for this in the simplefb driver.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/video/fbdev/simplefb.c | 35 +++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index 62f99f6fccd3..18025f34fde7 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -21,6 +21,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_clk.h>
>  #include <linux/of_platform.h>
>  #include <linux/parser.h>
> @@ -121,12 +122,13 @@ struct simplefb_params {
>  	u32 height;
>  	u32 stride;
>  	struct simplefb_format *format;
> +	struct resource memory;
>  };
>  
>  static int simplefb_parse_dt(struct platform_device *pdev,
>  			   struct simplefb_params *params)
>  {
> -	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *np = pdev->dev.of_node, *mem;
>  	int ret;
>  	const char *format;
>  	int i;
> @@ -166,6 +168,23 @@ static int simplefb_parse_dt(struct platform_device *pdev,
>  		return -EINVAL;
>  	}
>  
> +	mem = of_parse_phandle(np, "memory-region", 0);
> +	if (mem) {
> +		ret = of_address_to_resource(mem, 0, &params->memory);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "failed to parse memory-region\n");
> +			of_node_put(mem);
> +			return ret;
> +		}
> +
> +		if (of_property_present(np, "reg"))
> +			dev_warn(&pdev->dev, "preferring \"memory-region\" over \"reg\" property\n");
> +
> +		of_node_put(mem);
> +	} else {
> +		memset(&params->memory, 0, sizeof(params->memory));
> +	}
> +
>  	return 0;
>  }
>  
> @@ -193,6 +212,8 @@ static int simplefb_parse_pd(struct platform_device *pdev,
>  		return -EINVAL;
>  	}
>  
> +	memset(&params->memory, 0, sizeof(params->memory));
> +
>  	return 0;
>  }
>  
> @@ -431,10 +452,14 @@ static int simplefb_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "No memory resource\n");
> -		return -EINVAL;
> +	if (params.memory.start == 0 && params.memory.end == 0) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		if (!res) {
> +			dev_err(&pdev->dev, "No memory resource\n");
> +			return -EINVAL;
> +		}
> +	} else {
> +		res = &params.memory;
>  	}
>  
>  	mem = request_mem_region(res->start, resource_size(res), "simplefb");

