From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [Linux-fbdev-devel] Re: radeon, apertures & memory mapping
Date: Mon, 14 Mar 2005 18:40:25 +0200
Message-ID: <20050314164025.GA25171@sci.fi>
References: <1110715499.14684.132.camel@gaston>
	<9e473391050313081937cde207@mail.gmail.com>
	<1110750553.5787.155.camel@gaston>
	<9e47339105031314101c89e50e@mail.gmail.com>
	<1110752401.19810.177.camel@gaston>
	<9e47339105031315002a444f00@mail.gmail.com>
	<16948.56755.114690.200854@cargo.ozlabs.ibm.com>
	<20050314005613.GA21434@sci.fi> <1110762359.19810.209.camel@gaston>
	<ye8zmx68a2b.fsf@horse01.daimi.au.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <ye8zmx68a2b.fsf@horse01.daimi.au.dk>
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
To: Soeren Sandmann <sandmann@daimi.au.dk>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@yahoo.com>, Paul Mackerras <paulus@samba.org>, xorg@lists.freedesktop.org, dri-devel@lists.sourceforge.net

On Mon, Mar 14, 2005 at 05:30:04PM +0100, Soeren Sandmann wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>=20
> > In an ideal world ... However, since we are planning to move the memo=
ry
> > manager to the kernel, that would mean a kernel access (syscall, ioct=
l,
> > whatever...) twice per access to AGP memory. Not realistic.
>=20
> Could the user space driver batch many such accesses together and use
> a lock_many()/unlock_many() API?

Natrually it should try to do as much as possible during the=20
lock()/unlock() sequence.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
