From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] Add fb_check_var() for fixed
	mode	device.
Date: Fri, 29 Aug 2008 20:38:38 +0300
Message-ID: <20080829173838.GP16680@sci.fi>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin>
	<g94i4r$2hq$1@ger.gmane.org> <20080828074521.GO16680@sci.fi>
	<48B785DA.1030408@renesas.com>
	<1219999758.4421.259.camel@thor.sulgenrain.local>
	<Pine.LNX.4.64.0808291127510.18326@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZ7vs-0006r6-4a for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 10:38:48 -0700
Received: from smtp6.pp.htv.fi ([213.243.153.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KZ7vo-0000BQ-E3
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 10:38:48 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0808291127510.18326@anakin>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Helge Deller <deller@gmx.de>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>

On Fri, Aug 29, 2008 at 02:16:50PM +0200, Geert Uytterhoeven wrote:
> On Fri, 29 Aug 2008, Michel D?nzer wrote:
> > On Fri, 2008-08-29 at 14:15 +0900, Takashi Yoshii wrote:
> > > +	/* bigger is error, smaller is OK */
> > > +	if( ( var->xres > constant->xres )
> > > +	  ||( var->yres > constant->yres )
> > =

> > The resolution must match, otherwise userspace thinks it can e.g. set
> > 800x600 when the fixed mode is 1024x768.
> =

> It will be set later to the correct resolution. The above hunk just taks
> care of the rounding rules.
> =

> Anyway, I'm still wondering whether this check is really needed. If your
> application doesn't look at how fb_var_screeninfo was changed by calling
> FBIOPUT_VSCREENINFO, you're in deep trouble anyway, due to the rounding
> rules.

It can be used to to quickly check a bunch of modes for with =

FB_ACTIVATE_TEST. In fact FB_ACTIVATE_TEST's comment says that rounding
up should not happen here but no driver implements that. It could be
implemented in the common code by keeping a copy of the original var and
comparing them after the driver has done the rounding.

But what are the rounding rules anyway?
My take on the matter:
- xres_virtual/yres_virtual can be rounded up.
- xres/yres shouldn't be rounded since this is the first thing users
  usually care about.
- bits_per_pixel/red/gren/blue/transp shouldn't be rounded since
  it's the second thing users care about. I think most driver do round
  these though. In fact most drivers don't really even look at anything
  besides bits_per_pixel and green.length. Perhaps if the user has set
  some of them to zero the driver could pick freely.
- Timing values can be rounded. Which way or by how much I'm not sure.
  Refresh rate is the third thing users care about so huge rounding here
  could be problematic but some rounding is probably needed due to
  hardware constraints. In the "hardware supports only one mode" case
  the rounding should probably be unlimited though.
- xoffset/yoffset should be checked against panstep/wrap.
  FBIOPAN_DISPLAY doesn't allow any rounding but should
  FBIOPUT_VSCREENINFO?

Maybe some of the constraints (like limiting the refresh rate rounding to
some %) should only be enforced with FB_ACTIVATE_TEST. That would
prevent it breaking some stupid application that just sets some
randomish mode and expects the driver to hand out something that's supporte=
d.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
