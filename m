Received: from mail-ua2-f42.google.com (mail-ua2-f42.google.com [74.125.226.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B881FF7C8
	for <linux-fbdev@vger.kernel.org>; Thu,  1 Oct 2026 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790885867; cv=pass; b=AyMtRKKiRlZdC0VdU+yhWoztL/A1OwxG1bHnEwz/rYYL0fX3eKjZIpdR4u1ZhrSnMYYHEJQZDDuOujm6o7AafN0VQjearWG8fqvUnMvcQZzSuLD/2VznE3AnGUX/V2o+Vvh+iuscwDLAXtXNN9z2p8muGbt46ceiL8u1izmpnT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790885867; c=relaxed/simple;
	bh=PqLEnAhdWY4goD9GpAA/y+PQMN4ckdrxb2RJsFoXOlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vp4DB9y3U4gchc0kFP+mqULo6gA4KRTaStpiSjKPNXmy36hbRgOhnoYGipWOLlnxZWs/F9fLWw235I3fz5frOK3i3IGU9IZwqUoXOP+xf/tSy4KlZ8AbEzhbCUvT6TZtMOS/3RDYRJxrzq4ouTtCdu3yLT6ywpB2c89ENVITimU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YF9N0WhW; arc=pass smtp.client-ip=74.125.226.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF9N0WhW"
Received: by mail-ua2-f42.google.com with SMTP id a1e0cc1a2514c-988ce00f22dso895191241.3
        for <linux-fbdev@vger.kernel.org>; Thu, 01 Oct 2026 13:17:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790885865; cv=none;
        d=google.com; s=arc-20260327;
        b=WyWeG5RQuJthlYbBzDiPTAafBxhyS87b6WvMkgOrEUOmCzixofhoDCFspxmr+6WzBV
         Qixrur/CeaP6rOFvBPh9BVAqy6/g7qbu3aV7jjsSdJpJwCYsOkdodZEH+J4KGySW+dwO
         OdawDB4LSk+LXNbMJ4w+YIjzl4uTPiGDV/yOONzQf3Jat0ir9+hLlre2vck+Eq5uzm7K
         05jvByzdpVzdhpfHp6wofzYGEZH3AkGLqyHVD6PD0oYXI8Q4cXw0IDiLalIFNdalYvuJ
         YYYuDGBbilFc24tLSlrt0WLE0Jirx5s6cwazgGds5Q0duPwcapo/tTV8KTPvD0FhusvL
         qw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6tkKgICqIcJIGkBovWHK92OXP6OvdcQ+ysdZiv7iOmM=;
        fh=3roxRPs/uESKbQS3hUNQWlbFDi24UAQEFJkb3iYIb0o=;
        b=owPvhtn0xFUvMjJrDjEa8OEO4KeWbbj/6FpZ6imV7+C+4wOYaDZqFWylxV57AwWilL
         YJZgQIHnqCQg1ZQxUZcpbYbJtBd09HymoCr44dVKhYyEb+qWX0WBv+2VGvz63BeOVkgz
         AwOexEpmyjct8vQSdDhdsR1TnJ+/5rH0+l+Z4CQGgY9YOtuj3o5kxNes5GjTGeJ7uaiQ
         T7C5CMqIrzs+En5XBYaP4Oxx6rH+Baf/nx4arME0SOCmZ6kEmTI4vaPK/B4XO31t/+QS
         /tqpkJVozPoVrm51G6Evs3iPziP2XmnNSVCwMmYa+OJ73wGYuEibKL11RKm8EYciAHKD
         jlWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790885865; x=1791490665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6tkKgICqIcJIGkBovWHK92OXP6OvdcQ+ysdZiv7iOmM=;
        b=YF9N0WhWy+XpK6U4boK/iaw+QbfyDbqOmmCSHmfa+o63WHb9IyESBMoZx+7Bpv+BtN
         Sk/E49W0aw251HdhA99Q+G8xQsOgydxRWszIGvhUOd3JHU/MhqN9Wp55oiH4TgXhxsVP
         Wc4m8S9L7DMTDGA3JGRL6F7JnRA+9E5EjgesTr6k+OKdXAs1a0kfQktJKM+KJDS8S85a
         0AygCSPkBXNVxmVyChrh7sR50arfDBZ8G3H6Wgl0YR7GBJAgFjuh0L8sj1Xu8dpdlsX/
         QxKD1Y44iXm8TAy0eyhdsdKElA+wrPGAI2fmhdtDfNj/pU7cj0YqdrT8loPFnS0kgdaU
         j2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790885865; x=1791490665;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6tkKgICqIcJIGkBovWHK92OXP6OvdcQ+ysdZiv7iOmM=;
        b=gVkMOC8k+myXp0biLfF39I5pCmIcPi0Zeh98Z3/c69qpAzzZHVUQqez4ET0r/dkDN6
         U1KoDDmQvW8GQ1DQNYj5ZylyAD5Yg1ilwk+1FsP/+Vo/isYPAQRUzG953kT3zg/s6ERX
         /30J2qe2dIcYBR55gHddNuhVLiExu44LVgK3hOjKnLSSYYTOomEPUfYcoby2DGFZ3KSv
         ah14hm1v8ZumZ/G1mbkR+pZbLKeABLJSjwxf0t1Z2n+l9RBX8o6sbR3u3Ao8J2jgRs7b
         njpYT8qWrNYBs8DxVmu6c8CW/LDW75rBmcFylDE2Y1Lea9J+GhvegZ1btzfv9qNgSpHk
         ZXFw==
X-Forwarded-Encrypted: i=1; AKwUvBwr7jNWl0s1y65KKARWd+kW62+Tho+dMnDsiL9NJoIZw1AVLjITM1VNe8wCEvMC5RP75wPpqefSFEH46Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYIIejZmQk3gjS8yB7DynZ+fNn+xiitRqtzSVIqbsVwKpM+QjJiB
	EC7Gol/HY7dN5GKZYjR9GWP2J4ufYYREWO06QJumXbpXLYdO1/DxRnATSZFeBY/GaA/hBoI4Q/j
	Wlavy2YR+OmAyd2Vr6ufE1dWUplkZoXU=
X-Gm-Gg: AYBFou1LnpFlQnNHJVogYDtC3qWJELa+KwNcPBaWQTqtybW5LM8PJn8hUefj4eXM7Kx
	F+3bZJtWyHcmQ+UevbQaDDsR/8cB+49lYeHT1xPrSO7UDpFEryXrcAIGuGbwjixIIsGCwolP/y+
	HkULI7M+c9JsWmGHXf4ANuVL1p3WWhaJkTeAOJqtmyuBl90bmT0AMq//fEFmjf9iplF1pytt6ZF
	0YsgSgCOfUfz9fQ7olAMPtWpgFz7QCQPAo4eQailvmcrBqWoCob23NuXfBrPIjWx6Os7nA1waTG
	QYXbhrL9fV/8hfQmM2TTFAX82V/q6dCk5YL63Hk1Nqkeol4qoW49iQc3AjBTXNGkOg==
X-Received: by 2002:a05:6102:688f:b0:7a7:198a:c2c1 with SMTP id
 ada2fe7eead31-7c0f58ae607mr132715137.31.1790885864968; Thu, 01 Oct 2026
 13:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923201035.51007-1-maximpedraza@gmail.com>
 <64e273d4-2660-437d-8871-e2bfa3c377c9@suse.de> <CAEUXW=G2a=Qz-9P_2+EFe-GiW4WqdOjtSCxoO4P15u_J48nP9g@mail.gmail.com>
 <arbLHvCBqxG7zcf_@bywater> <CAEUXW=ELS1OCyDdy5Gx41g8twU5B8112gMct9uFqhdGVveRKMw@mail.gmail.com>
 <aryqYhHqFk3cXh9d@bywater>
In-Reply-To: <aryqYhHqFk3cXh9d@bywater>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Thu, 1 Oct 2026 22:17:31 +0200
X-Gm-Features: AclHuK_TJb3OzJ-b3Pi60bWWkDOOeJUZPt1GI9wR3Q6RdrK3y1nqllSCTtDORV8
Message-ID: <CAEUXW=G-iz7R=c=9pZS0vygX6YVJ1suFpAhyyjXb5KzUJGtwkQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Boot logo supplied by the device tree
To: Francesco Valla <francesco@valla.it>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This series is superseded by RFC v4 of the DRM splash client, which
adds the device tree support there, as Thomas suggested:

https://lore.kernel.org/all/20261001195847.141192-1-maximpedraza@gmail.com/

The node placement and the reserved memory region carried over; the
clut224 format and the ppmtodtlogo tool did not, as the client takes
BMP images. Helge, please drop this one.

Thanks to everyone who reviewed it.

M=C3=A0xim


El mi=C3=A9, 30 sept 2026 a las 8:32, Francesco Valla
(<francesco@valla.it>) escribi=C3=B3:
>
> Hi M=C3=A0xim,
>
> On Tue, Sep 29, 2026 at 01:46:36PM +0200, M=C3=A0xim Pedraza Padilla wrot=
e:
> > Hi Francesco,
> >
> > > v4 is planned but has been preempted by other activities - I am not a=
ble
> > > to give you an ETA at the moment. If you have capacity, feel free to
> > > take over.
> >
> > Thanks, I appreciate it. Since it is your series, I would like to run
> > past you what I would change before taking it on.
> >
> > The v4 would still be an RFC, based on drm-misc-next. Your patches keep
> > your authorship, with any fix to them folded in and noted in the commit
> > message.
> >
> > Fixes to what is in v3:
> >
> >   - the BGRT symbols exported, as in your patch for Mario, but with
> >     EXPORT_SYMBOL_GPL;
> >   - drm_splash_init_client() indexes modeset_mask by the number of
> >     modesets added in the first loop and by the number walked in the
> >     second, so an output without a mode ahead of a connected one gets
> >     the buffer instead;
> >   - for a tiled group, the first loop dereferences tiled->buffer before
> >     any buffer exists, and the width and height look swapped;
> >   - if the BMP firmware never arrives, the callback returns without
> >     waking the render thread, which is left in TASK_UNINTERRUPTIBLE for
> >     good;
> >   - the 24 bit blitters read each pixel as an unaligned u32, one byte
> >     past the image when the rows have no padding;
> >   - the image cleanup always calls memunmap(), which will need to know
> >     where the image came from once there is a third source;
> >   - the spaces in DRM_CLIENT_DEFAULT, in a patch of its own.
> >
>
> I suggest you also take at look at the review sashiko did for the V3
> [1], as it contains some good suggestions (some of them are already
> present in your list).
>
> > The modeset, tiling and render thread ones come from reading the code,
> > so I will reproduce them in qemu first. Tiling I cannot test at all.
> >
>
> I did not test tiling as well - I think it's a mode limited to some
> Intel cards?
>
> > Additions:
> >
> >   - a device tree image source: a node under /chosen with the BMP eithe=
r
> >     in the node itself (dtc's /incbin/) or in a reserved memory region,
> >     mapped with the same memremap() as the BGRT;
>
> A reserved memory region is (probably) a better idea, to allow change
> the splash without recompiling the devicetree.
>
> A possible usecase would be:
>
>  - bootloader reads the BMP image from a dedicated partition and loads
>    it to the reserved memory (very much like the BGRT path);
>  - splash client parses the devicetree, finds the memory region and
>    loads the image from there;
>  - userspace updates the dedicated partition with a different image.
>
> >   - placement from that node, a position with -1 centring an axis plus
> >     an offset, instead of always centring;
> >   - rotation, for the DT image and for BGRT images with the orientation
> >     bits set, which are skipped today;
> >   - the background colour coming from the same place as the image: the
> >     DT node can carry its own, splash_color goes with splash_bmp, and
> >     the Kconfig colour stays the default for everything else, BGRT
> >     included.
> >
> > The sources would be tried in the order DT, BGRT, BMP firmware, and
> > then just the colour. A DT node is only there if someone put it there
> > for that board, so it seemed right to let it win.
> >
> > Does that match what you had in mind? And how would you like to appear
> > in MAINTAINERS, as a maintainer next to me or as a reviewer?
> >
>
> Yes, please, either as a co-maintainer or as a reviewer, as you see fit.
>
> > If you are happy with it, I'll take you up on your offer.
> >
>
> Thank you for continuing the effort on this - I still believe it's
> useful, but currently is not fitting inside my schedule.
>
> > M=C3=A0xim
> >
>
> Regards,
> Francesco
>
>
> [1] https://sashiko.dev/#/patchset/20260510-drm_client_splash-v3-0-a9aee9=
f0b2fc%40valla.it
>
> > El vie, 25 sept 2026 a las 21:32, Francesco Valla
> > (<francesco@valla.it>) escribi=C3=B3:
> > >
> > > Hi M=C3=A0xim,
> > >
> > > On Fri, Sep 25, 2026 at 10:48:31AM +0200, M=C3=A0xim Pedraza Padilla =
wrote:
> > > > Hi Thomas,
> > > >
> > > > > the whole Linux logo on the console is somewhat gimmicky and IMHO=
 should
> > > > > not be further extended. Also fbdev as a whole has realistically =
run its
> > > > > course. We fix bugs and occasionally clean up the code, but it is
> > > > > questionable whether new feature make much sense. Even more so as=
 the
> > > > > drivers your system uses appear to be DRM ones.
> > > >
> > > > They are, it is tilcdc. Understood, I will drop the fbdev side, whi=
ch
> > > > also settles your comment on patch 1.
> > > >
> > > > > There is a proposal for a DRM splash screen at [1]. It retrieves =
the
> > > > > device vendor's logo from the firmware and displays it at the giv=
en
> > > > > coordinates. IMHO you should start with this series and add DT su=
pport
> > > > > there.
> > > >
> > > > Agreed. I have been following Francesco's series since Sam pointed =
me
> > > > at it, and it is where the DRM follow-up I mentioned in the cover l=
etter
> > > > belongs, rather than in a client of my own.
> > > >
> > > > A device tree source fits next to the BGRT one. The BGRT is the fir=
mware
> > > > handing the kernel an image and where to put it, and a DT system ha=
s no
> > > > such table. The BMP loaded as firmware only helps if the file is bu=
ilt
> > > > into the kernel, or if a filesystem is already there when the displ=
ay
> > > > comes up. With U-Boot's Falcon mode, the device tree is the only th=
ing
> > > > that reaches the kernel.
> > > >
> > > > So the plan would be a node under /chosen carrying a BMP, either in=
 the
> > > > node itself or in a reserved memory region the bootloader loaded it
> > > > into, with the placement properties from this series. The region is=
 the
> > > > same memremap() the BGRT source already does, only with the address
> > > > coming from the device tree.
> > > >
> > > > Rotation too: the client skips a BGRT image with the orientation bi=
ts
> > > > set today, and it could turn it instead. I will ask Rob separately =
how
> > > > he wants the image described, since that is what the binding hinges=
 on.
> > > >
> > > > Francesco, is a v4 on the way? Would you take a DT source as patche=
s on
> > > > top of your series, or would you rather I wait until it lands?
> > > >
> > >
> > > v4 is planned but has been preempted by other activities - I am not a=
ble
> > > to give you an ETA at the moment. If you have capacity, feel free to
> > > take over.
> > >
> > > > Max
> > > >
> > >
> > > Regards,
> > > Francesco
> > >
