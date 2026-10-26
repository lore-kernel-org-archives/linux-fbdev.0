Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793032005;
	b=sNi0Pndp/n/+UJPdjGbuRYgz8hhYZ1sibz8nyrMtWm6wPBeBHLt4e5ITW3yNej+lGFXq
	 SpMHs7ekdD/mrl00DxU/yutxTOycVwz9bVsaVCSM00Z8i8Dbk3kIyTELRCyhnBY2mKTyp
	 ZVwmJIXMwYF6vhPedIWzy+4gAi2gE7EOcVhae3tyOMY9MiKDq3KKYElxK+6hQ2aNCnjak
	 Ohh2+/fgkTAMvcxkK4euuFt3rbsEjjFCUtsSthGQGKtyoySkgYm3pLeoh3xH7JihoVu/n
	 C58tRO3AbWNtbXxNfdIAxR1yMqnQo837tFGVc5DSRFon7s8DqD/pk0OToWXGi0Y5Jgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=lW187BX7pvnv89/fgKm/N1OWRtkvU+9tvFLWWwcKajk=;
	b=Ep1JarGeUcRBO0glTIai/iHDCA0T1zDCaOtSElE+CpmVkI0bopNcdSFx/9QdI6MD99mW
	 rdmh/uaGj1efkMgFnYdlHz5GYAaVUZovrAeUNGR1dewjM5CnMZjbW4Dteqy1ctzyJ9a9+
	 dXbxH2g6tSjliVvB7X6ZzKJ56Frm+O5mcLM7Q12OBSttPw3wWtaFy8rdqwdk/9D+eYHzs
	 XGEX5yEi9zeAemEOP2GLCvF2DnY4Vzcm3HRMtgfCcOBuiI1zF7qqSBMwDOmDkhfQyAUpR
	 s7m0+YMxl/kDwKNuggqyz2G3IjHF84kpEyWccxY4IK4vJk99LRtR0sUua/wlfM4+ong==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MUOvYbUG;
	arc=fail smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC2606A31E
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 16:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87BC2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MUOvYbUG
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso4778895a12.3
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 09:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793032004; cv=none;
        d=google.com; s=arc-20260327;
        b=Jio0UpLBznAi/ewpjEYvJM4YShOTHzK9MNB9pfJs4hb4P9OrxKVaqZFk1vFkyinuqd
         40hjj6V51DWCESI2+ysdEU/S8r0f1+SLg0vN15uyXxN1R72d9cz3UZNVClJkYYIv1lIc
         P+diEssbd1T5oNjHcD5b4fL+wF1z+T5AzeAcfNIryB/VgP6cSz5BnpQjcu9pe1hxbeKx
         VGaBdyW8HXBKWHweVXettAIpnZa6qNu6s3HGJJwlkIELP0On0dVUdJ52xowHqR9ljwrI
         infFcupQnifyvcBaVDg1uQ2PWBVbTov5WrlgZDQMMj4+Oi5fLGPnzL2IKQ/WKPCb2UHr
         X9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lW187BX7pvnv89/fgKm/N1OWRtkvU+9tvFLWWwcKajk=;
        fh=EVpcmgmv5HBW+asomJQTq3sx/gFajzzm+LZ7LCRnSKI=;
        b=BMUDUfW9Ej9GOEfTNUwgFMaLIsZUMZ3g5jKvd5Tc0QRwRpZ6VMH8p1AMNFHavWbrFX
         UbPPRsZye3bE9U5gKxt84iKAnJj1W/R0QBW7Nn5JySInKYwntnvqlUWtqiejhSgMNyU9
         L68S0A1EVnC45fGi3avx4BH8xmzXt0VBXmXkA2pNDLuGtPND0fmHHkwkn6QeKAYa0njT
         ZtgYt7hwasHmWyDAEhSNAMXEKwKx2UVm+NgX5KEuEULjZMNEcDWDluMukvsz+UiHdWUJ
         Qpt73b2pWrNYaJMhgULsT1s2yK92CD4Zmk52BotWbv7wVaN3lKN+oK7wkOvg9Z+w/KC5
         giAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793032004; x=1793636804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lW187BX7pvnv89/fgKm/N1OWRtkvU+9tvFLWWwcKajk=;
        b=MUOvYbUGJvLRY+4ozSTJAEYhkO+CViDCgDR/3HRZ2ZWklhcxdU68sVei8SZjibc+9J
         J/ZNuFm8p9TkB2fxCuz3OVOlpf2qJp2bkWOYL6xSqXJ86bQpdYp+2R+NuOF3onvlTqMA
         Je20QgRQFsAlFNpoRVlKQx/997AKY43XUf9v7WKQD5FKqoZM//oU3SRUwQG2FwMcct48
         FPWtM84uU9h6uUcStZ5/AMLizASUvfEq+/F9MQT9uXBPbHezFapVQJANiRTyQ1zgykLO
         +TstMVO6d3IdV6JbtXoZLedXzaQgSP4HKjde5q+zJ2c8iK3D6Wtb0C/VG7RPtmcKiKA+
         ejWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032004; x=1793636804;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lW187BX7pvnv89/fgKm/N1OWRtkvU+9tvFLWWwcKajk=;
        b=2WdbeYnR8qV62nZKKtfcc0NnbknbgRJx0FQv0FYVDa/E3cWO+n+IT5rAWs0in6LQaA
         KKSWCmGb/fMGdzAU90z5RfdKb30bq6cg2HPN0d5dvO1YlQU18EpsSUAlD7meyGf8eCAb
         fFdXZDR8E74oSHXZ42s5N2SC9rivn4GqnrEFqSdM817y8h+NQ5qpQ8XvnX6a8EZfYc1E
         9GFCpNyBwD7rG++a3uEik7OlosJ/bgnuk+X5y9tTxXKAje62VXqmZCz+cWRk/ekqfwA7
         Wvr2IAMlUTg5KOjOxCKY5wwTwJmsB8FySEmm2SV3+9yYJMdB5lxaQDW1P+jDdHtUmsFb
         TFKA==
