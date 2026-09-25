Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8498448BA7
	for <linux-fbdev@vger.kernel.org>; Fri, 25 Sep 2026 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790326134; cv=pass; b=EJd7OeBOkHqiTmeg7XnLXX1qYPjWr7O6lEwGgQ5q6OaIe9L/5UxkoJp/ti6rRzRKOD1cWGxjV1FU+lrDD1wOJhvWRNj6EG9kQ/aTZ67iJcOOhKdmX7cL9NLCMAeR1vr/HpsBts2RFJwT03Fu7MsHg47NrTUN9z7aAX6kP8XBZoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790326134; c=relaxed/simple;
	bh=gauJN7JdNEDx+buCyqd3VHbvYdDh2e2ewuGyfJQewa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHEEiZ6RbmmgLFA97nsU5BclQ19aYB/irCR0XCx9Zd0r15p7YgWB8O14Byjl2OeqdBUFQ2dKWLZl7NDIl+1ESBJWlNuR0fUk4ZqyOuUCDwq0ofV8UeDxRpmkuHm6kUj1qcaONdvPY/SbG8hzVKg8r3pLA6d/UTESo/hwIgJMiu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rNyFxd/n; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNyFxd/n"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aaf10bf094so321667a12.2
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Sep 2026 01:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790326124; cv=none;
        d=google.com; s=arc-20260327;
        b=CeqpmTfUWKFKZroVDkq84W67S9E/L9Z+XF0gtz3ZzAiLMrPQ1cIx8wFU66/DRo3e5g
         ZID1aCcTVYczPmHvAAkk0ruEKQavFN34JIJ8nroBY2XtC2ANcTL0yMaF436TXgETF81u
         OBC67Xr2kI2skD/pCWigB0R1UrhXc8dywF2jqoaWqd3hoE7dhh2op5brUWIW3vKVrlJt
         RPYcfz19hQinlIHCefTLF/5aufGGXaY3VCVKQsY9uuVR/qJWku4xbeOELr+jVPgwUtF/
         /9hr6SK/5062JDOpql/H8vFEB8HYIFog9s1g2iPsCXwFZ6xABAIk+pV1JDeNw5VFBEV+
         0bHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QvIg3gtJ3ne9RMGhcBWBezpqaVocNGLhsAs+oiZ/Z6g=;
        fh=b17KXcFOis2b+HUn9eTs++Nzi1lVX50JTzfgQtSEFM0=;
        b=pJhnBUq7xjwidO886FwauATLKCPSK38TECwv1XbwUyswBcYBFmMWN2C4JAO2g6GoLj
         Nl73HozCqdzFPD2iSbZPrEc4aPReR8jmAnFmxzrDQIlX3vV2SdVcMcdrzRlCp0JMSmNX
         TJ6GAEG2fZJ3dtFSyCEWTpemQWNLssbzixubp1pFmNJLCHc3vnkbE5VKQvxGhAB64InF
         BuyT3yqsWOfaNMVILmXK7grbLmHJpVXuL6ch9wOVQIhind3OmPTsjbrzSvhMxmOl64xs
         HMSOzKW4PbZRDzFblK/ivMbwRr878fFJoOZ66v5gBQBnYi4ypbqONA5cPEenWTw+f0Jc
         poyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790326124; x=1790930924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QvIg3gtJ3ne9RMGhcBWBezpqaVocNGLhsAs+oiZ/Z6g=;
        b=rNyFxd/n7hPSoPBLPFNmjqcn90RgBc+wGqfe9ylg9F+b9M//nQHfUqxRA0DbQHhp86
         wCqpnTsECjC4tZTwsXZTOwYVnJcc+wHLKvBq54vpivK7OkLYmBU22/tN99PMMYmej3Ia
         xw+hdnxvMQNAn2l8OdXaQFtFdGeg51wlNxRBCDdLwY6qJVAffMY/PAvDhmIz6iziMQAU
         ZKwn15cjB0AjNHKJJlN4XToIBifAkGdDErtDcNav/KV6IEwCw8LkSKl9aUuPrEt0cVuD
         PPSNQ2yPKeI7YvbXs2DK52ZcmN+p9VJ6ukvpf75pIz5cA5/yf3mayryU89XBsIeCL1tz
         04xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790326124; x=1790930924;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QvIg3gtJ3ne9RMGhcBWBezpqaVocNGLhsAs+oiZ/Z6g=;
        b=SiZQmYFdYV7Ok2U4Jf1MhxZQGR+w465/PDBdm758Ks9LdzcwEu77cwhp0Yh3YHdxth
         TpCEssSVqSndZKVIPb7OM6sB0ygRSCuSUd1J3Y1vcYvPNdavlAXazVEuuhAjzm1bkAiA
         p2RQoztFsHZFXjC9wVLeDPPabpL4aOBrVXN4F6d5a1fLO+yHjW18bTclRZ1XR3HGxjFb
         NU2R7dj9vFaf+DR+i8c363h/CuEEpDDutNbdrA3gCWzH86Fg0n9InqXOzFhtPW0gRL0u
         gJFst4Agd8rYc9ZrS5V14UKhdFfefe3NJAJTu0jF4F/lINroOmJ7H1Yij5EQdk2GkIr7
         us5w==
