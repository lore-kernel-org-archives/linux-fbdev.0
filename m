Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E122C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Mar 2022 14:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbiCGOeT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 7 Mar 2022 09:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiCGOeS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 7 Mar 2022 09:34:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3213339150
        for <linux-fbdev@vger.kernel.org>; Mon,  7 Mar 2022 06:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646663603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BqBsilqCKDCrxnxeJqaARCUBXf202zo2/T5FUy2wzuY=;
        b=Of7s3S4cj9ow7uZoPlKnfmpowKYTm4bjKtXS+wX0wvXP8F7MNN25lcr/erFAnGDEuyRFHA
        QyadDTVTBbBJn9lmofuZZCRDGu/My6FiAI5SCbn3hc2w4/zmblhrbbziUOd28tqI6cE0ON
        YzlYBshSApaqKLFRx5fDKT8HcNjWW98=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-vVyFpOqJOuqZ0M_wej5xqA-1; Mon, 07 Mar 2022 09:33:21 -0500
X-MC-Unique: vVyFpOqJOuqZ0M_wej5xqA-1
Received: by mail-wm1-f72.google.com with SMTP id v67-20020a1cac46000000b00383e71bb26fso5183505wme.1
        for <linux-fbdev@vger.kernel.org>; Mon, 07 Mar 2022 06:33:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=BqBsilqCKDCrxnxeJqaARCUBXf202zo2/T5FUy2wzuY=;
        b=jtfnqZdorOkEyeQoMm6RYtvBpQ39U2np/DeRYDdqHHTvoVi5V9JhjoLhIoURqRVH8W
         UtpOlY8qGfXxQ6IhA8wiw7GrAm+6l/Gu+CCGCG6n0aOY5ikkl/4GNUyo66I6e6BbsLtl
         VtFu28RS0EQvFpWKet5pi2Jk/7aJVpl0odkxNJG9EI2/jHf9fFFNgxkv2ImHYzX+RyTJ
         JXIW0/oQznB0YA2gnPbLZvkEz2etvQnfYSQXV3BjzjEpUoXqeJlYXohsM+va7eu2Xn/x
         SObd/jZMxXvpWkRtb6bGv5bs2lSj+Mre90I8ogqHVEYgBrn007JEtFYUoqpySwHyCQLE
         3TNg==
X-Gm-Message-State: AOAM532pX5WAVtjlLflmCiF2wMbEqFK7yrM3FFxwZoVczNUQ5c0sbBDn
        Nif6F+6s8qG2iDFC6YqTacGdPKhCcOhqO0YzzcgzRiKm9B3N917T3kMwDG52SF1k7MO58LVCeAv
        MN88UFWCXbp4AHGkVdYDH9f4=
X-Received: by 2002:a7b:c154:0:b0:388:8e6e:ff76 with SMTP id z20-20020a7bc154000000b003888e6eff76mr9711125wmi.191.1646663600073;
        Mon, 07 Mar 2022 06:33:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfRVYkTxAcRn47Pfs4K6l3yvxYBhJf4kPwPZnm8FvG7VYk1WZXxsFh62kxfrGjwDoyNK0tCw==
X-Received: by 2002:a7b:c154:0:b0:388:8e6e:ff76 with SMTP id z20-20020a7bc154000000b003888e6eff76mr9711104wmi.191.1646663599814;
        Mon, 07 Mar 2022 06:33:19 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l18-20020adfe592000000b001f064ae9830sm9837404wrm.37.2022.03.07.06.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 06:33:19 -0800 (PST)
Message-ID: <9982c5a7-9715-7cdd-59be-8f27a65f32bf@redhat.com>
Date:   Mon, 7 Mar 2022 15:33:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] simpldrm: Enable boot time VESA graphic mode selection.
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     linux-fbdev@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-video@atrey.karlin.mff.cuni.cz,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Maxime Ripard <maxime@cerno.tech>,
        "H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Mack <daniel@zonque.org>
References: <20220218093334.24830-1-msuchanek@suse.de>
 <354f3cfd-bfa0-3ebe-3d67-705423d9294e@suse.de>
 <20220302193846.GT3113@kunlun.suse.cz>
 <2ba8497f-ba6d-558b-d782-bb3ee67d23ec@redhat.com>
 <81f87874-4aa8-265d-a0ed-c8a67708a92a@suse.de>
 <8d1c3caf-96ad-ae4c-021e-ac38f179dfcb@redhat.com>
In-Reply-To: <8d1c3caf-96ad-ae4c-021e-ac38f179dfcb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/4/22 21:47, Javier Martinez Canillas wrote:
> Hello Thomas,
> 
> On 3/4/22 21:00, Thomas Zimmermann wrote:
>> Hi,
>>
>> I've merged the patches into drm-misc-fixes. Thanks a lot to both of you.
>>
> 
> Ard already picked these through the efi tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/
>

I talked with Ard and he kindly dropped these patches from the efi
tree. So everything is fine.
 
>> Best regards
>> Thomas
>>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

