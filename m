From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: scroll modes
Date: Sat, 3 Dec 2005 13:01:40 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0512031259010.31646@pademelon.sonytel.be>
References: <438D9E60.7040007@t-online.de> <Pine.LNX.4.62.0511301347230.2123@pademelon.sonytel.be>
 <438DE211.2060900@t-online.de> <438E0E23.2000203@gmail.com>
 <438E2D8E.2040503@t-online.de> <438E3D66.8080601@gmail.com>
 <438F8136.5030005@t-online.de> <438F86F6.9090800@gmail.com>
 <438F8B9D.1060605@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-1597428643-1133611261=:31646"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EiW5O-0004Gi-Ke
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 03 Dec 2005 04:01:50 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EiW5M-0006jM-4n
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 03 Dec 2005 04:01:50 -0800
In-Reply-To: <438F8B9D.1060605@t-online.de>
Content-ID: <Pine.LNX.4.62.0512031301100.31646@pademelon.sonytel.be>
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
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/m68k <linux-m68k@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1597428643-1133611261=:31646
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-ID: <Pine.LNX.4.62.0512031301101.31646@pademelon.sonytel.be>
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by witte.sonytel.be id jB3C1frq011131

On Fri, 2 Dec 2005, Knut Petersen wrote:
> Antonino A. Daplas schrieb:
> > I think I see the problem.  Can you try this instead?
> > =20
> I have to get up in 6 hours, so I will check it tomorrow. I think your =
fix is
> right, the problem
> was  returning with -EINVAL if yoffset + info->var.yres >
> info->var.yres_virtual instead of
> calling the drivers panning function.
>=20
> > Tony
> >=20
> > PS: Do you still need the previous patch?  The one that adjusts
> > p->vrows?
> >=20
> > =20
> Don=B4t know,  but it=B4s in my working configuration, so at least it d=
oes not
> break anything.
>=20
> Geert stated that ywrap scrolling should be fine on amifb ... is that r=
eally
> true with
> current code?

To be honest, I don't know. The last kernel I booted on real Amiga hardwa=
re
was 2.6.8.1.

Anyone who can confirm that amifb works fine in recent kernels? Or perhap=
s
ywrap got disabled somewhere (which reminds me I still have to benchmark =
the
various scrollmodes to find the optimal value for amifb)?

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
---584337861-1597428643-1133611261=:31646--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
