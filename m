From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: scroll modes
Date: Fri, 02 Dec 2005 00:47:41 +0100
Message-ID: <438F8B9D.1060605@t-online.de>
References: <438D9E60.7040007@t-online.de> <Pine.LNX.4.62.0511301347230.2123@pademelon.sonytel.be> <438DE211.2060900@t-online.de> <438E0E23.2000203@gmail.com> <438E2D8E.2040503@t-online.de> <438E3D66.8080601@gmail.com> <438F8136.5030005@t-online.de> <438F86F6.9090800@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ehy8u-0000U9-U6
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Dec 2005 15:47:12 -0800
Received: from mailout08.sul.t-online.com ([194.25.134.20])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ehy8s-0006EE-O3
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Dec 2005 15:47:13 -0800
In-Reply-To: <438F86F6.9090800@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>

Antonino A. Daplas schrieb:

>I think I see the problem.  Can you try this instead?
>
> =20
>
I have to get up in 6 hours, so I will check it tomorrow. I think your=20
fix is right, the problem
was  returning with -EINVAL if yoffset + info->var.yres >=20
info->var.yres_virtual instead of
calling the drivers panning function.

>Tony
>
>PS: Do you still need the previous patch?  The one that adjusts
>p->vrows?
>
> =20
>
Don=B4t know,  but it=B4s in my working configuration, so at least it doe=
s=20
not break anything.

Geert stated that ywrap scrolling should be fine on amifb ... is that=20
really true with
current code?

cu,
 Knut




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
