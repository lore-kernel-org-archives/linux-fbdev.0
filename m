From: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: RE: [Linux-fbdev-devel] "remap_page_range" i810 compile time problem ..
Date: Thu, 10 Mar 2005 10:56:15 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348113A48FA@mail.esn.co.in>
Reply-To: linux-fbdev-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Sender: linux-fbdev-users-admin@lists.sourceforge.net
Errors-To: linux-fbdev-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-users>,
	<mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-users@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-users>,
	<mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-users>
Content-Type: text/plain; charset="us-ascii"
To: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-fbdev-users@lists.sourceforge.net

Hi adaplas,

> > I have problem with compiling the i810fb driver downloaded from
> > Sourceforge site.
> > I have D/W the i810fb patch "linux-i810fb-0.0.35.tar.bz2".
> >
> > When I run the make modules I get the following error
>=20
> Try the i810fb-lite driver.  If that does not work, let me know what
> kernel version you are using.

I got it.
The " remap_page_range" API the i810fb driver is using is old & when I
modifies the API with required parameters , I  compiled well & worked.

When I inserted the module using the modprobe i.e=20

Modprobe i810fb vram=3D2 xres=3D1024 bpp=3D16 hsync1=3D30 hsync2=3D55 =
vsync1=3D50
vsync2=3D85 accel=3D1 rotate=3D1

the screen rotated. GREAT.

But when I try this without accel=3D1 rotation fails. Can u just narrate
me what is accel accentually doing?

Also, the font I am getting looks linear & is not good? I do I modify
the font format

Regards,
Mukund jampala



>=20



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
