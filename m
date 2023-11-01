Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA4DC4332F
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Nov 2023 17:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjKARiH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 1 Nov 2023 13:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjKARiG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 1 Nov 2023 13:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386C5ED
        for <linux-fbdev@vger.kernel.org>; Wed,  1 Nov 2023 10:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698860243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4RhPlGusYVJsSef3GrnGduM/IdUh3rgV5mnvkxhbvvY=;
        b=ZT2bhAS+nHgcIQpNYWSyRw1I2/qJ7YahnJLh/NkSxCJkNWPGOlHMlTP2dlKSy4eaB9ZGMD
        frrIOzYuojuhIbRlhb9lwYTjwxZ6xZDJfu1jNFhmU3NeKMSsc7++gJ87OU+hiVl2mTDldK
        9tfeObA5lym58wSgjbSSjtVV5XqRTVI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-JcALNOlcMKiDvDLi5rF7sg-1; Wed, 01 Nov 2023 13:37:21 -0400
X-MC-Unique: JcALNOlcMKiDvDLi5rF7sg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9d8603d2b00so3346566b.1
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Nov 2023 10:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698860240; x=1699465040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4RhPlGusYVJsSef3GrnGduM/IdUh3rgV5mnvkxhbvvY=;
        b=DUhfaMiIs3D8J6ND13/fYRdUwSfn2p+wb51maAngYtjSxnAMrQDh/LN30xHGbALpa+
         VvmWo1ENsb5/nvPwHk/krLNBJDqbSg9XYVowJcCyIgab2kTVrudBJ/cUVifJUeXGMTuW
         LAzqmREM2NTO2PlQkCDIEislxLGlsk5D4x7Z5mZgfPIwqJtwM+QjdmjnctFXcSgnHCj4
         ztVzZWzgb322sx2Y2hE35dYecfwF23Zz88JHuiutSUekCkPL8b6FmEtUauMU2aDDB2rk
         6eMEfcs9EwB7vmiblVVcM464cllNUTLE4TYbrDSpjyBqAQGSoWXQbb9ZEhvNl8UKJeke
         1d6w==
X-Gm-Message-State: AOJu0Yzf6Et2RNtSpNZwtv9h1fmgB3FSKxQLTJDgZxIHJlA0ow8kRrui
        ebK68TDnEQ/6NK+/4kxF4OdBJ0UdkfCa4bPVpjPPJRvxMZCvvSoqjPkqjAzu4akeKD0ug55XXSC
        xS9NVWl6YDgRZsHo+wgGW71M=
X-Received: by 2002:a17:907:36c5:b0:9d3:f436:6804 with SMTP id bj5-20020a17090736c500b009d3f4366804mr2306785ejc.29.1698860240068;
        Wed, 01 Nov 2023 10:37:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEklBi1zQds+I7UJIFs3SEN4nSdkZJ2sw1JGoIHMH0zyb+URKHqpxh6RiFjAwQE0nQ5Pxclzw==
X-Received: by 2002:a17:907:36c5:b0:9d3:f436:6804 with SMTP id bj5-20020a17090736c500b009d3f4366804mr2306776ejc.29.1698860239742;
        Wed, 01 Nov 2023 10:37:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i17-20020a170906a29100b00992e265495csm174197ejz.212.2023.11.01.10.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 10:37:19 -0700 (PDT)
Message-ID: <0ca75b7a-0dc2-8f91-755c-d1338a96bb3a@redhat.com>
Date:   Wed, 1 Nov 2023 18:37:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] fbdev/simplefb: Add support for generic power-domains
Content-Language: en-US, nl
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Helge Deller <deller@gmx.de>, Robert Foss <rfoss@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20231011143809.1108034-1-thierry.reding@gmail.com>
 <20231011143809.1108034-3-thierry.reding@gmail.com>
 <0bc4aac4-817a-4a6d-8e7c-d19269c47a40@redhat.com>
 <ZUKBwZ3axCKQDXfz@orome.fritz.box>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZUKBwZ3axCKQDXfz@orome.fritz.box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

