Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A53EC7EE22
	for <linux-fbdev@archiver.kernel.org>; Thu, 11 May 2023 13:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbjEKNGO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 11 May 2023 09:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbjEKNGM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 11 May 2023 09:06:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852C76A76
        for <linux-fbdev@vger.kernel.org>; Thu, 11 May 2023 06:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1683810358; i=deller@gmx.de;
        bh=d40ZGve7zR+dGqvSjkDls2rBkKGgMLVsgb8ctJYfyUM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Ris4jwkUNOSDvhabAQDdhR1fwOJDxdNSeVvDDQ2y39degXD7Ydn+b/A7eNxJcIbWh
         hOvcBoQkXpOMzrycHWnrwTY49gEG9WP5KsBhyHlnR3jkM/j+M9wYWeUeOdahf5G1kM
         OraN062btXV8F8ph3Ivsy5flVSl+dulzZMQh3lE1y21htqLmLTLcDUhWglkTqueaEE
         rCyE4wFmwUyYfL7v6jG3TYcg6BrMOAgMTK5Vl4MWzhaWz0Jo6BPCWVmx4lrDg0ao1V
         tVRvUmNThvyMiXALKCvOeBcnha6Ckqyq9ttfGnjwp1DZKkAhBn2yQ/yz+z6hZAxXDB
         P0OYx0vkIyoqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.77.61] ([109.43.178.145]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUUw-1qXEc60mKa-00py8M; Thu, 11
 May 2023 15:05:58 +0200
Message-ID: <459c28bb-3104-8b53-970f-27995d3ea858@gmx.de>
Date:   Thu, 11 May 2023 15:05:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 00/15] fbdev: Remove trailing whitespaces
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230331092314.2209-1-tzimmermann@suse.de>
 <e2f54d17-debc-62f4-3644-8baea4a88b10@suse.de>
 <752f0e2b-e069-6221-1ee0-99306f2c718a@gmx.de>
 <5a0a1ed1-3aa2-0026-52f7-60bd5dcba8b8@suse.de>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <5a0a1ed1-3aa2-0026-52f7-60bd5dcba8b8@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V2K152GscDiiBxzZHHGwjYEDtGjlEX3qOUmqH1NUIb98boqYGac
 +yzxzOp4zVlpplTInStdElfuE1oSaDsOPlWr5pn94c7no1Uzds7zQIrZfmo1jpWPcYiA0pJ
 wapwA2xmjiojo+gSud//oSoGfLErYp7PNEC5o1qTQ99nBN54jLQYFA9Puq0nwEAg12o/pJ0
 MhVVg8PTr4jZzNx9jgLkg==
UI-OutboundReport: notjunk:1;M01:P0:FZyQVIiMDhw=;IbBi+C98Wtv7EfFh9lyIn8AF4KD
 bMHYJP05J/aO8UEV3u2C2IUr116hsb1LIF5IXmjZzHnhJS4kKun9f/98w4r5tnfGZJkHZ/VMY
 RGVxbCZdLHGLCZgUSSTyQr91sOIF0KZPyEKzFqB6rqkKBbhYvjGan93XJ203l2xtzZXwwb3LI
 xraZ2Ip74GPO9mzkqEd/i7SDaN4jMp0+/j0SnFNdIfnvVP38QM1naG/n8+OaQc7wFMTY3PldB
 R9iZuyjXf081I8O+rpi6OxnODEBjv+ghAxddOn4ohVGgVEAau12sJ96w+gtqhFMMkby7u+e36
 oBCfxiyOgfcSg0ORmFk0ftvpVmIgsHc1HLc46YwByq/93JUrxkqcuZG0leYA/N3AM5G5J4ZlK
 F4+WwGpYrvgXOWuHOPFmekypH0ORyTJLwk8QP4bYBncBPTCHTuFgBVbbD3BDviakU8b2MulIf
 1JwlvQiv3AqAmayXGVb3jxBlNVNZx4C8LMvtsps0XjV18SuIc6R5qjsL/Ood3g7aQKpvOn+km
 zUXOzwr3hkCwO5D842SWzj40lok5oumGh6d57u1A16g2fp+nT3Ro9ycjB6LwhFiEUK7oGufcx
 4li9LCsXxEAz4InbIew1F0LqNe5r+aW16cLTfNI4DwsexTrXH61herXf8q6Gqec3PwVgSylHR
 +DNCDWZ9NWdZmKXwgmU+RaxHQV0BWzvbyzUbCwP+CGOPS//jRPQKdEhRu8CzSISgL3hJ/4eLu
 I4K3toVnVj4g/q+ARmNQlMf9ZoYQK1TyIvxehKSiLFrHI/SXUasrWbknj/cswjpbvhXCnzyzy
 F8z1FAN7+eCUDYEIPqR+mXAsnDM98HI+AfFnOK563lPVqfgWlQsUe8NF1RN/jnsXuTIlIppJw
 4JGPyHfNDhyyl5XlPPmx9S882THs/Ql9B84866hadOyfM1xm4vmE4R3VAgX7PcHC4fss1Bmvr
 Vo+ciA==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 5/11/23 14:53, Thomas Zimmermann wrote:
