From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Thu, 17 Mar 2005 12:12:58 +1100
Message-ID: <1111021978.15510.97.camel@gaston>
References: <1110839873.5673.41.camel@gaston>
	<1110862777.4044.592.camel@localhost> <20050315060138.GA13064@sci.fi>
	<4236C770.8020101@hispeed.ch> <1110907029.4001.624.camel@localhost>
	<1110942559.24296.107.camel@gaston> <20050316200808.GB6651@sci.fi>
	<a728f9f90503161258181977fa@mail.gmail.com>
	<20050316210812.GA19937@sci.fi>
	<1111015801.15509.62.camel@gaston>  <20050317004713.GB8081@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050317004713.GB8081@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Jon Smirl <jonsmirl@yahoo.com>, xorg@lists.freedesktop.org, Alex Deucher <alexdeucher@gmail.com>, dri-devel@lists.sourceforge.net


> I understand you can't have userspace program the accelerator while 
> someone else is doing the same thing. Oh and I now understand that the 
> same really applies to direct framebuffer access due to the swapper.  

And you can't have someone program the accelerator while somebody does
direct access neither. It's basically all exclusive.
> I 
> hadn't really thought about that issue before since I don't own a 
> big-endian system. I really must try to get one...

The only thing that would "work" without arbitration is direct
famebuffer access on both, with both using a different swapper, that is
a different aperture. That is either doing the the way I described
earlier (having both apertures overlap the beginning of memory) or doing
the mapping the "right" way (that is both apertures mapping half of
memory so that together they map all of it).

The problem is that I think a bunch of BIOSes for x86 didn't care since
they don't use the swapper and didn't set the aperture size properly.

> So basically to fix both issues we need some locks everyone must acquire 
> before accessing the hardware.

Plus the VGA arbitration of course ... But yes. That's more or less what
DRM provides.

> With the current "mmap() registers and go" interface the accelerator lock 
> wouldn't actually guarantee anything but it would allow well behaving 
> applications to share the accelerator. Good behaviour is already expected 
> from the applications anyway due to the direct access to hardware 
> registers.

It's more than the accelerator. A framebuffer access concurrent with
accelerator operations can lockup too.

Ben.
