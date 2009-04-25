From: Alessio Sangalli <alesan@manoweb.com>
Subject: Re: Framebuffer using system memory
Date: Sat, 25 Apr 2009 02:37:25 -0700
Message-ID: <49F2D9D5.9020903@manoweb.com>
References: <49F263D0.4030108@manoweb.com>
	<10f740e80904250045u1e617c9v2d49f30fce1cf40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <alesan@manoweb.com>) id 1LxeKG-00043c-DB
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 25 Apr 2009 09:37:36 +0000
Received: from moutng.kundenserver.de ([212.227.126.177])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LxeKC-0001TJ-1U for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 25 Apr 2009 09:37:36 +0000
In-Reply-To: <10f740e80904250045u1e617c9v2d49f30fce1cf40@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:

> Alternatively, you could use__alloc_bootmem() in the early platform
> code to reserve
> the memory, cfr. arch/powerpc/platforms/ps3/setup.c


Yeah thanks, that example is pretty complete. I will try that. Anyway,
for my personal curiosity, is it possible at all to map memory not
managed by the kernel to userspace?

bye
as


------------------------------------------------------------------------------
Crystal Reports &#45; New Free Runtime and 30 Day Trial
Check out the new simplified licensign option that enables unlimited
royalty&#45;free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
