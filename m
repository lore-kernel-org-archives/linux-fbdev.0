From: Antonino Daplas <adaplas@pol.net>
Subject: Re: 2.5.51 -- rivafb is whacky (characters
	flipped on vertical axis, 640x480 usable area shown inside a higher-res
	area, etc).
Date: 13 Dec 2002 14:34:15 +0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1039770362.1025.18.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0212130508050.10929-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18MjUY-00083v-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 12 Dec 2002 22:40:11 -0800
In-Reply-To: <Pine.LNX.4.44.0212130508050.10929-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Miles Lane <miles.lane@attbi.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2002-12-13 at 10:09, James Simmons wrote:
> 
> > Can you test the attached patch (rivafb1.diff)?  It fixes some things: 
> 
> I tested the patch. The colors are still messed up :-( I'm running at 8 
> bpp mode. I applied the patch since it fixed some important things. 
> I also add support and more functionality. I still have some to go.
>  
I'm confused too :-(.  If I'm going to expect color problems, it's not
at bpp8 since you don't really do anything except write to the DAC.  And
the fact that the driver works perfectly for the Riva128 (nvidia's first
chipset) makes me wonder even more.  Currently, I'm running everything
with the riva128, directfb, xfbdev, even the xgamma utility works,
flawlessly.

The only thing I can think of that we're doing differently from the 2.4
driver is the save_vga() part in rivafb_open.  Perhaps touching the vga
registers somehow confuses the hardware.  Unlikely, but maybe worth a
try.

How extensive is the color problem?  Does it just affect the logo, or
everything? Also, is the color problem present in both hardware and
software mode (just do fbset -accel true/false to find out)?  Is the
vertical mirroring as reported by Miles still present?  How about bpp16
or bpp32?

How I would love to debug that,  but I don't have the hardware :-(

Tony 




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