X-Forwarded-Encrypted: i=1; AKwUvBymEJ3I1Qhsb5B8UIeph6LMuMpJGs7j4sDD5+SM4l5gL0bRIEuqDFJXgRU/zplgVHBYCenx40kPdZq/VQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mp+J/q6Td/xXxH0WKrAcPSbxfgbiNEmB0kH/e3HX9GDoVeD0hv
	2A1J33awYt/7hmNhwyPt9ZZ2PlrcaJPqiXTFbTNL++BWHRp8yZbumjoJor1h+f9lhAdt0jsajrs
	OOz6LnjFb0tTF+fDD3d0x404PgyV/RSd6sVDf
X-Gm-Gg: AYBFou1muoyjzOrj30aO8UpGxkGYXcZ26oDdhxT3f2EK+Z85nsJobaewsAbHboFaOj0
	SlnlsjdZrAmJRVukqmwijRI7TnMiijCgIkZSHrPzqyHAx9hm7ZIouPDsE7jnieAMXalf1oH3RD9
	2NEm+44QSpdLY1AzDdgX9NMpG7hYHAa0uhKBMsg0NMOAxVUAQ9eBt97X+JvrP3+SWVUXchRmjLM
	vnlSdK3IkuERDnWNha1JcbPpY+UU7QYjfIePLiCnBTs77JYMrgKpyNLyOb4uBhNLRF+Dq8vZkzi
	GttFRHwOQV/PWMtuueKkUxhqT/MdLLjYeoNryV6kJl2YQdI6HwcD1Hc=
X-Received: by 2002:a05:6402:24d4:b0:6aa:9f93:16c4 with SMTP id
 4fb4d7f45d1cf-6aac8f4aac3mr3566692a12.22.1790326123630; Fri, 25 Sep 2026
 01:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923201035.51007-1-maximpedraza@gmail.com> <64e273d4-2660-437d-8871-e2bfa3c377c9@suse.de>
In-Reply-To: <64e273d4-2660-437d-8871-e2bfa3c377c9@suse.de>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Fri, 25 Sep 2026 10:48:31 +0200
X-Gm-Features: AclHuK8L3-6NlXlRC7y4f0MJkO_RixkRbGaANjeKT0rfqAf4u1troaE7MC-VZQE
Message-ID: <CAEUXW=G2a=Qz-9P_2+EFe-GiW4WqdOjtSCxoO4P15u_J48nP9g@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Boot logo supplied by the device tree
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Helge Deller <deller@gmx.de>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Francesco Valla <francesco@valla.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

