From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] PXA255 LCD Driver
Date: Fri, 19 Mar 2004 23:52:37 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403192352050.14905-100000@phoenix.infradead.org>
References: <20040318203638.A12978@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B4TnI-0001fX-T6
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Mar 2004 15:52:52 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B4TnH-0008OL-4S
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Mar 2004 15:52:51 -0800
In-Reply-To: <20040318203638.A12978@flint.arm.linux.org.uk>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ian Campbell <icampbell@arcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> On Wed, Mar 17, 2004 at 07:03:06PM +0000, James Simmons wrote:
> > behavior is struct fb_monspecs. Take a look at it in fb.h. I'm interested 
> > if I got all the needed data from the EDID about a display panel.
> 
> You're thinking too PC-centric.  You don't get EDID data with embedded
> LCD panels.  Instead, you get timing information, number of pixels per
> line, and other parameters either from a PDF or paper datasheet on the
> device.

Your right. Want I would like to know is what do you guys need!!!





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
