From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: radeon, apertures & memory mapping
Date: Sun, 13 Mar 2005 17:10:37 -0500
Message-ID: <9e47339105031314101c89e50e@mail.gmail.com>
References: <1110677744.19810.80.camel@gaston> <20050313082216.GA7362@sci.fi>
	 <1110705646.14684.126.camel@gaston> <20050313103936.GA11002@sci.fi>
	 <1110715499.14684.132.camel@gaston>
	 <9e473391050313081937cde207@mail.gmail.com>
	 <1110750553.5787.155.camel@gaston>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110750553.5787.155.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>, Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org

On Mon, 14 Mar 2005 08:49:13 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> > If you are doing fallback calculations in a 6MB buffer that is 1,500
> > pages. Accessing all of this effectively flushes the data cache. Once
> > you are done with it you probably don't want those pages in the cache
> > anyway.
> 
> I wouldn't count on it flushing anything

I meant flushes out everything except the 1,500 pages you just
accessed. Since you don't want those pages any more a total cache
flush shouldn't make a difference, you don't want any of these pages
in the cache anyway.

> 
> Ben.
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
--
