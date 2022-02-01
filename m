Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B891CC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Feb 2022 15:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbiBAPKy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Feb 2022 10:10:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234200AbiBAPKx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 1 Feb 2022 10:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643728253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xahi6KlHV6F4VQ/xZVlvC1YTaLt1tqgz8laoIFbavo4=;
        b=KnJs+m9WmWD2cDEpzquJb6QH4bop2cYJVnN632+2P9VWFq9NWNzZ5Op+rPk6E0y9R3F2U2
        x2WnzoW28rSIMkN2VssIXC/x40w0osyTmXQJZrZQnVcQc1Og8BysD4zTcqg3HQmHorh5B3
        gq4vmj+YWHKe1hhIKWJUo9f+sTBtj5c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-ZGsKlv9tP1mCTfiobFf88g-1; Tue, 01 Feb 2022 10:10:51 -0500
X-MC-Unique: ZGsKlv9tP1mCTfiobFf88g-1
Received: by mail-wm1-f70.google.com with SMTP id l20-20020a05600c1d1400b0035153bf34c3so1769755wms.2
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Feb 2022 07:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xahi6KlHV6F4VQ/xZVlvC1YTaLt1tqgz8laoIFbavo4=;
        b=6gW5yLnv8+AdY44HQ4sdXvP+RnpcMcxcqDw4xtZP5PIK0vu7fgBuVTX+5d9HCQO5VP
         OR3M4PLYawl+cgdErX81fvGRKU+e/760qP1l+rVpzTktKjB8lkYnzvVcFmGyUZh+z3Z0
         SmUZZ2oL0z3sw0HUJdIv3Li69jwPaku6YwRBSGMKegtEBXR+lAz30C7DZR6cezzbQLVN
         xju5OuQoejpKNnIC0hN3xWtGQH17QuUFNHi13GHDvwouRYnc3ciOVHq3mgDTc1UfW4+5
         nzvBb1z2zH3ZlAQRC8pzvP+b7tJqXmHzxWxA/Lk0Azw8RJWtXBn/17eFHZPXQoV239MB
         +fZg==
X-Gm-Message-State: AOAM532ZU6lacxMwNSxYlKk7Vpyp911dsxkovqr+0tyQvU8D6VPP5be4
        tJuJKEObR6Q9hi4jSSQ04RhadPebRkV0ZHRvhIF43mapyFkPazonAvZ5JsDMAHvS0tKXt05mfqu
        ZXLdvkiFbhEBX/LCdTA5XRh4=
X-Received: by 2002:a05:6000:1a8c:: with SMTP id f12mr11663239wry.153.1643728250668;
        Tue, 01 Feb 2022 07:10:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdwGp2Pak+qnkxqFSHlJ5WHAuF3l8gqYjbIl9n8aNA5CLl+rlgxDBFzggA+hPhyEXVYtJztA==
X-Received: by 2002:a05:6000:1a8c:: with SMTP id f12mr11663221wry.153.1643728250430;
        Tue, 01 Feb 2022 07:10:50 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x4sm15296308wrp.13.2022.02.01.07.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 07:10:50 -0800 (PST)
Message-ID: <b4fe0d36-c4ef-6f7e-e47d-f98f6055ea92@redhat.com>
Date:   Tue, 1 Feb 2022 16:10:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>
References: <20220131202916.2374502-1-javierm@redhat.com>
 <YfhVBtv1UIA7bJja@ravnborg.org>
 <3aac291a-b30e-2775-336f-66dd08d634e2@redhat.com>
 <YfkA4ER/52I2v1JP@smile.fi.intel.com>
 <9ddd8a8c-4aa9-bc4a-5637-66197a7342d1@redhat.com>
 <Yfk9fuazUSgI6C9n@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Yfk9fuazUSgI6C9n@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/1/22 15:02, Andy Shevchenko wrote:
> On Tue, Feb 01, 2022 at 12:45:53PM +0100, Javier Martinez Canillas wrote:
>> On 2/1/22 10:44, Andy Shevchenko wrote:
>>> On Tue, Feb 01, 2022 at 01:14:22AM +0100, Javier Martinez Canillas wrote:
> 
> ...
> 
>>> The problem with no backward compatibility means that removal of old driver
>>> makes users unhappy since DT is kinda ABI and we do not break it.
>>>
>>
>> I think that's the crux of the issue. Do we want people to update their
>> kernel but using their existing Device Tree and be able to switch to the
>> DRM driver ?
>>
>> My take is that we should and that's why I kept the backward compatibility.
>>
>> Maybe we could do that in the meantime and at some point introduce new DT
>> bindings (with a different compatible string) that would use the latest
>> and greatest conventions in DT ? That seems to be a good compromise.
> 
> I have over-read in this discussion that current binding is not fully
> correct from hw perspective. If it's indeed the case (and I believe it's),
> then probably we should come with brand new driver with ssd130x name and
> incompatible bindingas (*).
>
> Otherwise in this driver we continue to be incorrect in them.
>

See the comment from Geert. I believe we should use the existing binding.
 
> *) But even though I think it would be good if you take the old one under your
>    maintainership.
>

Sure, now that I got familiar with the ssd130x devices, I'll be happy to
help with the ssd1307fb driver maintainership.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

