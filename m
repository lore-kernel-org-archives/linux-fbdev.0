From: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: RE: Crosstool for EBD9312..
Date: Mon, 7 Mar 2005 21:16:40 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348113A47A7@mail.esn.co.in>
Reply-To: linux-fbdev-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Sender: linux-fbdev-users-admin@lists.sourceforge.net
Errors-To: linux-fbdev-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-users>,
	<mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-users@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-users>,
	<mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-users>
Content-Type: text/plain; charset="us-ascii"
To: J.A.K.Mouw@its.tudelft.nl, Michael Burian <dynmail1@gassner-waagen.at>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-fbdev-users@lists.sourceforge.netlinux-fbdev-users@lists.sourceforge.net

Hello Burian,

> The framebuffer implementation you get in the unofficial cirrus tree
> (ep93xx-2.6) is not accelerated. The latest cirrus release (for
> linux-2.4.21-rmk1) seems acclerated. Diff the source for details.
>=20
> Note that the unaccelerated 2.6 driver and the accelerated
> 2.4.21-rmk1-crus-whatever driver do not have a common anchestor,
> the 2.6. was implemented from scratch, using fb-skeleton.c
>=20

OK.

> To explain it short:
>=20
> if hardware acceleration is not available you'll have to emulate the
> missing features in software (always possible), which is usually slow.

Yes, right. This will be painful (performance wise).

>=20
> if hardware acceleration is available but the driver does not use it
> (emulates it as if it wasn't there) you still have a software-only
driver.
=20
You mean if the existing driver support is not accelerated, we need to
emulate it in software again. But Why, can't we rewrite the driver at
some places & make it work?

> if hardware acceleration is available and the driver makes use of
> it you've got a "accelerated" driver. In the ep93xx's case
> the "raster engine" is used then.

What is the raster engine? I goggled it, but did not find any thing
strong enough.
=20
My actual requirement is to rotate the screen by 90 degrees. Maillists
ask me to use Xfree86 as it already has such kind of a support to rotate
the screen.=20

Are there any side affects if I make use of the X server & rotate the
screen. I mean is there any application that makes use of the video
buffer directly without using X server and may fail to rotate the screen
as we are rotating the screen at X server level and not at fb level.

Also, if my device uses the console the screen rotation at X server
level will not work. I mean if.

Thanks & Regards,
mukund jampala



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