> the whole Linux logo on the console is somewhat gimmicky and IMHO should
> not be further extended. Also fbdev as a whole has realistically run its
> course. We fix bugs and occasionally clean up the code, but it is
> questionable whether new feature make much sense. Even more so as the
> drivers your system uses appear to be DRM ones.

They are, it is tilcdc. Understood, I will drop the fbdev side, which
also settles your comment on patch 1.

> There is a proposal for a DRM splash screen at [1]. It retrieves the
> device vendor's logo from the firmware and displays it at the given
> coordinates. IMHO you should start with this series and add DT support
> there.

Agreed. I have been following Francesco's series since Sam pointed me
at it, and it is where the DRM follow-up I mentioned in the cover letter
belongs, rather than in a client of my own.

A device tree source fits next to the BGRT one. The BGRT is the firmware
handing the kernel an image and where to put it, and a DT system has no
such table. The BMP loaded as firmware only helps if the file is built
into the kernel, or if a filesystem is already there when the display
comes up. With U-Boot's Falcon mode, the device tree is the only thing
that reaches the kernel.

So the plan would be a node under /chosen carrying a BMP, either in the
node itself or in a reserved memory region the bootloader loaded it
into, with the placement properties from this series. The region is the
same memremap() the BGRT source already does, only with the address
coming from the device tree.

Rotation too: the client skips a BGRT image with the orientation bits
set today, and it could turn it instead. I will ask Rob separately how
he wants the image described, since that is what the binding hinges on.

Francesco, is a v4 on the way? Would you take a DT source as patches on
top of your series, or would you rather I wait until it lands?

Max

El jue, 24 sept 2026 a las 14:21, Thomas Zimmermann
(<tzimmermann@suse.de>) escribi=C3=B3:
>
> Hi,
>
> the whole Linux logo on the console is somewhat gimmicky and IMHO should
> not be further extended. Also fbdev as a whole has realistically run its
> course. We fix bugs and occasionally clean up the code, but it is
> questionable whether new feature make much sense. Even more so as the
> drivers your system uses appear to be DRM ones.
>
> There is a proposal for a DRM splash screen at [1]. It retrieves the
> device vendor's logo from the firmware and displays it at the given
> coordinates. IMHO you should start with this series and add DT support
> there.
>
> Best regards
> Thomas
>
> [1]
> https://lore.kernel.org/dri-devel/20260510-drm_client_splash-v3-0-a9aee9f=
0b2fc@valla.it/
>
>
> Am 23.09.26 um 22:10 schrieb Max Pedraza:
> > Embedded products routinely need their own boot logo. Today that means
> > pointing CONFIG_LOGO_LINUX_CLUT224_FILE at a different image, which bak=
es
> > it into the kernel image. Two products that share a board support packa=
ge
> > but differ in branding therefore need two kernel builds, and rebranding=
 an
> > existing product means rebuilding and requalifying a kernel for what is
> > purely a cosmetic change.
> >
> > This series lets the logo be described by the device tree instead: a no=
de
> > compatible with "boot-logo-clut224" under /chosen supplies the image in
> > the same paletted format the built-in CLUT224 logos already use, and th=
e
> > kernel prefers it over the built-in ones when it is present and enabled=
.
> > If the node is absent or disabled, nothing changes.
> >
> > The image can come from the node itself (patches 2-3) or from a reserve=
d
> > memory region the bootloader filled in (patches 5-6), because the image
> > and its placement are independent axes of variation. One board sold to
> > several customers wants several device trees differing in the logo. One
> > customer with several products built on that board, with different pane=
ls,
> > wants the same logo placed differently on each: there the image belongs=
 in
