From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Patch to cyberfb.c to drive Aurora 64 V+
 (fwd)
Date: Fri, 04 Jul 2003 10:43:18 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3F059286.1000306@pobox.com>
References: <Pine.GSO.4.21.0307041625200.9830-200000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252] helo=www.linux.org.uk)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19YRmp-0003s5-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 04 Jul 2003 07:43:43 -0700
In-Reply-To: <Pine.GSO.4.21.0307041625200.9830-200000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, baccala@vger.freesoft.org

Geert Uytterhoeven wrote:
> ---------- Forwarded message ----------
> Date: Wed, 2 Jul 2003 15:57:15 -0400 (EDT)
> From: Brent Baccala <baccala@vger.freesoft.org>
> To: linux-kernel@vger.kernel.org
> Cc: hartwinleen@gmx.net
> Subject: Patch to cyberfb.c to drive Aurora 64 V+
> 
> Hi -
> 
> I'm attaching a patch to 2.4.20's drivers/video/cyberfb.c to drive the
> S3 Aurora 64 V+ chip
> 
> cyberfb.c is a fairly generic S3 driver, so half of this patch is
> byte-ordering and probing on the PCI bus as well as the Zorro bus.
> 
> Unfortunately, the machine I was developing this on died, and the
> patch really isn't finished yet.  It works, but it has some problems
> (if you try to start a 16-color X server, you'll see; 256-color works
> fine, though, full color had some kind of problem, I recall).  It
> also has some "#if 0"s that really should be better conditionals.
> 
> But, the machine is dead, and barring a resurrection, I won't be
> doing any more work on this code.  It's a good starting point for
> anyone try to get an S3 Aurora V+ running with the kernel framebuffer
> code, and, I dare say, anyone with another kind of S3 or S3-compatible
> card should find it a good start.
> 
> Sorry about the half-finished code, but "release early, release often",
> so maybe somebody else can get some good from it.

Very cool!

For someone interested in this, there is also my cyberfb and s3fb work:
http://gtf.org/garzik/kernel/files/s3fb/

(also unfinished)

	Jeff





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
