Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3484EC61D97
	for <linux-fbdev@archiver.kernel.org>; Wed, 25 Jan 2023 07:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjAYH2Y (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 25 Jan 2023 02:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbjAYH2S (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 25 Jan 2023 02:28:18 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62D62E0FB
        for <linux-fbdev@vger.kernel.org>; Tue, 24 Jan 2023 23:28:16 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id n7so16079210wrx.5
        for <linux-fbdev@vger.kernel.org>; Tue, 24 Jan 2023 23:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0juD3Z6CRCmdLHAmguPHCfD9MzYp+16yRKaiS/m80wE=;
        b=hJxiagec1rMDmnWfW5Db4ImIGKsN81dLF361HfBJP8gONdeMsQyVbgsv7K0lPF+6FT
         YD3DGQd8VLYNojWtfWnDmovrjYzRRV8h74Bq+5b65qUON8i5QrRbdvw0ZbMbPOCyO8FJ
         yZNbD8ZWFKyi+jn1oyL7JMVdFx6Npj5RpjZozks7cLPnw2soJDZ7F6VTPpqgYH2zI2Kk
         3JyxsqEzKEnRU6LN3haphIkjU7qd1bprZTL7m5w1ngAP0ZhCsM6JtiqG4VfW13QzJjBC
         +JqSq7CQnBEBerxs6/Gi60UodIESSToTeelYUJgURCdi07LHNfhSmBPOM1i3aFy+v2gZ
         1n9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0juD3Z6CRCmdLHAmguPHCfD9MzYp+16yRKaiS/m80wE=;
        b=Zi0AXJT01dX/Bw4h9ecNHF352waTq52PsAoW2USA/8MiIi0YydqVerX/JyOZyRBTUL
         /AeLi/2T60AKFNZylddWMNokf4grrgh3D+cbA6p45QCqOQOkphBJ0L5/RfbZMQ65jxGL
         UwEzNMYsMliRZTIuTYuybdMGncOos5a4W1RM3zleUKecfRgIHdji2Jpht3gewt80LpQL
         pN/+N9rBym9g2x3UB27TiZjBUkRFsV3iu1jlV0OHC8iHy3pXQQzwXLjc3kHraAcegyIc
         v63LVHEtOtpEViVSP52e4yFa7P4ZGIsO1juX9f6G3m1R8nyP6f2vNZLnzKJgNuYOU7lF
         yi5Q==
X-Gm-Message-State: AO0yUKUnidLsvku6RG2i0Tp6MBRLu5U29XSoM9erRTnLPRZefWVbATAV
        JYX4WSRXOZaAcoyjOOka5nKh6w==
X-Google-Smtp-Source: AK7set9lUBCjZ9+aqMQcWhmoChQgZw7gc5KBt4C0vQo4fYLZ0wwqlOF3vMs9z66OwHjipriVA7x0sQ==
X-Received: by 2002:a5d:4f87:0:b0:2bf:b2c2:e122 with SMTP id d7-20020a5d4f87000000b002bfb2c2e122mr3656874wru.29.1674631695385;
        Tue, 24 Jan 2023 23:28:15 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g16-20020adffc90000000b002882600e8a0sm3788880wrr.12.2023.01.24.23.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 23:28:14 -0800 (PST)
Message-ID: <e053aa6d-8a0b-b0ea-85e7-a1b35fd00e53@linaro.org>
Date:   Wed, 25 Jan 2023 08:28:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 2/2] dt-bindings: display: simple-framebuffer: Document
 physical width and height properties
Content-Language: en-US
To:     Rayyan Ansari <rayyan@ansari.sh>, Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        janne@jannau.net, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20230121153544.467126-1-rayyan@ansari.sh>
 <20230121153544.467126-3-rayyan@ansari.sh>
 <CAL_JsqL+G=Cxkc2j_NowznpqNAnixrU+-6SdccFbpMaP6OYSqQ@mail.gmail.com>
 <cdf32cb0-4529-6bbd-fdda-ae641d141ee5@ansari.sh>
 <20230123175339.GA2019900-robh@kernel.org>
 <3d448210-e9d2-b0ee-e009-535bb0bb760d@ansari.sh>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3d448210-e9d2-b0ee-e009-535bb0bb760d@ansari.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 24/01/2023 23:19, Rayyan Ansari wrote:
> On 23/01/2023 17:53, Rob Herring wrote:
>> On Sun, Jan 22, 2023 at 05:25:38PM +0000, Rayyan Ansari wrote:
>>> On 22/01/2023 15:36, Rob Herring wrote:
>>>> On Sat, Jan 21, 2023 at 9:36 AM Rayyan Ansari <rayyan@ansari.sh> wrote:
>>>>>
>>>>
>>>> Why do you need this change?
>>>>
>>>> The 'simple-framebuffer' contains data on how the bootloader
>>>> configured the display. The bootloader doesn't configure the display
>>>> size, so this information doesn't belong here. The information should
>>>> already be in the panel node, so also no point in duplicating it here.
>>>>
>>>>> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
>>>>> ---
>>>>>    .../devicetree/bindings/display/simple-framebuffer.yaml   | 8 ++++++++
>>>>>    1 file changed, 8 insertions(+)
>>>
>>> Hi Rob,
>>>
>>> There is the usecase that Hans has mentioned, but I have also mentioned
>>> another usecase previously.
>>>
>>> Adding the width-mm and height-mm properties allows user interfaces such as
>>> Phosh (https://puri.sm/posts/phosh-overview/) to scale correctly to the
>>> screen. In my case, a panel node is not available and the aforementioned
>>> interface is in fact running on the SimpleDRM driver (which binds to the
>>> simple-framebuffer device).
>>
>> Why is the panel node not available? Why not add it? Presumably it is
>> not there because you aren't (yet) using the simple-panel driver (and
>> others that would need). But presumably you will eventually as I'd
>> imagine turning the screen off and back on might be a desired feature.
> 
> It requires more than using the simple-panel driver: first the SoC side 
> display hardware needs to be brought up, then a panel driver that 
> implements the proper DCS initialisation sequence needs to be written 
> (which is currently not fully known).
> 
>>
>> So why add a temporary DT property that's tied to your *current* kernel? > The DT should not be tightly coupled to the kernel.
> 
> I'm not sure what you mean by it being "tightly coupled" to the kernel.

It means that you used current Linux driver support (or lack) for some
hardware as an argument for bindings. If you add later the driver, the
bindings should be changed? Answer is: not. Bindings should be
independent of Linux drivers, thus whatever kernel is missing now, is
not an argument in favor of this property.

Best regards,
Krzysztof

