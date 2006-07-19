From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: printk change in 2.6.18?
Date: Wed, 19 Jul 2006 19:57:38 +0800
Message-ID: <44BE1E32.9060407@gmail.com>
References: <1756A939-0BF4-48F1-9CEC-DB468306073C@cecropia.com>
	<44BD72BB.2090000@gmail.com>
	<93DE4F1B-CF8B-4E72-8323-7869C9098728@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G3AgX-0006G5-N3 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 19 Jul 2006 04:57:49 -0700
Received: from py-out-1112.google.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G3AgV-0005aM-6i
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 19 Jul 2006 04:57:49 -0700
Received: by py-out-1112.google.com with SMTP id e30so228055pya
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 19 Jul 2006 04:57:43 -0700 (PDT)
In-Reply-To: <93DE4F1B-CF8B-4E72-8323-7869C9098728@cecropia.com>
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
To: Dennis Munsie <dmunsie@cecropia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Dennis Munsie wrote:
> The weirdness just goes on and on.... it seems that even though
> intelfb_mode_to_hw() is only called by intelfb_set_par() and that is
> only (as far as I can tell) called by fb_set_var(), the calls to
> fb_set_var() that I am seeing are not the ones calling
> intelfb_set_par().  Those ones either seem to be masked out completely,
> or they don't seem to be happening at all.
> 
> Except, that I know that they are happening, because I have some test
> code in there that I know very well is working and that if I comment
> that code out, everything breaks.
> 
> Is it possible for intelfb_set_par() to be called from anywhere else? 

Yes, fb_set_par() can be called directly by fbcon. See
drivers/video/console/fbcon.c

> Or is it only called by fb_set_var()?

No.

> 
> On Jul 18, 2006, at 7:46 PM, Antonino A. Daplas wrote:
> 
>> Does the printk's show up in syslog (dmesg)? How about when intelfb
>> and fbcon are just loaded? How about while doing an fbset?
> 
> the printk's don't seem to show up anywhere... I've tried all kinds of
> variations -- using the DBG_MSG() macro in the intelfb, using printk()
> with KERN_ERR, KERN_CRIT, and without anything (which should be KERN_WARN).
> 
> I have a serial connection with earlyprintk turned on -- I can see all
> of the messages back to the first line in the boot.  None of my messages
> show up.  I also have loglevel set to a ridiculous 255 -- it was at 8
> before.  I even have debug turned on in the intelfb driver.  At one
> point, I had verbose turned on as well, but that gets way too chatty.

You mean, if you type 'dmesg', you don't see the printk's? All printk's
should at least reach the logbuffer, but if it doesn't even reach the
logbuffer level, then the problem is very high up.

Tony

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
