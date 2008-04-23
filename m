From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] radeonfb: Fix 64 bits	resources
	on 32 bits archs
Date: Wed, 23 Apr 2008 20:34:21 +1000
Message-ID: <1208946861.9060.30.camel@pasglop>
References: <480E0A54.9010203@linux.vnet.ibm.com>
	<1208902903.9640.138.camel@pasglop>
	<1208943127.5632.324.camel@thor.sulgenrain.local>
	<20080423.025721.50367920.davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JocJE-0001Lb-4z for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 03:34:40 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1+A88YHpL8juasncupnoVi27VCQd45NmxI=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JocJC-0002GX-MF
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 03:34:40 -0700
In-Reply-To: <20080423.025721.50367920.davem@davemloft.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: David Miller <davem@davemloft.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, hollisb@us.ibm.com, linux-kernel@vger.kernel.org, michel@tungstengraphics.com, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, dzu@denx.de


On Wed, 2008-04-23 at 02:57 -0700, David Miller wrote:
> > It's up to the driver, and again, the current radeon driver doesn't
> use
> > radeonfb at all anymore...
> 
> The only portable thing is for X to use the PCI sysfs mmap() stuff,
> which current Xorg servers using libpciaccess do.
> 
> I know because I'm typing this from a sparc64 using a Radeon
> with current Xorg :-)

True :-) But I'd still like to fix the fb API for the sake of things
like directfb etc...

Ben.



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
