From: Matan Ziv-Av <matan@svgalib.org>
Subject: Re: VGA routing
Date: Wed, 10 Dec 2003 18:05:33 +0200 (IST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312101709300.3578@matan.home>
References: <20031207073448.83488.qmail@web14911.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AU6qL-0006hB-Fs
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Dec 2003 08:05:41 -0800
Received: from [212.29.226.3] (helo=arava.co.il)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AU6qK-0007FR-Jy
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Dec 2003 08:05:40 -0800
In-Reply-To: <20031207073448.83488.qmail@web14911.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 6 Dec 2003, Jon Smirl wrote:

> My machine has three busses.
> 1) on chip
> 2) AGP
> 3) PCI
> 
> My primary display is on a PCI card.
> When I boot the VGA ports are routed through the PCI bridge.
> I'm running X on the PCI card.

There is VGA bit of Bridge Control register in PCI-PCI bridges (bit 19, 
at 3c). But when there are a few cards on the same bus, I guess the 
behaviour is undefined, since I did not see anything relevant in the 
standards. 

> Thanks for the help. I'm trying to figure out the right way to initialize a
> secondary card by jumping to C000:0003 in it's BIOS. Does Xfree jump to
> C000:0003? I can't find where it does that in the source.

x86emu package does this by disabling all cards except for the one that 
is being initialized.


-- 
Matan Ziv-Av.                         matan@svgalib.org



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
