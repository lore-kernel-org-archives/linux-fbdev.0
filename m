Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9A3C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Mar 2022 12:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiCIMy3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Mar 2022 07:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiCIMy3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Mar 2022 07:54:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0897C487E
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Mar 2022 04:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646830410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bHT0karyGRRNCWlLhVHNQSuvHWxMwLXpGfkux8ifP78=;
        b=WoV1SDspwTkuXdIYl4tHkWEr475mZtxZKGxb8Kuh7X7FP7RcA7xcM2s+t8vmT1r78taVHm
        3M9C5S5THbE5gMyZ4Ywyia7+0ZrXTKzEXLkVHIoTZAqachuZoNXieDxjWVZSe8HODKKAhK
        vQWPN2VJe42pqVSjxcBOP2WgTqzaVP4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-pIUc_mfIPvmP3MJc_CMI_w-1; Wed, 09 Mar 2022 07:53:28 -0500
X-MC-Unique: pIUc_mfIPvmP3MJc_CMI_w-1
Received: by mail-wr1-f69.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so729962wrg.19
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Mar 2022 04:53:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bHT0karyGRRNCWlLhVHNQSuvHWxMwLXpGfkux8ifP78=;
        b=bKHAZWuVtrZ7Hr+tFvvnIdkt9bm/69mNWSOkBie2sbKQhbQ2v+phAFEXIVMsvcbTLS
         Yz/ttwuoj0RU+3fJG9LCL91t4dWpY3CqI9+KT4NYbapRmy5epcyPPEiUXVHozf928dhb
         ++aKBEUlkVeqbjapoAMtEgl8Xf2xTAmG044wExpvj9P4uWIlbQKpXQAJoQfYlUH2pPtN
         9fJv99xYG5urVZCALziyc2uJoxtgv87bGdNCRaZjT2wi1bT7XKHmps1yHAhUieVPKP++
         0hXa5UdB+mANGvrsfrkBZZZcxbaHMxGtqOv2BAi9QcMQuZdKcu0zo+DqWK0Tz6T6p8O9
         Upcg==
X-Gm-Message-State: AOAM531IUHy1cCmQHX5JK/ddgIX/X6XCUzaWvEwrtzwHnYQN2ATvHpZZ
        +ELFnY9I3wHKw0dkCtYwaJ6wXKiknSIP78KKZsrmLUOLff5GSFRt4cuWvcP/BSmTY12Hte13f3z
        HZS3TbUkjcBkAMh1Nxm3NWRU=
X-Received: by 2002:a05:600c:4f8f:b0:383:d0b:3706 with SMTP id n15-20020a05600c4f8f00b003830d0b3706mr3328430wmq.117.1646830407595;
        Wed, 09 Mar 2022 04:53:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhA94T4hLNZGfPp9ZlHTC1cFNUMD4hfeN8kfLp3ziXcsrKaa2MDMubqSWEOGZcY5C6vhou4g==
X-Received: by 2002:a05:600c:4f8f:b0:383:d0b:3706 with SMTP id n15-20020a05600c4f8f00b003830d0b3706mr3328411wmq.117.1646830407398;
        Wed, 09 Mar 2022 04:53:27 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l25-20020a1c7919000000b0038999b380e9sm1663075wme.38.2022.03.09.04.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 04:53:27 -0800 (PST)
Message-ID: <7d9b2035-13d6-5d58-e21c-52bbb9282796@redhat.com>
Date:   Wed, 9 Mar 2022 13:53:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 04/10] drm/framebuffer: Use actual bpp for
 DRM_IOCTL_MODE_GETFB
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1646683502.git.geert@linux-m68k.org>
 <d87068fd1e2cc6f772a64ba9306350a31baeae58.1646683502.git.geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <d87068fd1e2cc6f772a64ba9306350a31baeae58.1646683502.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/7/22 21:52, Geert Uytterhoeven wrote:
> When userspace queries the properties of a frame buffer, the number of
> bits per pixel is derived from the deprecated drm_format_info.cpp[]
> field, which does not take into account block sizes.
> 
> Fix this by using the actual number of bits per pixel instead.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

