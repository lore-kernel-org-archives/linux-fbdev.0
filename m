From: Otto Solares <solca@guug.org>
Subject: Re: fbdv/fbcon pending problems
Date: Tue, 24 Feb 2004 20:18:08 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040225021808.GB17390@guug.org>
References: <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org> <1077672591.978.49.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Avol4-000124-1U
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 18:26:46 -0800
Received: from guug.galileo.edu ([168.234.203.30])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvocW-0001wr-SQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 18:17:57 -0800
Content-Disposition: inline
In-Reply-To: <1077672591.978.49.camel@gaston>
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
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Wed, Feb 25, 2004 at 12:29:52PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2004-02-25 at 12:21, James Simmons wrote:
> > > Sure, hopefully fbdev drivers became more 'intelligent', with just a
> > > 
> > > echo "1024x768x16-75" > /sys/class/fbdev/0/geometry
> > > 
> > > they will compute internally the timings or get it from EDID and
> > > glad the user with something correct for the hardware.
> > > 
> > > cat /sys/class/fbdev/0/modes
> > > 
> > > will give you the modes supported by the card.
> > 
> > Yes.
> 
> Note that "the modes supported by the card" means nothing.
> 
> They depend on something fundamentally dynamic, which is what is
> connected to what output, mixed with some card-spcific limitations
> (like bandwidth limitations when using 2 very big monitors, vram
> limitations, etc...)
> 
> You can not really know a-priori what modes will be available for
> sure. You can provide a list of modes that are considered as valid
> for a given output, but the whole mode setting scheme cannot be
> anything else but non-deterministic. You setup a global configuration,
> send it down the driver, and obtain a new configuration which may or
> may not be what you asked for.

Hmm, how does winxp and macosx get their respectives video modes,
what is missing in fbdev for that? MacOSX always gives you valid modes
including refresh rates per adaptor/monitor, WinXP always give you valid
modes and valid refresh rates for the video card, you actually
'Apply' to test, most of the time it simply works.

> I'm trying to address the API issues as part of the userland library
> I'm talking about in the other email. The actual interface to the
> kernel driver should ultimately be hidden, and eventually private
> between card-specific kernel driver and card-specific module in
> the userland API.

Great! i think your idea is great, does that library will be xserver
dependant or will be an independent lib so others projects like mine
could benefit from it?  Any bits somewhere?  This alone could boom
and revolutionize the graphics solutions for linux.  A step in the
right direction for "World Domination" in the desktop field.

-otto



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
