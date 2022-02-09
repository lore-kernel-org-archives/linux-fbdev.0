Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34D1C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Feb 2022 16:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbiBIQKp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Feb 2022 11:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236618AbiBIQKp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Feb 2022 11:10:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF556C05CB82
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Feb 2022 08:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644423047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mFGitWE2+XjLxofbVGLQx4GJSy8OuJZkaSySeP1Crog=;
        b=PrQ3nyEj05s+rxbynfplFuIKpZjIjN+rmuHKy5NVQQIfoNr3Ypcku9XGVct8KqCv4QFhQ5
        EJhEFrPNo4Waay/7ZqrEFESgFQPay/rCk32ToC8dRoucaQJxxKpSPoxn4Y8/x64GZV8JPq
        DFxCLXNUWtNu02mU2LtcHLwawLLEh1g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-QgTMxZGtNyeVjbj8a3Qyrg-1; Wed, 09 Feb 2022 11:10:45 -0500
X-MC-Unique: QgTMxZGtNyeVjbj8a3Qyrg-1
Received: by mail-wr1-f71.google.com with SMTP id j8-20020adfa548000000b001e33074ac51so1288612wrb.11
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Feb 2022 08:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mFGitWE2+XjLxofbVGLQx4GJSy8OuJZkaSySeP1Crog=;
        b=MFAuGkwxMPAOgXt/Ic0GaNnvERYP6rxmxnMlWMFIpn6k1eP5ntlfJ0R0/bXQipPAvg
         bwkKEKQqjeKoOYQnO7Pi1UxWS7tITLeEuUR7bTKgrMDxxUh0/shjSOhUELLPcAWPezJ3
         86MkVt7I1FCaMIWURYPSXi9D4WKqadhMW54yXbMMoa26livMG+AkYAiV6jmW5xI2Zf8K
         zYCuHk4ZHhRr5Az5WhDN7tEGhCwOthDPp72an1U4Bl2HCTH6ka/NzBT+6U0dfZOC66WE
         lk2Di8t6D0TbjiTE8W0zZQzIcHhyWSDVdMGH8OEi3VK2c36nQLRgNymfQg4nll+aV41w
         xd3w==
X-Gm-Message-State: AOAM5337CFY1q2sM36Ihq7PAuBWAmHkRw/gyJnHzmWxcYmoC9VHNILBq
        cZz9nMfhjH4Bal5PSBRXZVwFrOTUyRCSOfXNX2ywAAQQ5so88d3Yf6vzM8MqMv6O7/c9ppzk86N
        WE0zMnlchTD8Xh5vypl/ct0Q=
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr3214211wmq.44.1644423044644;
        Wed, 09 Feb 2022 08:10:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3zGpKODhlGXZHF/WUPS4W/m1RBSXDfqzPUnuyKsIXdGF/OBtwjUhqThnva+EpdQTtV3YvBQ==
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr3214181wmq.44.1644423044396;
        Wed, 09 Feb 2022 08:10:44 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c18sm6654588wro.81.2022.02.09.08.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 08:10:44 -0800 (PST)
Message-ID: <ee81dc1f-2a45-9113-f1fb-47ef226a0da5@redhat.com>
Date:   Wed, 9 Feb 2022 17:10:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 5/7] (WIP) drm/solomon: Add SSD130X OLED displays SPI
 support
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209091204.2513437-1-javierm@redhat.com>
 <CAMuHMdWSDBjpYJv6JtgvyaKiFKh_eqbvH78TR6VBtpDeFJvqFQ@mail.gmail.com>
 <e6efb2fd-300e-5282-1f2e-a68130d0b45a@redhat.com>
 <YgPbleB+LAQ5ZXyB@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgPbleB+LAQ5ZXyB@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/9/22 16:19, Andy Shevchenko wrote:
> On Wed, Feb 09, 2022 at 02:04:17PM +0100, Javier Martinez Canillas wrote:
>> On 2/9/22 13:25, Geert Uytterhoeven wrote:
>>> On Wed, Feb 9, 2022 at 10:12 AM Javier Martinez Canillas
>>> <javierm@redhat.com> wrote:
> 
>> Yes, I know. Didn't feel like it, because the patch is a WIP anyways
>> (I haven't tested it but was included just for illustration purposes).
>>
>> If someone confirms that works then I will include a proper DT binding
>> in the next revision.
> 
> In a few weeks I hope I can do this.
>

Thanks, there's no rush. I just included this for your convenience because you
mentioned that have an display with a SPI interface.
 
> But you know Linux is almost always broken (*) on the certain embedded device
> if nobody keep an eye each rc cycle. It might take time to return it in shape
> first.
> 
> *) Speaking out of my own experience with device(s) that I possess.
> 

Unfortunately that's my experience too. I'll keep this patch in the series and
marked as RFC. But in v4 will extend the DT binding to mention the SPI devices.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

