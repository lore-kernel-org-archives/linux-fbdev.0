From: Alessio Sangalli <alesan@manoweb.com>
Subject: Framebuffer using system memory
Date: Fri, 24 Apr 2009 18:13:52 -0700
Message-ID: <49F263D0.4030108@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <alesan@manoweb.com>) id 1LxWf3-0000oa-Cr
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 25 Apr 2009 01:26:33 +0000
Received: from moutng.kundenserver.de ([212.227.126.177])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LxWf2-0005K9-1M for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 25 Apr 2009 01:26:33 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

Hi I am working on a framebuffer that uses the system memory.

What I mean here is that I need to pass mem=120M to a system that has
128MB to "reserve" 8MB of memory for the framebuffer; then I program the
hardware to use that region of memory.

The reason I do this is that it seems impossible to kmalloc more that
4MB of contiguos physical memory with the Linux Kernel.

Bottom line, I do not know how to map those 8MB back to userspace. If
userspace opens mmaps /dev/mem and writes to the appropriate location it
can access the fb perfectly.

Any hints? All of this is on ARM9.

Thank you
Alessio


------------------------------------------------------------------------------
Crystal Reports &#45; New Free Runtime and 30 Day Trial
Check out the new simplified licensign option that enables unlimited
royalty&#45;free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
