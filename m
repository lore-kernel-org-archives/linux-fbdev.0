From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: FB model basic issues (WAS: radeon,
 apertures & memory mapping)
Date: Thu, 17 Mar 2005 10:08:15 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0503171007200.5611@numbat.sonytel.be>
References: <20050315060138.GA13064@sci.fi> <4236C770.8020101@hispeed.ch>
 <1110907029.4001.624.camel@localhost> <1110942559.24296.107.camel@gaston>
 <20050316200808.GB6651@sci.fi> <a728f9f90503161258181977fa@mail.gmail.com>
 <20050316210812.GA19937@sci.fi> <1111015801.15509.62.camel@gaston>
 <20050317004713.GB8081@sci.fi> <1111021978.15510.97.camel@gaston>
 <20050317012503.GA20844@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584334533-881027591-1111050495=:5611"
In-Reply-To: <20050317012503.GA20844@sci.fi>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alex Deucher <alexdeucher@gmail.com>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584334533-881027591-1111050495=:5611
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by witte.sonytel.be id j2H98SGU013299

On Thu, 17 Mar 2005, Ville [iso-8859-1] Syrj=E4l=E4 wrote:
> On Thu, Mar 17, 2005 at 12:12:58PM +1100, Benjamin Herrenschmidt wrote:
> > > I understand you can't have userspace program the accelerator while=
=20
> > > someone else is doing the same thing. Oh and I now understand that =
the=20
> > > same really applies to direct framebuffer access due to the swapper=
. =20
> >=20
> > And you can't have someone program the accelerator while somebody doe=
s
> > direct access neither. It's basically all exclusive.
>=20
> I haven't seen that happen on any hardware I own. Matrox specs explicit=
ly=20
> mention that there is no need to synchronize accelerator and direct=20
> framebuffer access.

Really? I was always given Matrox as an example of a card that would lock=
 up if
you access the frame buffer while the accelerator is busy...

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
---584334533-881027591-1111050495=:5611--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
