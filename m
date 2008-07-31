From: Alessio Sangalli <alesan@manoweb.com>
Subject: Implementing new fb driver
Date: Wed, 30 Jul 2008 17:57:20 -0700
Message-ID: <48910DF0.4070906@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOMTz-00063L-3B for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jul 2008 17:57:31 -0700
Received: from moutng.kundenserver.de ([212.227.126.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KOMTx-0000jX-IQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jul 2008 17:57:31 -0700
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

Hi there, I will be implementing a framebuffer driver for an internally
developed video adapter.

This adapter is able to change resolution and bit depth, has hardware
mouse support and bitblt acceleration. It will be for the ARM9
architecture (AHB bus).

The question is: is there an API to implement to give access to these
features? Which driver you think can be considered similar to take
inspiration from?

Sorry for the stupid questions but I'd like to design a good interface
before beginning to hack... :)

bye
Alessio


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
