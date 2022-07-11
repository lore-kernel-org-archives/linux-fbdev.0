Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DA9C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 11 Jul 2022 10:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiGKKsD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 11 Jul 2022 06:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiGKKrq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 11 Jul 2022 06:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6252AEAF7
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 02:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657533265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/r5o7wkCaifmX4nx8dD1X4gWt/RrIM+1n5U2ObFDOvY=;
        b=b5GfiEd4nM4XyGJSuZ9LOPdY4nine3RDh6f+10mN4PXrzBcB+I2D/a9m8HX8eLbUBWwpXZ
        3bQWUr3vY+ArGA3znL0chYqwaxjxNT+3lJ9lpiBSlr/gOyjyW09aEf/wS4tfRWHaJGW/kE
        yKIyTTceTIX8jF5QI++F1/bM3UbnJtc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-FHS5XLNjP-qJWSN3_EN5kg-1; Mon, 11 Jul 2022 05:54:24 -0400
X-MC-Unique: FHS5XLNjP-qJWSN3_EN5kg-1
Received: by mail-wr1-f70.google.com with SMTP id g9-20020adfa489000000b0021d6e786099so478968wrb.7
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 02:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/r5o7wkCaifmX4nx8dD1X4gWt/RrIM+1n5U2ObFDOvY=;
        b=tFAPRdPQvcBY6IVEjwUbI5KTduh3H97OcR1SoOg2eLvxCN4pCqnZgZW81q/caBT0dn
         9I0O334UdpJsCKUCBUeNlMR987Z1WZjns9yyZ5uQP76AabVdovqH2PO/r11sDCIM1j2u
         qgilGmHBP6HMm8vABGYuXf5Cq1DCtar/FtFNobwmkRhEzx3vRpynYARRRKvXfDdlfpAa
         F4WKtbX2amNSiVMMBi2wP1RC+UO6vLjrFMcR/pulo6xE4lHI5bc9aztStHH0UnhWrmIr
         cdFxLUvcih+UpsW8dPFaFoSReuTcqhlWta2r7G99cpSHJZScMb2AbELXKTPvDS2MP14M
         2kJA==
X-Gm-Message-State: AJIora+7mDqLJ1l7R3k0jLa6bYQJx2fZwStzDmCdTjj4ago6u3FvRvVe
        7tJB0hNhuGbz8nkhA7sWjXmAcB7WLAAzaBu0wCCQFJYjJBIjBL7lo4XY7oBvPmCyAS7i+SLIN7D
        g+fBjAOePdkoNR5FZ5F2F4oY=
X-Received: by 2002:adf:d1c1:0:b0:21b:a5e9:b7b2 with SMTP id b1-20020adfd1c1000000b0021ba5e9b7b2mr16250718wrd.405.1657533263294;
        Mon, 11 Jul 2022 02:54:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sbBQ51QtlzjO+HKGQRy/aofISE85HxcGvQHuZ3vWX7i4s2OJEN+ZIlfmPB42g4aa4+kn9CLg==
X-Received: by 2002:adf:d1c1:0:b0:21b:a5e9:b7b2 with SMTP id b1-20020adfd1c1000000b0021ba5e9b7b2mr16250698wrd.405.1657533263004;
        Mon, 11 Jul 2022 02:54:23 -0700 (PDT)
Received: from [172.20.10.7] ([90.167.95.6])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c511400b003a2d3ed9297sm18324607wms.1.2022.07.11.02.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 02:54:22 -0700 (PDT)
Message-ID: <253d0bea-f197-4208-b5e6-39c22ab91833@redhat.com>
Date:   Mon, 11 Jul 2022 11:54:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 02/11] fbdev/vga16fb: Create EGA/VGA devices in sysfb code
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org
References: <20220707153952.32264-1-tzimmermann@suse.de>
 <20220707153952.32264-3-tzimmermann@suse.de>
 <fec8dcc1-c490-3bb6-2d2f-805d690d3f95@redhat.com>
 <95302954-76bc-3da6-70ad-25a8a22a37f0@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <95302954-76bc-3da6-70ad-25a8a22a37f0@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 7/11/22 09:58, Thomas Zimmermann wrote:
