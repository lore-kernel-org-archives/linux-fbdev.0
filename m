From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fbdv/fbcon pending problems
Date: Thu, 26 Feb 2004 11:33:01 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1077755580.22232.89.camel@gaston>
References: <Pine.LNX.4.44.0402260014130.24952-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aw9iq-0004f6-I5
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 Feb 2004 16:49:52 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Aw9MP-0007ot-7L
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 Feb 2004 16:26:41 -0800
In-Reply-To: <Pine.LNX.4.44.0402260014130.24952-100000@phoenix.infradead.org>
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


> Well now that we have one input api that can happen. Of course with 
> graphics its much more diverse with what you can do. That is one of the 
> reasons for so many graphics libraries. It would be really hard to write
> a one size fits all library when it comes to graphics.

Note that I am NOT talking about a graphics library. This has NO
BUSINESS doing any kind of rendering. It's only the userland interface
to the underlying kernel drivers as far as mode switching & geometry
is concerned. That's _ALL_. In the same  was as libGL is the userland
interface to DRI, or iptables the userlnad interface to netfilter,
etc...
 
> By state machine I mean the physical hardware state. If it's hardware 
> access then it should be in the kernel. Note I'm refering to mode setting 
> not acceleration. Now EDID overrides per monitor model and saving the 
> state to disk is different. That should be userland. 

I agree. The HW access is done in kernel space. That's even true for
acceleration actually. You are mixing things. What I'm taking about
is exactly that: The userland library gets the various EDID & other
probing informations coming from the kernel drivers. It does the various
policy decisions on mode setting, it provides the API for userland to
deal with mode setting & monitor placement (what I call geometry)
and saving/restoring of configurations. The actual banging of the mode
to the HW is done by the kernel driver though. (The card specific back
end of the library probably builds either a mode description or a
register list and pass that to the kernel driver).

> I think we are fine for whats in the kernel. As for multiple head and 
> geometry stuff its not that hard if done right. I have been using 
> multi-head systems for years. I have multip desktop systems for years!!!

I have been using multi head systems for years and I've seen how good
it can be, but also a bunch of the pitfalls when trying to design a
driver for it. If it was that easy, we would have had the right support
in fbdev for ages. We don't.

Ben.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
