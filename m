From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: waitforVBlank, how does this even work?
Date: Fri, 04 Mar 2005 09:08:27 +1100
Message-ID: <1109887707.5679.214.camel@gaston>
References: <9e473391050301215019081bce@mail.gmail.com>
	 <Pine.LNX.4.62.0503021128001.14333@node2.an-vo.com>
	 <1109806955.5610.129.camel@gaston>
	 <Pine.LNX.4.62.0503022003090.17679@node2.an-vo.com>
	 <1109816602.5610.153.camel@gaston>
	 <Pine.LNX.4.62.0503022159440.17679@node2.an-vo.com>
	 <20050303075559.GA7469@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050303075559.GA7469@sci.fi>
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
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Vladimir Dergachev <volodya@mindspring.com>, Jon Smirl <jonsmirl@gmail.com>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, DRI developer's list <dri-devel@lists.sourceforge.net>


> > Oh, but I was not suggesting that. I just meant that interrupt handling 
> > code is self-contained and can easily serve several consumers.
> 
> I'm with you here. And the same should IMHO hold for DMA handling. And for 
> memory management of course.

DMA handling is the main piece of what the DRM does, memory management
is the missing part.

No, what we really need is just what we said: merging fbdev & DRM and
adding memory management.

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
--