X-Gm-Message-State: AFq9FYKVgwv/dpjhVL+7OLmtk5RPGAaw5dL3R0oIMf06HQlVsIiQ3/5R
	JOrOjaLR1bo39uDHgotcNvDYj9MgPiYdeRdzAJWzf/5hX4mTFrDwoziTFKy1K4256A3poXGURly
	jpGmV73qZA69kiwm05c3D7Z1iq7aHK3o=
X-Gm-Gg: AYBFou2Qrv9xTvuEqdckkBruiZbSzcA60SOPLjx4EmN73i071mbHGDaEQe2SJyQgJWk
	vFSQut75tzkVyQNVJOQG4E/vEh30pN2+WIQanR5QAAyYKHuF3DVC0tz0IdJL37g3aSr9U7LiG6T
	n4hmiezf8298n+Pl7WeY2Sf/YdJr72bWBmRM3yypEJCiwLGpqWUt/2Vk6cphsZDLAuThkLUAbrZ
	6Oe6kHz/rIL0F45TnZAJC2m5xaWvZ4sU9e/FuPQas4y5n4HgPkJ9rbHBtm6m6OoFTRyetSbaUio
	SnxUaLfIU2j5OXdixKlW1RawAQlxRNpFfMsESglYFAgMj3xJF14wI/GKiB0BM5soA5GSPiVN1Pk
	jwCJYClZ3tTtn/zJlG+IMsbY4FNXXKjMRDmowdnJJRMNbkNIoCNpuTFkZGf3g5dSE8zHjjA==
X-Received: by 2002:a17:907:961a:b0:c44:14d:d95d with SMTP id
 a640c23a62f3a-c46bde35b78mr860710466b.23.1793032003455; Mon, 26 Oct 2026
 09:26:43 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026154604.579823-2-bestswngs@gmail.com> <2f8371e4-ea8c-45d4-8a42-e1a616915b61@gmx.de>
In-Reply-To: <2f8371e4-ea8c-45d4-8a42-e1a616915b61@gmx.de>
From: Weiming Shi <bestswngs@gmail.com>
Date: Mon, 26 Oct 2026 09:26:07 -0700
X-Gm-Features: AclHuK8xJMkjzycsM_PGDEWxDNP3nAsGNewoI6y1CFU9ObUj4hzqU8eQ9FVmawY
Message-ID: <CANgPUi1WDS4aK9+7LO+O4D1JDvGd3isWVWps_W-ocD_fT39HAQ@mail.gmail.com>
Subject: Re: [PATCH v2] fbdev: vfb: Validate framebuffer geometry and memory size
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, co+b0df61d49532b2ee@bugs.sh, 
	Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Helge Deller <deller@gmx.de> =E4=BA=8E2026=E5=B9=B410=E6=9C=8826=E6=97=A5=
