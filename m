From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Provide control of active VGA device on PCI systems
Date: Wed, 23 Feb 2005 08:27:14 +1100
Message-ID: <1109107634.5326.146.camel@gaston>
References: <9e47339105021921507545d084@mail.gmail.com>
	 <200502221050.43534.jbarnes@sgi.com> <1109105867.5411.128.camel@gaston>
	 <200502221302.59803.jbarnes@sgi.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3hZW-0006tc-9y
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Feb 2005 13:27:58 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D3hZV-0001Ec-OU
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Feb 2005 13:27:58 -0800
In-Reply-To: <200502221302.59803.jbarnes@sgi.com>
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
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, fbdev <linux-fbdev-devel@lists.sourceforge.net>


> > The problem is that on some cards (ATIs for example), the BIOS will
> > modify the image in RAM at c0000 and will put in there various infos,
> > like panel type, PLL infos, etc... that can't always be obtained from
> > the "hard" ROM (especially the panel infos). The driver (raeonfb or X,
> > strace X and see it mmap'ing /dev/mem at c0000...) need those things.
> 
> Shouldn't the driver safe that stuff at suspend time for use at resume time?  
> Or do we expect to be able to resume with different hw attached?

That's even more complicated :)

Honestly, I don't know for sure... I suppose the stuff should not change
accross suspend/resume. If the BIOS is used to re-post the on
board/primary card, it will just put the same stuff back in there. BIOS
wrappers that POST secondary cards shouldn't touch the real c0000 area
but some kind of shadow elsewhere. The driver POSTing code should
definitely return the modified shadow area btw...

Another problem with suspend/resume is to re-post the chip on resume,
which is quit a nightmare too. One would think it would be possible to
just re-run the BIOS to re-POST, but that will not always work. On
laptops, the video chip tend not to have any ROM attached (the video
BIOS is somewhere stuffed with the main BIOS image). You can find the
stuff at 0xc0000 but it doesn't necessarily contain the full video BIOS
code...

The ATI driver for example in Windows has a library that "knows" how to
re-POST gazillion of chips, but they can't/won't really opensource this
last I asked.

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
