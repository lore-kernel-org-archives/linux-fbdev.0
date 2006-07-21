From: Dennis Munsie <dmunsie@cecropia.com>
Subject: YUV support
Date: Fri, 21 Jul 2006 17:08:53 -0400
Message-ID: <A52F3235-4BC6-4B97-921D-5FFD642AA044@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G42DF-0007Pz-2F for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 21 Jul 2006 14:07:09 -0700
Received: from mail2.sea5.speakeasy.net ([69.17.117.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G42DE-0000X8-Nt
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 21 Jul 2006 14:07:08 -0700
Received: from lex098.cecropia.com (HELO [192.168.3.132])
	(dmunsie@cecropia.com@[63.138.212.98])
	(envelope-sender <dmunsie@cecropia.com>)
	by mail2.sea5.speakeasy.net (qmail-ldap-1.03) with RC4-SHA encrypted
	SMTP for <linux-fbdev-devel@lists.sourceforge.net>;
	21 Jul 2006 21:07:00 -0000
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

Hi again,

I'm starting to investigate adding YUV support to the intelfb driver,  
and I was wondering what support is already in the framebuffer  
subsystem for YUV.  Doing a quick grep for YUV only yielded a handful  
of references -- all in drivers.  Nothing seems to be there for  
generic YUV support.

Am I correct in this assumption?  And, if so, what would be the best  
way to expose YUV support?  Driver specific ioctl's?  Separate fb  
device for the YUV overlay?  Give up and use X? (just kidding on that  
last one -- I hope).

dennis


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
