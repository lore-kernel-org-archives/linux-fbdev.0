From: Jan De Luyck <lkml@kcore.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] Sysfs for framebuffer
Date: Tue, 23 Mar 2004 17:01:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200403231701.19786.lkml@kcore.org>
References: <20040320174956.GA3177@dreamland.darkstar.lan> <200403231211.09334.lkml@kcore.org> <20040323122627.GA22830@lambda>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040323122627.GA22830@lambda>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: Text/Plain; charset="us-ascii"
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kronos <kronos@kronoz.cjb.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 23 March 2004 13:26, Sven Luther wrote:

> > - From a users point of view: if there are only to be framebuffer devices
> > listed in this class, why not call it just what it is: "Framebuffer" ?
> > Naming it after something it is only in a broad sense makes no sense to
> > me. I'd be looking in /sys/.../framebuffer instead of /sys/.../graphics
> > or /display.
>
> Notice that /display is what is used by most OF implementations, so this
> kinda makes sense. I would vote like BenH on this if i was consulted.

OF implementations?

>
> > Display would be the EDID info of my screen (physical), and graphics...
> > well... I'd half expect something like capture cards to be there...
>
> But this also makes sense, still, i guess we are concerned with more
> info than just the framebuffer, right ?

Yup. What's in a name indeed. But one might try to make it as non-confusing as 
possible.

Kind regards,

Jan De Luyck

- -- 
Anything is possible on paper.
		-- Ron McAfee
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAYF9OUQQOfidJUwQRAlUCAJ9gevHf51xYtw7Zu4PAAI3Lq+VvJgCbByUB
c2zgx+ZzG9zKZo/9Lslr76s=
=zzhB
-----END PGP SIGNATURE-----
