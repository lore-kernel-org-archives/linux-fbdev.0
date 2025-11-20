Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD061D90DF
	for <linux-fbdev@vger.kernel.org>; Thu, 20 Nov 2025 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661670; cv=none; b=G9P12PeMtAgBPjpo/fpOJRGB65tV1pTjVH4xb3q6XNTsoMQhzWJv01MIsFr5YgQgHdGvUbOk47agw1RHeKS08SI1P3fn81biRPnjD82SFghvM2eKmiv2jeyWFxDMjGMs0j7xk1X2ty7LkK16RsxedMInJsmwxvR7HGK73SL/EXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661670; c=relaxed/simple;
	bh=SjyjrQ6s4TV6sJ8XGr/KKXZed2kb1vrF8/oTbosjCgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQP70o11wZeIrB6U/5cJcJVFJs/37EuQOXc4l6aK20fpljzTvo0QEle1lAaP9RLbK6ifoTdk7YsI+Bd3jvZCx7ONHcRnPznwsnJmTwc48GekLU7MckfxFRFxg6auNRwRAgwRlrwnlQD5oUOOqko8WYcJmxMhVTuDN6tJf97pWkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYuyNX4D; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYuyNX4D"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5958931c9c7so1313716e87.2
        for <linux-fbdev@vger.kernel.org>; Thu, 20 Nov 2025 10:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763661659; x=1764266459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4i+XBRMdEy12pL0HjcgWxdFQn5Uv2AViQ31Fb1aIWY=;
        b=WYuyNX4DPBPUaSbxR69IOu4HpUFvz01SaHhdXpTRlSpJpru4ISbsaCeyYAW9VKp6L4
         /u8ru/7e6HMY0fNwl0aH4wRSIpaC+8Z+LEB9xDtBF5lHFLxhzf+B4HtFFOz72bnL23QX
         qVOhRT82wgq97ylOMdKMHtz20/d38SOZaicQFKvOnU5eUIKS3dyJ49jdK7UfITysGycp
         FouU5AX+Pe2MIdk+JJVPlzNzn4Q2ivAVXtL2zP9WmFsnhY5SjB5hk1yMclJAdFPfOSGV
         hhYjQEzqF+gC6HTzwuKU7og7v62ko4WGlq1m5N32jXkTI9dmkNWSWkNytlDFz1eu8IP0
         IZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763661659; x=1764266459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e4i+XBRMdEy12pL0HjcgWxdFQn5Uv2AViQ31Fb1aIWY=;
        b=tzN5C73Rf5/zUZsCUqGGvQEcs8tNrKaE4MkB+jmveMYRbfx7cC/9+AqunArgpD0mWN
         mbVDfBxPDhhOs6FQyNokRY7A7Z2vHGikAHKvvv+Ix2sd7+hJNvWNRG8NzFQzPZV2M9IA
         M01OrxnjsN+drmhNLXS9Tr8KYVAuQhXVKanPWB0rBOMtoGcu+FAbClwbtLJ2vR5UbAJr
         4ts4PEdrrf5+cC+CNoAAZw4L9nfmC+78wwBVpINWYicskmu/2PisiWiqYkld0qioW5/f
         f8Ln79mi0gINghqSxnvDfSf6jmRFcfqZeoytq39TCH6K3fLAMIa7mOkMhVFfs+WYP+tV
         I3ww==
X-Forwarded-Encrypted: i=1; AJvYcCWqlS2WHYE0tMg43eAI5IbIlLn5eYJLu7uwcxZJg6/hFHmDiRq33nfI7FUZ3WKi8Hi8kbJpYUycN50/gA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGdZnXOgzVzv/c2WWU8/h2aXlSbZFbmpu+ax4jEv3HAiQuvPVB
	sREjCg0rgSsuciDJFVnBnTmcP6b2dThLEBjtHy/X3CfsRSUjE0SjprNekPgdhyg3xfV6qmemfzT
	Abw94LYqWxQlo40vbXfCEczytVsORpd0agCiuD0XoWRgW
X-Gm-Gg: ASbGnctdWZggfSO8LAnP4TvRDxnpsIeWoc0Ac5Imn1QXjtDc29reANOWbMBzHmuq5ND
	aBvH/LOVxhQVtKr2jzRYl4IEiLl3ef1WBjLh4W/KGhKM4Dh0ZWTzRZBluIfXjCfHs+yPW2LX5If
	bf3ihbt6vV/IrKDbzL0JpvvKftqg6MkgaFjmW81FHWPgBoOwScfwgUzGDNmzH2oNc/0mSY8VXga
	DfiGc4hXJjjTFpNePqCfUVSiVdA1XgMKih4jNPT5/x6EJMGIKUXH45mqjIZXbC/woQw4yXYn7W4
	o632wn/GjhqHbn8OMDyypVnHhsE/
