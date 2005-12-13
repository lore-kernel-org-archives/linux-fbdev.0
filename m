From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: scrollmode selection problem
Date: Tue, 13 Dec 2005 13:35:20 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0512131334430.17990@pademelon.sonytel.be>
References: <439DB5A3.9050205@t-online.de> <Pine.LNX.4.62.0512131206120.17990@pademelon.sonytel.be>
 <439EBE5E.1040007@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-1242916380-1134477320=:17990"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Em9NU-00006S-P3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Dec 2005 04:35:32 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Em9NR-0001Ao-49
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Dec 2005 04:35:32 -0800
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id jBDCZKYL009247
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 Dec 2005 13:35:20 +0100 (MET)
In-Reply-To: <439EBE5E.1040007@t-online.de>
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

---584337861-1242916380-1134477320=:17990
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by witte.sonytel.be id jBDCZKYL009247

On Tue, 13 Dec 2005, Knut Petersen wrote:
> > This used to work fine (garbage in borders was cleared when fbcon did
> > pan/wrap), so I consider it a regression.
> >=20
> > =20
> Well, it definitely is broken. If you don=C2=B4t have a quick fix, we s=
hould
> disable
> that code path for 2.6.15 as I suggested.
>=20
> Our goal should be
>=20
>       int good_wrap =3D (cap & FBINFO_HWACCEL_YWRAP) &&
>               divides(ywrap, vc->vc_font.height) &&
> -               divides(vc->vc_font.height, vyres) &&
> -               divides(vc->vc_font.height, yres);
>=20
>=20
> for one of the next releases.

You're right, I was confused with ypan. Upon more reflections, for ywrap,=
 it
probably never worked before.

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
---584337861-1242916380-1134477320=:17990--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
