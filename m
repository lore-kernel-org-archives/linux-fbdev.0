From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: RE: Submit Silicon Motion SM501 (VoyagerGX) display driver for li nux  kernel 2.6.4
Date: Sun, 18 Apr 2004 10:17:57 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040418141757.GA30429@linux-sh.org>
References: <9AD3B169567B1346BE6004E2F97C72390135D63B@MARS>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFD7h-0001To-PA
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 18 Apr 2004 07:18:17 -0700
Received: from smtp.golden.net ([199.166.210.31] helo=newsmtp.golden.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BFD7h-0000mL-EJ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 18 Apr 2004 07:18:17 -0700
Content-Disposition: inline
In-Reply-To: <9AD3B169567B1346BE6004E2F97C72390135D63B@MARS>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Ge Wang <GeWang@siliconmotion.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

To follow up on this (as no one else seems to have), this current driver has
a number of issues. A big part of necessary cleanup could be done just with
doing away with the hungarian notation nonsense, using standard types, and
using a struct fb_videomode modedb instead if wrapping everything to use the
non-standard modedb that exists in the driver currently.

Additionally, I have a board I'm working on presently that has an SM501 on =
it
(non-PCI) which this driver presently won't work on. Furthermore, I have
another set of SM501 fb drivers from Renesas that break things out somewhat
further (which includes i2c, once I finish hacking on the voyager i2c stuff=
).
This actually breaks it out into 7 different framebuffers:

#ifdef CONFIG_FB_VOYAGER_GX
        { "voyager_panel_fb", voyafb_init, NULL },
        { "voyager_video_fb", voyafb_init2, NULL },
        { "voyager_valpha_fb", voyafb_init3, NULL },
        { "voyager_alpha_fb", voyafb_init4, NULL },
        { "voyager_panel_csr_fb", voyafb_init5, NULL },
        { "voyager_crt_fb", voyafb_init6, NULL },
        { "voyager_crt_csr_fb", voyafb_init7, NULL },
#endif

As such, this needs some rework as well. The default voyager_panel_fb should
be pretty close to what Ge's driver does, though presently doesn't address =
PCI.
I plan on merging in Ge's driver at the same time I do the rework on the
Renesas one (though Ge and others will have to do testing on PCI).

I'd appreciate it if no one merged any SM501 related fb patches until I'm
finished consolidating the various implementations and we have something in
place that will work for everyone.

On Wed, Mar 24, 2004 at 04:10:11PM -0800, Ge Wang wrote:
> Sure, I'll CC it to linux-fbdev-devel@lists.sourceforge.net. Thanks for y=
our
> suggestion.
>=20
> Ge
>=20
> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
> Sent: Wednesday, March 24, 2004 3:51 PM
> To: Ge Wang
> Subject: Re: Submit Silicon Motion SM501 (VoyagerGX) display driver for
> linux kernel 2.6.4
>=20
>=20
> On Thu, 2004-03-25 at 10:20, Ge Wang wrote:
> > Hi Ben,
> >=20
> > We'd like to submit Silicon Motion SM501 (VoyagerGX) display driver=20
> > source code for linux kernel 2.6.4. I attach it with this email. It=20
> > will be put on our web site soon. It's at(www.siliconmotion.com)=20
> > Support\Drivers\Voyager
> > (SM501) Software Update\voyager-0.01-linux-2.6.4.tgz. If you have any
> > questions or concerns, just let me know. Your help is very appreciated.
>=20
> Hi !
>=20
> Can you post this to the linux-fbdev mailing list (Sorry for ping-ponging
> you like this, but this is the best way to get some good review of the
> driver)
>=20

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAgo4V1K+teJFxZ9wRAqv6AJ99vlpyK9YhvnTkLHlRwqxrJjatCwCfblOW
hxmu37KwNFKrg7SYytKfuKA=
=Gy9r
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
