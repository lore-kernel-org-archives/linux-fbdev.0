From: James Simmons <jsimmons@infradead.org>
Subject: Re: Feature Freeze?
Date: Wed, 5 Mar 2003 18:52:56 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303051847030.27760-100000@phoenix.infradead.org>
References: <20030305134355.GA3105@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qe1E-00060K-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 10:53:32 -0800
In-Reply-To: <20030305134355.GA3105@iliana>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> And do you think there is a chance of standard vgacon working on a ppc
> board ? 

I have done some work on vgacon but it needs alot of work. Vgacon is also 
broken on many platforms. I personally liek to see vgacon independent of 
the BIOS and more portable. I'm working on this.

> I thought that the new API, separating the fbcon layer from the fbdev
> drivers would add support for this more easily. 

You can. I did this because there are embedded devices coming out with two 
framebuffers. They open like a book and they have two touchscreens but no 
keybaords. Here VTs make no sense. So you can compile in input support for 
the touchscreen and just fbdev support. Then just write your app. 

> What about multi-seat, with two full consoles,
> with mouse and keyboard for each ?

That requires massive surgery for the console layer. 

> I thought that one of the reasons of the
> rewrite was to provide easier multi-head and multi-seat support though.

Its is for the long run. The changes required for this where huge. You had 
to have one input api. A clean console independent fbdev api. Then you can 
touch the core console code. When 2.7/3.1 comes around we can add the new 
console code in. Not much work there then. 

> What i think would be nice is to be able to separate the framebuffer
> setup (where we write to) from the dac/dp output to the monitors, and
> when we outport this to the higher level apps, we export them
> separatedly. This way X drivers can use one huge framebuffer, with DRI
> enabled to render on the framebuffer, and enable arbitrary setting of
> viewports into this framebuffer, with eventual scaling or other such
> stuff. And fbcon could then easily use two viewports into the same
> framebuffer to do dual-head/dual-seat. Overlays (for cursor and/or video)
> would be linked to the monitor outputs and not the framebuffer.
> 
> But maybe it is too late for this, good ideas for 2.7.x/3.1.x or
> whatever it will be named though, together with a framebuffer/agp memory
> management scheme which would be common to DRI, fbdev and X, and would
> reside in the drm module.

Next developement cycle. This is huge amount of work as well.




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
