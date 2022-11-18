Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D931C433FE
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Nov 2022 08:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbiKRI5P (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 18 Nov 2022 03:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241681AbiKRI5M (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 18 Nov 2022 03:57:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D52C63CC9
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Nov 2022 00:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668761821; bh=jH2i4n9y0EjwjOJjODy/96qGtLySn8PV6mHc8f/XM3Q=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BqCdhcdt74FnfVLzvC9fyd8zUKvl1Va4xPBNAIdNhObZqhygqg60+e8kv1KIlhM55
         brq5jIU0qS+VN3bQLwrO+jNZKMRj5OcGuOlU4p+Xx3OiG8LRetxlHlECjB7UDsyxPN
         2wNL6xWUKQTVs+eH3QvAFwYxNoe0C7n5HurpZB4//baacohQiCcQA2PBBFTHR9y/es
         uNV5Zzxt9A8zCCmHz7pKBESZudzOQlnmobgavpGK1GglObOgWlXDSyhsTsLlma7hGo
         5ScSMUyyxTY9dKsdXadxH/pSBVJjYEip4XyUytSi4CTkPVL3dnODg2601gE8jofF3f
         vLMIbnK3ZL3Xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.164.156]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRmfo-1oXAEp2Fsg-00T9BZ; Fri, 18
 Nov 2022 09:57:01 +0100
Message-ID: <0084795e-a13b-eb14-034a-c70ec66baa79@gmx.de>
Date:   Fri, 18 Nov 2022 09:57:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] Add framebuffer device driver for gamecube/wii,
 incorporating Farter's work.
Content-Language: en-US
To:     Zopolis0 <creatorsmithmdt@gmail.com>
Cc:     linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <CAEYL+X9qahvtsi71thrOzzqdtq_mpdTyV1ZCqc-TvMH--7HqdQ@mail.gmail.com>
 <09b7b91c-4bae-0bba-7701-cb1f8c58c00b@gmx.de>
 <CAEYL+X-GSKCP9j0fz6m_VQ0tBH+adEkChWMxpOkeQ8TXC8tguw@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAEYL+X-GSKCP9j0fz6m_VQ0tBH+adEkChWMxpOkeQ8TXC8tguw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JmD30CmSFk1VnryTWcKXADSiZEsiH4a1OinS6VUPwfIQSy5Qi1q
 Fougp6oMeCcgNWE+S+sgdy0Aa22BFrRZ07MJGs+5GWjl2K3sqd9yLH0wQcfDhCTsmEHUAmN
 ZZaNmA/3dy4TyxcqpQs1w6fVO6BPBYmFTC0zsARUhkJJeQ//HVRemePiqFRFvccAkKpWrZr
 ZmxASeJJf3+CPEmr6u2wA==
UI-OutboundReport: notjunk:1;M01:P0:NJdJ1tiqGUU=;Czrw/6NCZTJ55Z7MTSo2PqVmW5F
 OtfKY1qZROqKbdMBVZBXVdFQlklytF0t/eqA2vSrRFPMwfm06EvvGvb+8RgHfltG4nO+4KSLX
 /Kk4AGHj9e+79gloKlqPAMHhX1Lq/HVA7d0rrHd3ja2d0cz+yqaGR7OOjXErz3tmIZrXIprjb
 aN/FfYjRrLWVDMfGz+2JUATnXnjLlaAZWifqLg8hPVSTpIQ7a5bTIw6p1FkR8z6feVhHI//5M
 ZXefbI6dJCHctYAQHwajYAY8NjPzvC7aLWmY2Wkz/P+2cUKCqUMubuZHZbqWsfqT1jBpypSy3
 SBGOSyBDjHtbIm9pRfowdhOL8VrTLCvf85DxG/6ey6U2AYcodmJHpKso64YxQT4kkjTniE9My
 HNNT9bx1LXWFxz8SPhbVXOCRN7F+CJlqj7y4q81GO4AOPtxN+5wr1qsI3yCOEAkSNVnZliWaG
 MLshLfjLRAupL1NuMmMrHp3vsOxxDmll8lPWxlHLwF0r6G1tAzgbkuewBqBuAI8WOYITEFax5
 ogOt31bdYNMxBLSUORbTDO0AHzKP5/QXYlQ/3PjN7iq9wRek/ffiULJa40mUJ/43jJns4yvrn
 yRkpjNFfGDhNxra9iv/k3oMY98N7tvpxJvwAoxBRL0k9fJbODF5tC8H42Z2WTehpYev9KcoVS
 NfrcekBuRBAbI9GiAC99awDJ8GIjY/eGsSZojb3sVrSYZHCm9Al4igTvmd+UrVe+3vMer7LVf
 X/ZoR1sx6DSiUBdZ9IRdzhADBaXv4JZONvpItZH+nWqLXqvX/yw9K4QMbUzPA0YsMlNnXzelW
 VshT0IfKq/CU2tFW1cSUyKWpVNVzbBnUL1/4olSc7/IDIdYbrcLdKFbLGGdZO4Ry/J+ejuVKt
 N2Y+N+hXm9l9nJABEmUZuNTyZC4rP0u1BuojrymLWCx8l0MAuQq/kBP8PBfWJSdwsD3fNhFlQ
 vJiGqw==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Maximilian,

