From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Subject: Re: [Linux-fbdev-devel] [PATCH 0/7] Detaching fbcon
Date: Mon, 12 Jun 2006 16:20:11 +0200
Message-ID: <1150122011.5693.17.camel@thor.lorrainebruecke.local>
References: <44856223.9010606@gmail.com> <448C19D7.5010706@t-online.de>
	 <448C83AD.9060200@gmail.com> <448D1C9E.7050606@t-online.de>
	 <448D5B4F.5080504@gmail.com>
	 <a5d587fb0606120628o203941c3h761bfffbb6ec08f7@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752001AbWFLOUU@vger.kernel.org>
In-Reply-To: <a5d587fb0606120628o203941c3h761bfffbb6ec08f7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>

On Mon, 2006-06-12 at 15:28 +0200, Michal Suchanek wrote:
>=20
> I like the possibility to change X resolution using fbset (from insid=
e
> X). I use it to correct problems caused by crashed X programs that
> change resolution. But I run X with the UseFbDev option.

Still, you should use something like xrandr instead, so the X server
knows about it.


--=20
Earthling Michel D=C3=A4nzer           |          http://tungstengraphi=
cs.com
Libre software enthusiast         |          Debian, X and DRI develope=
r