> > a shared binary and only the placement belongs in the device tree.
> >
> > Patch 1 is a cleanup that stands on its own. fb_prepare_logo() works ou=
t
> > how many rows to keep clear for the logo and fb_show_logo_line() works =
out
> > where to draw it, and both open code the same decision; nothing makes t=
hem
> > agree, even though fbcon erases whatever falls outside the rows that we=
re
> > reserved. It gives the position a structure of its own, in linux_logo.h=
,
> > with -1 on an axis meaning centre on that axis, so that fb_center_logo
> > becomes a value rather than a second code path and both callers share o=
ne
> > calculation. No functional change. The device tree placement in patch 4
> > then only fills the same structure in from the node, which is parsed in
> > logo.c next to the image that comes from it, so that everything that kn=
ows
> > the binding lives in one place and the frame buffer code only asks for =
the
> > result.
> >
> > We have been carrying a cruder version of this downstream on an AM335x
> > product since 2020, across a handful of board revisions, and it has
> > removed a real maintenance burden for us.
> >
> > Where this fits
> > ---------------
> >
> > There are already ways to get a picture on the screen early, and this d=
oes
> > not replace any of them. A bootloader splash handed over through a
> > simple-framebuffer node is the earliest of all. A userspace splash is t=
he
> > most flexible, and is what most systems end up using. What neither cove=
rs
> > is the case where nothing initialises the display before the kernel doe=
s.
> >
> > That case is not exotic. U-Boot's SPL can boot the kernel directly, and
> > display initialisation lives in U-Boot proper, which then never runs:
> > there is no splash to hand over and nothing for a simple-framebuffer no=
de
> > to point at. Falcon mode exists to cut boot time, which is the same rea=
son
> > one cares about how early the logo appears, so the two tend to arrive
> > together. Userspace is far too late to fill that gap: on the board I
> > tested, the kernel has the panel up at 3.2 seconds.
> >
> > Rob Herring asked in v2 why a simple-framebuffer handover would not do,
> > and I answered that it did not work on our hardware. That was wrong, an=
d I
> > am correcting it here: the node I had measured it with was incomplete, =
and
> > with a complete one it does work. What it does not do is help where the=
re
> > is no splash to hand over in the first place, and it does not survive t=
he
> > native driver.
> >
> > simplefb registers fb0 at 1.79 seconds with the bootloader's image; til=
cdc
> > initialises at 3.16 seconds, registers its own fb1 and reprograms the
> > controller to scan that buffer, which starts empty, so the screen goes
> > black. Nothing is evicted and nothing is cleared: the two frame buffers
> > coexist, and cat /dev/fb0 > /dev/fb1 brings the picture straight back. =
It
> > is only that nobody does it, and by the time anything could, userspace =
is
> > already up, which is the moment a splash was there to cover. With
> > simpledrm it does not even survive in memory, since it hands its client=
s
> > shmem buffers and blits them onto the firmware framebuffer, so the firs=
t
> > frame any client commits overwrites what the bootloader drew. A logo th=
e
> > kernel draws itself has none of this: there is nothing to carry across.
> >
> > Notes on the binding
> > --------------------
> >
> >    - The compatible has no "linux," prefix. Rob asked why it was Linux
> >      specific, and nothing in the node is: it describes an image and wh=
ere
> >      it goes, which any consumer can read. A bootloader drawing the sam=
e
> >      logo before the kernel starts is the obvious other one. The 224 is=
 the
