From: Christian Hoffmann <chrmhoffmann@gmail.com>
Subject: Re: Fwd: [Suspend-devel] resume not working on
	acer ferrari 4005 with radeonfb enabled
Date: Tue, 14 Nov 2006 22:47:49 +0100
Message-ID: <200611142247.55137.chrmhoffmann@gmail.com>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com>
	<200611140008.55059.rjw@sisk.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0170426688=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gk68Y-0007mj-33 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 13:48:10 -0800
Received: from nf-out-0910.google.com ([64.233.182.188])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gk68W-0001Hk-De
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 13:48:10 -0800
Received: by nf-out-0910.google.com with SMTP id c31so733195nfb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 14 Nov 2006 13:48:07 -0800 (PST)
In-Reply-To: <200611140008.55059.rjw@sisk.pl>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Solomon Peachy <pizza@shaftnet.org>, Pavel Machek <pavel@ucw.cz>

--===============0170426688==
Content-Type: multipart/signed; boundary="nextPart1990370.NSl1Nzi9yF";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1990370.NSl1Nzi9yF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 14 November 2006 00:08, Rafael J. Wysocki wrote:
> On Monday, 13 November 2006 23:08, Christian Hoffmann wrote:
> > > -----Original Message-----
> > > From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> > > Sent: Monday, November 13, 2006 3:06 PM
> > > To: Christian Hoffmann
> > > Cc: Pavel Machek; Benjamin Herrenschmidt; Andrew Morton;
> > > Solomon Peachy; linux-fbdev-devel@lists.sourceforge.net; LKML
> > > Subject: Re: Fwd: [Suspend-devel] resume not working on acer
> > > ferrari 4005 with radeonfb enabled
> > >
> > > On Monday, 13 November 2006 11:51, Christian Hoffmann wrote:
> > > > > -----Original Message-----
> > > > > From: Pavel Machek [mailto:pavel@ucw.cz]
> > > > > Sent: Sunday, November 12, 2006 1:14 PM
> > > > > To: Benjamin Herrenschmidt
> > > > > Cc: Christian Hoffmann; Andrew Morton; Solomon Peachy; Rafael J.
> > > > > Wysocki; linux-fbdev-devel@lists.sourceforge.net; LKML;
> > > > > Christian@ogre.sisk.pl; Hoffmann@albercik.sisk.pl
> > > > > Subject: Re: Fwd: [Suspend-devel] resume not working on
> > >
> > > acer ferrari
> > >
> > > > > 4005 with radeonfb enabled
> > > > >
> > > > > Hi!
> > > > >
> > > > > > > Then the radeonfb doesn't kick in at all (guess some
> > >
> > > pci ids are
> > >
> > > > > > > added in that patch).
> > > > > > >
> > > > > > > BTW: resume/suspend works ok if I have the vesa fb enabled.
> > > > > >
> > > > > > In that case (vesafb), when does the screen come back
> > > > >
> > > > > precisely ? Do
> > > > >
> > > > > > you get console mode back and then X ? Or it only comes
> > >
> > > back when
> > >
> > > > > > going back to X ? Do you have some userland-type vbetool
> > > > >
> > > > > thingy that
> > > > >
> > > > > > bring it back ?
> > > > >
> > > > > He's using s3_bios+s3_mode, so kernel does some BIOS
> > >
> > > calls to reinit
> > >
> > > > > the video. It should come out in text mode, too.
> > > > >
> > > > > Christian, can you unload radeonfb before suspend/reload it after
> > > > > resume?
> > > >
> > > > Will it work if radeonfb is compiled as module? I think I
> > >
> > > had problems
> > >
> > > > with that, but I'll try again.
> > > >
> > > > > Next possibility is setting up serial console and adding some
> > > > > printks to radeon...
> > > >
> > > > Unfortunatly, the laptop doesn't have serial port. I tried to get a
> > > > USB device (pocketpc) read the USB serial, but I only partially
> > > > succeeded. I can pass console=3DttyUSB0 to the kernel and
> > >
> > > load the ipaq
> > >
> > > > serial console driver as it oopses. I am able to echo strings to
> > > > /dev/ttyUSB0  and read them on the ipaq, but I am not able to
> > > > "deviate" the kernel messages to that port. Any hints on how to do
> > > > that would be very appreciated, I didn't find anything
> > >
> > > usefull on the
> > >
> > > > web. (I tried with setconsole /dev/ttyUSB0 but it gives error msg
> > > > about device busy or something)
> > >
> > > Would it be practicable to use netconsole on your box?  If
> > > so, it should work.
> >
> > I tried netconsole, and it somehow works, but when suspending it says in
> > an "infinite" loop:
> >
> > unregister_netdevice: waiting for eth2 to become free. Usage count =3D 1
>
> Hm.  Is your kernel compiled with CONFIG_DISABLE_CONSOLE_SUSPEND set?
>
> Rafael

I tried that patch, but the last message I see over netconsole (using tg3) =
is:
Suspending console(s)
and then nothing. Nothing on resume at all :(

Adding some printks in the radeonfb_pci_suspend and radeonfb_pci_resume=20
(radeon_pm.c) didn't help: I don't see them. But I am not a kernel programm=
er=20
at all, so I might do something wrong or in the wrong place.

Chris

--nextPart1990370.NSl1Nzi9yF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARVo5itonrF4PGGDNAQKcXQ//exYPS3r5nq/TEH1x12dE18o7SUTttMGD
F+zGUWOAHWqE9FEC8TCqbIiav5xCos7Dn6sI4DvPEKTZnkYYiKiTZOxOq6pj1Ath
VMNwHoaXqljwUAxGPBRrtQJ/+S2hFVt57C5eCfwpdPawqqfkcw1xDkuoocl8aPdg
6hGpnv+EV0NOpFG6X+GVnbdHoUbWqMIJBwR/lLo0+ntDRsiQRZILFB6/NGCJXMvC
rc1P/0KgpkCzPJYfuqkmGs/Z8bRiPq+a8fqiNX8WOYUg0o6YokQ2rBNl5NBWxgxY
PIXGUZJV6i5wVdTdjqi3AgmT0/6DR8pTaDzE5PdUmEdcrJ8Hh3m8U1OFSgpM+LkE
z7YZ8qd45FtRv6SdDt+XFpMjGgLVUuBFVvXDBdDWrwrEQOH+Y84GEgQiz4U/VkM6
6fcMQtaZpj8rrs9HA1KWtFUf33B2UROYqhjECdVvLVw7hlgW3BRDpyp8mIBYa88d
Yo+oTWLIBh+1sr8aUt3/iXJiKlBXwZaxdjHiDXRLzmL1EupEgMHTmruDIzW1kDl5
DZIzDNfYyfeKmC/YIP+/Wu5Q3ykq2Y27FgEaT7uObafCuOeZM7MUOO/wPl7Ro2vb
mknm2kh1DeT8HxffwzH7Paa6e4MM+F526WyngVmK4HrDRPF+ojYlbDbx62FVIhnI
ZWNeXtCQEog=
=THAM
-----END PGP SIGNATURE-----

--nextPart1990370.NSl1Nzi9yF--


--===============0170426688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0170426688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0170426688==--
