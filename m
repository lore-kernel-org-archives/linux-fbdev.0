Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724CBC433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 25 Feb 2022 22:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbiBYWLa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 25 Feb 2022 17:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbiBYWLa (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 25 Feb 2022 17:11:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42F5652E20
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Feb 2022 14:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645827056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WAHJITj5STzbbuF37W0DjncfQl4DVrBRuJjULvPB2II=;
        b=KakMYWeBJKAPIieALCo6RK6sFeEvcMCQaxPP7QjBZbaI0yCYvE0Z0m19SLOWMBIWotiP6b
        CuKxh9ghaQhVsdisCARimP8Vt3C1EjYUuVe4SQ38XANZWXusacJSr39DkPfr0zGxwvQ2Hv
        UKgCVFVBy6kzGXqmtu9IzsIC+VnuERA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-vbmnrD6dNbSGjbNysY7JHw-1; Fri, 25 Feb 2022 17:10:55 -0500
X-MC-Unique: vbmnrD6dNbSGjbNysY7JHw-1
Received: by mail-wm1-f72.google.com with SMTP id f189-20020a1c38c6000000b0037d1bee4847so2229132wma.9
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Feb 2022 14:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WAHJITj5STzbbuF37W0DjncfQl4DVrBRuJjULvPB2II=;
        b=oyUEDZOqQs2Gs+Qt2FOKYBkuFP3kmNOmk1GHWFyiqbblTAXi3lttLIrqTXjbvq1D0R
         VD4W6I04hrzCaeIMWfXp8Z8xDlAoXICPuo/mfv/xGEJ2QlW/txPSRDXhKuwKjza2T8G/
         Yld+0cgAgPktkVhifnV7aZk4zcr/5uXGVEXk9iCyjbzBpWrk4Dle47X0HnUVVCRPSuOp
         AGI6vt6dINmq5JuKG6hbIt0ebP4SYa1aB8o/ypsXA0louZkeHa28JFZZJ4OESyB29QjD
         id18Qfh1LfpvGkeRglz93cnCqnKQkTEbjALbB5qE6JkvxuEBxxleRsEf1dq7liljLKbQ
         IkxA==
X-Gm-Message-State: AOAM532LfPZDh7ZuiEVRRImw1eflFf5z/agllZ93iNpnFgPthLiVJabu
        eP9RphqxxOM7nTiX0LhBa2kNKLFtqXFelm8csIfgFg4MJnNb5dMINOVkltQdGTxfBrt/NOfb9tI
        8S/ZPEfEXnfsbWDTo1a7hiTk=
X-Received: by 2002:a05:600c:1592:b0:381:21b4:d1d8 with SMTP id r18-20020a05600c159200b0038121b4d1d8mr4424281wmf.119.1645827053953;
        Fri, 25 Feb 2022 14:10:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAHm39sLaSq2pOYdrWxQg66pEwR/Bg1+VCOw5sY82fSKXIkbndkrbvrCZ8Q8iJZV1EJ/AdAQ==
X-Received: by 2002:a05:600c:1592:b0:381:21b4:d1d8 with SMTP id r18-20020a05600c159200b0038121b4d1d8mr4424269wmf.119.1645827053705;
        Fri, 25 Feb 2022 14:10:53 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x3-20020adfdd83000000b001e58c8de11bsm3544558wrl.39.2022.02.25.14.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 14:10:53 -0800 (PST)
Message-ID: <ae441f09-3d63-a731-fe59-06b8aafa0983@redhat.com>
Date:   Fri, 25 Feb 2022 23:10:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/3] sysfb: Enable boot time VESA graphic mode
 selection
Content-Language: en-US
To:     Michal Suchanek <msuchanek@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
        Helge Deller <deller@gmx.de>, Ard Biesheuvel <ardb@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        linux-kernel@vger.kernel.org, linux-video@atrey.karlin.mff.cuni.cz,
        linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>
References: <1f13e6f2-a87c-83ac-7119-8632c8c8ac8e@redhat.com>
 <948c39940a4e99f5b43bdbcbe537faae71a43e1d.1645822213.git.msuchanek@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <948c39940a4e99f5b43bdbcbe537faae71a43e1d.1645822213.git.msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/25/22 21:51, Michal Suchanek wrote:
> Since switch to simplefb/simpledrm VESA graphic mode selection with vga=
> kernel parameter is no longer available with legacy BIOS.
> 
> The x86 realmode boot code enables the VESA graphic modes when option
> FB_BOOT_VESA_SUPPORT is enabled.
> 
> This option is selected by vesafb but not simplefb/simpledrm.
> 
> To enable use of VESA modes with simplefb in legacy BIOS boot mode drop
> dependency of BOOT_VESA_SUPPORT on FB, also drop the FB_ prefix. Select
> the option from sysfb rather than the drivers that depend on it.
> 
> The BOOT_VESA_SUPPORT is not specific to framebuffer but rather to x86
> platform, move it from fbdev to x86 Kconfig.
> 
> Fixes: e3263ab389a7 ("x86: provide platform-devices for boot-framebuffers")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Acked-by: Borislav Petkov <bp@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