> >      palette limit of the format, which is what lets the kernel use the
> >      image the way it already uses its built-in logos, without converti=
ng
> >      it.
> >    - The palette size is derived from the length of the "clut" property
> >      instead of being a separate property, so it cannot disagree with t=
he
> >      palette actually supplied.
> >    - "data" holds plain palette indices. The 32 entry offset the frame
> >      buffer layer reserves for the console is an implementation detail =
and
> >      is applied by the kernel.
> >    - "logo-position" takes -1 on an axis to mean centre on that axis, w=
hich
> >      is what fb_center_logo already meant. A boolean could only centre =
both
> >      axes or neither, and next to explicit coordinates it would have to
> >      override them silently.
> >    - "logo-rotation" turns the logo, not the screen. "logo-position" an=
d
> >      "logo-offset" are screen pixels whatever the rotation says, and a
> >      quarter turn only changes how much room the logo takes up.
> >    - "logo-position" and "logo-offset" are spelled with the prefix beca=
use
> >      plain "position" and "offset" are already used elsewhere in the tr=
ee
> >      with an incompatible type, which dtschema rejects.
> >    - The reserved memory path takes a "memory-region" phandle rather th=
an a
> >      bare address. The reservation is what makes the memory safe to rea=
d at
> >      all, and it is what gives the kernel a size to bounds check agains=
t.
> >
> > The byte arrays are not written by hand: patch 7 adds ppmtodtlogo, a ho=
st
> > tool along the lines of the existing pnmtologo -- plain C, no
> > dependencies, no quantization of its own -- that turns a PPM image into
> > the node or into the memory region blob. It is what produced everything
> > tested below.
> >
> > Until chosen.yaml knows about the node, dtbs_check rejects it on any bo=
ard
> > that uses it: it allows only ^framebuffer under /chosen. I sent that on=
e
> > line change as dt-schema pull request 204, and Rob closed it saying he
> > expects it is either not needed or will change, given this discussion.
> > That seems like the right order to me, so I am not asking for it again
> > here: once the shape of the binding is settled, the schema change follo=
ws
> > from it, and I will send it then.
> >
> > On a system that has DRM but no frame buffer device, nothing draws the
> > logo at all: fbcon is what draws it today, and without it there is no
> > consumer. Showing it there needs an in-kernel DRM client, which I have
> > working on top of this series and will send separately. I mention it
> > because it is the reason the node is parsed in logo.c rather than in
> > fb_logo.c: the same node then puts the logo on the same pixel whichever=
 of
> > the two draws it, rotated or not, which I checked on the same board.
> >
> > Testing: built for arm with CONFIG_LOGO_DT_CLUT224 both enabled and
> > disabled, and each of the seven patches builds on its own, with the opt=
ion
> > enabled from the patch that introduces it. Also built for x86_64 with
> > CONFIG_OF=3Dn, where nothing is left unresolved and the placement data =
is
> > dropped from the image, and for powerpc Cell -- where SPU_BASE makes
> > CONFIG_FB_LOGO_EXTRA real -- to a linked vmlinux. No compiler warnings,
> > W=3D1 clean on the files touched, checkpatch --strict clean apart from =
the
> > MAINTAINERS reminder for the new tool, which the existing drivers/video=
/
> > entry already covers. A full dt_binding_check has one complaint for thi=
s
> > binding and none other in the whole tree: the chosen.yaml rejection
> > described above.
> >
> > Boot tested under qemu-system-arm -M versatilepb with PL111 and fbcon, =
at
> > 16bpp, over a 26 case matrix: absolute positions, per axis centring, al=
l
> > four corners, offsets including negative ones, out of range values, the
> > three rotations, and each rotation combined with an offset and with an
> > absolute position, each compared pixel by pixel against the source imag=
e
> > rotated to match. A position out of range on both axes is clamped to th=
e
> > corner, and the console text then overwrites the rows below what fbcon
> > reserved. Supplying the same image through a reserved region instead
> > produces an identical logo area. Blobs with a bad magic, a geometry lar=
ger
> > than the reservation and an out of range pixel are each rejected with a
> > warning, with no logo drawn and no crash.
> >
> > Also boot tested on real hardware: an AM335x board (tilcdc) with an
> > 800x480 panel at 16bpp. The product logo comes up where the node asks,
> > both carried in the device tree and taken from a bootloader-loaded
> > reserved memory region, and the two produce a frame buffer that is
> > identical byte for byte. Dumping /dev/fb0 and comparing it against the
> > source image, the logo lands on exactly the pixel the binding predicts:
> > 16836 of 16836 pixels match, and one pixel of displacement in any
> > direction drops that to about 90%. With logo-rotation =3D "ccw" it land=
s on
> > the rotated position the same way, every pixel.
> >
> > Changes since v2:
> >    - Rebased onto current mainline (v7.3-rc3).
> >    - Dropped the "linux," prefix from the compatible, and renamed the
> >      binding to match, per Rob.
> >    - A rotation asked for by the device tree now turns the logo and not=
 the