=E5=91=A8=E4=B8=80 09:06=E5=86=99=E9=81=93=EF=BC=9A
>
> On 10/26/26 16:46, Weiming Shi wrote:
> > FBIOPUT_VSCREENINFO can supply a virtual width large enough to
> > overflow get_line_length()'s int multiplication and bypass the
> > video-memory limit, allowing fbcon to write past the framebuffer. The
> > offset additions can also wrap, while an excessive videomemorysize
> > module parameter can be truncated when PAGE_ALIGN() is assigned to
> > unsigned int.
> >
> > Limit virtual geometry and offsets to 8192 x 8192 and cap video
> > memory at 512 MiB, keeping the stride, framebuffer-size, and generic
> > fbdev drawing calculations within their destination types.
> >
> > KASAN reports:
> >
> >    BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect
> >      drivers/video/fbdev/core/sysfillrect.c:24
> >    Write of size 8 at addr ffa0000001671000 by task poc/198
> >    sys_fillrect
> >      drivers/video/fbdev/core/sysfillrect.c:24
> >    bit_clear_margins
> >      drivers/video/fbdev/core/bitblit.c:247
> >    fbcon_clear_margins.constprop.0
> >      drivers/video/fbdev/core/fbcon.c:1410
> >    fbcon_switch
> >      drivers/video/fbdev/core/fbcon.c:2261
> >    redraw_screen
> >      drivers/tty/vt/vt.c:994
> >    fbcon_modechanged
> >      drivers/video/fbdev/core/fbcon.c:2693
> >    fbcon_update_vcs
> >      drivers/video/fbdev/core/fbcon.c:2732
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: <co+b0df61d49532b2ee@bugs.sh>
> > Suggested-by: Helge Deller <deller@gmx.de>
> > Assisted-by: LLM
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> > Changes in v2:
> > - Limit virtual geometry and offsets to 8192 x 8192. This retains 8K mo=
de
> >    support while bounding all generic fbdev drawing calculations.
> > - Cap videomemorysize at 512 MiB.
> > - Keep the existing arithmetic types now that all inputs are bounded.
> >
> >   drivers/video/fbdev/vfb.c | 17 ++++++++++++++++-
> >   1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
> > index de137b2bd..de40ba8c3 100644
> > --- a/drivers/video/fbdev/vfb.c
> > +++ b/drivers/video/fbdev/vfb.c
> > @@ -31,6 +31,9 @@
> >        */
> >
> >   #define VIDEOMEMSIZE        (1*1024*1024)   /* 1 MB */
> > +#define MAX_VIDEOMEMSIZE     (512 * 1024 * 1024)
> > +#define MAX_XRES             8192
> > +#define MAX_YRES             8192
> >
> >   static void *videomemory;
> >   static u_long videomemorysize =3D VIDEOMEMSIZE;
> > @@ -159,6 +162,14 @@ static int vfb_check_var(struct fb_var_screeninfo =
*var,
> >       else
> >               return -EINVAL;
> >
> > +     if (var->xres_virtual > MAX_XRES ||
> > +         var->yres_virtual > MAX_YRES)
> > +             return -EINVAL;
> > +
> > +     if (var->xoffset > MAX_XRES - var->xres ||
> > +         var->yoffset > MAX_YRES - var->yres)
> > +             return -EINVAL;
>
> Instead of returning EINVAL, I wonder if we could simply
> cap the resolutions at MAX_XRES/MAX_YRES?
>
>
> > +
> >       if (var->xres_virtual < var->xoffset + var->xres)
> >               var->xres_virtual =3D var->xoffset + var->xres;
> >       if (var->yres_virtual < var->yoffset + var->yres)
> > @@ -434,9 +445,13 @@ static int __init vfb_setup(char *options)
> >   static int vfb_probe(struct platform_device *dev)
> >   {
> >       struct fb_info *info;
> > -     unsigned int size =3D PAGE_ALIGN(videomemorysize);
> > +     unsigned int size;
> >       int retval =3D -ENOMEM;
> >
>
> and here maybe
>         videomemorysize =3D min(videomemorysize, MAX_VIDEOMEMSIZE);
>
> that way the driver loads even if the provided too big value?
>
> Helge
> > +     if (videomemorysize > MAX_VIDEOMEMSIZE)
> > +             return -EINVAL;
> > +     size =3D PAGE_ALIGN(videomemorysize);
>
>

Yes, that makes sense. I'll cap the geometry and videomemorysize as
suggested and send a v3.
