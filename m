Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9701AC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 30 Nov 2021 20:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbhK3U0U (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 30 Nov 2021 15:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbhK3U0R (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 30 Nov 2021 15:26:17 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB93C061574
        for <linux-fbdev@vger.kernel.org>; Tue, 30 Nov 2021 12:22:57 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l16so47064426wrp.11
        for <linux-fbdev@vger.kernel.org>; Tue, 30 Nov 2021 12:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=02uY4AmojDwifo7LgepwuVCqs4Jz+sFd/07AQHN7lY0=;
        b=jbF/TxWeIOG9zF+Sg6hp+nRBv7Ql9V7HNVmAjWhvG7abajbX923ZC/ZZs+GFWcFKjp
         JpHt3aGvrrWCQAXAaV8IjEWvrRk+E3Qfl71sdfYM7jWB+7sH8sernuoAs7OZl4ljHY1z
         ArHlhlavWip4kdFPzLyrdOMRCbwf1xTqcT+arquc+ngNhHn0ieqwUmFuWi3aaQW/9nnk
         iLa53Wx/Yjo30/xm2KgOtU2vqczHgVVlCx/v5kqwDzNU09uRLlggFDVt5i8XGdvVRugd
         XbeG1iMzmFe/7bsrtrrb8HI4FWRRSC6vCntmUbwmM4InTF/yc2485UuWWZoHNppHOOhl
         o/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=02uY4AmojDwifo7LgepwuVCqs4Jz+sFd/07AQHN7lY0=;
        b=rlQsI2Vl0N6/soaB0ZkjH9lTi0rIx3YYF5LTdy+A6PsWQA1Di7wRFJU3y7JBwO5P3s
         1G1xD33BTLfYCPseP2FWoIVGIjJb4pVun+kiyepJa7KJ4NXrKEOVfo1IAq2DValOkXjW
         gUos095GdPBKiCz/x2xG3t16brH6nX5cco8oe5Nq1DyxCn77kN60clhhN1gJgBz1g23y
         lnDCM8dY5aurnLN8NN8Rmo8jWoQXECWLVFe3zhqX+rtBU2Hoxs4r9djBdvXPd5ooDFrc
         LCCNEMjqG7tJo841to2dxvrhtOsvKM7vVatyLl7W5pz9sgtXpGzSHAX2Q9HdELXUA5TQ
         0V4Q==
X-Gm-Message-State: AOAM530lh0ca47RJmgvhv7CzXXLKAH8rI547XMobLCFBROuZOCyv+Cuo
        MD4ZJdX9u11BKAWWgVkhFZQ=
X-Google-Smtp-Source: ABdhPJzJTgk7rUqaZ3m5/DRW8UjR5XiojzKeXyklSH+D4g5cHUFuA0L9SjbjHQ/YuoUjc9TpybqKSw==
X-Received: by 2002:a5d:64e7:: with SMTP id g7mr1264073wri.350.1638303776509;
        Tue, 30 Nov 2021 12:22:56 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:cdea:1258:1cb4:5e92? (p200300ea8f1a0f00cdea12581cb45e92.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:cdea:1258:1cb4:5e92])
        by smtp.googlemail.com with ESMTPSA id m125sm3216445wmm.39.2021.11.30.12.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 12:22:56 -0800 (PST)
Message-ID: <8597bdf2-c383-43b5-6205-f78c90b4957a@gmail.com>
Date:   Tue, 30 Nov 2021 21:22:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] staging: fbtft: add spi_device_id table
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev
References: <aadbd32c-c0ab-4c8a-c590-3334f736f224@gmail.com>
 <CAMuHMdU_90XdFZM6kVA78XUX+7+Jm1WqjBmBN7irVOY3k-Gcfg@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAMuHMdU_90XdFZM6kVA78XUX+7+Jm1WqjBmBN7irVOY3k-Gcfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 30.11.2021 09:16, Geert Uytterhoeven wrote:
> Hi Heiner,
> 
> On Mon, Nov 29, 2021 at 10:12 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>> After 5fa6863ba692 ("spi: Check we have a spi_device_id for each DT
>> compatible") we need the following to make the SPI core happy.
>>
>> Works for me with a SH1106-based OLED display.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/staging/fbtft/fbtft.h
>> +++ b/drivers/staging/fbtft/fbtft.h
>> @@ -307,12 +307,19 @@ static const struct of_device_id dt_ids[] = {                              \
>>                                                                            \
>>  MODULE_DEVICE_TABLE(of, dt_ids);                                           \
>>                                                                            \
>> +static const struct spi_device_id spi_ids[] = {                            \
>> +       { .name = _compatible },                                           \
> 
> Shouldn't this be the part of _compatible after the "<vendor>," prefix?
> 

You're right. I was fooled by a new bug in SPI core that made the warning
suddenly disappear:
https://patchwork.kernel.org/project/spi-devel-general/patch/44b2ad71-dc4b-801c-237f-9c233f675c0d@gmail.com/

>> +       {},                                                                \
>> +};                                                                         \
>> +                                                                          \
>> +MODULE_DEVICE_TABLE(spi, spi_ids);                                        \
>>                                                                            \
>>  static struct spi_driver fbtft_driver_spi_driver = {                       \
>>         .driver = {                                                        \
>>                 .name   = _name,                                           \
>>                 .of_match_table = dt_ids,                                  \
>>         },                                                                 \
>> +       .id_table = spi_ids,                                               \
>>         .probe  = fbtft_driver_probe_spi,                                  \
>>         .remove = fbtft_driver_remove_spi,                                 \
>>  };                                                                         \
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

