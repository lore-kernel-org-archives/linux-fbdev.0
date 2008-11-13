From: <JosephChan@via.com.tw>
Subject: Re: [PATCH] Fix crash in viafb due to 4k stack
	overflow
Date: Thu, 13 Nov 2008 08:58:22 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB8081F500A@exchtp03.taipei.via.com.tw>
References: <20081112150104.8f7a71f6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <JosephChan@via.com.tw>) id 1L0QjP-00045L-5y
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Nov 2008 01:10:47 +0000
Received: from exchtp08.via.com.tw ([61.66.243.7])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L0QjF-0001z0-61 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Nov 2008 01:10:47 +0000
Content-class: urn:content-classes:message
In-Reply-To: <20081112150104.8f7a71f6.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: akpm@linux-foundation.org, bonbons@linux-vserver.org
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, arjan@infradead.org

I will try this new patch later. :)

BRs,
Joseph Chan

-----Original Message-----
From: Andrew Morton [mailto:akpm@linux-foundation.org] =

Sent: Thursday, November 13, 2008 7:01 AM
To: Bruno Pr=E9mont
Cc: arjan@infradead.org; Joseph Chan; linux-fbdev-devel@lists.sourceforge.n=
et; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix crash in viafb due to 4k stack overflow

On Mon, 10 Nov 2008 22:00:46 +0100
Bruno Pr__mont <bonbons@linux-vserver.org> wrote:

> During conversion of viafb_ioctl() I noticed the following:
> =

> Those two cases just copy_from_user and do nothing with copied data, =

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
> =

> Handling of GET/SET GAMMA looks buggy:
> In each case 256*4 bytes are allocated but only 4 bytes (size of =

> pointer) are copied to/from userspace though =

> viafb_(get|set)_gamma_table() operates on the full 256 elements...
>         case VIAFB_SET_GAMMA_LUT:
>                 viafb_gamma_table =3D kmalloc(256 * sizeof(u32), GFP_KERN=
EL);
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
> =

>         case VIAFB_GET_GAMMA_LUT:
>                 viafb_gamma_table =3D kmalloc(256 * sizeof(u32), GFP_KERN=
EL);
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
> =

> I don't know if there is a userspace app that uses these VIA IOCTLs...
> so the ioctl part is just compile-tested.
> After checking, fbset just uses some generic framebuffer IOCTLs =

> outside of viafb's scope, thus not passing through viafb_ioctl().
> =

> =

> =

> ---
> --- linux-2.6.28-rc3/drivers/video/via/viafbdev.c.orig	2008-11-09 19:36:4=
7.000000000 +0100
> +++ linux-2.6.28-rc3/drivers/video/via/viafbdev.c	2008-11-10 20:50:32.000=
000000 +0100

hm, OK, I dropped the old patch and merged this one.

It'd be nice to have it runtime tested and reviewed by Joseph, but we haven=
't heard from him yet.  viafb might be 8k-stacks-only in 2.6.27, which woul=
d be bad.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
