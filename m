From: Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [PATCH] Provide control of active VGA device on PCI systems
Date: Tue, 22 Feb 2005 13:02:59 -0800
Message-ID: <200502221302.59803.jbarnes@sgi.com>
References: <9e47339105021921507545d084@mail.gmail.com> <200502221050.43534.jbarnes@sgi.com> <1109105867.5411.128.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3hBW-0005Ly-9n
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Feb 2005 13:03:10 -0800
Received: from omx3-ext.sgi.com ([192.48.171.20] helo=omx3.sgi.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D3hBT-0008R8-PP
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Feb 2005 13:03:10 -0800
In-Reply-To: <1109105867.5411.128.camel@gaston>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Tuesday, February 22, 2005 12:57 pm, Benjamin Herrenschmidt wrote:
> Well, that's something we need to figure out... While I do think the
> POSTing must be under driver control, as I explained, there is still
> that nasty notion of who has the stuff at 0xc0000 ... and if your
> firmware runs the x86 BIOS but doesn't keep the shadow around, then you
> are toast with a good deal of laptop chips.

Right, that's a big pain.

> The problem is that on some cards (ATIs for example), the BIOS will
> modify the image in RAM at c0000 and will put in there various infos,
> like panel type, PLL infos, etc... that can't always be obtained from
> the "hard" ROM (especially the panel infos). The driver (raeonfb or X,
> strace X and see it mmap'ing /dev/mem at c0000...) need those things.

Shouldn't the driver safe that stuff at suspend time for use at resume time?  
Or do we expect to be able to resume with different hw attached?

Jesse


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
