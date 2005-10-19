From: "Nathanael D. Noblet" <nathanael@gnat.ca>
Subject: Re: Re: [directfb-users] Framebuffer woes...
Date: Wed, 19 Oct 2005 12:11:41 -0700
Message-ID: <1129749102.25223.7.camel@localhost.localdomain>
References: <1129687824.25556.32.camel@localhost.localdomain>
 <4355D310.1060203@gmail.com> <4355E708.1000702@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ESJLl-0003qD-VY
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 19 Oct 2005 12:11:46 -0700
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10] helo=pd4mo3so.prod.shaw.ca)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ESJLk-0002dc-Jd
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 19 Oct 2005 12:11:45 -0700
Received: from pd3mr8so.prod.shaw.ca (pd3mr8so-qfe3.prod.shaw.ca [10.0.141.24])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0IOM00MCPFZJ0V50@l-daemon> for
 linux-fbdev-devel@lists.sourceforge.net; Wed, 19 Oct 2005 13:11:43 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
 by pd3mr8so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0IOM00MH2FZI9A10@pd3mr8so.prod.shaw.ca> for
 linux-fbdev-devel@lists.sourceforge.net; Wed, 19 Oct 2005 13:11:43 -0600 (MDT)
Received: from [192.168.0.2] (S010600119576abd3.gv.shawcable.net [24.69.163.8])
 by l-daemon (iPlanet Messaging Server 5.2 HotFix 1.18 (built Jul 28 2003))
 with ESMTP id <0IOM0050CFZIBS@l-daemon> for
 linux-fbdev-devel@lists.sourceforge.net; Wed, 19 Oct 2005 13:11:42 -0600 (MDT)
In-reply-to: <4355E708.1000702@t-online.de>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, directfb-users@directfb.org

On Wed, 2005-10-19 at 08:26 +0200, Knut Petersen wrote:
> Hi Nathanael,
>=20
> >>I have a VIA EPIA board. It has a built in Trident graphics adapt=
er. The
> >>problem I'm having is that when I try to get it to run, the lcd O=
SD
> >>throws up an error message about 'Out Of Range', sometimes blanki=
ng the
> >>screen, sometimes not.
> >>
> >>   =20
> >>
>=20
> What kind of Epia? I suppose Epia 800 or Epia 5000. If that=C2=B4s =
the case,=20
> disable
> tridentfb and enable the cyblafb driver included in the 2.6.14-rc k=
ernels.
>=20
> >>mode "1024x768-76"
> >>    # D: 78.653 MHz, H: 59.949 kHz, V: 75.694 Hz
> >>    geometry 1024 768 1024 768 16
> >>    timings 12714 128 32 16 4 128 4
> >>    rgba 5/11,6/5,5/0,0/0
> >>endmode
> >>
> >>   =20
> >>
> Add
>        video=3Dcyblafb:1024x768,bpp=3D16,ref=3D76
> to the  kernel command line. If that does not help immediately, use
>        video=3Dcyblafb:1024x768,bpp=3D16,ref=3D76,verbosity=3D2 vga=
=3D0x317
> and send complete dmesg output after booting as well as lspci -vv o=
utput.
>=20
> There will be a lot of debugging output, be sure to use a big enoug=
h
> buffer size for kernel messages.
>=20
> >>All of those (regardless of depth (8,16,24) all produce 'out of r=
ange'
> >>problems.
> >>
> >>   =20
> >>
> tridentfb timing calcualtion was broken in 2.4 kernels and is broke=
n for=20
> 2.6 kernels,
> at least for the cyberblade/i1.

Well thank you SOO much. I'm not done yet, but those messages are gon=
e.
I will continue testing & working on this, if I run into more problem=
s
or bugs I'll post any feedback/information I have.

--=20
Nathanael D. Noblet
Gnat Solutions, Inc
http://www.gnat.ca/
T 250.385.4613
C 250.383.4613




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
