From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fbdev: workaround for broken X
 servers
Date: Fri, 5 Nov 2004 10:56:04 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0411051052490.15464@waterleaf.sonytel.be>
References: <1099448020.900.25.camel@gaston> <20041103032613.GA3677@sci.fi>
 <1099633776.9260.160.camel@gaston> <20041105093618.GA15762@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-684387517-1099648564=:15464"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQ0pN-0001iD-LK
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 01:56:17 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CQ0pG-0004It-F9
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 01:56:17 -0800
In-Reply-To: <20041105093618.GA15762@sci.fi>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-684387517-1099648564=:15464
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by witte.sonytel.be id iA59u4GU010298

On Fri, 5 Nov 2004, Ville [iso-8859-1] Syrj=E4l=E4 wrote:
> On Fri, Nov 05, 2004 at 04:49:36PM +1100, Benjamin Herrenschmidt wrote:
> > Ok, can we agree here on what has to be done ? X is hard-coding numbe=
rs
> > that don't seem to be make any sense vs. our constants. In radeonfb, =
I
> > used switch case on constants, not +1, so there is something I'm not
> > getting. Besides, radeon always try to power down TFT panels when
> > blank !=3D 0, maybe I should improve that ... What is this +1 thing, =
where
> > does it comes from ?
>=20
> Maybe it's there because someone wanted to blank the display without=20
> disabling sync signals.

Yes of course! (/me wasn't completely awake yet)

> I suggest a new set of constants that cover all legal values. Here's th=
e=20
> first drawft.
>=20
> --- linux-orig/include/linux/fb.h	2004-11-05 12:25:14.087807848 +0200
> +++ linux/include/linux/fb.h	2004-11-05 12:28:02.734169704 +0200
> @@ -27,7 +27,7 @@
>  /* #define FBIOSWITCH_MONIBIT	0x460E */
>  #define FBIOGET_CON2FBMAP	0x460F
>  #define FBIOPUT_CON2FBMAP	0x4610
> -#define FBIOBLANK		0x4611		/* arg: 0 or vesa level + 1 */
> +#define FBIOBLANK		0x4611		/* see FB_BLANK_* */
>  #define FBIOGET_VBLANK		_IOR('F', 0x12, struct fb_vblank)
>  #define FBIO_ALLOC              0x4613
>  #define FBIO_FREE               0x4614
> @@ -258,6 +258,12 @@
>  #define VESA_HSYNC_SUSPEND      2
>  #define VESA_POWERDOWN          3
> =20
> +#define FB_BLANK_NO_BLANKING	0
> +#define FB_BLANK_BLANKING	1
> +#define FB_BLANK_VSYNC_SUSPEND	2
> +#define FB_BLANK_HSYNC_SUSPEND	3
> +#define FB_BLANK_POWERDOWN	4
> +

Yep, these nicely cover the current intended behavior.

But every existing application that uses (shiver) the kernel headers will=
 break
after this change...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org

In personal conversations with technical people, I call myself a hacker. =
But
when I'm talking to journalists I just say "programmer" or something like=
 that.
							    -- Linus Torvalds
---559023410-684387517-1099648564=:15464--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
