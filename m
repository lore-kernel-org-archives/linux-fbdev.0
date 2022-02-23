Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B096FC433FE
	for <linux-fbdev@archiver.kernel.org>; Wed, 23 Feb 2022 16:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242827AbiBWQfZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 23 Feb 2022 11:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242830AbiBWQfY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 23 Feb 2022 11:35:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74534527CF
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Feb 2022 08:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645634095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=clONYmZ5X2qlfrfzJXRhqvS1L3/caQ4kzeJBK6mGohk=;
        b=ercBwKn+MFV+8vGY1W14XWigiUxu3lmI55faiI5FSDPo/OBqeFHtVzp+AEl2MfahEbsauw
        yqThiG67o+oR5AfU+Y7Vyl9DZrmbYRoBTQAmhkZwK7W+bGgG7KE0BU45RGL/B6y8eJw/v4
        bcGWHzuUuHKkZdy1FQZJpinOs/Ci5Rg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-DncLIHvuOaOgoCWCIGjKzA-1; Wed, 23 Feb 2022 11:34:54 -0500
X-MC-Unique: DncLIHvuOaOgoCWCIGjKzA-1
Received: by mail-wr1-f69.google.com with SMTP id m3-20020adfa3c3000000b001ea95eb48abso2321898wrb.3
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Feb 2022 08:34:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=clONYmZ5X2qlfrfzJXRhqvS1L3/caQ4kzeJBK6mGohk=;
        b=iJPn1cm+kIzJi/RZRBEZEz6MybloG0xYV5ARP1/PUUaTB0yC0mgQ8KbvQrUlHI+x0S
         sFKFc50yRJRY3vER8KvWu+IuW80nwMqnHyoQmzxOddmIemtcaWsZb0pze9Al1MixiflV
         +HnTO5vZc5Z/Kc+rEtUMFbOTGXAsfvY4Z97ay5p/arf19viMN9degI5XZ2Q9b8Oc95+L
         EPJGN8sn6UkRCaYS45d6E8yLud+H75to6kgb4MPEyKIDV+/IvHp0NIEgMpUq9o+H22+z
         4cRl4DD80QBZZZ+dSaXA6vouC5R3wxDEzKmWyKjb7a0BD+xzjKAvd+Jy5ZxlYwDDKyIA
         k7Og==
X-Gm-Message-State: AOAM530onqBZEY02Z4RRc7FNCEqrqvbj6Rix7YlKS0Hf9oIBOH+b/H0z
        bQvdbSJCR6JdZyFNjAzV7anFP8iInppZISLGQfsJKmTT7dr14vpuKQPnw7NaXVk2cfEFg2Sbuez
        QM4VOXs9DjfMhd/KvqRYOpdQ=
X-Received: by 2002:adf:e544:0:b0:1ed:b6d5:d26b with SMTP id z4-20020adfe544000000b001edb6d5d26bmr327967wrm.634.1645634093125;
        Wed, 23 Feb 2022 08:34:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBzj3eVsLKn39DYPTvyzPcJE9MCfAnVshf1YYTW2KZMiRN8LC5w3bIaIsgJsQ3ygOVbXPktQ==
X-Received: by 2002:adf:e544:0:b0:1ed:b6d5:d26b with SMTP id z4-20020adfe544000000b001edb6d5d26bmr327942wrm.634.1645634092830;
        Wed, 23 Feb 2022 08:34:52 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a1sm40095wrf.42.2022.02.23.08.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 08:34:52 -0800 (PST)
Message-ID: <33b80f9c-d54a-5471-a58b-7a783a7a9e5b@redhat.com>
Date:   Wed, 23 Feb 2022 17:34:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] simplefb: Enable boot time VESA graphic mode
 selection.
Content-Language: en-US
To:     Michal Suchanek <msuchanek@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220218160436.23211-1-msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Michal,

On 2/18/22 17:04, Michal Suchanek wrote:
> Since switch to simplefb/simpledrm VESA graphic modes are no longer
> available with legacy BIOS.
>

Maybe you can mention that is the "vga=" kernel command line parameter
since that may be more evident to people reading the commit message ?
 
> The x86 realmode boot code enables the VESA graphic modes when option
> FB_BOOT_VESA_SUPPORT is enabled.
> 
> To enable use of VESA modes with simplefb in legacy BIOS boot mode drop

I think you meant "VESA modes with the sysfb driver" ? or something like
that since otherwise it seems that you meant to use it with the simplefb
(drivers/video/fbdev/simplefb.c) fbdev driver, which doesn't support the
"vga=" param as far as I understand (it just uses whatever was setup).

The name sysfb_simplefb is really horrible, because it is too confusing
and probably we should change it at some point...

Patch itself looks good to me though.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

