From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [Linux-fbdev-devel] waitforVBlank, how does this even work?
Date: Wed, 2 Mar 2005 09:30:27 +0200
Message-ID: <20050302073027.GA17607@sci.fi>
References: <9e473391050301215019081bce@mail.gmail.com> <1109747415.5611.92.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <1109747415.5611.92.camel@gaston>
Sender: dri-devel-admin@lists.sourceforge.net
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, DRI developer's list <dri-devel@lists.sourceforge.net>

On Wed, Mar 02, 2005 at 06:10:14PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2005-03-02 at 00:50 -0500, Jon Smirl wrote:
> > For the r128 driver both the fbdev and drm drivers have implemented
> > waitforVBlank and they both play with the interrupt registers. I can
> > only assume that no one has ever tried to use them at the same time.
> > In the radeon case the DRM driver has implemented waitforVBlank and
> > the fbdev driver has not.
> >=20
> > This is a mess and it is yet another reason for merging DRM and fbdev
> > into a sane, combined driver.
>=20
> I'd say nobody ever used both :)

I (and others) have with mga. The easiest solution was to disable the irq=
=20
code in the drm. That was for running OpenGL on DirectFB btw.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
--
