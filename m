From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Provide control of active VGA device on PCI systems
Date: Wed, 23 Feb 2005 07:57:47 +1100
Message-ID: <1109105867.5411.128.camel@gaston>
References: <9e47339105021921507545d084@mail.gmail.com>
	 <9e473391050219230764b0dfd2@mail.gmail.com>
	 <200502221050.43534.jbarnes@sgi.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3h74-0004vI-Hd
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Feb 2005 12:58:34 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D3h73-0006Nb-07
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Feb 2005 12:58:34 -0800
In-Reply-To: <200502221050.43534.jbarnes@sgi.com>
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

On Tue, 2005-02-22 at 10:50 -0800, Jesse Barnes wrote:

> Nice, if this is combined with Ben's suggestion of using a firmware loader 
> type model to deal with POSTing, it seems like we're in pretty good shape.  
> Can you add documentation for this API to 
> Documentation/filesystems/sysfs-<foo>.txt (maybe the pci file or a new file) 
> so that userspace people will be able to figure out how to use it?
> 
> Also, how does one know if a card is 'primary' or not?  I.e. some BIOSes will 
> POST all cards, some will POST only one, and some will POST none...

Well, that's something we need to figure out... While I do think the
POSTing must be under driver control, as I explained, there is still
that nasty notion of who has the stuff at 0xc0000 ... and if your
firmware runs the x86 BIOS but doesn't keep the shadow around, then you
are toast with a good deal of laptop chips.

The problem is that on some cards (ATIs for example), the BIOS will
modify the image in RAM at c0000 and will put in there various infos,
like panel type, PLL infos, etc... that can't always be obtained from
the "hard" ROM (especially the panel infos). The driver (raeonfb or X,
strace X and see it mmap'ing /dev/mem at c0000...) need those things.

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
