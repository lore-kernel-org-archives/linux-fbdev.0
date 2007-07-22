From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] two warning fixes
Date: Sun, 22 Jul 2007 00:03:03 -0400
Message-ID: <46A2D6F7.9080309@garzik.org>
References: <20070718235504.GA9601@havoc.gtf.org>	
	<alpine.LFD.0.999.0707181834070.27353@woody.linux-foundation.org>	
	<469ECD29.2010909@garzik.org> <m3r6n4bjgg.fsf@maximus.localdomain>	
	<alpine.LFD.0.999.0707191100480.27353@woody.linux-foundation.org>	
	<m3644e2abd.fsf@maximus.localdomain>
	<1184977973.5439.45.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ICSf9-0003NA-VP for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 21 Jul 2007 21:03:20 -0700
Received: from srv5.dvmed.net ([207.36.208.214] helo=mail.dvmed.net)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ICSf8-0001ig-Gw
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 21 Jul 2007 21:03:19 -0700
In-Reply-To: <1184977973.5439.45.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, ak@suse.de, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Krzysztof Halasa <khc@pm.waw.pl>

Benjamin Herrenschmidt wrote:
> Thus, we have two choices here:
> 
>  - The simple one: sysfs_create_blah() displays a warning when it fails
> and has no must_check
> 
>  - The one that adds code everywhere (the current one):
> sysfs_create_blah() returns an error, has much_check, and thus all
> callers like I described abvoe need to add code to test it and print a
> warning. Lots of added .text and .data for little benefit.


Not necessarily as simple as that -- you need to make sure you don't 
pass something bogus to a sysfs_remove_blah() function at 
unregister/unload time, if sysfs_create_blah() failed.

Certainly sysfs_foo() failure is often ignorable in the sense that you 
want the driver to keep loading... but that does not imply that it is 
strictly ignorable, if you also consider the associated cleanup code.

	Jeff



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
