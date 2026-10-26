Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793029789;
	b=XMI4o7Zpl9T6dzkzPDRofa9XB66IKPcZ2cfeWP5LzPLkCf1s1uqRMBb116rb8Al8YChD
	 FvTh4RTM6PYzfAurCCXM6k5Pi6It6Z/dBoi4wFr+5SxW6u9WEMK2bAVRC+gdBPT5NphuU
	 tws5Z8hAsLgb9HaNa/asP+gtMzsJRlC41j9wscx2VHbyOiJgEhkfoBGIYm5V0p87oF4bz
	 X5nnbTaRiIHoxXnvZkDAkCx7p5k+D3C7fQuzukHYQe5PjWUGEUJxlzEkKSHzeegML0Ao5
	 wJtROpWO2lWx+ak/Hc/QlCtGKkGGCY/JUkTfzZTGq+Y5KdUaY17xcS+VopEJdPrvRTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=LuKCUhjbeOX3G6yTs4pSwfb4wNEV8f8KmzUas8xg7eY=;
	b=qQ38FxZiCXU0ZDoiVHFnaRIuVDAd/LEzeMX8ie7vzKMKr4KABr9yToELb8hoCRyMgu6H
	 8ukae7ZHN3iYGwj90RHtomt+PULmouCkbhwL+r6h8LWP20og0YrZ5fXZ+b/hWFqW9x11e
	 tsLzbUdosvewTJb/hTmAzDShMC4OBaFYMCeXXbN0mEXGP3eOtxoymZuYJaRNohxIsIbNV
	 8Wp16OJbSfj26ImRQESgXM8dKoNThSILzUakPyoF+zDr3rkBGyBX26s7fgaMQYQtxiz1u
	 bM2IFSIyPvwEGLU3Cofo9/QOatTrFhNhHCA/JicskiDv5dGZNU8ZygXOt7oEnz9VdBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O6D8gvKx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC11F606A31B
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 15:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC11F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O6D8gvKx
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c315869241fso399665266b.0
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 08:49:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793029787; cv=none;
        d=google.com; s=arc-20260327;
        b=pTS+xZ/VaxHAlANhs3MGLwolkb8n8Nd3jiEDxUna3dvH6/Qj5VD2X8p2KSg8L2pTs3
         aaNuH4kWyBXUcRAfKc3ucDPc3EgmSUV6SyWerFx2P9qQpyHHmB8r5y9XM7S8IbOWbI2X
         y2yxWKd5Z5ceKl0dcjefdpyJxLxSqinr/inhPhW51j8r6DN2hwXOEq1IHPOmfkLhPALP
         wvpjqzjPsL3ywYLvy2fzAf9WRAszxKgNUNqHytaL3TnTByjqmpMVxy6fhdFR+a9E2iox
         YzK+Xk4Y2amLK2w/Z1Z3/55wGE/coRcfuqCBzl72h69CPaGn3nNaxZrmve3zMpMYJeDh
         iRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LuKCUhjbeOX3G6yTs4pSwfb4wNEV8f8KmzUas8xg7eY=;
        fh=yZJq/6wsCfs0NwKHZyqtHNH8sDXFPPRQj54cpoHjumo=;
        b=lb7mDfe3B8dpPterb2rbSQtMsk1DCPRDQrlMtfEHDB7A3VylD/J+0jLkVJI/wx8Bm/
         br/jFRrG6kAJIirU4DnOEtMMdqnzuLrPwC7veKNj2eOV4esaNTq5clfdG8TLHIrwXpjM
         MgNnkaPuFm8vQmqfSZYVaiavOnjD31pcJLN527wtPZ77iOvAnYRXwFOC8GRfqBKlV9zd
         RfJkSjJNcyaFBG6OPVkoNyRNKxEWkslSlF2r+6aWkVL6S1xOlRadql5WMDLmp7Gws+yU
         rV+F7J5s1gH9eqM6psB6JdwTY/MFvt9dm3jKDXJVngZdzUdBpn3x89M5bWL4AGeIMMLI
         gtbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793029787; x=1793634587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LuKCUhjbeOX3G6yTs4pSwfb4wNEV8f8KmzUas8xg7eY=;
        b=O6D8gvKx54v4dsR8YAYGcxK+85DcAY5IABfprIRSDaATYpabq/fGfJEstJa+Ox/+VB
         HBAWLPqKQDB1eFEj2Ejjf7wf0f9TZWM98TjPDICVP5x37jTjCoJnNd61EWVVIQ7dTvRD
         9hooDZ99yAsxtojQZCawm/wClyEpXpcfe1bwB1NWbqn1yD6KSBhNvlks38B0b73kMff8
         MChRmMf+M+BJkvAWWEV+QQe5iOJ8LZPGeIIoNBh3lu5UU84fs8XWhIOT9rA8ZvVEad5I
         7/CJU41asmw26M8hAdsxB2S1cQ/zKlM4Rps0HWvDncmPMgI4zHaSe0EhcwSHdK620pWb
         0vLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793029787; x=1793634587;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LuKCUhjbeOX3G6yTs4pSwfb4wNEV8f8KmzUas8xg7eY=;
        b=ty1q/WXbDtphGjSVrdz8sWqfGaFsDHZhaGVSIBsaPMQSVOQ+KJnpMJhOzw7tpy1F2O
         BUX275vr6VACRYEJcdYGh7KirNNROwPRuwYU1rkvkqhEQsml57o8xpEp4EZ37RSIKmWo
         o/B4WZIwqNFuYHjHbmWd69yN53Iq1AlOcBiNXc2PvaFyunHjBIzUkPPwETimXiHy88d0
         uy7zph45+5uMJd8xsh/iCiwdZegBNt0lIl2yweyJyCVkaUGHgffD/HjnSviagmryjqdw
         1cjwZ9vdFjViA4pmEMNIpWcgkZzOLr8fWR2SIN+xoMmaja9D0CV9C08i9sLWMStv4hLd
         ZMyw==