> >      screen: "logo-position" and "logo-offset" stay in screen pixels, a=
nd a
> >      quarter turn only changes how much room the logo takes up. v2 fed =
the
> >      device tree rotation into the path fbcon uses for a rotated consol=
e,
> >      which places the logo in the console's own frame and maps the resu=
lt
> >      back, so a vertical offset came out horizontal on a screen that wa=
s not
> >      rotated. Found by testing it on the panel. fb_rotate_logo() is spl=
it
> >      into the part that turns the image and the part that moves the
> >      placement, and the console path is unchanged.
> >    - The placement properties are read in logo.c, next to the image, an=
d the
> >      frame buffer code only asks for the result, so that the binding is
> >      parsed in a single place.
> >    - Added patch 1, which pulls the logo position out into something bo=
th
> >      fb_prepare_logo() and fb_show_logo_line() share, after Helge point=
ed out
> >      that the placement patch was stamped in rather than merged with th=
e
> >      existing code. That turned up a real bug: the reservation took the=
 larger
> >      of the console position and the device tree one while the drawing =
took
> >      only the device tree one.
> >    - IS_ENABLED() instead of #ifdef, per Helge, so the code is compile =
checked
> >      whatever the configuration.
> >    - The device tree is read once, from fb_prepare_logo(), rather than =
from
> >      every accessor.
> >    - Dropped "logo-centered" for -1 in "logo-position", per Helge.
> >    - The position and offset are added in 64 bits and both are bounded =
in the
> >      binding; in int, a large pair from the device tree wrapped instead=
 of
> >      landing against an edge.
> >    - The copy of the image is no longer freed from a late initcall, whi=
ch ran
> >      before async_synchronize_full() and so could pull it out from unde=
r a
> >      display driver still probing. Pixels are allocated with kvmalloc()=
.
> >    - The example declares compatible and model on the root node, and th=
e
> >      binding no longer requires the image properties unconditionally, w=
hich
> >      made the reserved memory form unreachable. Both found by Rob's bot=
.
> >    - Extra logos are not drawn when the device tree supplied the logo; =
they
> >      stack up from an arbitrary point once it has been placed.
> >
> >
> > Max Pedraza (7):
> >    fbdev: describe where the boot logo goes in one place
> >    dt-bindings: display: add a device tree supplied boot logo
> >    video: logo: allow the boot logo to come from the device tree
> >    fbdev: honour the device tree boot logo placement properties
> >    dt-bindings: display: allow the boot logo in a reserved memory regio=
n
> >    video: logo: allow the boot logo to come from a reserved memory regi=
on
> >    video: logo: add ppmtodtlogo host tool
> >
> >   .../bindings/display/boot-logo-clut224.yaml   | 161 +++++++
> >   MAINTAINERS                                   |   1 +
> >   drivers/video/fbdev/core/fb_logo.c            | 221 ++++++++--
> >   drivers/video/logo/Kconfig                    |  12 +
> >   drivers/video/logo/Makefile                   |   6 +-
> >   drivers/video/logo/logo.c                     | 332 +++++++++++++-
> >   drivers/video/logo/ppmtodtlogo.c              | 416 +++++++++++++++++=
+
> >   include/linux/linux_logo.h                    |  59 +++
> >   8 files changed, 1170 insertions(+), 38 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/display/boot-log=
o-clut224.yaml
> >   create mode 100644 drivers/video/logo/ppmtodtlogo.c
> >
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG N=C3=BCrnbe=
rg)
>
>
