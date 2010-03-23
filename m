From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Tue, 23 Mar 2010 23:02:26 +0000
Subject: Re: kdrive vs. xorg rotation on AT91SAM9263 atmel_lcdfb
Message-Id: <1269385346.16545.288.camel@thor.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <68FBE0F3CE97264395875AC1C468F22C276323@mail03.cyberswitching.local>
In-Reply-To: <68FBE0F3CE97264395875AC1C468F22C276323@mail03.cyberswitching.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Sam, 2010-03-20 at 12:25 -0700, Chris Verges wrote:=20
> Hi fellow fbdev users,
>=20
> I'm seeking help with a migration from kdrive to xorg.  Under
> kdrive-fbdev, I'm able to rotate the X11 output using xrandr in all four
> orientations: normal, left, right, inverted.  However, under
> xf86-video-fbdev, xrandr only reports that it does not support left,
> right, or inverted rotations.  Dynamic rotation is critical for this
> application, so I cannot use the "Rotate" option in xorg.conf.
>=20
> The atmel_lcdfb driver that we're using in the kernel does not support
> hardware rotation, so I believe that a software-based Shadow Buffer is
> required.  (Please correct me if I'm wrong on this!)  I added in the
> "ShadowFB" option to xorg.conf for the fbdev device, but xrandr still
> only reports normal rotation possible.
>=20
> I've hit a brick wall in my own research on this, so would appreciate
> any help that the community can offer.  Any suggestions?

Support for this simply hasn't been implemented yet in the
xf86-video-fbdev driver.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
