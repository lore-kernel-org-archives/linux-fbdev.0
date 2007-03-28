From: Jimmy Jazz <Jimmy.Jazz@gmx.net>
Subject: Re: radeonfb doesn't work with an ati X800 pcie
 card
Date: Wed, 28 Mar 2007 23:08:02 +0200
Message-ID: <460AD932.5080903@gmx.net>
References: <46093D22.3090401@gmx.net>
Reply-To: Jimmy.Jazz@gmx.net, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HWfNI-00089F-AI for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Mar 2007 14:08:08 -0700
Received: from ip-62-241-114-101.evc.net ([62.241.114.101]
	helo=snowman.cryosphere.shacknet.nu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HWfNG-0006Dw-Jw
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Mar 2007 14:08:08 -0700
In-Reply-To: <46093D22.3090401@gmx.net>
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
To: Jimmy.Jazz@gmx.net, linux-fbdev-devel@lists.sourceforge.net

Jimmy Jazz a =E9crit :
>
> Certainly not related to the current issue, radeonfb and x11 disagree =

> how many memories the video card really has. radeonfb found half the =

> content and detects the dvi connector where the flat screen is =

> attached to quite well but identifies a CRT monitor instead of a TMDS.

this one was easy,  the size was just limited to less then 256 :)

# diff -ruN radeon_base.c.patched2 radeon_base.c
--- radeon_base.c.patched2      2007-03-26 14:15:47.000000000 +0200
+++ radeon_base.c       2007-03-28 23:03:53.000000000 +0200
@@ -2139,10 +2139,6 @@
        /* mem size is bits [28:0], mask off the rest */
        rinfo->video_ram =3D tmp & CONFIG_MEMSIZE_MASK;

-       /* Limit memory to 128 megs for now */
-       if (rinfo->video_ram > MAX_VRAM)
-               rinfo->video_ram =3D MAX_VRAM;
-
        /*
         * Hack to get around some busted production M6's
         * reporting no ram


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
