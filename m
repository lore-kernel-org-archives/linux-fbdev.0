From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [Linux-fbdev-devel] Re: FB model basic issues (WAS: radeon,
	apertures & memory mapping)
Date: Thu, 17 Mar 2005 21:54:14 +0200
Message-ID: <20050317195414.GA29118@sci.fi>
References: <1110907029.4001.624.camel@localhost>
	<1110942559.24296.107.camel@gaston> <20050316200808.GB6651@sci.fi>
	<a728f9f90503161258181977fa@mail.gmail.com>
	<20050316210812.GA19937@sci.fi> <1111015801.15509.62.camel@gaston>
	<20050317004713.GB8081@sci.fi> <1111021978.15510.97.camel@gaston>
	<20050317012503.GA20844@sci.fi>
	<Pine.LNX.4.62.0503171007200.5611@numbat.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503171007200.5611@numbat.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Jon Smirl <jonsmirl@yahoo.com>, xorg@lists.freedesktop.org, Alex Deucher <alexdeucher@gmail.com>, dri-devel@lists.sourceforge.net

On Thu, Mar 17, 2005 at 10:08:15AM +0100, Geert Uytterhoeven wrote:
> On Thu, 17 Mar 2005, Ville [iso-8859-1] Syrj??wrote:
> > On Thu, Mar 17, 2005 at 12:12:58PM +1100, Benjamin Herrenschmidt wrot=
e:
> > > > I understand you can't have userspace program the accelerator whi=
le=20
> > > > someone else is doing the same thing. Oh and I now understand tha=
t the=20
> > > > same really applies to direct framebuffer access due to the swapp=
er. =20
> > >=20
> > > And you can't have someone program the accelerator while somebody d=
oes
> > > direct access neither. It's basically all exclusive.
> >=20
> > I haven't seen that happen on any hardware I own. Matrox specs explic=
itly=20
> > mention that there is no need to synchronize accelerator and direct=20
> > framebuffer access.
>=20
> Really?

Really.

> I was always given Matrox as an example of a card that would lock up if
> you access the frame buffer while the accelerator is busy...

Apparently they didn't know what they were talking about.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
