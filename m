From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: waitforVBlank, how does this even work?
Date: Wed, 02 Mar 2005 18:53:32 +1100
Message-ID: <1109750012.5611.98.camel@gaston>
References: <9e473391050301215019081bce@mail.gmail.com>
	 <1109747415.5611.92.camel@gaston>  <20050302073027.GA17607@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050302073027.GA17607@sci.fi>
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
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, DRI developer's list <dri-devel@lists.sourceforge.net>

On Wed, 2005-03-02 at 09:30 +0200, Ville Syrj=E4l=E4 wrote:
> On Wed, Mar 02, 2005 at 06:10:14PM +1100, Benjamin Herrenschmidt wrote:
> > On Wed, 2005-03-02 at 00:50 -0500, Jon Smirl wrote:
> > > For the r128 driver both the fbdev and drm drivers have implemented
> > > waitforVBlank and they both play with the interrupt registers. I ca=
n
> > > only assume that no one has ever tried to use them at the same time.
> > > In the radeon case the DRM driver has implemented waitforVBlank and
> > > the fbdev driver has not.
> > >=20
> > > This is a mess and it is yet another reason for merging DRM and fbd=
ev
> > > into a sane, combined driver.
> >=20
> > I'd say nobody ever used both :)
>=20
> I (and others) have with mga. The easiest solution was to disable the i=
rq=20
> code in the drm. That was for running OpenGL on DirectFB btw.

I'd rather have disabled the IRQ code in the fbdev and added a
waitForVBlank in the DRM ...

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
