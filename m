From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] PXA255 LCD Driver
Date: Thu, 18 Mar 2004 20:36:38 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040318203638.A12978@flint.arm.linux.org.uk>
References: <1079525185.13373.143.camel@icampbell-debian> <Pine.LNX.4.44.0403171723330.15898-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B44G8-00089Q-Mi
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Mar 2004 12:36:56 -0800
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B44G7-0007i6-7M
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Mar 2004 12:36:55 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403171723330.15898-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Wed, Mar 17, 2004 at 07:03:06PM +0000
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Ian Campbell <icampbell@arcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Mar 17, 2004 at 07:03:06PM +0000, James Simmons wrote:
> behavior is struct fb_monspecs. Take a look at it in fb.h. I'm interested 
> if I got all the needed data from the EDID about a display panel.

You're thinking too PC-centric.  You don't get EDID data with embedded
LCD panels.  Instead, you get timing information, number of pixels per
line, and other parameters either from a PDF or paper datasheet on the
device.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
