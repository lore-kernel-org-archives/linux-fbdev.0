From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: fglrx + radeonfb leads to crashes?
Date: Thu, 18 Mar 2004 02:23:17 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1079572996.13243.10.camel@thor.asgaard.local>
References: <200403172018.i2HKI5E0002012@napali.hpl.hp.com>
	 <1079569590.909.12.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3mFk-0004vK-88
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Mar 2004 17:23:20 -0800
Received: from netline-mail1.netline.ch ([195.141.226.27])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3mFj-00052u-30
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Mar 2004 17:23:19 -0800
In-Reply-To: <1079569590.909.12.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: davidm@hpl.hp.com, ajoshi@shell.unixbox.com, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2004-03-18 at 01:26, Benjamin Herrenschmidt wrote:=20
> On Thu, 2004-03-18 at 07:18, David Mosberger wrote:
> >=20
> > I have a machine here with an ATI FireGL Z1 card.  It works fine with
> > the ATI fglrx binary-only driver on 2.6.5-rc1.  However, if radeonfb
> > is enabled and I try to stop the X server or switch away from it to
> > another virtual console, then the screen display gets all messed up
> > and the machine gets stuck.  When this hapens, I periodically see this
> > kind of message:
> >=20
> >   radeonfb: FIFO Timeout !
> >=20
> > Now, this is on ia64 machine so at this point I'm just wondering
> > whether this problem also shows up on other machines.  If it's an
> > ia64-specific problem, I can look into it.  Otherwise, I guess I'll
> > just disable radeonfp for now.
>=20
> This is a known problem. I'm not sure at this point what ATI binary
> driver is doing, I think it messes up the card internal memory map,
> among others, and it definitely doesn't restore things properly when
> beeing switched out.
>=20
> I only have PPC machines so I can't experiment with it myself though.
> The "fix" might be as simple as restoring MC_FB_LOCATION,
> MC_AGP_LOCATION and the various offset when re-initing the mode (the
> latest fbdev will trigger a mode restore & engine reset when switching
> out from a KD_GRAPHICS console).

Note that I don't have problems switching between radeonfb and an X
server from DRI CVS which sets up the card memory layout in the
recommended way and never restores it. Am I missing something?


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dclick
