From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: linux 2.6.21-rc1 : FB Kconfig error
Date: Wed, 21 Feb 2007 11:03:31 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0702211102000.340@pademelon.sonytel.be>
References: <200702210946.27758.toralf.foerster@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-2138482386-1172052211=:340"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJoK3-0006mw-W2 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 02:03:40 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HJoK2-0007uQ-Fs
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 02:03:39 -0800
In-Reply-To: <200702210946.27758.toralf.foerster@gmx.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-2138482386-1172052211=:340
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

	Hi Toralf,

On Wed, 21 Feb 2007, Toralf [iso-8859-1] F=F6rster wrote:
> With latest sources I get :
>=20
> ...
>  make mrproper ...
>  make rndconfig ...drivers/video/Kconfig:1604:warning: 'select' used by=
 config symbol 'FB_PS3' refer to undefined symbol 'PS3_PS3AV'
>  make oldconfig ...

This looks actually like a bug in kconf, since it doesn't obey the
`depends on PPC_PS3' one line above...

Roman, would it be hard to fix this?  Thx!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe =
(NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaa=
n 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, B=
elgium
---584337861-2138482386-1172052211=:340
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
---584337861-2138482386-1172052211=:340
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---584337861-2138482386-1172052211=:340--
