From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Thu, 17 Mar 2005 11:28:00 +1100
Message-ID: <1111019280.15510.85.camel@gaston>
References: <1110837171.5863.16.camel@gaston>
	<1110838356.4003.548.camel@localhost> <1110839873.5673.41.camel@gaston>
	<1110862777.4044.592.camel@localhost> <20050315060138.GA13064@sci.fi>
	<1110926659.25201.11.camel@gaston> <20050315230522.GA1444@sci.fi>
	<1110930551.649.47.camel@gaston> <20050316205511.GA18107@sci.fi>
	<1111015676.7192.58.camel@gaston>  <20050317001409.GA8081@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050317001409.GA8081@sci.fi>
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
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org

On Thu, 2005-03-17 at 02:14 +0200, Ville Syrj=E4l=E4 wrote:
> On Thu, Mar 17, 2005 at 10:27:56AM +1100, Benjamin Herrenschmidt wrote:
> > On Wed, 2005-03-16 at 22:55 +0200, Ville Syrj=E4l=E4 wrote:
> > > On Wed, Mar 16, 2005 at 10:49:11AM +1100, Benjamin Herrenschmidt wr=
ote:
> > > > In the meantime, can you tell me more about your arbitration sche=
me ?
> > >=20
> > > There is a lock associated with the graphics card. The lock is alwa=
ys=20
> > > taken before programming the hardware. Other things wanting access =
to the=20
> > > hardware wait until the lock is released.
> >=20
> > Ok, so it would be easy to have directFB use an external arbiter with=
out
> > breaking existing clients ? It will need at least to use the vga arbi=
ter
> > that I'm about to finish, that should allow at least to have X on one
> > card and directFB on another without conflict.
>=20
> Is the vga arbiter required for something else besides access to some=20
> legacy ports? DirectFB only uses legacy ports to wait for vsync if a=20
> better method is not available.

Yes. I need to extend the Arbiter API a bit in fact to deal with clients
that don't "know" if the card is doing legacy decoding like you.

The problem is that unless the card you are using is not doing any
legacy decoding (has been set not to decode legacy VGA IO ports and
legacy VGA memory), trying to use another card in the system that does
decode them requires switching off IO and MEM access on you. Even if you
aren't actually using those legacy stuff, the simple fact that the card
is decoding them mean it needs to be disabled.

(In fact, it could be avoided in some cases where the card is under a
different P2P bridge by just disabling VGA forwarding, but that's the
aribter salad, as a client, you don't have to "know" that).

So the arbiter provides calls to "lock" some resources and deals with
eventually ping-pong'ing IOs. It's currently providing APIs to lock
legacy IO and legacy MEM and to inform the arbiter that the card isn't
decoding some or all of the legacy stuff (to put it out of the arbiter
hands basically). It needs an addition to the API I posted for cases
where you don't know if the card is doing legacy decoding, to indicate
you want to access the normal memory/IO resources of the card, and
implictely lock the legacy ones if they are beeing decoded. I'm working
on it, I hope to have something to start playin with soon, there are
some issues to deal with the kernel vga console though that i'm trying
to iron out.

Ben.
