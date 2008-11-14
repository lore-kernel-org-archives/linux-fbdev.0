From: <JosephChan@via.com.tw>
Subject: RE: [PATCH] Fix crash in viafb due to 4k stack overflow
Date: Fri, 14 Nov 2008 16:41:26 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB808226A07@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752498AbYKNIlp@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: JosephChan@via.com.tw, akpm@linux-foundation.org, bonbons@linux-vserver.org
Cc: arjan@infradead.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, ScottFang@viatech.com.cn

After testing the patch with 2.6.28-rc4 kernel, I found something stran=
ge in both viafb built-in and module modes.
See the result on my EPIA-EX (CX700) below. Based on the result, it loo=
ks like something wrong with the new patch.

Kernel 2.6.28-rc4 + viafb-fix-crash-due-to-4k-stack-overflow.patch

1. w/o patching the viafb-fix-crash-due-to-4k-stack-overflow.patch
=3D> System works properly without "kernel panic" issue.

2. w/ patching the viafb-fix-crash-due-to-4k-stack-overflow.patch
=3D> System hangs with "kernel panic" randomly after loading the viafb =
module.
     Such as:
BUG: unable to handle kernel NULL pointer dereference at 000000c7
IP: [<c03dc6ec>] rt_worker_func+0xc7/0x15d
Last sysfs file: /sys/class/graphics/fb0/dev
Modules linked in: viafb i2c_algo_bit via_rhine sg pata_via sd_mod ehci=
_hcd

Pid: 6, comm: events/0 Not tainted (2.6.28-rc4b #1) pn test
EIP: 0060:[<c03dc6ec>] EFLAGS: 00010286 CPU:0
EIP is at rt_worker_func+0xc7/0x15d
=2E.....
=2E...
=2E....


BRs,
Joseph

-----Original Message-----
=46rom: Joseph Chan=20
Sent: Thursday, November 13, 2008 8:58 AM
To: 'Andrew Morton'; Bruno Pr=E9mont
Cc: arjan@infradead.org; linux-fbdev-devel@lists.sourceforge.net; linux=
-kernel@vger.kernel.org
Subject: RE: [PATCH] Fix crash in viafb due to 4k stack overflow

I will try this new patch later. :)

BRs,
Joseph Chan

-----Original Message-----
=46rom: Andrew Morton [mailto:akpm@linux-foundation.org]
Sent: Thursday, November 13, 2008 7:01 AM
To: Bruno Pr=E9mont
Cc: arjan@infradead.org; Joseph Chan; linux-fbdev-devel@lists.sourcefor=
ge.net; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix crash in viafb due to 4k stack overflow

On Mon, 10 Nov 2008 22:00:46 +0100
Bruno Pr__mont <bonbons@linux-vserver.org> wrote:

> During conversion of viafb_ioctl() I noticed the following:
>=20
> Those two cases just copy_from_user and do nothing with copied data,=20
> incomplete implementation?:
>         case VIAFB_SET_PANEL_POSITION:
>                 if (copy_from_user(&u.panel_pos_size_para, argp,
>                                    sizeof(u.panel_pos_size_para)))
>                         return -EFAULT;
>                 break;
>         case VIAFB_SET_PANEL_SIZE:
>                 if (copy_from_user(&u.panel_pos_size_para, argp,
>                                    sizeof(u.panel_pos_size_para)))
>                         return -EFAULT;
>                 break;
>=20
> Handling of GET/SET GAMMA looks buggy:
> In each case 256*4 bytes are allocated but only 4 bytes (size of
> pointer) are copied to/from userspace though
> viafb_(get|set)_gamma_table() operates on the full 256 elements...
>         case VIAFB_SET_GAMMA_LUT:
>                 viafb_gamma_table =3D kmalloc(256 * sizeof(u32), GFP_=
KERNEL);
>                 if (!viafb_gamma_table)
>                         return -ENOMEM;
>                 if (copy_from_user(viafb_gamma_table, argp,
>                                 sizeof(viafb_gamma_table))) {
>                         kfree(viafb_gamma_table);
>                         return -EFAULT;
>                 }
>                 viafb_set_gamma_table(viafb_bpp, viafb_gamma_table);
>                 kfree(viafb_gamma_table);
>                 break;
>=20
>         case VIAFB_GET_GAMMA_LUT:
>                 viafb_gamma_table =3D kmalloc(256 * sizeof(u32), GFP_=
KERNEL);
>                 if (!viafb_gamma_table)
>                         return -ENOMEM;
>                 viafb_get_gamma_table(viafb_gamma_table);
>                 if (copy_to_user(argp, viafb_gamma_table,
>                         sizeof(viafb_gamma_table))) {
>                         kfree(viafb_gamma_table);
>                         return -EFAULT;
>                 }
>                 kfree(viafb_gamma_table);
>                 break;
>=20
> I don't know if there is a userspace app that uses these VIA IOCTLs..=
=2E
> so the ioctl part is just compile-tested.
> After checking, fbset just uses some generic framebuffer IOCTLs=20
> outside of viafb's scope, thus not passing through viafb_ioctl().
>=20
>=20
>=20
> ---
> --- linux-2.6.28-rc3/drivers/video/via/viafbdev.c.orig	2008-11-09 19:=
36:47.000000000 +0100
> +++ linux-2.6.28-rc3/drivers/video/via/viafbdev.c	2008-11-10 20:50:32=
=2E000000000 +0100

hm, OK, I dropped the old patch and merged this one.

It'd be nice to have it runtime tested and reviewed by Joseph, but we h=
aven't heard from him yet.  viafb might be 8k-stacks-only in 2.6.27, wh=
ich would be bad.
