From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fbdv/fbcon pending problems
Date: Wed, 25 Feb 2004 12:29:52 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1077672591.978.49.camel@gaston>
References: <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Avo6p-0000mv-UD
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 17:45:11 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Avnlm-0001cY-5N
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 17:23:26 -0800
In-Reply-To: <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Otto Solares <solca@guug.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Wed, 2004-02-25 at 12:21, James Simmons wrote:
> > Sure, hopefully fbdev drivers became more 'intelligent', with just a
> > 
> > echo "1024x768x16-75" > /sys/class/fbdev/0/geometry
> > 
> > they will compute internally the timings or get it from EDID and
> > glad the user with something correct for the hardware.
> > 
> > cat /sys/class/fbdev/0/modes
> > 
> > will give you the modes supported by the card.
> 
> Yes.

Note that "the modes supported by the card" means nothing.

They depend on something fundamentally dynamic, which is what is
connected to what output, mixed with some card-spcific limitations
(like bandwidth limitations when using 2 very big monitors, vram
limitations, etc...)

You can not really know a-priori what modes will be available for
sure. You can provide a list of modes that are considered as valid
for a given output, but the whole mode setting scheme cannot be
anything else but non-deterministic. You setup a global configuration,
send it down the driver, and obtain a new configuration which may or
may not be what you asked for.

I'm trying to address the API issues as part of the userland library
I'm talking about in the other email. The actual interface to the
kernel driver should ultimately be hidden, and eventually private
between card-specific kernel driver and card-specific module in
the userland API.

Ben.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
