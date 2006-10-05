From: James Cloos <cloos@jhcloos.com>
Subject: Non-blinking Cursor?
Date: Wed, 04 Oct 2006 23:12:49 -0400
Message-ID: <m3fye3pi9j.fsf@lugabout.jhcloos.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVJfw-0000d7-Sh for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Oct 2006 20:13:33 -0700
Received: from ore.jhcloos.com ([64.240.156.239])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GVJfu-0003Y4-RT
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Oct 2006 20:13:32 -0700
Received: from lugabout.jhcloos.org (ppp13.pm3-15.buf-ch.ny.localnet.com
	[69.48.15.13])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "lugabout.jhcloos.org",
	Issuer "ca.jhcloos.com" (verified OK))
	by ore.jhcloos.com (Postfix) with ESMTP id 410CB1C57D
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed,  4 Oct 2006 22:11:57 -0500 (CDT)
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
To: linux-fbdev-devel@lists.sourceforge.net

Is there a way to get the cursor to stop blinking w/ a frambuffer
console?  The escape sequence in the docs (for a vga cons) does
not work.

To be clear, I'm not asking about hinding the cursor.  It is just
that flashing cursors give me headaches.

(I use radeonfb.)

Thanks.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 0xED7DAEA6

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
