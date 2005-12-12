From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: scrollmode selection problem
Date: Mon, 12 Dec 2005 18:38:43 +0100
Message-ID: <439DB5A3.9050205@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Elrcw-0007a3-63
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Dec 2005 09:38:18 -0800
Received: from mailout01.sul.t-online.com ([194.25.134.80])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Elrcv-0000Xn-UN
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Dec 2005 09:38:18 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net

Have a look at the following problem:

framebuffer memory size is 8MB
xres is 800, yres is 600, bpp is 8.
xres_virtual is 1024, yres_virtual is 8192.
font dimensions 8x16

check_var() and set_par() are called, set_par() decides that ywrap
scrolling is possible and sets FBINFO_HWACCEL_YWRAP.

Well, that decision is _wrong_  as  600/16 results in a 37 line display
height, 8 pixel lines at the bottom are unused. But they are displayed,
and obviously they contain garbage as YWRAP scrolling is selected by
updatescrollmode().

As the driver does know nothing about fonts, the obvious place to
change is updatescrollmode().

        int good_wrap =3D (cap & FBINFO_HWACCEL_YWRAP) &&
                divides(ywrap, vc->vc_font.height) &&
                divides(vc->vc_font.height, vyres) &&
                divides(vc->vc_font.height, yres);

would be a solution, but I don=B4t like it. There is no real reason that=20
ywrap
scrolling should be disallowed when divides(vc->vc_font.height, vyres)
or divides(vc->vc_font.height, yres) are false ... only limitations of th=
e
fbcon scrolling code.

Has someone already written code to remove that limitation?

cu,
 Knut



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