On 11/15/22 23:05, Zopolis0 wrote:
> I'm not too familiar with DRM, unfortunately, so I can't give you a grea=
t answer.
>
> My current aim is just to get this and the other gc-linux patches into u=
pstream before they begin to rot.
>
> But, I'd be happy to look into porting this to DRM after it's merged tho=
ugh.

Your aim to upstream the patches is ok, but generally DRM is the way forwa=
rd
for Linux graphics.

I've briefly looked at the driver and it seems that it initially sets up t=
he
graphics mode, and that changes to the screen are then rendered into a mem=
ory
buffer from where a damage detection is then run which updates the screen.
As far as I understand DRM, this is how it's done in DRM for various
graphics drivers (Thomas, please correct me if I'm wrong!).
Additionally the driver includes two IOCTLs for FBIOWAITRETRACE (wait for =
retrace)
and FBIOFLIPHACK (wait until a specific video page is visible or not visib=
le).
I assume libsdl is using those? Are they still required nowadays?
I don't know if such ioctls are doable in DRM or if DRM has other
possibilities - this would be interesting as it would help to decide
if porting to DRM is possible & useful.

Usually we also expect the patches to be sent with proper commit messages
in plain text to the mailing lists. Since you had problems with this, I've
stored your patch in the fbdev-wii branch of my git repo, so that it's eas=
ier
for me to take a look at the patch. For people who are interested as well,
it's archieved here now:
https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/com=
mit/?h=3Dfbdev-wii&id=3D802bb0aa1af149ec8299ea7dfebf3fc10dc9c3df

That said, I wish you much success with pushing the other gc-patches upstr=
eam.
But for now I won't merge this patch unless the possibility to convert to =
DRM
has been fully clarified.

Helge

> On Wed, 16 Nov 2022 at 04:05, Helge Deller <deller@gmx.de <mailto:deller=
@gmx.de>> wrote:
>
>     On 11/15/22 11:05, Zopolis0 wrote:
>      > Just upstreaming the gc/wii framebuffer driver from gc-linux, and
>      > incorporates Farter's patch to solve the color issue. See
>      > https://fartersoft.com/blog/2011/06/22/hacking-up-an-rgb-framebuf=
fer-driver-for-wii-linux/ <https://fartersoft.com/blog/2011/06/22/hacking-=
up-an-rgb-framebuffer-driver-for-wii-linux/>
>      > and https://fartersoft.com/blog/2011/07/31/hacking-up-an-rgb-fram=
ebuffer-driver-for-wii-linux-take-two/ <https://fartersoft.com/blog/2011/0=
7/31/hacking-up-an-rgb-framebuffer-driver-for-wii-linux-take-two/>.
>
>     Just for the record:
>     Is there a reason why it wasn't (or can't be) ported to DRM ?
>     Looking at the patch (and the hardware behind it) I do see various r=
easons,
>     but I'd like to hear it from you...
>
>     Helge
>

