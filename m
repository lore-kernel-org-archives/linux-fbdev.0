From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fbdev: workaround for broken X
 servers
Date: Fri, 5 Nov 2004 16:48:03 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0411051646400.15464@waterleaf.sonytel.be>
References: <1099448020.900.25.camel@gaston> <20041103032613.GA3677@sci.fi>
 <1099633776.9260.160.camel@gaston> <20041105093618.GA15762@sci.fi>
 <Pine.GSO.4.61.0411051052490.15464@waterleaf.sonytel.be> <1099655227.3946.17.camel@gaston>
 <Pine.GSO.4.61.0411051313130.15464@waterleaf.sonytel.be> <20041105153027.GA207@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1691952160-1099669644=:15464"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQ6Jt-0003uj-IP
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 07:48:09 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CQ6Jr-0006vy-2a
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 07:48:09 -0800
In-Reply-To: <20041105153027.GA207@sci.fi>
Content-ID: <Pine.GSO.4.61.0411051647570.15464@waterleaf.sonytel.be>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1691952160-1099669644=:15464
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-ID: <Pine.GSO.4.61.0411051647571.15464@waterleaf.sonytel.be>
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by witte.sonytel.be id iA5Fm3GU006006

On Fri, 5 Nov 2004, Ville [iso-8859-1] Syrj=E4l=E4 wrote:
> On Fri, Nov 05, 2004 at 01:15:35PM +0100, Geert Uytterhoeven wrote:
> > On Fri, 5 Nov 2004, Benjamin Herrenschmidt wrote:
> > > > But every existing application that uses (shiver) the kernel head=
ers will break
> > > > after this change...
> > >=20
> > > Geert, can you explain the whole story please ?
> >=20
> > The story about the +1 or the story about the breakage?
> >=20
> > The Story About The +1
> > ----------------------
> > Since the VESA levels do not provide a way to blank (`make it black')=
 the
> > screen, the +1 is introduced. Hence 0 means unblank, 1 means black sc=
reen, 2
> > means lowest power save level, and so on...
> >=20
> > The Story About The Breakage
> > ----------------------------
> > Every application that passes VESA_*+1 will break when recompiled, si=
nce (most
> > of) the VESA_* values are incremented by 1 by the patch.
>=20
> My proposed patch doesn't touch the VESA_* values. It just adds new=20
> constants which match the VESA_*+1 convention. That way old apps will=20
> continue to work and developers don't have to guess what values are=20
> actully legal.

<embarassed>
Oops, you're right.

Sorry, I misread you patch to modify the values.
<embarassed>

So yes, it's OK!!

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
---559023410-1691952160-1099669644=:15464--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
