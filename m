From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [Xpert]PPC -- XFree86 (ati) support for 1280x854-16 with Radeon
 Mobility M7 LW (new Apple Titanium)?
Date: 06 Aug 2002 12:02:21 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1028628142.1097.569.camel@tibook>
References: <20020806063014.91902.qmail@web13001.mail.yahoo.com>
	<1028617305.3298.55.camel@turbulence.megapathdsl.net> 
	<1028618001.3298.68.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from netline-be1.netline.ch ([195.141.226.32])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17c1AZ-0004qF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 06 Aug 2002 03:02:27 -0700
In-Reply-To: <1028618001.3298.68.camel@turbulence.megapathdsl.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: xpert@xfree86.org
Cc: linux-fbdev-devel@lists.sourceforge.net


[ CC: to linux-fbdev-devel as this should also cover some of your
questions there ]

On Tue, 2002-08-06 at 09:13, Miles Lane wrote:
>=20
> What's the status with XFree86 support for the new
> 800MHz Titanium PowerBook?  Every time I have tried
> to start the XFree86 HEAD ati driver, it locks up
> my machine.
>=20
> I have tried starting the server at 8bpp, disabling
> accelleration and forcing PCIMode. =20
>=20
> XFree86 -configure gave me the following (commented out
> lines removed):
>=20
> Section "Device"
> 	Identifier  "Card0"
> 	Driver      "ati"
> 	VendorName  "ATI Technologies Inc"
> 	BoardName   "Radeon Mobility M7 LW"
> 	BusID       "PCI:0:16:0"
> EndSection
>=20
> dmesg (SuSE 2.4.16-npmac kernel):
>=20
> radeonfb: ref_clk=3D2700, ref_div=3D12, xclk=3D36675 from OF
> radeonfb: Failed to detect DFP panel size
> Using unsupported 1280x854 ATY,Crown_A at bc008000, depth=3D8, pitch=3D12=
80
> Console: switching to colour frame buffer device 160x53
> fb0: Open Firmware frame buffer device on
> /pci@f0000000/ATY,CrownParent@10/ATY,Crown_A
> no framebuffer address found for
> /pci@f0000000/ATY,CrownParent@10/ATY,Crown_B

You need a newer kernel.

> fbset:
>=20
> mode "1280x854-85"
>     # D: 100.000 MHz, H: 75.758 kHz, V: 84.740 Hz
>     geometry 1280 854 1280 854 8
>     timings 10000 16 16 16 16 8 8
>     rgba 8/0,8/0,8/0,0/0
> endmode

This is from OFfb and thus bogus.


> Should the radeonfb driver enable the XFree86 fbdev driver=20
> to operate at 16 bpp?  Where can I get the latest/best=20
> radeonfb code?

Recent benh kernel or at least 2.4.18.

> What are the pros and cons of using fbdev verses the XFree86 ati driver?

All cons, no pros really.

The 4.2.0 or later ati/radeon driver should work with Option "UseFBDev"
if you're running radeonfb. You'll have to provide a 1280x854 mode
definition (fbset -x). If you want DRI, you need to get the current DRI
CVS.


--=20
Earthling Michel D=E4nzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
