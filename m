From: "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>
Date: Fri, 09 Jan 2015 22:31:38 +0000
Subject: Re: SSD1306 OLED driver
Message-Id: <20150109223138.GB4891@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WYTEVAkct0FjGQmd"
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
To: linux-fbdev@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2015 at 06:13:43PM +0530, Ssagarr Patil wrote:
> Hi Maxime,
>=20
> Thanks for your response!
>=20
> > On Fri, Jan 09, 2015 at 03:45:01PM +0530, Ssagarr Patil wrote:
> >>
> >> Hi Maxime,
> >>
> >>>>> Thanks for the pointer, I am using spi_write() call and I see /dev/=
fb0 node created.
> >>>>> but when I do echo "1121"> /dev/fb0 nothing comes up on oled any po=
inters on this ?
> >>>>
> >>>> You can't use it like that. It's a standard framebuffer, that is
> >>>> represented as an array of pixels, so you need to use a font renderi=
ng
> >>>> software if you want to output some text.
> >>>>
> >>> can fbtest
> >>> (https://git.kernel.org/cgit/linux/kernel/git/geert/fbtest.git/)
> >>> be used to to draw something ?
> >>>
> >> how do I set pixels of it ? Please if you can point me to some stuff t=
hat would be helpful.
> >
> > Last time I tried, fbtest didn't support monochrome display.
> >
> > And you'll find anything you need in the documentation.
> > https://www.kernel.org/doc/Documentation/fb/framebuffer.txt
> >
>
> In my case I see that init is done but I dont see any pixels on the
> screen at all.
>
> I am now concerned if the driver was tested in first place ?

No. I just submitted some good looking code that never ever got
tested.

More seriously, There's a few thing that comes to my mind:
  - Your controller doesn't behave the same way than the ones already
    supported.
  - You haven't posted your changes yet, so maybe you're not doing the
    transfers right
  - Your SPI controller is doing something weird

What happens if you plug a logical analyzer on the bus?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUsFbKAAoJEBx+YmzsjxAg9SgP/RTSWcoOvZOdJCR18ZSAEB3C
ai+vsvXToLP9xCc63BgxJAOEIT+CJuQQDfOXCJdVX+pOO+IP1FcwNE29Dm7Rud63
775UoVJYz0DrNR5LlYwvIhkXb1oAB4nbvM3lvGBvUqr7iVsMNPHY0sFQgfi31GVL
40AzHJL4xCYDZAZw1uSR+v5iDbyUyih9W8jTF+bnrOex2Diif+q1di/J3JalNSwk
s7kbxtJo7TkFkhMjYgX70XFr2uTnTJ+HmKe6KUswP06PmI0IW5Vye+48eI8GsJCv
rH2h83hhM0qJmqBTQJuyIi7wWQThNHYGLj00pcOaRa05XVyjxV5MoE/vwRqtaX18
SMlc5FsY+/aasVz+JENRGBj9G1C0rATS2ynj0K5wsCVJwBeZk5V+CpahKBcX+5m1
jQdEib/t0sWCJiRk0HMaFrYYhCf5gVyu4tHWv/VhM073oUBthfF7Iqaf/iV3mHqH
hHZdX+SHCb7xfdNFqb29zcI9Yr4bSdTdCmKR0wI6+zQqd1s72GcOCZ7UpM7g8VBR
5m7VRzK2jB7AOWfIIgxtIlEVPG0N3/H3aLUBMAcn6HsFLdtoDhUMs1ZjJx72Sw4C
wN31szimEIIaQE06Z0sVKdcux8X9UUwkWbgEKUc3Odi3uI9opJ2WwXeWPnZfMm0q
OZ8uovUBfKrGKMCeVgW4
=ImYc
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
