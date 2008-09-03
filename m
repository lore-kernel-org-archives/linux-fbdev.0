From: "Jorge Marques Pelizzoni" <jpeliz@icmc.usp.br>
Subject: LPC2478: how far from a frame buffer driver?
Date: Wed, 3 Sep 2008 11:08:25 -0300 (BRT)
Message-ID: <56392.200.178.190.130.1220450905.squirrel@mail2.icmc.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kat2Z-0004jr-IP for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 07:08:59 -0700
Received: from mail.icmc.usp.br ([143.107.231.3] helo=mail2.icmc.usp.br)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Kat2W-0004qG-2P
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 07:08:59 -0700
Received: from mail2.icmc.usp.br (mail2 [143.107.231.3])
	by mail2.icmc.usp.br (Postfix) with ESMTP id CD6435139
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed,  3 Sep 2008 11:08:25 -0300 (BRT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: fbdev  <linux-fbdev-devel@lists.sourceforge.net>



Hi all,

I am considering using microcontroller LPC2478 by NXP (for its built-in,
DMA performing LCD controller) in a project. Has any of you heard of
someone developing a fb driver for it? Anyway, I'll probably be working on
that in no time. So those of you knowleadgeable of this MCU's architecture
have any pointers (e.g. most suitable sample code to base on) regarding
such effort?

Thanks in advance. Cheers,

Jorge M. Pelizzoni.



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
