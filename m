From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] neofb patches
Date: Fri, 30 Apr 2004 17:50:07 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404301707110.12865-100000@phoenix.infradead.org>
References: <20040430150627.GB1543@sci.fi>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJbDI-0005em-Na
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Apr 2004 09:50:12 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BJbDH-0005Zw-0Q
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Apr 2004 09:50:12 -0700
In-Reply-To: <20040430150627.GB1543@sci.fi>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> > > I don't like micro kernel designs. This is way micro kernels handle this 
> > > problem.
> > 
> > This has nothing to do with microkernel design and everything to do with
> > not bloating the kernel with things that don't to be there.
> 
> I would like the kernel to handle CRTCs and overlays in the same way, and 
> that way IMHO should be to calculate register values in userspace and just 
> have a few ioctls to have the kernel write them.
> 
> Set all registers ioctl:
> Nothing special needed here I think.
> 
> Set buffer offset (pan/flip) ioctl:
> This one should return the current vertical blank counter. It's needed for 
> proper triple buffering. It should also be able to choose when to flip 
> (immediately or vblank, on top/bottom/any field).
> 
> Wait for vertical blank ioctl:
> This one should also return the current vblank counter. It should also be 
> able to wait for absolute and relative vblank counter values. Waiting for 
> relative=1 would insure you're at the vblank when it returns and waiting 
> for absolute=last_flip_counter_value+1 would help wi

Reason why a "universal" library will not work.

1) There will never be a universal library. I have worked with:

EmbeddedQT
framebuffer based Gtk
directfb
sdl
Embedded OpenGL
GGI
Java j2me
lots of home brewed solutions

The latest thing now is OpenML. Next year it will be something else.

Ben you can create your library all you want but the reality is very few 
will end up using it.

2) Several of the above libraries depend on mode changing being avaliable 
   in fbdev. Take that away and alot of companies will be very upset. I 
   tell you if I owned/worked for a company that wrote embedded software 
   that changed the video mode via fbdev (which BTW I do) and that was 
   taken away I would be very upset!!!! The only we use the fbdev interface
   is because it is easy to port our software from one box to another and 
   second it does mode switching for us. We don't need to write the mode 
   switching for each box. You take that away and the reality is companies
   will have no real reason to use the fbdev api anymore. We will just come 
   up with our own thing. Do you really want that to happen?

3) The BIGGEST issue is the license issue. Sorry but GPL and even LPGL 
   doesn't fly at most companies. Most likely your library will be one
   of these license. Most comapnies like to use there own license. Using 
   the fbdev api doesn't require dealing with a license but using a 
   userland library does. This is one of the major reasons for the above
   libraries.

	




  



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