> Hi Javier,
> 
> I'll try to give the motivation of this patch below. I known it's rather 
> hypothetical as the VGA driver is probably not used much.
> 
> Am 08.07.22 um 15:09 schrieb Javier Martinez Canillas:
>> Hello Thomas,
>>
>> On 7/7/22 17:39, Thomas Zimmermann wrote:
>>> Move the device-creation from vga16fb to sysfb code. Move the few
>>> extra videomode checks into vga16fb's probe function.
>>>
>>> The vga16fb driver requires a screen_info for type VIDEO_TYPE_VGAC
>>> or VIDEO_TYPE_EGAC. Such code is nowhere present in the kernel, except
>>> for some MIPS systems. It's not clear if the vga16fb driver actually
>>> works in practice.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> ---
>>>   drivers/firmware/sysfb.c      |  4 +++
>>>   drivers/video/fbdev/vga16fb.c | 59 +++++++++++++++++------------------
>>>   2 files changed, 32 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
>>> index 1f276f108cc9..3fd3563d962b 100644
>>> --- a/drivers/firmware/sysfb.c
>>> +++ b/drivers/firmware/sysfb.c
>>> @@ -94,6 +94,10 @@ static __init int sysfb_init(void)
>>>   		name = "efi-framebuffer";
>>>   	else if (si->orig_video_isVGA == VIDEO_TYPE_VLFB)
>>>   		name = "vesa-framebuffer";
>>> +	else if (si->orig_video_isVGA == VIDEO_TYPE_VGAC)
>>> +		name = "vga-framebuffer";
>>> +	else if (si->orig_video_isVGA == VIDEO_TYPE_EGAC)
>>> +
>>
>> I wonder if we really need to do this distinction or could just have a single
>> platform device for both VIDEO_TYPE_VGAC and VIDEO_TYPE_EGAC. After all, the
>> same fbdev driver is bound against both platform devices.
> 
> With the current driver, we don't strictly need to distinguish. But the 
> sysfb code is the one we care about. So I wanted it to be clear and 
> nicely looking. All the mode tests, etc depend on the driver (which no 
> one cares about).
>

Right. That is a good point. We don't want to leak a driver implementation
detail in the sysfb code. And in theory there could be for example a DRM
driver for EGA and one for VGA.
 
> There's also a difference in hardware features between EGA and VGA. Most 
> notably, VGA has much better color support.
>

Yes, I know the differences. My point was that the orig_video_isVGA was
used to make the distinction and that the same driver supported both, but
as you said that may not be the case and separate drivers could be used.

>>
>> [...]
>>
>>>   static int vga16fb_probe(struct platform_device *dev)
>>>   {
>>> +	struct screen_info *si;
>>>   	struct fb_info *info;
>>>   	struct vga16fb_par *par;
>>>   	int i;
>>>   	int ret = 0;
>>>   
>>> +	si = dev_get_platdata(&dev->dev);
>>> +	if (!si)
>>> +		return -ENODEV;
>>> +
>>> +	ret = check_mode_supported(si);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>
>> What do you see as the advantage of moving the check to the driver's probe?
>>
>> Because after this change the platform driver will be registered but for no
>> reason, since can't even probe if orig_video_isVGA is neither VGAC nor EGAC.
> 
> The driver only supports very specific modes, which may not be what 
> screen_info detected. Note that VGAC/EGAC can also refer to text-mode 
> buffers. The current vgacon could be turned into a platform driver that 
> adopts such a text buffer and integrates it with aperture helpers.
>

Yes, and also there's also the monochrome variant of VGA and EGA (VGAM/EGAM).

Should we also make that distinction or for example "vga-framebuffer" should
handle both color and monochrome variants if at some point vgacon is turned
into a fbdev or DRM driver ?

>>
>> [...]
>>
>>> +static const struct platform_device_id vga16fb_driver_id_table[] = {
>>> +	{"ega-framebuffer", 0},
>>> +	{"vga-framebuffer", 0},
>>> +	{ }
>>> +};
>>> +
>>
>> The fact that the two entries don't have a platform data is an indication for
> 
> The name is the indication. I know that vga16 doesn't treat them 
> differently.
>

Yes, my point was that the platform device name used to bind is an internal
Linux interface that could be changed later if needed. But I understand your
point and since the platform device names are exposed to user-space, makes
more sense for them to reflect what devices are bound even when the existing
driver doesn't treat them differently.
 
>> me that we could just consolidate in a single "vga16-framebuffer" or smt. I
>> know that this won't be consistent with efi, vesa, etc but I don't think is
>> that important and also quite likely we will get rid of this driver and the
>> platform device registration soon. Since as you said, it's unclear that is
>> even used.
> 
> There's mips code in the arch/ directory that appears to setup 
> screen_info in the correct way. I can't say whether that's still useful 
> to anyone. On x86, I could set a VGA mode on the kernel command line, 
> but screen_info's isVGA only contained '1'. It might be possible to fix 
> this easily by setting the right values in vga_probe(). [1] I simply 
> don't have the time to provide a patch and deal with the potential 
> fallout of such a change.
>

Indeed. This seems to be a remnant from the time when isVGA was just a bool
and then at some point the field semantics was extended to denote the mode
but the existing users weren't fixed (nor the field named to reflect this).

Probably should be cleaned up at some point but unsure if the churn would
be worth it.
 
>>
>>>   static struct platform_driver vga16fb_driver = {
>>>   	.probe = vga16fb_probe,
>>>   	.remove = vga16fb_remove,
>>>   	.driver = {
>>> -		.name = "vga16fb",
>>> +		.name = "vga-framebuffer",
>>>   	},
>>
>> Maybe "vga16-framebuffer" instead? Since for example VESA is also VGA AFAIK.
> 
> VESA is something else than VGA. Setting a VESA mode (done via INT 10h 
> IIRC) and then fiddling with VGA state will likely produce broken output 
> on the screen.
>

Technically it is something else but Linux conflates them in many places. For
example, as you mentioned one can change the VESA modes using the "vga" param
(which confusingly leads to the use of vesafb+fbcon driver instead of vgacon).

That's why I think that "vga-framebuffer" as driver name would be misleading.
Specially since it would also bind to the "ega-framebuffer" platform device.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

