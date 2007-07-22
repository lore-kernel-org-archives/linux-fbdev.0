From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git patches] two warning fixes
Date: Mon, 23 Jul 2007 07:29:20 +1000
Message-ID: <1185139760.5439.52.camel@localhost.localdomain>
References: <20070718235504.GA9601@havoc.gtf.org>
	<alpine.LFD.0.999.0707181834070.27353@woody.linux-foundation.org>
	<469ECD29.2010909@garzik.org> <m3r6n4bjgg.fsf@maximus.localdomain>
	<alpine.LFD.0.999.0707191100480.27353@woody.linux-foundation.org>
	<m3644e2abd.fsf@maximus.localdomain>
	<1184977973.5439.45.camel@localhost.localdomain>
	<46A2D6F7.9080309@garzik.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ICizk-0004tg-FJ for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 22 Jul 2007 14:29:40 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX18ZU7ey2PHIiDuQFoE8r96ZAeleYYs4V68=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ICizj-0008Ho-1H
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 22 Jul 2007 14:29:40 -0700
In-Reply-To: <46A2D6F7.9080309@garzik.org>
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
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, ak@suse.de, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Krzysztof Halasa <khc@pm.waw.pl>


> Not necessarily as simple as that -- you need to make sure you don't 
> pass something bogus to a sysfs_remove_blah() function at 
> unregister/unload time, if sysfs_create_blah() failed.
> 
> Certainly sysfs_foo() failure is often ignorable in the sense that you 
> want the driver to keep loading... but that does not imply that it is 
> strictly ignorable, if you also consider the associated cleanup code.

It should be trivial enough to have sysfs_create_blah() do enough
initializations before it can fail so that sysfs_remove_blah() do the
right thing regardless.

It's actually a major PITA for a driver that creates a whole bunch of
sysfs files to have to track precisely which ones were created
successfully for the error path. If it's a single function, goto does
the trick but if for some reason it's not, it's really annoying.

Ben.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
