From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: Seg fault on any FB write (Epson
 S1D13A04onColdfire running 2.6.25)
Date: Thu, 13 Nov 2008 12:55:02 +0100
Message-ID: <20081113125502.0e43a930.kristoffer.ericson@gmail.com>
References: <4918E5C3.2090108@one.net> <49195726.2060103@cetrtapot.si>
	<43185.137.237.242.42.1226415047.squirrel@webmail.nuvox.net>
	<49199EE3.5090101@cetrtapot.si>
	<1210.137.237.242.125.1226419828.squirrel@webmail.nuvox.net>
	<491A930F.2040507@cetrtapot.si> <491BB164.2020203@one.net>
	<491BEA6A.5060402@cetrtapot.si>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6925949310730742620=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1L0ZqL-0005RH-QK
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Nov 2008 10:54:33 +0000
Received: from nf-out-0910.google.com ([64.233.182.186])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L0ZqK-0001Rc-0G for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Nov 2008 10:54:33 +0000
Received: by nf-out-0910.google.com with SMTP id g16so411765nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Nov 2008 02:54:30 -0800 (PST)
In-Reply-To: <491BEA6A.5060402@cetrtapot.si>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Cc: linux-fbdev-devel@lists.sourceforge.net

--===============6925949310730742620==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__13_Nov_2008_12_55_02_+0100_mH0wRDxOtQ/IIL=X"

--Signature=_Thu__13_Nov_2008_12_55_02_+0100_mH0wRDxOtQ/IIL=X
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Nov 2008 09:50:50 +0100
Hinko Kocevar <hinko.kocevar@cetrtapot.si> wrote:

> James Kimble wrote:
> >=20
> > In looking at your driver (which I think is a lot better organized than
> > the general one that came with the kernel by the way) I see that you're
> > doing a whole string of:
> >=20
> >                                            ~~~~~~~~~~
> >    device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x12);
> >    device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x14);
> >    device_create_file(&s1d13706fb_device.dev, &dev_attr_reg_0x16);
> >                                             ~~~~~~~~~~    =20
> > In  s1d13706fb_init(). I didn't do any of this my driver. Is this needed
> > for any purpose other than to allow easy access to change the values in
> > these registers in user space?
> >=20
>=20
> It is there purely for debugging purposes. It also allows quick setup of
> eg. different LCD panels that require some tweaking in order to center the
> image or fix refresh rate.
>=20
> > I was able to port your driver to the values and registers used by my
> > device and the behavior is virtually the same as with my driver. Screen
> > is initialized, I can see the color palette get set and the panel
>=20
> And if you draw a pixel from the driver - does it work? Another quick test
> is to set color palette and then memset() complete framebuffer memory to
> a singles value stored in palette, or change the palette index value to
> achieve image color change on the screen.
>=20
> > enable. Everything boots up fine but none of my user space applications
> > work. The first time I try to write to a register or video memory I get
> > a seg fault.
> >=20
>=20
> Does the oops appear in the dmesg, too?
>=20
> > This has got to be some kind of memory configuration issue. I've moved
> > the CS configuration for this device to different memory locations but
> > it doesn't change the behavior. I'm setting things up in U-Boot in
> > exactly the same way I had been setting them up in Colilo for the 2.6.10
> > kernel (where everything worked).
> >=20

I agree, it sounds alot more like a deeper bug
than restricted to your video driver. I can't see
anything that would cause that (atleast yet). Would
be worth it to get some input from linux-m68k (coldfire m68k right?).

>=20
> What about other memory mapped devices you might have on the system? Do
> they function properly? If not this might be indicator where look for
> the problem.
>=20
> Regards,
> Hinko
>=20
> --=20
> Hinko Ko=C4=8Devar, OSS developer
> =C4=8CETRTA POT, d.o.o.
> Planina 3, 4000 Kranj, SI EU
> tel     ++386 (0) 4 280 66 03
> e-mail  hinko.kocevar@cetrtapot.si
> http    www.cetrtapot.si
>=20
>=20
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challe=
nge
> Build the coolest Linux based applications with Moblin SDK & win great pr=
izes
> Grand prize is a trip for two to an Open Source event anywhere in the wor=
ld
> http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Thu__13_Nov_2008_12_55_02_+0100_mH0wRDxOtQ/IIL=X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkcFZYACgkQPQls10ERAGcUHgCgu2btP8Pvn4StzFv9s5NYBps/
E/MAoK4FMmAjixTo4pVP2L++6Z3sWGfS
=S2aG
-----END PGP SIGNATURE-----

--Signature=_Thu__13_Nov_2008_12_55_02_+0100_mH0wRDxOtQ/IIL=X--


--===============6925949310730742620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============6925949310730742620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============6925949310730742620==--
