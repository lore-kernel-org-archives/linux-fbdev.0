From: Dennis Munsie <dmunsie@cecropia.com>
Subject: printk change in 2.6.18?
Date: Tue, 18 Jul 2006 17:05:18 -0400
Message-ID: <1756A939-0BF4-48F1-9CEC-DB468306073C@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G2wjT-0006xl-Ez for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 18 Jul 2006 14:03:55 -0700
Received: from mail8.sea5.speakeasy.net ([69.17.117.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G2wjS-0004Z5-6P
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 18 Jul 2006 14:03:55 -0700
Received: from lex098.cecropia.com (HELO [192.168.3.132])
	(dmunsie@cecropia.com@[63.138.212.98])
	(envelope-sender <dmunsie@cecropia.com>)
	by mail8.sea5.speakeasy.net (qmail-ldap-1.03) with RC4-SHA encrypted
	SMTP for <linux-fbdev-devel@lists.sourceforge.net>;
	18 Jul 2006 21:03:48 -0000
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

I just migrated my development over to 2.6.18-rc2, and I've now  
noticed that some of the printk's that used to work under 2.6.17  
stopped working under 2.6.18.  The printk's that I'm referring to are  
in intelfbhw_mode_to_hw() which is ultimately called by  
intelfb_set_par() which is called by fb_set_var().

I can put a printk() at the top of fb_set_var(), and it shows up.   
But anything else in there fails to show up.

Have there been any changes in the framebuffer that would suppress  
printk's in fb_set_var()?  I didn't see anything obvious, but I'm  
probably missing something.

dennis

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
