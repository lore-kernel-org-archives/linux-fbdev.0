From: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives black screen
Date: Tue, 29 Mar 2005 11:16:58 +0200 (CEST)
Message-ID: <dJBFtcnM.1112087818.6686590.khali@localhost>
References: <a44ae5cd05032817125e99b868@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DGCuK-0008Av-To
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Mar 2005 01:21:08 -0800
Received: from zone4.gcu-squad.org ([213.91.10.50] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DGCuH-0006yB-Td
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Mar 2005 01:21:08 -0800
In-Reply-To: <a44ae5cd05032817125e99b868@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
To: miles.lane@gmail.com, rddunlap@osdl.org
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net


Hi gentle folks,

> Perhaps you are thinking I am using the NVidia binary driver?
> This is not the case.  nvidiafb is a recently added framebuffer
> driver (IIRC, first showing up in 2.6.12-rc1-mm2).  I believe
> khali@linux-fr.org is the author.

I am not! Antonino Daplas is. Adding him to the CC list, although I guess
he reads linux-fbdev-devel.

The only part I can help with is the i2c stuff, which caused trouble
already, but so far I couldn't find anything relevant. The nvidiafb
driver is quite new, and it's natural that it needs some debugging. I
suspect that the driver has some severe problem with the way it handles
resources, as was suggested by our previous (failed) attempts to debug
it. I'd be happy to help with the debugging but unfortunately (no quite
so) I don't have any nvidia device in my machines anymore.

Somewhere else in this thread, Randy suggested that some __devinit stuff
wasn't really. I think it would be worth investigating this first, and
make sure that nothing is incorrectly tagged. The oops reported by Miles
sounded like large memory chunks had been freed when they shouldn't
have. I think I understand that erroneously tagging things __init might
lead to that kind of trouble. But maybe it's a completely different
problem, I'm really only suggesting this because I don't get what's
going on either.

Thanks,
--
Jean Delvare


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