> Hi
>
> Am 11.05.23 um 14:51 schrieb Helge Deller:
>> Hi Thomas,
>>
>> On 5/11/23 14:08, Thomas Zimmermann wrote:
>>> I thought these patches would go through the fbdev tree, but I could
>>> not find them v6.4-rc1. Please review the remaining ones, so that I
>>> can merge them via drm-misc.
>>
>> Sorry, I thought you had planned to take them through drm-misc anyway,
>> so I didn't applied them.
>>
>> I just reviewed them again, and you may add my
>> Acked-by: Helge Deller <deller@gmx.de>
>>
>> Alternatively I can apply them now to fbdev and send them for -rc2.
>> Just let me know your preference.
>
> Please do. Having them in -rc2 is even better.

Ok.

Helge

>
> Best regards
> Thomas
>
>>
>> Helge
>>
>>
>>>
>>> Best regards
>>> Thomas
>>>
>>> Am 31.03.23 um 11:22 schrieb Thomas Zimmermann:
>>>> The trailing whitespaces are annoying. So remove them. No
>>>> functional changes. Some of the patches has already been
>>>> acked by Helge.
>>>>
>>>> Thomas Zimmermann (15):
>>>> =C2=A0=C2=A0 fbdev/68328fb: Remove trailing whitespaces
>>>> =C2=A0=C2=A0 fbdev/atmel_lcdfb: Remove trailing whitespaces
>>>> =C2=A0=C2=A0 fbdev/cg14: Remove trailing whitespaces
>>>> =C2=A0=C2=A0 fbdev/controlfb: Remove trailing whitespaces
>>>> =C2=A0=C2=A0 fbdev/g364fb: Remove trailing whitespaces
>>>> =C2=A0=C2=A0 fbdev/hgafb: Remove trailing whitespaces
>>>> =C2=A0=C2=A0 fbdev/hpfb: Remove trailing whitespaces
>>>> =C2=A0=C2=A0 fbdev/macfb: Remove trailing whitespaces
>>>> =C2=A0=C2=A0 fbdev/maxinefb: Remove trailing whitespaces
>>>> =C2=A0=C2=A0 fbdev/p9100: Remove trailing whitespaces
>>>> =C2=A0=C2=A0 fbdev/platinumfb: Remove trailing whitespaces
>>>> =C2=A0=C2=A0 fbdev/sa1100fb: Remove trailing whitespaces
>>>> =C2=A0=C2=A0 fbdev/stifb: Remove trailing whitespaces
>>>> =C2=A0=C2=A0 fbdev/valkyriefb: Remove trailing whitespaces
>>>> =C2=A0=C2=A0 fbdev/vfb: Remove trailing whitespaces
>>>>
>>>> =C2=A0 drivers/video/fbdev/68328fb.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
12 +--
>>>> =C2=A0 drivers/video/fbdev/atmel_lcdfb.c |=C2=A0=C2=A0 2 +-
>>>> =C2=A0 drivers/video/fbdev/cg14.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 2 +-
>>>> =C2=A0 drivers/video/fbdev/controlfb.c=C2=A0=C2=A0 |=C2=A0 34 +++----
>>>> =C2=A0 drivers/video/fbdev/g364fb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 6 +-
>>>> =C2=A0 drivers/video/fbdev/hgafb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 36 +++----
>>>> =C2=A0 drivers/video/fbdev/hpfb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 8 +-
>>>> =C2=A0 drivers/video/fbdev/macfb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 10 +-
>>>> =C2=A0 drivers/video/fbdev/maxinefb.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 2 +-
>>>> =C2=A0 drivers/video/fbdev/p9100.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 4 +-
>>>> =C2=A0 drivers/video/fbdev/platinumfb.c=C2=A0 |=C2=A0 30 +++---
>>>> =C2=A0 drivers/video/fbdev/sa1100fb.c=C2=A0=C2=A0=C2=A0 |=C2=A0 32 ++=
+---
>>>> =C2=A0 drivers/video/fbdev/stifb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 156 +++++++++++++++---------------
>>>> =C2=A0 drivers/video/fbdev/valkyriefb.c=C2=A0 |=C2=A0 14 +--
>>>> =C2=A0 drivers/video/fbdev/vfb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 10 +-
>>>> =C2=A0 15 files changed, 179 insertions(+), 179 deletions(-)
>>>>
>>>
>>
>

