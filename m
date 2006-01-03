From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb: Radeon Mobility X700 (M26) +
	x86-64 supported?
Date: Tue, 03 Jan 2006 11:38:17 +1100
Message-ID: <1136248698.4688.2.camel@localhost.localdomain>
References: <20051223031333.GA14399@shaftnet.org>
	 <43B57067.1010807@vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EtaB2-00016R-Cn
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 02 Jan 2006 16:37:24 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EtaB0-0004S1-3I
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 02 Jan 2006 16:37:24 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k030VaWG022908
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 2 Jan 2006 18:31:37 -0600
In-Reply-To: <43B57067.1010807@vc.cvut.cz>
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net


> It is not in the BIOS anymore.  VESA call 0x4F15 works fine, but I did 
> not bothered with looking at the BIOS yet.  With my hardware radeonfb 
> correctly finds that LVDS output is programmed for 1920x1200 and does 
> not touch it, unfortunately it has some problems with memory fetches 
> which cause pixels (+-)512-768 and 1536-1792 to be missing on display, 
> and right side of picture being black.
> 
> For now I use vesafb - unfortunately BIOS does not have 1920x1200 
> videomode, but 1600x1200 works more or less acceptable, those pixels are 
> really small...

Does it work with a recent X.org ? What does it say in the log ? The ATI
BIOS tables have changed format and radeonfb doesn't (yet) know about
the new format.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
