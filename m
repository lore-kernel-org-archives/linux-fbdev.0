From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch 1/9] atyfb: Remove FIXME
Date: Sun, 10 Sep 2006 09:48:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0609100947260.18335@pademelon.sonytel.be>
References: <20060903220646.894202994@proteus.korsu.shacknet.nu>
	<200609090002.54186.alex.kern@gmx.de> <20060909074639.GA2616@sci.fi>
	<Pine.LNX.4.62.0609091017450.24057@pademelon.sonytel.be>
	<20060909123916.GA12468@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1238459007-1157874510=:18335"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GMK3a-000070-Dc for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Sep 2006 00:48:46 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GMK3Y-00046d-Ma
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Sep 2006 00:48:46 -0700
In-Reply-To: <20060909123916.GA12468@sci.fi>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Alexander Kern <alex.kern@gmx.de>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1238459007-1157874510=:18335
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by witte.sonytel.be id
	k8A7mUQe008703

On Sat, 9 Sep 2006, Ville [iso-8859-1] Syrj=E4l=E4 wrote:
> On Sat, Sep 09, 2006 at 10:20:25AM +0200, Geert Uytterhoeven wrote:
> > On Sat, 9 Sep 2006, Ville [iso-8859-1] Syrj??wrote:
> > > > have checked this patches  on my RAGE MOBILITY=20
> > > > on top of 2.6.17.11(added with some fuzzies)
> > > >=20
> > > > Signed-off-by: Alexander Kern <alex.kern@gmx.de>
> > > > for all 9 patches
> > > >=20
> > > > Best Wishes
> > > > Mit freundlichen Gr?n
> > > >=20
> > > > P.S. I would like to iron out the long standing issue on my lapto=
p
> > > > I saw about for along time. I can shutdown but reboot. At least T=
FT goes=20
> > >                                                 ^
> > > There should be a "not" here, right?
> > >=20
> > > > black, leds go off and than nothing. Have you any infos about spe=
cial=20
> > > > register state for MOBILITY before reboot?
> > >=20
> > > No. My OmniBook 500 does the same thing BTW. I can shutdown but reb=
oot=20
> > > just hangs the laptop. I'm guessing the BIOS doesn't like the state=
 in=20
> > > which atyfb leaves the card. The reason I'm thinking it's the BIOS =
is=20
> > > that my OB6000, which has nearly the same hardware, reboots just fi=
ne.
> > > I also tried all of the reboot=3D kernel options but none helped.
> > >=20
> > > Maybe we just need to restore some of the original state before reb=
oot.=20
> > > But I don't know if that's even possible. Do drivers get any kind o=
f=20
> > > notification about reboot?
> >=20
> > I used to have the same problem (shutdown works, reboot hangs with bl=
ack
> > screen) on my Vaio Z600 (Z505 in US/JP), but recent 2.6 (I use a Debi=
an kernel)
> > seems to have this fixed.
>=20
> Was that with atyfb? My OB500 reboots fine without atyfb.

Yes, with atyfb. On 2.4 with atyfb, reboot hangs. On recent 2.6 with atyf=
b,
reboot works fine.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org

In personal conversations with technical people, I call myself a hacker. =
But
when I'm talking to journalists I just say "programmer" or something like=
 that.
							    -- Linus Torvalds
---584337861-1238459007-1157874510=:18335
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
---584337861-1238459007-1157874510=:18335
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---584337861-1238459007-1157874510=:18335--