X-Gm-Message-State: AFq9FYKDfdKx7oJDWyz7YImio3IpGqOyHivuJPZ1HpDS+EdfyEwL1W3i
	GgWHRUBKrbON24LPLCJ3I8pD/hupeEEVSH/e4pEp/owXF4bSlrQHsEhiMCLdqYrFHMdsrpChwNk
	WnWEri0vQE1sQxzFAU39U6p+Sfvp1l4Y=
X-Gm-Gg: AYBFou11mxbyYWvqNW6Jjdq2RsaxUGY4VpXUmp/a0HDY4fRJoKxoJUrMzdqq6ZuYRX9
	lCK0RgW70LSCCcMigKd/Z/7HJ6GlqjWC3iScbuPyUaOlAykrgxEOhJ2z4QXUIrRkoxsRbLj05SH
	sVnTUlCCf1KhvdoJw2ppKhj+pQpgAQRRv1rPWfG6N/5JxhY2Cx869jmZ76pyNC1F134Tw5D28In
	kgmyV/z1VnR/1Oe6BBCpyD4gDgEhxMtK0HVQZmjM51QHsTw63x5dyhbfVub3wYd3TI7X9bxNTTf
	TVLEW0R5XzINj61ePU6jPo8RJPHNu0vy1Ct6rOGBAgsXxE+MMd0YtUkVPWSF0U6UFOSewFWlQVu
	0xJURTvPJH5QY9VybuB3HVCxMmuYhnvzEMmbIp8wrgjUyMOl9JYLRSZaiGwb2daWmNcqx8A==
X-Received: by 2002:a05:6938:e081:20b0:c45:b99:f282 with SMTP id
 a640c23a62f3a-c46c19961d9mr554911866b.7.1793029787038; Mon, 26 Oct 2026
 08:49:47 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023175128.4127122-2-bestswngs@gmail.com> <f5a860e9-7b8f-400c-8d30-44f62e5129b8@gmx.de>
In-Reply-To: <f5a860e9-7b8f-400c-8d30-44f62e5129b8@gmx.de>
From: Weiming Shi <bestswngs@gmail.com>
Date: Mon, 26 Oct 2026 08:49:10 -0700
X-Gm-Features: AclHuK87d0T070FMTlQKiyTb8NOFRveqVBojRHsTQZkg5N_7T-c0np5SCvqWpSI
Message-ID: <CANgPUi3MF6j-K+51MVFtZ39Ve9sUT801Jyewqn8i0hKDSEw86A@mail.gmail.com>
Subject: Re: [PATCH] fbdev: vfb: Validate framebuffer geometry and memory size
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, co+b0df61d49532b2ee@bugs.sh, 
	Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Helge Deller <deller@gmx.de> =E4=BA=8E2026=E5=B9=B410=E6=9C=8825=E6=97=A5=
