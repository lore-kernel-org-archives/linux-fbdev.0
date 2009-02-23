From: krzysztof.h1@poczta.fm
Subject: Re: 
	=?utf-8?q?=5BPATCH=5D_fb=3A_hide_cursor_in_gr?=
	=?utf-8?q?aphics_mode?=
Date: 23 Feb 2009 09:45:10 +0100
Message-ID: <20090223084511.1CA9A36FDC8__35744.6732269183$1235378886$gmane$org@f44.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1LbWRK-00029I-KD
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Feb 2009 08:45:26 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LbWRA-0003gG-W1 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Feb 2009 08:45:26 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Risto Suominen <risto.suominen@gmail.com>, Krzysztof Helt <krzysztof.h1@poczta.fm>, adaplas@pol.net, Andrew Morton <akpm@linux-foundation.org>, geert@linux-m68k.org, linux-fbdev-devel

Risto Suominen napisa=B3(a):
> Krzysztof, my patch is basically the same as yours. I already tried
> to send it to Xorg mailing list, but did not receive any feedback.
> =


Right. One should set zero the xoffset also (can be non-zero on some cards).

The Xfbdev is incorrectly designed as it uses settings read from one
console to apply them to another console. It breaks if someone uses two =

graphics  cards and the target console is on a different card then a =

current one.

I have to find out what how the problem above affects a HW cursor.

Regards,
Krzysztof

> If virtual resolution is higher than the screen (as in atyfb), and
> yoffset
> given by the framebuffer driver happens to be non-zero (fbcon changes it
> on-
> the-fly), Xfbdev places its image starting above the displayed part of
> the
> framebuffer. This patch makes sure that the whole picture is visible.
> =

> Signed-off-by: Risto Suominen >Risto.Suominen@gmail.com>
> ---
> The testing is done on version 1.1.1 and linux kernel version 2.6.18.
> =

> --- a/hw/kdrive/fbdev/fbdev.c.org       2006-07-05 21:31:39.000000000
> +0300
> +++ b/hw/kdrive/fbdev/fbdev.c   2009-01-18 15:42:06.000000000 +0200
> @@ -215,6 +215,8 @@ fbdevScreenInitialize (KdScreenInfo *scr
> =

>      /* Now get the new screeninfo */
>      ioctl (priv->fd, FBIOGET_VSCREENINFO, >priv->var);
> +    /* We can get anything into yoffset if fbcon is active */
> +    priv->var.yoffset =3D 0;
>      depth =3D priv->var.bits_per_pixel;
>      gray =3D priv->var.grayscale;
> =

> =




----------------------------------------------------------------------
Promocja w Speak Up. Angielski 50% gratis! =

Liczba miejsc ograniczona. Sprawd=BC!>> http://link.interia.pl/f205c



---------------------------------------------------------------------------=
---
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
