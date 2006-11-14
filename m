From: Christian Hoffmann <chrmhoffmann@gmail.com>
Subject: Re: Fwd: [Suspend-devel] resume not working on
	acer ferrari 4005 with radeonfb enabled
Date: Tue, 14 Nov 2006 19:51:33 +0100
Message-ID: <200611141951.38949.chrmhoffmann@gmail.com>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com>
	<200611140008.55059.rjw@sisk.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0330633404=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gk3Ny-0007C1-ML for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 10:51:54 -0800
Received: from ug-out-1314.google.com ([66.249.92.174])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gk3Ny-0003PB-0r
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 10:51:54 -0800
Received: by ug-out-1314.google.com with SMTP id z38so1401147ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 14 Nov 2006 10:51:47 -0800 (PST)
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
Cc: Andrew Morton <akpm@osdl.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Solomon Peachy <pizza@shaftnet.org>, Pavel Machek <pavel@ucw.cz>

--===============0330633404==
Content-Type: multipart/signed; boundary="nextPart4798411.Y9qFbjklld";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4798411.Y9qFbjklld
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
> > > > succeeded. I can pass console=ttyUSB0 to the kernel and
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
> > unregister_netdevice: waiting for eth2 to become free. Usage count = 1
>
> Hm.  Is your kernel compiled with CONFIG_DISABLE_CONSOLE_SUSPEND set?
>
> Rafael
No, I don't even have your patch installed that gives that option.

Chris

--nextPart4798411.Y9qFbjklld
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARVoQOtonrF4PGGDNAQIc6Q/9F/V1369/stWZWO6KtZ53avvjRkOBpjbV
gwmmTzhH/PMInElIWs8kXK5KsJ4WmAWvwIjLyHx+WwH6N6iaBAwNvCUkDkaOTVgC
SHNi7wbJJfU09WfgKOifetzYoOnWLic3j1CzQ5ZzGQkXdjT8t0CfqhiKviz04LKf
9Ria+Rq+zuQSGL3Wgz6zjtcI/0to5w3xTYcXiZSx/SxQOxn7+kYuXhcQA5zRpmL6
fmItFEhuHLvxBjG/AV5+qOKj1H+31iEJGPbBWVcU0OgI1x8g0+6jZod/DCI1E1Me
YmHUctwWLr/Bn1NyUItZH6d00eIxR7U5TBj6sH/Ndcgb98H5sbGkzKnKLZTLIVD6
1jCjXtFPp67kqLH4MCx88HcFTS34MMY0WHVSldRwdewbY9HWFP59hRpIRD2sxnry
l4OPuQCfdfHJevdKL3kZTn4psYNHBtsLcLvKLAZigu/i1dN+ywvE2tkHHE8LdemU
Pwc3UWIM2YNAbpiVhpe5lkDaQAbFcMFEAcoRved5IlfPG57tU3W8YybzzfhazhyQ
LT4nfrtuJR42hDobsY1vOyhZWTdm4gSP32DdKnhCs5uCJ3/WtKt92wPyQSdDn6dw
cY5azCP+7l8qzFbeDnz8pZhnQhTTz5vXtS9ZoIbD29xyF4cplohJMCPq7Jw5rJFh
vQXpOyo4Aqc=
=Zf1j
-----END PGP SIGNATURE-----

--nextPart4798411.Y9qFbjklld--


--===============0330633404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0330633404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0330633404==--
