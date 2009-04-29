From: Dave Airlie <airlied@gmail.com>
Subject: Re: KMS + fb + FBIOPUT_VSCREENINFO
Date: Wed, 29 Apr 2009 17:27:11 +1000
Message-ID: <21d7e9970904290027v1275c346p8a8f29d2fb4658fb@mail.gmail.com>
References: <8563BBE2A1F848B3B98C1A5FAE08BD09@avitech.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757330AbZD2H1X@vger.kernel.org>
In-Reply-To: <8563BBE2A1F848B3B98C1A5FAE08BD09@avitech.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Peter Hanzel <hanzelpeter@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Tue, Apr 28, 2009 at 6:32 PM, Peter Hanzel <hanzelpeter@gmail.com> w=
rote:
> Hello.
>
> I have tried DRM with intel KMS and it is workiing. I am using only
> framebuffer console.
> Fbcon initializes 1280x800 mode and it works like a charm.
>
> But when I try to call FBIOPUT_VSCREENINFO on /dev/fb0, it always ret=
urns
> EINVAL,
> I have checked drivers/gpu/drm/i915/intel_fb.c
> and found that
>
> intelfb_check_var =A0 =A0 =A0 =A0returns -EINVAL =A0 =A0 if (var->pix=
clock =3D=3D -1 ||
> !var->pixclock)
> intelfb_set_par =A0 =A0 =A0 =A0 =A0 =A0 returns -EINVAL =A0 =A0if (va=
r->pixclock !=3D -1) {
> DRM_ERROR("PIXEL CLCOK SET\n"); =A0return
>
> So the FBIOPUT_VSCREENINFO always fails.
>
> So is the change of resolution not supported through FBIOPUT_VSCREENI=
NFO
> call?
>

The problem we've had is defining proper semantics for what happens in
multi-output systems when
 you call this ioctl. Which crtc/output should it set the mode on?
what happens if the mode isn't valid on all
connected monitors etc.

It should be quite trivial to hook up in fact I already did it once bef=
ore.

I think we probably need some sysfs or fb ioctl to configure which
crtc/output combos will get controlled
by an fbset.

kms also has an option to run with one fb per crtc, which could also
be checked out. I'm not sure how much further we got with it.

Dave.

> Thanks.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
