Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38652C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Feb 2022 16:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbiBIQGF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Feb 2022 11:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbiBIQF7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Feb 2022 11:05:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 004EDC061355
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Feb 2022 08:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644422762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LEFCqKCSxGi9whZ4JcEN5a7NElBGZhBjkZkBGJeeZak=;
        b=HAeQnG9zGRYf3Vk1WDDDN6FqSbmiqqmDfxjdt4BmR52Pu5LZX4pF/a6EREX3Si8GKV+d6D
        TZStNHjtKklM0euRLn/ufFcohAwOae/jQimVkK0g7kzQrT3ZW44D6yBn5hXhXSSRBmehzQ
        j9Q/g15D5pzHmt5VWkuAYXAlZAsa2Do=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-q1jqpsb7PpuFk3YM7uQqcA-1; Wed, 09 Feb 2022 11:05:22 -0500
X-MC-Unique: q1jqpsb7PpuFk3YM7uQqcA-1
Received: by mail-wr1-f70.google.com with SMTP id e11-20020adf9bcb000000b001e316b01456so1259000wrc.21
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Feb 2022 08:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LEFCqKCSxGi9whZ4JcEN5a7NElBGZhBjkZkBGJeeZak=;
        b=DFKZL6vxCtug+GJN1Op3YvjYROHaViAqP8U0lH57vWulfJS6B4cBQRcQAkhyGHZm24
         usTQf0Og5Z8nF5x7pHsEm0IJYBbsxKJagfFxnUYjt3n1Fu9gXrfxfM9PkfDBpikNOteB
         anuqGzWFRJaK9ajiWqVLgTQ5T1KFPP+oWZtCk9VYqw4Vi6KR1Gn1qOdwSI9S7/yTAIit
         w0mcXfDOjjAkcoxKAHl9fZJfW2FQErhcLscCBn0LO4ACbeVV+oUWjmh4fAMORQlnbcd2
         RF/z5nQBhB8oUy3j8yCCDae1GkbdBdFXy+ldqckm0ZiQKEIS8InZjaERbTWc1I6JcH37
         yw9Q==
X-Gm-Message-State: AOAM5338EeaNumANNxJILUZSE5URNNTE83zRlHwxqckoCaHSmKImSZT9
        rTBkfXJE60viQdxwe7M6ToJfvy/NvmHE+MB9BVUzwoh0TGNFpmydbKWxShno9rRYZe79LKbmtr+
        uwuQFcNJMJPBc7DwQvb2qjDE=
X-Received: by 2002:a1c:2942:: with SMTP id p63mr2673418wmp.75.1644422721362;
        Wed, 09 Feb 2022 08:05:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx+j9ANRMCysRCXC83SlIGGD+b29Hyb7iOR9cmkjVggSgqjPJ0r7Mq6unfGb1nTB3jvtmr0qA==
X-Received: by 2002:a1c:2942:: with SMTP id p63mr2673393wmp.75.1644422721161;
        Wed, 09 Feb 2022 08:05:21 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i15sm1276298wmq.23.2022.02.09.08.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 08:05:20 -0800 (PST)
Message-ID: <f3096131-4285-6e06-8e0a-47b23f8feb9c@redhat.com>
Date:   Wed, 9 Feb 2022 17:05:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 4/7] drm/solomon: Add SSD130X OLED displays I2C support
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209090314.2511959-5-javierm@redhat.com>
 <YgPanXaAYQxHTjMd@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgPanXaAYQxHTjMd@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/9/22 16:15, Andy Shevchenko wrote:
> On Wed, Feb 09, 2022 at 10:03:11AM +0100, Javier Martinez Canillas wrote:
>> The ssd130x driver only provides the core support for these devices but it
>> does not have any bus transport logic. Add a driver to interface over I2C.
> 
> Thanks!
> 
> ...
> 
>> + * Authors: Javier Martinez Canillas <javierm@redhat.com>
> 
> s?!
>

Right.
 
> ...
> 
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
> 
> regmap.h ?
> err.h?
>

The regmap.h header is included in ssd130x.h and err.h in regmap.h.

> ...
> 
>> +	ssd130x = ssd130x_probe(&client->dev, regmap);
> 
>> +
> 
> Redundant blank line.
> 

Ok.

>> +	if (IS_ERR(ssd130x))
>> +		return PTR_ERR(ssd130x);
> 
> ...
> 
>> +	{ /* sentinel */ },
>
> No comma for terminator entry.
> 
> 

Right. I removed in one place bug forgot here.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

