From: Paul Mackerras <paulus@samba.org>
Subject: Re: radeon, apertures & memory mapping
Date: Mon, 14 Mar 2005 11:41:23 +1100
Message-ID: <16948.56755.114690.200854@cargo.ozlabs.ibm.com>
References: <1110677744.19810.80.camel@gaston>
	<20050313082216.GA7362@sci.fi>
	<1110705646.14684.126.camel@gaston>
	<20050313103936.GA11002@sci.fi>
	<1110715499.14684.132.camel@gaston>
	<9e473391050313081937cde207@mail.gmail.com>
	<1110750553.5787.155.camel@gaston>
	<9e47339105031314101c89e50e@mail.gmail.com>
	<1110752401.19810.177.camel@gaston>
	<9e47339105031315002a444f00@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e47339105031315002a444f00@mail.gmail.com>
Sender: dri-devel-admin@lists.sourceforge.net
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>, Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org

Jon Smirl writes:

> > It works, but it's illegal. That means that the CPU might well speculate
> > a load from one of these pages in kernel-land just because it happens to
> > be next to a page where you are iterating an array, and may then bring a
> > bit in the cache from that page.
> 
> That shouldn't matter the page brought in would be for a speculative
> read and never accessed. It should just fall out of the cache and not
> be written back. There is only one cachable mapping. In this model
> writes are always followed by a flush before telling the GPU to access
> the memory that has just been written.

That would be fine, but it would mean making sure that every time any
code in the DRI, DRM or X server writes to the AGP memory, it does the
flush as well.  Sounds like a maintenance nightmare to me...

Paul.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
--