=E5=91=A8=E6=97=A5 12:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On 10/23/26 19:51, Weiming Shi wrote:
> > get_line_length() multiplies two int operands before assigning the
> > result to u_long. Setting xres_virtual to 0x8000000 at 32 bpp therefore
>
> A xres_virtual value of 134217728 seems quite unrealistic IMHO...
>
> > wraps the product to zero and bypasses vfb_check_var()'s video-memory
> > limit. fbcon can then clear margins with a zero line stride and write
> > past the vmalloc'ed framebuffer.
> >
> > The xoffset + xres and yoffset + yres calculations can likewise wrap,
> > leaving an invalid offset in info->var after fb_pan_display() rejects
> > it. Subsequent fbcon drawing can then access far beyond the framebuffer=
.
> >
> > Finally, PAGE_ALIGN(videomemorysize) was narrowed from unsigned long to
> > unsigned int. Values near or above 4 GiB could therefore allocate a muc=
h
> > smaller buffer than the size used for mode validation.
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
> > Reject video-memory sizes whose aligned value is not representable by
> > the fbdev metadata. Check the offset additions for overflow. Compute th=
e
> > line length and framebuffer size in u64, reject unrepresentable line
> > lengths, and check the total-size multiplication before comparing it
> > with the allocated video-memory size.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: <co+b0df61d49532b2ee@bugs.sh>
> > Assisted-by: LLM
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >   drivers/video/fbdev/vfb.c | 31 +++++++++++++++++++++----------
> >   1 file changed, 21 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
> > index de137b2bd..84b0a937c 100644
> > --- a/drivers/video/fbdev/vfb.c
> > +++ b/drivers/video/fbdev/vfb.c
> > @@ -101,11 +101,11 @@ static const struct fb_ops vfb_ops =3D {
> >        *  Internal routines
> >        */
> >
> > -static u_long get_line_length(int xres_virtual, int bpp)
> > +static u64 get_line_length(u32 xres_virtual, u32 bpp)
>
>
> Instead of trying to extend to 64bit, I think we should simply
> limit the maximum allowed screen sizes to e.g. 4096 x 4096
> (or some other realistic values).
>
>
> >   {
> > -     u_long length;
> > +     u64 length;
> >
> > -     length =3D xres_virtual * bpp;
> > +     length =3D (u64)xres_virtual * bpp;
> >       length =3D (length + 31) & ~31;
> >       length >>=3D 3;
> >       return (length);
> > @@ -122,7 +122,8 @@ static u_long get_line_length(int xres_virtual, int=
 bpp)
> >   static int vfb_check_var(struct fb_var_screeninfo *var,
> >                        struct fb_info *info)
> >   {
> > -     u_long line_length;
> > +     u64 line_length, size;
> > +     u32 xres, yres;
> >
> >       /*
> >        *  FB_VMODE_CONUPDATE and FB_VMODE_SMOOTH_XPAN are equal!
> > @@ -159,17 +160,23 @@ static int vfb_check_var(struct fb_var_screeninfo=
 *var,
> >       else
> >               return -EINVAL;
> >
> > -     if (var->xres_virtual < var->xoffset + var->xres)
> > -             var->xres_virtual =3D var->xoffset + var->xres;
> > -     if (var->yres_virtual < var->yoffset + var->yres)
> > -             var->yres_virtual =3D var->yoffset + var->yres;
> > +     if (check_add_overflow(var->xoffset, var->xres, &xres) ||
> > +         check_add_overflow(var->yoffset, var->yres, &yres))
> > +             return -EINVAL;
> > +
> > +     if (var->xres_virtual < xres)
> > +             var->xres_virtual =3D xres;
> > +     if (var->yres_virtual < yres)
> > +             var->yres_virtual =3D yres;
> >
> >       /*
> >        *  Memory limit
> >        */
> >       line_length =3D
> >           get_line_length(var->xres_virtual, var->bits_per_pixel);
> > -     if (line_length * var->yres_virtual > videomemorysize)
> > +     if (line_length > U32_MAX ||
> > +         check_mul_overflow(line_length, (u64)var->yres_virtual, &size=
) ||
> > +         size > videomemorysize)
> >               return -ENOMEM;
> >
> >       /*
> > @@ -434,9 +441,13 @@ static int __init vfb_setup(char *options)
> >   static int vfb_probe(struct platform_device *dev)
> >   {
> >       struct fb_info *info;
> > -     unsigned int size =3D PAGE_ALIGN(videomemorysize);
> > +     unsigned int size;
> >       int retval =3D -ENOMEM;
> >
> > +     if (videomemorysize > U32_MAX - (PAGE_SIZE - 1))
> > +             return -EINVAL;
> > +     size =3D PAGE_ALIGN(videomemorysize);
>
> same here.
> There doesn't seem to be a maximum limit for videomemorysize.
> Maybe adding a check and allow a maximum of e.g. 512MB ?
>
> Will you send a revised patch?
>
> Helge

Thanks for your review. v2 sent.
