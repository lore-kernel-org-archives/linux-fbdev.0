From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Thu, 17 Mar 2005 10:27:56 +1100
Message-ID: <1111015676.7192.58.camel@gaston>
References: <1110784327.5787.288.camel@gaston>
	<1110817205.4004.527.camel@localhost> <1110837171.5863.16.camel@gaston>
	<1110838356.4003.548.camel@localhost> <1110839873.5673.41.camel@gaston>
	<1110862777.4044.592.camel@localhost> <20050315060138.GA13064@sci.fi>
	<1110926659.25201.11.camel@gaston> <20050315230522.GA1444@sci.fi>
	<1110930551.649.47.camel@gaston>  <20050316205511.GA18107@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050316205511.GA18107@sci.fi>
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

On Wed, 2005-03-16 at 22:55 +0200, Ville Syrj=E4l=E4 wrote:
> On Wed, Mar 16, 2005 at 10:49:11AM +1100, Benjamin Herrenschmidt wrote:
> > In the meantime, can you tell me more about your arbitration scheme ?
>=20
> There is a lock associated with the graphics card. The lock is always=20
> taken before programming the hardware. Other things wanting access to t=
he=20
> hardware wait until the lock is released.

Ok, so it would be easy to have directFB use an external arbiter without
breaking existing clients ? It will need at least to use the vga arbiter
that I'm about to finish, that should allow at least to have X on one
card and directFB on another without conflict.

Ben.
