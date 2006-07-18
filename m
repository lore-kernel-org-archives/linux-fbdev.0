From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: printk change in 2.6.18?
Date: Wed, 19 Jul 2006 07:46:03 +0800
Message-ID: <44BD72BB.2090000@gmail.com>
References: <1756A939-0BF4-48F1-9CEC-DB468306073C@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G2zGY-0003qD-Cy for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 18 Jul 2006 16:46:14 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G2zGW-0000ov-Qv
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 18 Jul 2006 16:46:14 -0700
Received: by py-out-1112.google.com with SMTP id e30so47510pya
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 18 Jul 2006 16:46:11 -0700 (PDT)
In-Reply-To: <1756A939-0BF4-48F1-9CEC-DB468306073C@cecropia.com>
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
Cc: Dennis Munsie <dmunsie@cecropia.com>

Dennis Munsie wrote:
> I just migrated my development over to 2.6.18-rc2, and I've now  
> noticed that some of the printk's that used to work under 2.6.17  
> stopped working under 2.6.18.  The printk's that I'm referring to are  
> in intelfbhw_mode_to_hw() which is ultimately called by  
> intelfb_set_par() which is called by fb_set_var().

Does the printk's show up in syslog (dmesg)? How about when intelfb
and fbcon are just loaded? How about while doing an fbset?

> 
> I can put a printk() at the top of fb_set_var(), and it shows up.   
> But anything else in there fails to show up.
> 
> Have there been any changes in the framebuffer that would suppress  
> printk's in fb_set_var()?  I didn't see anything obvious, but I'm  
> probably missing something.

It's possible that the changes in the vt layer may have caused this
unintentionally.

Tony

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
