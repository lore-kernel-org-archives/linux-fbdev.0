From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: waitforVBlank, how does this even work?
Date: Fri, 04 Mar 2005 09:47:21 +1100
Message-ID: <1109890041.5610.230.camel@gaston>
References: <9e473391050301215019081bce@mail.gmail.com>
	 <Pine.LNX.4.62.0503021128001.14333@node2.an-vo.com>
	 <1109806955.5610.129.camel@gaston>
	 <Pine.LNX.4.62.0503022003090.17679@node2.an-vo.com>
	 <1109816602.5610.153.camel@gaston>
	 <Pine.LNX.4.62.0503022159440.17679@node2.an-vo.com>
	 <20050303075559.GA7469@sci.fi>
	 <Pine.LNX.4.62.0503031011150.21362@node2.an-vo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.62.0503031011150.21362@node2.an-vo.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, Jon Smirl <jonsmirl@gmail.com>, DRI developer's list <dri-devel@lists.sourceforge.net>

On Thu, 2005-03-03 at 10:12 -0500, Vladimir Dergachev wrote:
> >>>> With which part ? ;)
> >>>
> >>> On having a small stub module that does just IRQs ... I think the base
> >>> module should be the fbdev (mode setting etc...)
> >>
> >> Oh, but I was not suggesting that. I just meant that interrupt handling
> >> code is self-contained and can easily serve several consumers.
> >
> > I'm with you here. And the same should IMHO hold for DMA handling. And for
> > memory management of course.
> 
> With one refinement - the DMA code would need to be a customer of IRQ 
> code..

No, again, DMA is what DRM is for, or you want to re-invent the whole
architecture ?

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
