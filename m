From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Re: [RADEON] Connector type
Date: Fri, 29 Aug 2003 01:27:16 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1062113236.14324.46.camel@thor.holligenstrasse29.lan>
References: <20030828162025.GA7317@dreamland.darkstar.lan>
	 <1062090156.612.144.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19sWAh-0006jj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Aug 2003 16:27:19 -0700
Received: from [195.141.226.27] (helo=netline-mail1.netline.ch)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19sWAh-0004ns-7a
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Aug 2003 16:27:19 -0700
In-Reply-To: <1062090156.612.144.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kronos@kronoz.cjb.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@yahoo.com>

On Thu, 2003-08-28 at 19:02, Benjamin Herrenschmidt wrote:
> On Thu, 2003-08-28 at 18:20, Kronos wrote:
> > Hi,
> > currently DDCReg in  radeonfb is hardcoded to CRT  port (secondary port,
> > primary DAC).
> >=20
> > I've working code to detect connector type. On my board it finds the CRT
> > port  and  DVI  port. The  latter is  ignored  because  dviDisp_type  is
> > MT_NONE. If crtDisp_type is MT_NONE then it will use the DVI port.

BTW, do you do this the same way as or differently than the XFree86
driver?

> > What should I  do if both port  are in use? Read EDID  from primary port
> > and ignore secondary?
>=20
> What about a module/kernel option ? In the meantime, I'm working on
> dual head support, though I'm not sure I'll have that finished soon.

How do you plan to handle this, create a second framebuffer device?


--=20
Earthling Michel D=C3=A4nzer   \  Debian (powerpc), XFree86 and DRI develop=
er
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
