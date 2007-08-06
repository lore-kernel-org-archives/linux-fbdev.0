From: Rodolfo Giometti <giometti@enneenne.com>
Subject: Re: [RFC] Dynamic boot logo
Date: Mon, 6 Aug 2007 11:45:52 +0200
Message-ID: <20070806094552.GB354@enneenne.com>
References: <20070804134123.GA19707@enneenne.com>
	<46B6D374.9080001@cetrtapot.si>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IHz8G-0001MB-EE for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 06 Aug 2007 02:44:12 -0700
Received: from 81-174-11-161.static.ngi.it
	([81.174.11.161] helo=mail.enneenne.com ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IHz8E-00009y-Qb
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 06 Aug 2007 02:44:12 -0700
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50) id 1IHz3l-0000HG-45
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 06 Aug 2007 11:39:36 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.63)
	(envelope-from <giometti@enneenne.com>) id 1IHz9s-0006uu-9n
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 06 Aug 2007 11:45:52 +0200
Content-Disposition: inline
In-Reply-To: <46B6D374.9080001@cetrtapot.si>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Mon, Aug 06, 2007 at 09:53:24AM +0200, hinko.kocevar@cetrtapot.si wrote:
> 
> We would like to have this feature on my embedded system too! Currently 
> we are using bitmap file converted to standard header file and then 
> compiled in the kernel, which is not flexible at all.

Yes, I see.

> Maybe you could access the same flash memory from the Linux too - using 
> either physical or virtual address space, eg. by I/O or memory mapping it.

Yes, I know, but _how_ can I do it? :) In u-boot is very easy but in
Linux I still haven't found a good way to do so.

> Another way could be using a dedicated kernel module for the job - eg. 
> you compile the graphic support in the module and the when update is 
> needed only module can be replaced in the file system leaving kernel 
> intact (at least while kernel version does not change).

This is not solve the problem, you still need a compilation stage. I
wish avoiding it. And, on the other hand, you cannot load a kernel
module since you don't mount a root filesystem which is very late
during boot.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
