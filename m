From: Jerald Fitzjerald <jfj@freemail.gr>
Subject: Plans for 2D acceleration
Date: Wed, 26 Sep 2007 04:41:45 -0700
Message-ID: <46FA4579.6040905@freemail.gr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IaVGM-0002aq-Kl for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 26 Sep 2007 04:41:06 -0700
Received: from kane.otenet.gr ([195.170.0.77] ident=OTEnet-mail-system)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IaVGK-0003YH-TA
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 26 Sep 2007 04:41:06 -0700
Received: from [87.203.210.184] (athedsl-59754.home.otenet.gr [87.203.210.184])
	by kane.otenet.gr (8.13.8/8.13.8/Debian-3) with ESMTP id l8QBf09N024661
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 26 Sep 2007 14:41:01 +0300
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi.

Are there any plans to expose simple 2D acceleration to userland?
I'm talking about the very basic operations:

- fill rectangle (graphics memset)
- blit (graphics memcpy)

and possibly

- copyarea (graphics memmove)
- waitretrace

Is there a reason we _don't_ want these exposed to userland or
just nobody has taken the time to do it?


Thanks,

jf

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
