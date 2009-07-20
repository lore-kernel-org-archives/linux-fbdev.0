From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 1/2] ep93xx video platform support
Date: Mon, 20 Jul 2009 23:18:52 +0100
Message-ID: <20090720221852.GI11151@n2100.arm.linux.org.uk>
References: <4A60D6F3.5060906@bluewatersys.com>
	<4A6309CD.9070505@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901AC23A5@mi8nycmail19.Mi8.com>
	<4A64D9B7.8050005@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901AC23BF@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69) (envelope-from
	<linux+linux-fbdev-devel=lists.sourceforge.net@arm.linux.org.uk>)
	id 1MT1CT-0001Uq-1A for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Jul 2009 22:19:13 +0000
Received: from caramon.arm.linux.org.uk ([78.32.30.218])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MT1CQ-00085n-FT
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Jul 2009 22:19:12 +0000
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901AC23BF@mi8nycmail19.Mi8.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>, d.venzano@motronica.com, linux-fbdev-devel@lists.sourceforge.net, arm kernel <linux-arm-kernel@lists.arm.linux.org.uk>

On Mon, Jul 20, 2009 at 05:01:00PM -0400, H Hartley Sweeten wrote:
> On Monday, July 20, 2009 1:55 PM, Ryan Mallon wrote:
> > Russell, will this eventually be okay to go through the ARM patch
> > system, or does it need to go via the framebuffer people?
> 
> I think Russell could ok this part of the support.  The actual driver
> will probably need to go via the framebuffer people.

I think it depends on whether there's any response from framebuffer
folk.  I've heard many stories of people submitting patches to the
framebuffer list and nothing happening.  Safest thing is probably to
CC Andrew Morton as a just-in-case measure.

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
