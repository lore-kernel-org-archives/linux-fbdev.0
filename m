From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [Linux-fbdev-devel] Re: FB model basic issues (WAS: radeon,
	apertures & memory mapping)
Date: Wed, 16 Mar 2005 15:42:50 -0500
Message-ID: <1111005770.5535.63.camel@localhost>
References: <1110784327.5787.288.camel@gaston>
	<1110817205.4004.527.camel@localhost> <1110837171.5863.16.camel@gaston>
	<1110838356.4003.548.camel@localhost> <1110839873.5673.41.camel@gaston>
	<1110862777.4044.592.camel@localhost> <20050315060138.GA13064@sci.fi>
	<4236C770.8020101@hispeed.ch> <1110907029.4001.624.camel@localhost>
	<1110942559.24296.107.camel@gaston>  <20050316200808.GB6651@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050316200808.GB6651@sci.fi>
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
Content-Type: text/plain; charset="utf-8"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

On Wed, 2005-03-16 at 22:08 +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
>=20
> I don't see the current system slowly evolving into some superb future=20
> system with an in kernel memory manager. The current APIs just have too=20
> many limitations. I think the memory manager must be the foundation of=20
> everything and after it's in place the fbdev API should be able to use it=
.=20
> The only change to simple fbdev apps would be that they can't get access=20
> to any offscreen memory as they do now. Something like DirectFB would nee=
d=20
> to change to accomodate the new system but I don't see that as a problem.

I agree on this.


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer
