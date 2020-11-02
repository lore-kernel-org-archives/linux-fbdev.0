Return-Path: <SRS0=+7Ut=EI=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA1CC00A89
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 18:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D91E22268
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 18:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFwIY8EW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgKBSwk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKBSwj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 Nov 2020 13:52:39 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE88BC0617A6;
        Mon,  2 Nov 2020 10:52:39 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id x13so11557607pgp.7;
        Mon, 02 Nov 2020 10:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HK3WmJW6u7M5Vx/m49h+Vsg1q0S7SYUSgOeAa79ZZJk=;
        b=aFwIY8EW04InPVpjr7nipH18G4FAvswDmuqXCLLvRJjfVAYOc7qSxRnzhEC2rjfdc7
         xJWHaMe0AYzP6PUFnRMr7E0DVDwNN9l9YuIygAuViSk9uOzcoJybD3wYAmsnMlYhgKWV
         FTYNjgdhdw3VBoLrZhgl1rhLzi8TrQ5cEXIWic3oZ/bSWbeuHdonVlWSkBW/GUpizCN8
         ONphXj05E2sTYjX/NawxS/mtdKGBKrDsGtvN4tgUjwrWo8PJbZV9AyN4Oai1nU/9az1k
         DXLfiw811jl5BAOzvT4w7EqrLaStaH/ww0+oOhwMNNSLpQsrtH9L/jg0lSvwFSRUTxdt
         xmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HK3WmJW6u7M5Vx/m49h+Vsg1q0S7SYUSgOeAa79ZZJk=;
        b=jfoPBkgIahV1CGjiNRwv/kbr+IurPB1bAZiYW6kcFVq1GQncRKsToe4oABz/Ldzaa1
         DRhwgmp9FvAWLPLOSJL99JAHNme1sDQpeQZkjLyXI7Urj8kWD4I4gq2pSofzfjfAGDpB
         XEP5Dm+pJ7JEW1bsz4k6OlBYO2wJOfdyfUz3fOsTahkVD2jdR8h4bjS1hhbWIgabJ1GN
         6P7iCJwsvM5jPM/XZINPSDHzE5HPp4HL7w//ckJ5GgyeMj/aGfVdPjyBKOTgvtPjLaab
         z7LLz35tDv6uzJEBrIrIuSqtDU1SLfZxqP0QFfSWduRz4p0Xn2xdYAZNNr/VLWW0Jv/M
         jNug==
X-Gm-Message-State: AOAM530EU2UUEi/vC1AI4eBJFjqotgFi4PP/8QHIs4SYsIML0uZ4KYhn
        WPP61+Om4AxLid6KIWUl2t8=
X-Google-Smtp-Source: ABdhPJxZFZg9a0x6Bf+IQte8IWMpeNM5Kh+wMkhnG24E8lYn1AFwZwa988kzNa4zMg3YHRzGP/ldnA==
X-Received: by 2002:a17:90a:a505:: with SMTP id a5mr18272328pjq.76.1604343159258;
        Mon, 02 Nov 2020 10:52:39 -0800 (PST)
Received: from ?IPv6:2001:df0:0:200c:bd11:f10f:c2c8:538d? ([2001:df0:0:200c:bd11:f10f:c2c8:538d])
        by smtp.gmail.com with ESMTPSA id e2sm210215pjw.13.2020.11.02.10.52.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 10:52:38 -0800 (PST)
Subject: Re: [PATCH/RFC v2] video: fbdev: atari: Fix TT High video mode
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
References: <20201101102941.2891076-1-geert@linux-m68k.org>
 <20201101112915.GB1263673@ravnborg.org> <874km91by4.fsf@igel.home>
 <CAMuHMdUMF4R91Nt6mv9Tqz0zSaNh7AV8mghUoKL+uO-_PUH2aQ@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <609bf047-2c4a-393e-75f6-c86f748682dc@gmail.com>
Date:   Tue, 3 Nov 2020 07:52:34 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUMF4R91Nt6mv9Tqz0zSaNh7AV8mghUoKL+uO-_PUH2aQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Geert,

On 2/11/20 9:39 PM, Geert Uytterhoeven wrote:
> Hi Andreas,
>
> On Sun, Nov 1, 2020 at 1:47 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>> On Nov 01 2020, Sam Ravnborg wrote:
>>> On Sun, Nov 01, 2020 at 11:29:41AM +0100, Geert Uytterhoeven wrote:
>>>> The horizontal resolution (640) for the TT High video mode (1280x960) is
>>>> definitely bogus.  While fixing that, correct the timings to match the
>>>> TTM195 service manual.
>>>>
>>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>>> ---
>>>> Untested on actual hardware, hence the RFC.
>>>>
>>>> v2:
>>>>    - Use correct base.
>>>> ---
>>>>   drivers/video/fbdev/atafb.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
>>>> index f253daa05d9d3872..5ecf3ec9f94cb720 100644
>>>> --- a/drivers/video/fbdev/atafb.c
>>>> +++ b/drivers/video/fbdev/atafb.c
>>>> @@ -495,8 +495,8 @@ static struct fb_videomode atafb_modedb[] __initdata = {
>>>>               "tt-mid", 60, 640, 480, 31041, 120, 100, 8, 16, 140, 30,
>>>>               0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
>>>>       }, {
>>>> -            /* 1280x960, 29 kHz, 60 Hz (TT high) */
>>>> -            "tt-high", 57, 640, 960, 31041, 120, 100, 8, 16, 140, 30,
>>>> +            /* 1280x960, 72 kHz, 72 Hz (TT high) */
>>>> +            "tt-high", 57, 1280, 960, 7761, 260, 60, 36, 4, 192, 4,
>>>>               0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
>>> Well-spotted. The change of 640 => 1280 is surely right.
> TBH, I spotted that 7 years ago, but never got to looking up and calculating
> the other values...

Looks like one of my copy&paste errors that went undetected for too long...
I seem to have copied the tt-mid values above in that case.

Need to go back to the old driver to see what had been used there. A quick diff didn't show anything useful.

>>> I have a harder time understanding why the change of pixclock from 31041
>>> to 7761 is correct. All other modes have a pixclock close to or equal
>>> to 32000 - so it looks strange this one is off.
> 32000 ps is 31.25 MHz. Looks like these are bogus, too, and only
> the VGA and Falcon video modes are correct?

These were the only ones I could test (haven't seen a TT in 20 years). 
At the time I worked on the Atari FB driver, I didn't have access to the 
Profibuch either.

As Andreas mentioned, the Falcon (or external) hardware is the only one 
that can be programmed freely, so we need to work from the 95 MHz 
pixclock Andreas found. That's 10.5 ns approx.

10.5 ns * 1280 * 960 (omitting HBL and VBL timing) gives 77 Hz refresh 
so I don't think 95 MHz for 72 Hz refresh are unreasonable.

Need to look up what all the other numbers in the mode entry mean now ...

Cheers,

     Michael


>
>> According to the Profibuch the pixclock should be about 95000.
> 95 ns? That's a 10.5 MHz pixel clock? Definitely too low.
> The TTM195 manual says 128.85 MHz.
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
