From: Bill Gatliff <bgat@billgatliff.com>
Subject: SM501 framebuffer driver
Date: Fri, 06 Oct 2006 11:11:46 -0500
Message-ID: <45268042.8050207@billgatliff.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVsIa-0004C8-FZ for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Oct 2006 09:11:44 -0700
Received: from smtp2.mtco.com ([207.179.226.205])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GVsIZ-0002wm-4y
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Oct 2006 09:11:44 -0700
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
Cc: Robert Whaley <rwhaley@applieddata.net>

Guys:


Sorry about starting a new thread, but I was referred to this 
list/thread by a colleague just a few minutes ago.  (OT: it isn't in the 
archives in SF, either!).

I hate to play "me too!", but I also have an SM501 framebuffer driver in 
a partial state of development.  I'd love to collaborate with others to 
get a good version pushed upstream.

One of the challenges I've encountered with this chip is dealing with 
all the "other stuff" it has onboard.  In my driver, I addressed that by 
creating a whole new bus similar to what Nico did for the UCB1400.  I 
was in the process of getting AC97 working when I figured out that that 
part of the chip is so braindead, it isn't worth using--- at least on 
ARM platforms that don't have DMA (which was my case).

In an upcoming project I need to use the USBH, so I'll be revisiting 
this issue again soon.  I have also cc'd others who have worked with me 
on this chip.

I'd be happy to post code if that makes sense.  Or to host a CVS repo or 
something.


Kindest regards,


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
