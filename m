From: Thibaut VARENE <varenet@esiee.fr>
Subject: Re: [PATCH][RFC] Add support for Epson S1D13806 FB
Date: Mon, 14 Mar 2005 15:24:03 +0100
Message-ID: <20050314142404.58FDF365923@mail.esiee.fr>
References: <200503142207.57074.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAqUU-0003iF-EB
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 06:24:18 -0800
Received: from mail.esiee.fr ([147.215.1.3])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAqUS-00051X-FV
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 06:24:18 -0800
In-Reply-To: <200503142207.57074.adaplas@hotpop.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Cc: Thibaut VARENE <T-Bone@parisc-linux.org>, linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@pol.net>, Ben Dooks <ben-linux-arm@fluff.org>

-------------------
> On Monday 14 March 2005 21:00, Thibaut VARENE wrote:
> > -------------------
>=20
> BTW, I would guess that scrolling is slow in this driver.  Since
this driver
> can do pan_display, If this:=20
>=20
> info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
>=20
> is added somewhere before register_framebuffer(), and
var->xres_virtual >
> var->xres, you might get a several-fold increase in scrolling speed
(since
> scrolling mode will be SCROLL_PAN_REDRAW instead of SCROLL_REDRAW).

Err, afaict, it is already added before register_framebuffer():

	info->fbops =3D &s1d13xxxfb_fbops;
	info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
=09
[snip]

	if (register_framebuffer(info) < 0) {

The scrolling doesn't feel particularly slow here... Though it's hard
to tell in 640x480 ;)

Thanks

Thibaut VARENE


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
