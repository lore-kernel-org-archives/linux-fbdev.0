From: krzysztof.h1@poczta.fm
Subject: Re: Implementing new fb driver
Date: 31 Jul 2008 10:11:54 +0200
Message-ID: <20080731081154.57D5320B413@f26.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOTkw-000848-Le for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 01:43:30 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KOTkw-0002Vj-95
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 01:43:30 -0700
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
To: Alessio Sangalli <alesan@manoweb.com>, linux-fbdev-devel@lists.sourceforge.net



 > Hi there, I will be implementing a framebuffer driver for an internally
 > developed video adapter.
 > 
 > This adapter is able to change resolution and bit depth, has hardware
 > mouse support and bitblt acceleration. It will be for the ARM9
 > architecture (AHB bus).
 > 
 > The question is: is there an API to implement to give access to these
 > features? Which driver you think can be considered similar to take
 > inspiration from?
 > 
 > Sorry for the stupid questions but I\'d like to design a good interface
 > before beginning to hack... :)
 > 
 
There is a driver template called skeletonfb.c. It has extensive comments. Please use it as your template and report any problem (it should be up to date with API but something maybe missing).

A good example of working ARM fb driver is s3c2410fb driver.

Regards,
Krzysztof

----------------------------------------------------------------------
Najciekawsze miejsca w Polsce i na swiecie!
Zobacz >>> http://link.interia.pl/f1e60


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
