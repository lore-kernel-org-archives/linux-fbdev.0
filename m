Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F215C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Feb 2022 17:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbiBIRFU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Feb 2022 12:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbiBIRE4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Feb 2022 12:04:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85258C050CD3
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Feb 2022 09:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644426298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5nGt1sk91AWrErDudwLdxz09p1Z/A3GC5vPQgc/7QHA=;
        b=fn4rjVms3TvKhIry+agCcOHNRr3YekAFd0CIcsuMyFVdM8OolKRvpopPix+62dxTCmUVNo
        d3RR2NdXXOS22ES1z6RdcQzingKRM9IwxAXM7wcyq/le+8kt11Z55ZwML/kE63EM9Iau1E
        kcingd9mpXqG5FQcMZvt0jjAMEnuXM0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-c9QxX-W6N0KSiLbTp5yUJw-1; Wed, 09 Feb 2022 12:04:57 -0500
X-MC-Unique: c9QxX-W6N0KSiLbTp5yUJw-1
Received: by mail-wm1-f69.google.com with SMTP id g22-20020a1c4e16000000b0037bc7a977b3so284093wmh.5
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Feb 2022 09:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5nGt1sk91AWrErDudwLdxz09p1Z/A3GC5vPQgc/7QHA=;
        b=kr98TqiAQ3NDFVnkRit0gnN/zPIzdsPlERxYxxkwOrjmXrs2S1/hihRBJzkeSTg3P5
         y+SvUlqTqo4oMjBEoSFDPG3ApOkeaUvtlul2DDXfDcQNJns5PFBrbbJaRJiqYjw+Wo7W
         zAy/AbB5wH94hKGkLUADOvBmQRx18mxmvHsGHmQ7fqOWdB3DO3OAdU3TSsKrDepqVpH/
         Wtbu4rKLvj7+jrpI/bm7XtKAvWbaxvJJu6/OiBkBYUOhq2ZuIlW04qM7uKxI8IAd4Tgd
         2mBMooZist6SJSrn2s5Vn+9z/Y5snwk0st6AU7rdicuD/YGSjkM/Z8IRzl9oxqLOzW4w
         STOA==
X-Gm-Message-State: AOAM533h13QqObfzjZlqsE9Zj4q7YsoRWtm0gj+os9ampGoxCtTLWhCM
        NZhdyvfWcUDW9VFBEh9klE20dxX04fuia9WADtWM6GZvmN5P93DU5JkiVZMFO/AiM7kdB+nXKZ8
        8o0RLyxaLhDr2xCtfgOgFUZQ=
X-Received: by 2002:a5d:52c9:: with SMTP id r9mr2859440wrv.449.1644426296219;
        Wed, 09 Feb 2022 09:04:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxz9gThGzXLX/giWr/W1JvBYUZrrvATgUCuQX0yG/Chw7zuZKfaPye67aCPQ6VfuNzsiGcx7w==
X-Received: by 2002:a5d:52c9:: with SMTP id r9mr2859414wrv.449.1644426295970;
        Wed, 09 Feb 2022 09:04:55 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o14sm5276066wmr.3.2022.02.09.09.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 09:04:55 -0800 (PST)
Message-ID: <46b671fd-3929-4cf0-1e0d-5f6305464238@redhat.com>
Date:   Wed, 9 Feb 2022 18:04:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 5/7] (WIP) drm/solomon: Add SSD130X OLED displays SPI
 support
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209091204.2513437-1-javierm@redhat.com>
 <CAMuHMdWSDBjpYJv6JtgvyaKiFKh_eqbvH78TR6VBtpDeFJvqFQ@mail.gmail.com>
 <YgPbAL0I8Wn7nnNb@smile.fi.intel.com>
 <d32c731b-c06f-2dcb-5a6d-1a84351719b2@redhat.com>
 <CAMuHMdXsAyp18ivtSe-ZVmu6xbBBnvjMuZ=H1w9Gk=Ys4rkCeg@mail.gmail.com>
 <YgPuy1QVv9A7rcCh@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgPuy1QVv9A7rcCh@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/9/22 17:41, Andy Shevchenko wrote:
> On Wed, Feb 09, 2022 at 05:25:03PM +0100, Geert Uytterhoeven wrote:
>> On Wed, Feb 9, 2022 at 5:07 PM Javier Martinez Canillas
>> <javierm@redhat.com> wrote:
> 
> ...
> 
>> Are they all broken?
> 
> I guess it's incorrect question. The one we need to ask is is OF code broken?
> B/c ACPI can easily cope with this (they are different buses, can't clash).
> 

Yes, it's a problem specific to OF. It works correctly with both ACPI
and legacy platform code.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

