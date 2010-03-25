From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Thu, 25 Mar 2010 08:57:03 +0000
Subject: RE: kdrive vs. xorg rotation on AT91SAM9263 atmel_lcdfb
Message-Id: <1269507423.441.2668.camel@thor.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <68FBE0F3CE97264395875AC1C468F22C276323@mail03.cyberswitching.local>
In-Reply-To: <68FBE0F3CE97264395875AC1C468F22C276323@mail03.cyberswitching.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Die, 2010-03-23 at 17:14 -0700, Chris Verges wrote:=20
> > Support for this simply hasn't been implemented yet in the
> > xf86-video-fbdev driver.
>=20
> Oh, well, that would certainly explain why.  Thanks for the answer!
>=20
> Do you happen to know if support for xrandr rotation is in the fbdev
> roadmap?

What roadmap? :)

> If not, any pointers on how I could go about adding support?  Is there
> another driver that provides a sample that you'd recommend I use as a
> template?

Looking at how the kdrive code handles it might be useful. If not, I'm
not sure there's any other Xorg driver which supports dynamic rotation
without hardware acceleration, but looking at the radeon or intel
drivers could be useful at least for the shadow buffer management
aspects.

You may want to ask on the xorg-devel mailing list at lists.x.org for
more suggestions.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer








