Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D09C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Feb 2022 08:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245122AbiBBIqK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 2 Feb 2022 03:46:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233262AbiBBIqG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 2 Feb 2022 03:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643791565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+t98WKUfmAfPmDThATdXX8CTJNH50fOldGy238DTDyQ=;
        b=IJSKlgjLlk0t3JkyAJDPQ2r+xsJ45q0E22jopbQP+pmzu+ey5h4MyYpvnbGW+GQwwT6mZh
        0tgxYDArIKDs20VmMVQRn1AEqen6IivkEfAX9amkBut0SkKLs3uvRFHHXQgyQFybCRrvl6
        vnD90EOE4+0/mE/BPsl2fz6J/y1nfhU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-5nO-K7EHPd-oop7j7IMFFA-1; Wed, 02 Feb 2022 03:46:04 -0500
X-MC-Unique: 5nO-K7EHPd-oop7j7IMFFA-1
Received: by mail-wr1-f71.google.com with SMTP id c9-20020adfa709000000b001dde29c3202so6627894wrd.22
        for <linux-fbdev@vger.kernel.org>; Wed, 02 Feb 2022 00:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+t98WKUfmAfPmDThATdXX8CTJNH50fOldGy238DTDyQ=;
        b=fkfap4g+BH0M1FWe7pQH3r4H2x3yQysobqjMhbgSxZR5qxFk2fKS/fXmV/8ZuYFrlJ
         tZfN1w3VcfyY9AObA7iTmiG6dI7P3uycHYCRMc3V9r5/QeidRI9jLpQ4vrmUmDDWG0Cy
         Gei/eLsR/MZTVsltoENbMn83F+MBnvprnL6hm+ZFU+rwaDjynDQkc7BicNt1VrB/C8q2
         AEDlLFcuZZf1/YhURhkkHw1yqCwIqkEyuBZn23jeEznMJciUZyc/jk8iSQHZzcLSvkRZ
         g/w71NI2oxLkHX+9uk62JtxdSpFDd6Dh7xM99+rLUUtCyTxEPe5IgI4E9CtEw32JxNUm
         fzDQ==
X-Gm-Message-State: AOAM533986ohNdDeaiVURy6n5MOWbkkhYAKmvuQnU2qQ1FdGkd1RkizY
        Bm84PsHYXWtD9Tk5FaxuwLL54mUSNwvUXZaGtSB2vJvlf4i5feAEknMR8Mr8RzrcWyg4TJUB1AO
        ouyIuOud50OaeWaOTQZTzXs0=
X-Received: by 2002:a1c:ed12:: with SMTP id l18mr5135963wmh.93.1643791563288;
        Wed, 02 Feb 2022 00:46:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOc8cdyaslolsIIxQodJLho1aNIKNdP+8hs8Kq/JhdZJPYGQq4WH3NEN3pv9foMaQLLMG8PQ==
X-Received: by 2002:a1c:ed12:: with SMTP id l18mr5135948wmh.93.1643791563135;
        Wed, 02 Feb 2022 00:46:03 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y14sm18994810wrd.91.2022.02.02.00.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 00:46:02 -0800 (PST)
Message-ID: <570d4384-b838-2bf6-1ff5-f8956ba7cee5@redhat.com>
Date:   Wed, 2 Feb 2022 09:46:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] drm: Add I2C connector type
Content-Language: en-US
To:     Simon Ser <contact@emersion.fr>, Sam Ravnborg <sam@ravnborg.org>
Cc:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <20220131201225.2324984-2-javierm@redhat.com> <YfhMESTylI1NTKDg@ravnborg.org>
 <4d9a56a7-da25-b411-61cc-372c6fa9011d@tronnes.org>
 <YfmeztkVXwZzAwYe@ravnborg.org>
 <0yOiGD-56rTdV--oDietLeMO46Z8iFNnCNVVRg3Yh9D13AghGCYm5aP67SoswHY7Ye3vc3UEKzgtI02-F6vJ4b5xGLlE5yg6n2HznaWzYvg=@emersion.fr>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <0yOiGD-56rTdV--oDietLeMO46Z8iFNnCNVVRg3Yh9D13AghGCYm5aP67SoswHY7Ye3vc3UEKzgtI02-F6vJ4b5xGLlE5yg6n2HznaWzYvg=@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/1/22 23:29, Simon Ser wrote:
> On Tuesday, February 1st, 2022 at 21:57, Sam Ravnborg <sam@ravnborg.org> wrote:
> 
>> As I wrote in another part of this thread(s) - typing the patch is easy.
>> But I do not understand the userspace implications so I need someone
>> else to say go.
> 
> User-space shouldn't really use the connector for anything except making it
> easier for the user to understand where to plug the display cable. I think a
> generic "panel" connector type makes sense.
> 

I'll drop this patch from the series. I didn't have all the context and thought
that was an opportunity to add an I2C type, since there was a SPI type already.

But seems to be more controversial than I expected and shouldn't really matter
for a tiny driver like this. I will just go ahead and use the Unknown type.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

