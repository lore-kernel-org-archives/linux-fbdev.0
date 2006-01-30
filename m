From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fbdev: Fix usage of blank value
 passed to fb_blank
Date: Mon, 30 Jan 2006 11:22:05 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0601301121250.18565@pademelon.sonytel.be>
References: <20060127231314.GA28324@hansmi.ch> <20060127.204645.96477793.davem@davemloft.net>
 <43DB0839.6010703@gmail.com> <200601282106.21664.ioe-lkml@rameria.de>
 <43DC25EB.1040005@gmail.com> <20060129144228.GA22425@sci.fi>
 <43DD510E.9090404@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-1435854487-1138616525=:18565"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F3WB9-0004ik-BH
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 30 Jan 2006 02:22:35 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1F3WB4-0005Ns-PC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 30 Jan 2006 02:22:35 -0800
In-Reply-To: <43DD510E.9090404@gmail.com>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Oeser <ioe-lkml@rameria.de>, Linux Kernel Development <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@hansmi.ch

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1435854487-1138616525=:18565
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by witte.sonytel.be id k0UAM6YL015036

On Mon, 30 Jan 2006, Antonino A. Daplas wrote:
> Ville Syrj=E4l=E4 wrote:
> > On Sun, Jan 29, 2006 at 10:18:19AM +0800, Antonino A. Daplas wrote:
> >> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> >> index d2dede6..5bed0fb 100644
> >> --- a/drivers/video/fbmem.c
> >> +++ b/drivers/video/fbmem.c
> >> @@ -843,6 +843,19 @@ fb_blank(struct fb_info *info, int blank
> >>  {=09
> >>   	int ret =3D -EINVAL;
> >> =20
> >> +	/*
> >> +	 * The framebuffer core supports 5 blanking levels (FB_BLANK), whe=
reas
> >> +	 * VESA defined only 4.  The extra level, FB_BLANK_NORMAL, is a
> >> +	 * console invention and is not related to power management.
> >> +	 * Unfortunately, fb_blank callers, especially X, pass VESA consta=
nts
> >> +	 * leading to undefined behavior.
> >=20
> > Since when? X.Org uses numbers 0,2,3,4 which match the FB_BLANK=20
> > constants not the VESA constants.
> >=20
>=20
> How about if we silently convert FB_BLANK_NORMAL requests to
> FB_BLANK_VSYNC_SUSPEND, would that work?

Do all (old, pre-VESA) monitors like it when vsync goes away?

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
---584337861-1435854487-1138616525=:18565--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
