From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: radeon, apertures & memory mapping
Date: Mon, 14 Mar 2005 16:09:10 +1100
Message-ID: <1110776950.19810.253.camel@gaston>
References: <20050313082216.GA7362@sci.fi>
	 <1110750553.5787.155.camel@gaston>
	 <9e47339105031314101c89e50e@mail.gmail.com>
	 <1110752401.19810.177.camel@gaston>
	 <9e47339105031315002a444f00@mail.gmail.com>
	 <16948.56755.114690.200854@cargo.ozlabs.ibm.com>
	 <20050314005613.GA21434@sci.fi> <1110762359.19810.209.camel@gaston>
	 <9e47339105031317474b9a6234@mail.gmail.com>
	 <16949.3582.867897.542158@cargo.ozlabs.ibm.com>
	 <9e47339105031320407b3b6bcd@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e47339105031320407b3b6bcd@mail.gmail.com>
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
Cc: Paul Mackerras <paulus@samba.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net

On Sun, 2005-03-13 at 23:40 -0500, Jon Smirl wrote:
> On Mon, 14 Mar 2005 15:07:26 +1100, Paul Mackerras <paulus@samba.org> wrote:
> > xorg@lists.freedesktop.org removed from CC since I can't post to it.
> > 
> > Jon Smirl writes:
> > 
> > > It shouldn't hurt to have a parallel non-cached mapping being used in
> > > conjuction with this protocol. By definition the non-cached mapping
> > > never gets into an inconsistent state.
> > 
> > According to the PowerPC Architecture specification, it is a
> > programming error to have both cacheable and uncacheable mappings of
> > the same page.  That means the hardware designers consider that they
> > don't have to worry if the hardware misbehaves if software does
> > that. :P  So that is not a feasible solution for us.
> > 
> > Paul.
> 
> Ok, I see this is a problem for the PPC. I've never used a PPC so you
> guys have to tell me what is illegal on it.

And probably for other platforms as well. I'm pretty sure some Athlons
will be very upset too. I'm not even sure you can do that sort of tricks
on MIPS which has strange mapping rules, etc, etc, etc...

Anyway, mixing cacheable and non-cacheable mappings is asking for
trouble, just don't do it.

Having the ability to do both (selected by the platform type, or some
AGP errata bit, or whatever) is a different issue and might be worth
investigating.

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
--
