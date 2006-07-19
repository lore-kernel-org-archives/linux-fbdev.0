From: Dennis Munsie <dmunsie@cecropia.com>
Subject: Re: printk change in 2.6.18?
Date: Tue, 18 Jul 2006 22:41:19 -0400
Message-ID: <93DE4F1B-CF8B-4E72-8323-7869C9098728@cecropia.com>
References: <1756A939-0BF4-48F1-9CEC-DB468306073C@cecropia.com>
	<44BD72BB.2090000@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G3209-0001uE-5n for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 18 Jul 2006 19:41:29 -0700
Received: from mail4.sea5.speakeasy.net ([69.17.117.6])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G3207-0000aK-Ts
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 18 Jul 2006 19:41:29 -0700
Received: from pool-71-126-244-175.bstnma.fios.verizon.net (HELO
	[192.168.0.100]) (dmunsie@cecropia.com@[71.126.244.175])
	(envelope-sender <dmunsie@cecropia.com>)
	by mail4.sea5.speakeasy.net (qmail-ldap-1.03) with RC4-SHA encrypted
	SMTP for <linux-fbdev-devel@lists.sourceforge.net>;
	19 Jul 2006 02:41:21 -0000
In-Reply-To: <44BD72BB.2090000@gmail.com>
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
To: "Antonino A.Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

The weirdness just goes on and on.... it seems that even though  
intelfb_mode_to_hw() is only called by intelfb_set_par() and that is  
only (as far as I can tell) called by fb_set_var(), the calls to  
fb_set_var() that I am seeing are not the ones calling intelfb_set_par 
().  Those ones either seem to be masked out completely, or they  
don't seem to be happening at all.

Except, that I know that they are happening, because I have some test  
code in there that I know very well is working and that if I comment  
that code out, everything breaks.

Is it possible for intelfb_set_par() to be called from anywhere  
else?  Or is it only called by fb_set_var()?

On Jul 18, 2006, at 7:46 PM, Antonino A. Daplas wrote:

> Does the printk's show up in syslog (dmesg)? How about when intelfb
> and fbcon are just loaded? How about while doing an fbset?

the printk's don't seem to show up anywhere... I've tried all kinds  
of variations -- using the DBG_MSG() macro in the intelfb, using  
printk() with KERN_ERR, KERN_CRIT, and without anything (which should  
be KERN_WARN).

I have a serial connection with earlyprintk turned on -- I can see  
all of the messages back to the first line in the boot.  None of my  
messages show up.  I also have loglevel set to a ridiculous 255 -- it  
was at 8 before.  I even have debug turned on in the intelfb driver.   
At one point, I had verbose turned on as well, but that gets way too  
chatty.

I haven't tried the other methods -- to be honest, I've been using  
printk's without problem now for the past couple of months, and I  
never bothered trying to use modules yet.  For my purposes, making  
some changes, recompiling, and rebooting the box hasn't been too big  
of a hassle.

So, for now, I'm sidestepping this entire episode by just hacking in  
some sysfs attributes to get the info out that I need.  It's not  
ideal, but it'll work.  I might have another look at it once I get  
the intelfb driver issues that I'm working on sorted out.

dennis

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
