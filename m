From: Rodolfo Giometti <giometti@enneenne.com>
Subject: [RFC] Dynamic boot logo
Date: Sat, 4 Aug 2007 15:41:23 +0200
Message-ID: <20070804134123.GA19707@enneenne.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IHK65-00085t-Fx for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 04 Aug 2007 06:55:13 -0700
Received: from 81-174-11-161.static.ngi.it
	([81.174.11.161] helo=mail.enneenne.com ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IHK64-0008Is-1N
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 04 Aug 2007 06:55:13 -0700
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50) id 1IHK1j-00067j-Jg
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 04 Aug 2007 15:50:47 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.63)
	(envelope-from <giometti@enneenne.com>) id 1IHK7l-00059H-Jw
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 04 Aug 2007 15:56:57 +0200
Resent-Message-ID: <20070804135657.GG3876@enneenne.com>
Resent-To: linux-fbdev-devel@lists.sourceforge.net
Content-Disposition: inline
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

Hello,

I'd like to have some suggestions from you about how I can implement
the "dynamic boot logo" feature in Linux reading the logo from the
flash memory.

In my custom board, using u-boot I read a compressed bitmap from the
flash memory and then I use it to display the logo, so users just have
to change flash content in order to change then boot logo without
recompiling u-boot.

Could it be possible in Linux also? Which could be, in your opinion,
the best way to solve this problem?

Thanks in advance,

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
