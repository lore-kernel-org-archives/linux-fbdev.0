From: "Paul A. Clarke" <pc@us.ibm.com>
Subject: Re: 
 matroxfb-fix-dvi-setup-to-be-more-compatible.patch introduces jitter
Date: Thu, 10 Aug 2006 11:55:07 -0500
Message-ID: <44DB64EB.3020007@us.ibm.com>
References: <689964845@web.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GBDoa-0006L5-1m for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 09:55:24 -0700
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GBDoX-0007MJ-5a
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 09:55:24 -0700
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7AGtBZ8024033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 10 Aug 2006 12:55:11 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k7AGt948245440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 10 Aug 2006 12:55:09 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7AGt87s015815 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 10 Aug 2006 12:55:09 -0400
In-Reply-To: <689964845@web.de>
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
Cc: vandrove@vc.cvut.cz

I've been looking deeper into this problem, which was reportedly introduced by 
my patch a while ago, in Linux kernel 2.6.17.  I don't doubt the reports, but 
I'd like to replicate the problem as seen on the x86 boxes as reported in kernel 
bug 6720 and a few others directly to me, so I can verify a fix (if/when I can 
create one).

So, I installed SLES 10 on an old x86 box, with a PCI G450 (actually an IBM 
GXT135P).  I verified that my patch is _not_ included in that kernel 
(2.6.16.21).  However, I see jittery DVI-D output at all times.  I've tried 
640x480@60Hz, 1280x1024@60Hz, different "vesa" mode parameters (0x11b, 0x1bb), 
XServer "-fbbpp 32".  I usually end up losing sync with the monitor after a few 
minutes.

I don't have much experience with the G450 on x86, but I'm quite surprised.  Has 
anyone else observed this?
-- 
Regards,
Paul Clarke

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
