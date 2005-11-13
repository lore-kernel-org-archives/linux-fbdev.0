From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: Image defects with 2.6.14/atyfb/Sunblade 100
Date: Sun, 13 Nov 2005 21:08:19 +0100
Message-ID: <200511132108.19391.alex.kern@gmx.de>
References: <Pine.LNX.4.63.0511112134500.3900@bobcat>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbO8S-0002gD-RA
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Nov 2005 12:07:32 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1EbO8R-0008Ax-8U
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Nov 2005 12:07:32 -0800
In-Reply-To: <Pine.LNX.4.63.0511112134500.3900@bobcat>
Content-Disposition: inline
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
Content-Type: text/plain; charset="utf-8"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jurij Smakov <jurij@wooyd.org>, debian-sparc@lists.debian.org

Am Samstag 12 November 2005 06:51 schrieb Jurij Smakov:
> [Forwarding information to linux-fbdev-devel]
>
> Hello,
>
> Recently Luigi Gangitano has pointed out a linux-fbdev-devel thread [0]
> in which progress was achieved in fixing the atyfb bug resulting in
> console and X display corruption on SunBlade 100, filed as #321200 in the
> Debian bug tracking system [1]. The patch mentioned in the thread (which
> we plan to include in the next Debian kernel package release) is attached.
> While the situation with this patch is greatly improved, users testing the
> new 2.6.14 kernel packages have reported [2,3] that there is still some
> minor screen corruption in a form of red dots or lines. A screenshot
> (provided by Andrey Chernomyrdin) can be viewed at [4]. We'd appreciate
> any ideas which could lead to the resolution of this problem.
>
> Please CC the responses to me (and, optionally to the
> debian-sparc@lists.debian.org), as I'm not subscribed to this list.
>
> [0] http://marc.theaimsgroup.com/?t=3D111088248100003&r=3D1&w=3D2
> [1] http://bugs.debian.org/321200
> [2] http://lists.debian.org/debian-sparc/2005/11/msg00076.html
> [3] http://lists.debian.org/debian-sparc/2005/11/msg00087.html
> [4] http://www.wooyd.org/debian/tmp/sunblade.png
>
> Thanks and best regards,
>
> Jurij Smakov                                        jurij@wooyd.org
> Debian kernel team
> Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC

Hello,

are you sure, you have these artefactes under X11 with "ati" driver too?
If yes,  it has nothing todo with "fbdev". "ati" chahges all chip settings =
on=20
it own. Anyway "ati" was for me any time "refrence number one", and if they=
=20
do not have solution, I don't have it for sure ;-(

What about ask maintainer of "ati"?

P.S.
I think these red dots caused by overclocking something(dotclock, memory,=20
GPU).

=2D-=20

Best Wishes
Mit freundlichen Gr=C3=BC=C3=9Fen

Alex Kern


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
