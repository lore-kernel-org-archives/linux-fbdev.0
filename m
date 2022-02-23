Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955E3C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 23 Feb 2022 18:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbiBWSNl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbiBWSNk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 23 Feb 2022 13:13:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 326F94831E
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Feb 2022 10:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645639992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95fZFgzFhUpzX6RItnD0JyQ0tqRlNULc6H8xcXm68i8=;
        b=UOnELPQL2ZfKHsGTrItV3CwtBJbrqOCi8DRTgPKg89hfqJ7CF0Nh3OC8OX6oyXt76OQPnR
        HOWJ+zMwb7VCRPxnTMbxf976xJ2LiwGfSqX7n/Fi1jGpxfkjt0pRBh1KRXFBdG1YnVat1+
        0Mxegy8uGQWZba45yLQntqJt9T0ZqP0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-T0gFCH5yOWGvYHpbSg-ZNA-1; Wed, 23 Feb 2022 13:13:10 -0500
X-MC-Unique: T0gFCH5yOWGvYHpbSg-ZNA-1
Received: by mail-wm1-f71.google.com with SMTP id r206-20020a1c44d7000000b00380e36c6d34so1467769wma.4
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Feb 2022 10:13:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=95fZFgzFhUpzX6RItnD0JyQ0tqRlNULc6H8xcXm68i8=;
        b=EopulEDI9RP5fXOpjHsexm6mt90CoUe97kZs+LzwuRWCXtVuzNZYlOgE89LXUm1G5z
         AlbWPvD/7szl9YUz1/OqtRmaOmEi3mdFM+T8RrYiW/7FUijCVrolggxl2K425T/vGcYm
         xVu8WvTAmXMaSCo4cb9sNlLe4RJr+hZf/rER2nws9nFvtFqbnSxPxxjqUQLhsSarcphg
         s5uBlTbAu1wfnYIn2ERJUDuEaI8xYYKLfVSvcBLIklAhlU27MsSmnAWPdT144/fPhgS7
         3QEoRWW3Ot6UYKUqXlWm36rHoeiFf2iV1XBawOCxktBF78lFIPLmnIOJ0x9jwkXipmGL
         Qbhw==
X-Gm-Message-State: AOAM533pgeSLIEVVtrauvbfRxAygMk/PB56NsrYBQtkkqmwc94tnZnPv
        aWIAYnbF9TjocIW3C4nbs+wo837RS0o+0NZQT9xV5tSrO9Mel1t+PX7mCmQpcrCEV0LVemy4/JN
        hMMuejUGeAingRHSg6uFyflM=
X-Received: by 2002:a05:600c:4b92:b0:380:e46c:c35 with SMTP id e18-20020a05600c4b9200b00380e46c0c35mr723229wmp.15.1645639989589;
        Wed, 23 Feb 2022 10:13:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+OMBA5FBflXxH1bgqITdjSzJn7yz73jIBRhiyyfuoGwM/4IaCFSE4PIcSUMEwpEBhJd4yHg==
X-Received: by 2002:a05:600c:4b92:b0:380:e46c:c35 with SMTP id e18-20020a05600c4b9200b00380e46c0c35mr723183wmp.15.1645639989344;
        Wed, 23 Feb 2022 10:13:09 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e7sm250125wrg.44.2022.02.23.10.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 10:13:08 -0800 (PST)
Message-ID: <a9df1753-8e3b-55bb-2dab-9e7aeaa52a8d@redhat.com>
Date:   Wed, 23 Feb 2022 19:13:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] simplefb: Enable boot time VESA graphic mode
 selection.
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
        Helge Deller <deller@gmx.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        linux-kernel@vger.kernel.org, linux-video@atrey.karlin.mff.cuni.cz
References: <a789e375-a23e-6988-33bc-1410eb5d974f@suse.de>
 <20220218160436.23211-1-msuchanek@suse.de>
 <33b80f9c-d54a-5471-a58b-7a783a7a9e5b@redhat.com>
 <20220223164528.GE3113@kunlun.suse.cz>
 <f832a836-b6ee-ffc5-6f83-86c9ba475400@redhat.com>
 <20220223171235.GF3113@kunlun.suse.cz>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220223171235.GF3113@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/23/22 18:12, Michal Suchánek wrote:
> On Wed, Feb 23, 2022 at 05:54:54PM +0100, Javier Martinez Canillas wrote:

[snip]

>>
>> Yes, that's what I tried to say. But your commit message says "To enable
>> use of VESA modes with simplefb in legacy BIOS boot mode" and that isn't
>> accurate AFAIU (unless you meant sysfb instead).
> 
>  config SYSFB_SIMPLEFB
>         bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
>         depends on SYSFB
> +       select BOOT_VESA_SUPPORT if X86
> 
> This to me means that it's simplefb specifically that requires it, not sysfb.
> More precisely SYSFB_SIMPLEFB which is the simplefb implementation on top of
> legacy BIOS.
> 

Ok, I see what you meant. The fact that simplefb is what's named to the part
of the sysfb driver that register the "simple-framebuffer" platform device
and also the name of the fbdev driver that matches the "simple-framebuffer"
is too confusing.

My point about the subject line remains thought, I would use something like:

firmware: sysfb: Enable boot time VESA graphic mode selection for simplefb

But I'll stop bike-shedding this. I don't mind if you keep the current line
and feel free to keep my r-b tag.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

