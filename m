From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: scrollmode selection problem
Date: Tue, 13 Dec 2005 08:36:30 +0800
Message-ID: <439E178E.9070208@gmail.com>
References: <439DB5A3.9050205@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ely9n-0004qF-A1
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Dec 2005 16:36:39 -0800
Received: from zproxy.gmail.com ([64.233.162.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ely9m-0004eq-59
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Dec 2005 16:36:39 -0800
Received: by zproxy.gmail.com with SMTP id s18so1690234nze
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 12 Dec 2005 16:36:37 -0800 (PST)
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Knut Petersen <Knut_Petersen@t-online.de>

Knut Petersen wrote:
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

I agree.

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
t

It's a solution, and the correct one with the current code.

> ywrap
> scrolling should be disallowed when divides(vc->vc_font.height, vyres)
> or divides(vc->vc_font.height, yres) are false ... only limitations of =
the
> fbcon scrolling code.
>=20
> Has someone already written code to remove that limitation?

None that I know of. Unfortunately, there's only a sprinkling of hardware
that supports ywrap, so you're the best bet to do that (hint, hint :-)=20

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
