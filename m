From: =?ISO-8859-1?Q?Ga=EBl_Deest?= <GUtopiste@free.fr>
Subject: Extending vesafb for modes switching ?
Date: Sun, 01 Feb 2004 18:54:27 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <401D4B63.1080203@free.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AnLmd-0000pq-5k
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 01 Feb 2004 09:53:23 -0800
Received: from postfix3-1.free.fr ([213.228.0.44] ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AnLmc-0000xV-Od
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 01 Feb 2004 09:53:22 -0800
Received: from free.fr (lns-th2-4f-81-56-245-43.adsl.proxad.net [81.56.245.43])
	by postfix3-1.free.fr (Postfix) with ESMTP id BCCD1C4124
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  1 Feb 2004 18:53:20 +0100 (CET)
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

Ok, this may be a silly question. I am not a kernel/fbdev hacker, so I=20
may ignore some relevant issues. But after many researches, I can't see=20
why it would be impossible for the vesafb driver to handle modes switchin=
g.

According to my understanding of this stuff, vesafb mode setting is=20
possible only during real mode, via a boot argument,  set by bios=20
interrupts, which prevent from changing it later (if I said something=20
wrong, please correct me.) But what about the xfree86 driver ? It seems=20
to do its job via the VBE bios of the card. What would prevent vesafb=20
from doing the same ? I know vesafb only supports VBE 2.0, not 3.0. I=20
couldn't find the VBE 2.0 documentation, but in VBE 3.0 one, protected=20
mode is supported.

I would see this as a great improvement, because of the really little=20
number of cards actually supported by vesafb.

Regards,

Ga=EBl D.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