On 11/1/23 17:50, Thierry Reding wrote:
> On Thu, Oct 26, 2023 at 02:50:27PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> Thank you for your patches.
>>
>> On 10/11/23 16:38, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> The simple-framebuffer device tree bindings document the power-domains
>>> property, so make sure that simplefb supports it. This ensures that the
>>> power domains remain enabled as long as simplefb is active.
>>>
>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>> ---
>>>  drivers/video/fbdev/simplefb.c | 93 +++++++++++++++++++++++++++++++++-
>>>  1 file changed, 91 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
>>> index 18025f34fde7..e69fb0ad2d54 100644
>>> --- a/drivers/video/fbdev/simplefb.c
>>> +++ b/drivers/video/fbdev/simplefb.c
>>> @@ -25,6 +25,7 @@
>>>  #include <linux/of_clk.h>
>>>  #include <linux/of_platform.h>
>>>  #include <linux/parser.h>
>>> +#include <linux/pm_domain.h>
>>>  #include <linux/regulator/consumer.h>
>>>  
>>>  static const struct fb_fix_screeninfo simplefb_fix = {
>>> @@ -78,6 +79,11 @@ struct simplefb_par {
>>>  	unsigned int clk_count;
>>>  	struct clk **clks;
>>>  #endif
>>> +#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
>>> +	unsigned int num_genpds;
>>> +	struct device **genpds;
>>> +	struct device_link **genpd_links;
>>> +#endif
>>>  #if defined CONFIG_OF && defined CONFIG_REGULATOR
>>>  	bool regulators_enabled;
>>>  	u32 regulator_count;
>>> @@ -432,6 +438,83 @@ static void simplefb_regulators_enable(struct simplefb_par *par,
>>>  static void simplefb_regulators_destroy(struct simplefb_par *par) { }
>>>  #endif
>>>  
>>> +#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
>>> +static void simplefb_detach_genpds(void *res)
>>> +{
>>> +	struct simplefb_par *par = res;
>>> +	unsigned int i = par->num_genpds;
>>> +
>>> +	if (par->num_genpds <= 1)
>>> +		return;
>>> +
>>> +	while (i--) {
>>> +		if (par->genpd_links[i])
>>> +			device_link_del(par->genpd_links[i]);
>>> +
>>> +		if (!IS_ERR_OR_NULL(par->genpds[i]))
>>> +			dev_pm_domain_detach(par->genpds[i], true);
>>> +	}
>>
>> Using this i-- construct means that genpd at index 0 will
>> not be cleaned up.
> 
> This is actually a common variant to clean up in reverse order. You'll
> find this used a lot in core code and so on. It has the advantage that
> you can use it to unwind (not the case here) because i will already be
> set to the right value, typically. It's also nice because it works for
> unsigned integers.
> 
> Note that this uses the postfix decrement, so evaluation happens before
> the decrement and therefore the last iteration of the loop will run with
> i == 0. For unsigned integers this also means that after the loop the
> variable will actually have wrapped around, but that's usually not a
> problem since it isn't used after this point anymore.

Ah yes you are right, I messed the post-decrement part.

I got confused when I compaired this to the simpledrm code
which uses the other construct.

> 
>>>  static int simplefb_probe(struct platform_device *pdev)
>>>  {
>>>  	int ret;
>>> @@ -518,6 +601,10 @@ static int simplefb_probe(struct platform_device *pdev)
>>>  	if (ret < 0)
>>>  		goto error_clocks;
>>>  
>>> +	ret = simplefb_attach_genpd(par, pdev);
>>> +	if (ret < 0)
>>> +		goto error_regulators;
>>> +
>>>  	simplefb_clocks_enable(par, pdev);
>>>  	simplefb_regulators_enable(par, pdev);
>>>  
>>> @@ -534,18 +621,20 @@ static int simplefb_probe(struct platform_device *pdev)
>>>  	ret = devm_aperture_acquire_for_platform_device(pdev, par->base, par->size);
>>>  	if (ret) {
>>>  		dev_err(&pdev->dev, "Unable to acquire aperture: %d\n", ret);
>>> -		goto error_regulators;
>>> +		goto error_genpds;
>>
>> This is not necessary since simplefb_attach_genpd() ends with:
>>
>> 	devm_add_action_or_reset(dev, simplefb_detach_genpds, par)
>>
>> Which causes simplefb_detach_genpds() to run when probe() fails.
> 
> Yes, you're right. I've removed all these explicit cleanup paths since
> they are not needed.
> 
>>
>>>  	}
>>>  	ret = register_framebuffer(info);
>>>  	if (ret < 0) {
>>>  		dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);
>>> -		goto error_regulators;
>>> +		goto error_genpds;
>>>  	}
>>>  
>>>  	dev_info(&pdev->dev, "fb%d: simplefb registered!\n", info->node);
>>>  
>>>  	return 0;
>>>  
>>> +error_genpds:
>>> +	simplefb_detach_genpds(par);
>>
>> As the kernel test robot (LKP) already pointed out this is causing
>> compile errors when #if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
>> evaluates as false.
>>
>> Since there is no simplefb_detach_genpds() stub in the #else, but as
>> mentioned above this is not necessary so just remove it.
> 
> Yep, done.

Great, thank you.

Regards,

Hans


