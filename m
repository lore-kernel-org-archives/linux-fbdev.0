From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: radeonfb: Radeon Mobility X700 (M26) +	x86-64
 supported?
Date: Tue, 03 Jan 2006 21:39:28 +0100
Message-ID: <43BAE100.2050906@vc.cvut.cz>
References: <20051223031333.GA14399@shaftnet.org>	 <43B57067.1010807@vc.cvut.cz> <1136248698.4688.2.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EtswU-0002zJ-Q7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Jan 2006 12:39:38 -0800
Received: from mailgw.cvut.cz ([147.32.3.235])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EtswR-0003u1-Ou
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Jan 2006 12:39:38 -0800
Received: from mailgw (localhost [127.0.0.1])
	by mailgw.cvut.cz (Postfix) with SMTP id 1491413B70E
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  3 Jan 2006 21:39:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mailgw.cvut.cz (Postfix) with ESMTP id F0BA613B77C
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  3 Jan 2006 21:39:28 +0100 (CET)
Received: from mailgw.cvut.cz ([127.0.0.1])
	by localhost (mailgw [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 02321-01-3 for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 3 Jan 2006 21:39:28 +0100 (CET)
Received: from [127.0.0.1] (vana.vc.cvut.cz [147.32.240.58])
	by mailgw.cvut.cz (Postfix) with ESMTP id CA4B413B70E
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  3 Jan 2006 21:39:28 +0100 (CET)
In-Reply-To: <1136248698.4688.2.camel@localhost.localdomain>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Benjamin Herrenschmidt wrote:
>>It is not in the BIOS anymore.  VESA call 0x4F15 works fine, but I did 
>>not bothered with looking at the BIOS yet.  With my hardware radeonfb 
>>correctly finds that LVDS output is programmed for 1920x1200 and does 
>>not touch it, unfortunately it has some problems with memory fetches 
>>which cause pixels (+-)512-768 and 1536-1792 to be missing on display, 
>>and right side of picture being black.
>>
>>For now I use vesafb - unfortunately BIOS does not have 1920x1200 
>>videomode, but 1600x1200 works more or less acceptable, those pixels are 
>>really small...
> 
> 
> Does it work with a recent X.org ? What does it say in the log ? The ATI
> BIOS tables have changed format and radeonfb doesn't (yet) know about
> the new format.

I've put logs at http://platan.vc.cvut.cz/ftp/private/radeon/.  It works fine 
with fglrx driver.  With radeon driver from X.org 6.9 it tries to do something, 
but it is hopelessly off - I can see that it attempts to show black/white X 
screen with mouse cursor, but lines are not horizontally synchronized and 
vertically picture is shifted so that vertical blanking is somewhere around 
LCD's 66%.  I can try to grab movie if you want...

ddcprobe.txt is output from ddcprobe, dmesg.txt are radeonfb's boot messages, 
vga.rom is BIOS, and fglrx.xorg.log and radeon.xorg.log are X.org logs.
								Petr



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
