From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: FB model basic issues (WAS: radeon,
	apertures & memory mapping)
Date: Thu, 17 Mar 2005 10:20:07 +1100
Message-ID: <1111015207.15509.49.camel@gaston>
References: <1110837171.5863.16.camel@gaston>
	<1110954676.5271.2.camel@gaston> <20050316140948.GA20074@sci.fi>
	<200503161148.58067.ajax@nwnk.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <200503161148.58067.ajax@nwnk.net>
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
To: Adam Jackson <ajax@nwnk.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@yahoo.com>, xorg@lists.freedesktop.org, dri-devel@lists.sourceforge.net, Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>

On Wed, 2005-03-16 at 11:48 -0500, Adam Jackson wrote:
> On Wednesday 16 March 2005 09:09, Ville Syrj=E4l=E4 wrote:
> > On Wed, Mar 16, 2005 at 05:31:16PM +1100, Benjamin Herrenschmidt wrot=
e:
> > > Well, do they "revert" it after atyfb/aty128fb/radeonfb set it then=
 ?
> > > it's definitely set on mode switch.
> >
> > The point is that there can be offscreen surfaces with different dept=
h
> > than the fbdev surface.
>=20
> _Will_ be.  Otherwise GL and Render performance drops through the floor=
.

Yes, but again, GL/DRI knows how to play with the swapper, that is not
my point. Looks like people here prefer arguing for the sake of it
rather than trying to make progress...

I think I'll just decide something randomly in radeonfb and let folks
cope with it.

Ben.
