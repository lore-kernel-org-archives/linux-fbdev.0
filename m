From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [patch 1/9] atyfb: Remove FIXME
Date: Sat, 9 Sep 2006 15:39:16 +0300
Message-ID: <20060909123916.GA12468@sci.fi>
References: <20060903220646.894202994@proteus.korsu.shacknet.nu>
	<200609090002.54186.alex.kern@gmx.de>
	<20060909074639.GA2616@sci.fi>
	<Pine.LNX.4.62.0609091017450.24057@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GM27I-0002NH-QX for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 09 Sep 2006 05:39:25 -0700
Received: from gw03.mail.saunalahti.fi ([195.197.172.111])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GM27H-0003jg-CG
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 09 Sep 2006 05:39:24 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0609091017450.24057@pademelon.sonytel.be>
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
Cc: Alexander Kern <alex.kern@gmx.de>

On Sat, Sep 09, 2006 at 10:20:25AM +0200, Geert Uytterhoeven wrote:
> On Sat, 9 Sep 2006, Ville [iso-8859-1] Syrj??wrote:
> > > have checked this patches  on my RAGE MOBILITY =

> > > on top of 2.6.17.11(added with some fuzzies)
> > > =

> > > Signed-off-by: Alexander Kern <alex.kern@gmx.de>
> > > for all 9 patches
> > > =

> > > Best Wishes
> > > Mit freundlichen Gr?n
> > > =

> > > P.S. I would like to iron out the long standing issue on my laptop
> > > I saw about for along time. I can shutdown but reboot. At least TFT g=
oes =

> >                                                 ^
> > There should be a "not" here, right?
> > =

> > > black, leds go off and than nothing. Have you any infos about special =

> > > register state for MOBILITY before reboot?
> > =

> > No. My OmniBook 500 does the same thing BTW. I can shutdown but reboot =

> > just hangs the laptop. I'm guessing the BIOS doesn't like the state in =

> > which atyfb leaves the card. The reason I'm thinking it's the BIOS is =

> > that my OB6000, which has nearly the same hardware, reboots just fine.
> > I also tried all of the reboot=3D kernel options but none helped.
> > =

> > Maybe we just need to restore some of the original state before reboot. =

> > But I don't know if that's even possible. Do drivers get any kind of =

> > notification about reboot?
> =

> I used to have the same problem (shutdown works, reboot hangs with black
> screen) on my Vaio Z600 (Z505 in US/JP), but recent 2.6 (I use a Debian k=
ernel)
> seems to have this fixed.

Was that with atyfb? My OB500 reboots fine without atyfb.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
