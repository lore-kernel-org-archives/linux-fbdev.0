From: Antonino Daplas <adaplas@pol.net>
Subject: [Fwd: [directfb-dev] Is is eady to improve / extend 5005 driver]
Date: 17 Feb 2003 14:32:21 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045463288.1207.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-NUblBXmyYhyYqm8xQpwm"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18kepg-00034u-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 16 Feb 2003 22:32:52 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Hartmut Van Waregem <hvanwaregem@yahoo.com>


--=-NUblBXmyYhyYqm8xQpwm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit




--=-NUblBXmyYhyYqm8xQpwm
Content-Disposition: inline
Content-Description: Forwarded message - [directfb-dev] Is is eady to
	improve / extend 5005 driver
Content-Type: message/rfc822

Return-Path: <directfb-dev-bounce@directfb.org>
X-Sieve: cmu-sieve 2.0
Received: from smtp.convergence.de (buserror-extern.convergence.de
	[212.84.236.66]) by tom.po.com (8.12.2/8.12.2) with ESMTP id h1BMM6jO001798
	for <adaplas@pol.net>; Tue, 11 Feb 2003 17:22:07 -0500 (EST)
Received: from localhost ([127.0.0.1] helo=smtp.convergence.de) by
	smtp.convergence.de with esmtp (Exim 4.12) id 18iipA-0000rX-00; Tue, 11 Feb
	2003 23:24:20 +0100
Received: with ECARTIS (v1.0.0; list directfb-dev); Tue, 11 Feb 2003
	23:24:13 +0100 (CET)
Received: from [212.84.236.2] (helo=chambertin.convergence.de) by
	smtp.convergence.de with esmtp (TLSv1:DES-CBC3-SHA:168) (Exim 4.12) id
	18iip2-0000rE-00 for directfb-dev@smtp.convergence.de; Tue, 11 Feb 2003
	23:24:12 +0100
Received: from web20710.mail.yahoo.com ([216.136.226.183]) by
	chambertin.convergence.de with  smtp (Exim 3.33 #2 ) id 18iilx-0008Dt-00
	for <directfb-dev@directfb.org>; Tue, 11 Feb 2003 23:21:01 +0100
Message-ID: <20030211222059.99232.qmail@web20710.mail.yahoo.com>
Received: from [81.51.21.169] by web20710.mail.yahoo.com via HTTP; Tue, 11
	Feb 2003 14:20:59 PST
Date: Tue, 11 Feb 2003 14:20:59 -0800 (PST)
From: Hartmut Van Waregem <hvanwaregem@yahoo.com>
Subject: [directfb-dev] Is is eady to improve / extend 5005 driver
To: directfb-dev@directfb.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-ecartis-version: Ecartis v1.0.0
Sender: directfb-dev-bounce@directfb.org
Errors-to: directfb-dev-bounce@directfb.org
X-original-sender: hvanwaregem@yahoo.com
Precedence: bulk
X-list: directfb-dev

Hi,

I am trying to implement a new application for the
OpenBrick (www.openbrick.org) which is based on the
IGS 5005 chipset.

I tried many binary drivers from TVIA (available here
or there on the Web) which are all more a less buggy.
Also, apparently, TVIA does not open source the
drivers and requires a very high amount of money to
provide source code from what I read on this mailing
list. I have contacted the people at Nexedi who
distribute the OpenBrick but they told me that they
were not allowed yet to distribute the binary driver
which TVIA provided them and that they were still
waiting for TVIA to allow them to do so. They advised
me to use VESA until TVIA would provide them a good
support. 

Therefore, I would prefer to support the kernel GPL
driver for IGS 5005 by developing my application based
on this driver rather than supporting the TVIA
proprietary approach.

I have already been evaluating the kernel fb driver
which works quite OK on the OpenBrick but does not
seem to be able to initialize the 4MB shared memory,
thus preventing high resolutions / high depth. I will
try this WE to patch  it somehow to get the 4MB.
Besides that, scrolling generates many strange small
pixels in high res (it is OK in low res). And some
features of the IGS 5005 do not seem to be
implemented.

What I need for my application(s) is
	- get good resolution (ie. 1280 x 1024 in 16 bits)
	- be able to display a small MPEG stream (from a
file) on the TV output and a Web Page on the VGA
output at the same time

I would really appreciate if someone could let me know
if all this is possible / easy / complex etc. to
implement based on either directfb and/or the linux
framebuffer driver.

Regards,

Hartmut.

__________________________________________________
Do you Yahoo!?
Yahoo! Shopping - Send Flowers for Valentine's Day
http://shopping.yahoo.com


-- 
Info:  To unsubscribe send a mail to ecartis@directfb.org with 
"unsubscribe directfb-dev" as subject.


--=-NUblBXmyYhyYqm8xQpwm--




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
