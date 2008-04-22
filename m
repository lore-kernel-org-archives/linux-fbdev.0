From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Subject: Re: [PATCH 1/3] radeonfb: Fix 64 bits resources on 32 bits archs
Date: Tue, 22 Apr 2008 18:04:29 +0200
Message-ID: <1208880269.5632.262.camel@thor.sulgenrain.local>
References: <20080422012723.BA9F2DE13F@ozlabs.org>
	 <480E0A54.9010203@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757121AbYDVQEq@vger.kernel.org>
In-Reply-To: <480E0A54.9010203@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net, Hollis Blanchard <hollisb@us.ibm.com>, adaplas@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Detlev Zundel <dzu@denx.de>

On Tue, 2008-04-22 at 17:55 +0200, Christian Ehrhardt wrote:
>=20
> You see it e.g. when you try to initialize X11, the x11 radeon driver
> issues a FBIOGET_FSCREENINFO ioctl [...]

=46WIW, current versions of the xf86-video-ati radeon driver no longer =
use
radeonfb for anything.


--=20
Earthling Michel D=C3=A4nzer           |          http://tungstengraphi=
cs.com
Libre software enthusiast         |          Debian, X and DRI develope=
r
