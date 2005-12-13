From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: scrollmode selection problem
Date: Tue, 13 Dec 2005 13:28:14 +0100
Message-ID: <439EBE5E.1040007@t-online.de>
References: <439DB5A3.9050205@t-online.de> <Pine.LNX.4.62.0512131206120.17990@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Em9FY-00085A-Nz
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Dec 2005 04:27:20 -0800
Received: from mailout11.sul.t-online.com ([194.25.134.85])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Em9FX-0003rP-2K
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Dec 2005 04:27:20 -0800
In-Reply-To: <Pine.LNX.4.62.0512131206120.17990@pademelon.sonytel.be>
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


>This used to work fine (garbage in borders was cleared when fbcon did
>pan/wrap), so I consider it a regression.
>
> =20
>
Well, it definitely is broken. If you don=C2=B4t have a quick fix, we sho=
uld=20
disable
that code path for 2.6.15 as I suggested.

Our goal should be

       int good_wrap =3D (cap & FBINFO_HWACCEL_YWRAP) &&
               divides(ywrap, vc->vc_font.height) &&
-               divides(vc->vc_font.height, vyres) &&
-               divides(vc->vc_font.height, yres);
=20

for one of the next releases.

cu,
 Knut



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