X-Google-Smtp-Source: AGHT+IHahn8Y/hERYatOt3b0WUUo2gmSRmy3wN7QEwtkGV+n5IPr/Emi48mtcyvcilgV4k5PIyQiZnjo7H/5FRrbfk8=
X-Received: by 2002:a05:6512:15a2:b0:594:51ac:13e with SMTP id
 2adb3069b0e04-5969e2c5badmr1388220e87.17.1763661658684; Thu, 20 Nov 2025
 10:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118095700.393474-1-hsukrut3@gmail.com> <4ec784a5-0f67-4fd3-9d51-d89a9fa9a385@gmail.com>
In-Reply-To: <4ec784a5-0f67-4fd3-9d51-d89a9fa9a385@gmail.com>
From: sukrut heroorkar <hsukrut3@gmail.com>
Date: Thu, 20 Nov 2025 23:30:46 +0530
X-Gm-Features: AWmQ_bkm9gCUmV6YMuwXUBLKyVsWtV8rR0o7D9LtASeWj-n-9-UVTo-Ks6EE5Yc
Message-ID: <CAHCkknoKsS7bjgR5WaV0-1e_2mB1XiqXi_Y_UWyAeC5N8PfPRw@mail.gmail.com>
Subject: Re: [PATCH] fbdev: q40fb: request memory region
To: David Hunter <david.hunter.linux@gmail.com>
Cc: Helge Deller <deller@gmx.de>, 
	"open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, 
	"open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 7:27=E2=80=AFPM David Hunter
<david.hunter.linux@gmail.com> wrote:
>
> On 11/18/25 04:56, Sukrut Heroorkar wrote:
> > The q40fb driver uses a fixed physical address but never reserves
> > the corresponding I/O region. Reserve the range  as suggested in
> > Documentation/gpu/todo.rst ("Request memory regions in all fbdev driver=
s").
> >
> > No functional change beyond claming the resource. This change is compil=
e
> > tested only.
>
> Reserving memory is a significant "functional" change, so you should not
> put "No functional change...". I have noticed that in the mentorship
> program, mentees might say this often times when they have not done
> testing.
>
> Thank you for describing that you did a compile test, but I believe that
> more testing should be done before this patch is accepted.
qemu-system-m68k does not emulate a Q40 machine, thus the change
was compile tested only with W=3D1 & debugging enabled.
>
> As a result, if you are unable to test this device, I believe that an
> RFT tag should be used. Also, the testing information goes below the
> "---". This puts it in the change log and would make it so that if a
> patch is accepted, everything below the change log is not put in the
> commit message.
Thank you. I will make a note of this for the future patches.
> >
> > Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
> > ---
> >  drivers/video/fbdev/q40fb.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/video/fbdev/q40fb.c b/drivers/video/fbdev/q40fb.c
> > index 1ff8fa176124..935260326c6f 100644
> > --- a/drivers/video/fbdev/q40fb.c
> > +++ b/drivers/video/fbdev/q40fb.c
> > @@ -101,6 +101,12 @@ static int q40fb_probe(struct platform_device *dev=
)
> >       info->par =3D NULL;
> >       info->screen_base =3D (char *) q40fb_fix.smem_start;
> >
> > +     if (!request_mem_region(q40fb_fix.smem_start, q40fb_fix.smem_len,
> > +                             "q40fb")) {
> > +             dev_err(&dev->dev, "cannot reserve video memory at 0x%lx\=
n",
> > +                     q40fb_fix.smem_start);
> > +     }
> > +
>
> Is this correct? It seems to me that in the case of an error, all you
> are doing is simply logging the error and proceeding. Would this cause
> the device to continue to try to use space that it was not able to
> reserve? I do not have experience with this device or the driver, but
> that does not seem correct to me.
I referred to a patch, which was recently accepted, having a similar
implementation.
However, other fbdev drivers with similar implementation, returns a
-EBUSY  when the
If() evaluates true indicating resource already being occupied.  I
will make the necessary
changes and resend the patch as RFT.
>
> >       if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
> >               framebuffer_release(info);
> >               return -ENOMEM;
> > @@ -144,6 +150,7 @@ static int __init q40fb_init(void)
> >               if (ret)
> >                       platform_driver_unregister(&q40fb_driver);
> >       }
> > +
> >       return ret;
> >  }
> >
>
