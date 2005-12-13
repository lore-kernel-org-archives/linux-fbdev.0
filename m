From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: scrollmode selection problem
Date: Tue, 13 Dec 2005 12:07:03 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0512131206120.17990@pademelon.sonytel.be>
References: <439DB5A3.9050205@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-1339478597-1134472023=:17990"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Em7zw-0003FH-Ql
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Dec 2005 03:07:08 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Em7zv-0006yN-5H
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Dec 2005 03:07:08 -0800
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id jBDB73YL005784
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 Dec 2005 12:07:03 +0100 (MET)
In-Reply-To: <439DB5A3.9050205@t-online.de>
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1339478597-1134472023=:17990
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by witte.sonytel.be id jBDB73YL005784

On Mon, 12 Dec 2005, Knut Petersen wrote:
> Have a look at the following problem:
>=20
> framebuffer memory size is 8MB
> xres is 800, yres is 600, bpp is 8.
> xres_virtual is 1024, yres_virtual is 8192.
> font dimensions 8x16
>=20
> check_var() and set_par() are called, set_par() decides that ywrap
> scrolling is possible and sets FBINFO_HWACCEL_YWRAP.
>=20
> Well, that decision is _wrong_  as  600/16 results in a 37 line display
> height, 8 pixel lines at the bottom are unused. But they are displayed,
> and obviously they contain garbage as YWRAP scrolling is selected by
> updatescrollmode().
>=20
> As the driver does know nothing about fonts, the obvious place to
> change is updatescrollmode().
>=20
>        int good_wrap =3D (cap & FBINFO_HWACCEL_YWRAP) &&
>                divides(ywrap, vc->vc_font.height) &&
>                divides(vc->vc_font.height, vyres) &&
>                divides(vc->vc_font.height, yres);
>=20
> would be a solution, but I don=B4t like it. There is no real reason tha=
t ywrap
> scrolling should be disallowed when divides(vc->vc_font.height, vyres)
> or divides(vc->vc_font.height, yres) are false ... only limitations of =
the
> fbcon scrolling code.
>=20
> Has someone already written code to remove that limitation?

This used to work fine (garbage in borders was cleared when fbcon did
pan/wrap), so I consider it a regression.

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
---584337861-1339478597-1134472023=:17990--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
