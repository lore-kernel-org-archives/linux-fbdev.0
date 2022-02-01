Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6E4C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Feb 2022 11:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbiBALRk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Feb 2022 06:17:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236983AbiBALRj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 1 Feb 2022 06:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643714259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vjw//fLkAQ84TIDAJkx8fTRjA3gXymjff0vArIKpGDA=;
        b=R8+z0Hg5S4kdg+0BcfbBfd0XcQtTDbiS6G/flwcOkL5YDe+4t/HU+Xrq0W5myQPHdGY1fy
        RpEwpdVEKGESqjSUQW7P6KYptyeD8UHmskS533ieAjCZnglJVEpTMTHH8GTGBJC6fPYuCr
        MJhUxnMdO2lQrrpy+M9wI+JHzMIdrG8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-C8X3VZR8N2qG0S2XvE1Tnw-1; Tue, 01 Feb 2022 06:17:38 -0500
X-MC-Unique: C8X3VZR8N2qG0S2XvE1Tnw-1
Received: by mail-wr1-f69.google.com with SMTP id k12-20020adfe3cc000000b001d6806dfde1so5857516wrm.16
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Feb 2022 03:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vjw//fLkAQ84TIDAJkx8fTRjA3gXymjff0vArIKpGDA=;
        b=0uk84royfQfYoFPd1AB5IvaRwgXteJRkCQy87spmKhwO/9CXexi+zR3sXFS3Z5SUSD
         SXE40AyOhw0Osfswv38X08BwEY9FxwgODOKk7TyfuXYMlszcwPQw9vDNfKjfjtopBKb7
         t91qr4niTHHmGzLH9BAHJ2bERxKRK8hYfM5Sng6GtmohqpedE1QjujQUffMLq8rPO/Zf
         Xo9FDOcYxoQf0DzPDe85Fftz+ZmnaRPgRReWLlY/qZgBQYDKVFV1t9fXVj8hS3i9J6vX
         35Kr8BfpeTIX6Cz6s+4DDPqBipaWM3o41l+p6D6sq5fvC+SHc4UzQhIxAJjSUoJbqwRB
         aGKg==
X-Gm-Message-State: AOAM531eb4sLiNQh8L2ZszuP5lbBlkC2t3A6oB9NgXJYEImDomHbGESz
        xrbwcDSauAoKEr8hzPN4FQXZ/rWYJFXL/4FiJdw4kexzt21ONNQxHDURCwgwo75AKWjx2A/izf9
        t3u6zxGbw8+iIvFfjRsyTVYQ=
X-Received: by 2002:adf:f045:: with SMTP id t5mr21095373wro.385.1643714256622;
        Tue, 01 Feb 2022 03:17:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbcg9U2rYIsyfcakZ9zSjonoBgrdJ/oOcSUdMbVuNhLqDn/9NnvNfRqe0QXRW90Ej8ByOWhg==
X-Received: by 2002:adf:f045:: with SMTP id t5mr21095354wro.385.1643714256365;
        Tue, 01 Feb 2022 03:17:36 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p7sm1824109wmq.20.2022.02.01.03.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 03:17:36 -0800 (PST)
Message-ID: <273132fb-cf11-93a6-6bfd-3cc8b19f8fa9@redhat.com>
Date:   Tue, 1 Feb 2022 12:17:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] MAINTAINERS: Add entry for Solomon SSD1307 OLED
 displays DRM driver
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220131201537.2325487-1-javierm@redhat.com>
 <Yfj+FOELlbtdhvRa@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Yfj+FOELlbtdhvRa@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Andy,

On 2/1/22 10:32, Andy Shevchenko wrote:
> On Mon, Jan 31, 2022 at 09:15:37PM +0100, Javier Martinez Canillas wrote:
>> To make sure that tools like the get_maintainer.pl script will suggest
>> to Cc me if patches are posted for this driver.
>>
>> Also include the Device Tree binding for the old ssd1307fb fbdev driver
>> since the new DRM driver was made compatible with the existing binding.
> 
> Dunno why you have patches 3 and 4 missed references (in terms of email
> thread).
>

Yeah, I use the patman tool [0] to post patches and something went wrong
after sending the first patch and I had to manually post the others with
git-send-email. I could had used --in-reply-to, but didn't feel like it.

[0]: https://gitlab.com/u-boot/u-boot/tree/master/tools/patman
 
>> +DRM DRIVER FOR SOLOMON SSD1307 OLED DISPLAYS
>> +M:	Javier Martinez Canillas <javierm@redhat.com>
>> +S:	Maintained
>> +T:	git git://anongit.freedesktop.org/drm/drm-misc
>> +F:	Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
>> +F:	drivers/gpu/drm/tiny/ssd1307.c
> 
> I think it makes sense to add ssd1307fb as well. At least you may point out
> people patching old driver about new one until it's gone completely.
> 

That's a good idea. I also found some issues in the ssd1307fb driver when
doing the port, so I could dig more to fix them and propose myself as a
co-maintainer for the fbdev driver.

But I'll do that as a separate patch-set.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

