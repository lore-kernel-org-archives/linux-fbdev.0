From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
	one works ;-)
Date: Wed, 21 Apr 2004 10:30:00 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1082507399.2056.26.camel@gaston>
References: <Pine.LNX.4.44.0404202032210.29160-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BG5dE-0004b7-Bt
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 17:30:28 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BG5dD-0002Qn-SV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 17:30:28 -0700
In-Reply-To: <Pine.LNX.4.44.0404202032210.29160-100000@phoenix.infradead.org>
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
Cc: David Eger <eger-dated-1082943669.d79d33@theboonies.us>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2004-04-21 at 08:52, James Simmons wrote:
> > BTW, James, did we decide what is the best way to set fbcon accel
> > mode ? For drivers with copyarea accelerated, we want YMOVE. I'd like
> > a patch to send Linus/Andrew asap along with some pending radeonfb
> > fixes for that.
> 
> I had to do some thinking about this. Here is explation ofthe scrolling 
> code. It really needs to be cleaned up. So renamings would make sense 
> here.

> .../...

Why not simply

 1) Document properly what those various options do
 2) Let the driver provide it's "preferred" scroll mode ? It's sort-of
    a stack violation since it really only affects fbcon at this point,
    but since it's just an "hint", it's perfectly acceptable.

(Note: I'm not sure about controlfb at this point, I have to dig
out some old HW and test)

Also, we sort-of lost the ability to have fbcon specific accels in the
drivers... It would have been nice to be able to store the font in
vram and use blits to composite text, but that would have meant having
fbcon-related hooks =P Or maybe we can find a clean way to express that
to fbcon without clobbering fbdev's with fbcon-related datas ? Simply by
having fbcon request a vres big enough to store the font data outside
of the visible area and using copyarea ?

Ben.

> In the original code we had:
> 
> These we set by the driver.
> 
> SCROLL_YREDRAW		( __SCROLL_YFIXED  | __SCROLL_YREDRAW )     Lots use this
> SCROLL_YNOMOVE		( __SCROLL_YNOMOVE | __SCROLL_YPANREDRAW )  Lots use this
> SCROLL_YNOPARTIAL	  __SCROLL_YNOPARTIAL			    (controlfb)
> 
> fbcon.c -> updatescrollmode.
> 
> __SCROLL_YFIXED		--> Does not update. Test to see if it is set then exits
> __SCROLL_YWRAP		--> sets if we have ywrapstep and conditions are right
> __SCROLL_YPAN		--> sets if we have ypanstep and conditions are right
> __SCROLL_YNOMOVE	--> test for this and if yes then
> __SCROLL_YREDRAW	-->			set __SCROLL_YREDRAW
> __SCROLL_YMOVE		-->		      else set __SCROLL_YMOVE
> 
> __SCROLL_YMASK		Mask to clear out extra bits.
> 
> Not used in updatescrollmode
> 
> __SCROLL_YPANREDRAW	--> Set by SCROLL_YNOMOVE
> __SCROLL_YNOPARTIAL	--> Set by SCROLL_YNOPARTIAL. Its deals for the case 
> 			    when we can only only pan the whole screen, 
> 			    not a region of the screen.
> ---------------------------------------------------------------------------------
> Let go over what happened in the old code.
> 
> So if the driver set SCROLL_YNOPARTIAL then __SCROLL_YNOPARTIAL was set. This was
> to deal with hardware panning flickering. Only the controlfb used it. Is this 
> problem still present? If not this could go away. The goal is:
> 
> 	Handle screen flickering.
> 
> The second one is the driver using SCROLL_YREDRAW. This sets __SCROLL_YFIXED and
> __SCROLL_YREDRAW. When going into updatescrollmode nothing happens since the first
> thing we do is test for __SCROLL_YFIXED. So the goal is to override the hardware 
> panning or wrap. The system is set up to only __SCROLL_YREDRAW which just redraws
> all the font images. In this case only __SCROLL_YREDRAW is important. So the 
> goal is:
> 	
> 	if driver set SCROLL_YREDRAW
> 		Use hardware image drawing	// Only use this
> 
> The 3rd and final one is where we set the scrollmode to __SCROLL_YNOMOVE and 
> __SCROLL_YPANREDRAW. __SCROLL_YNOMOVE again is one of those variables used only
> in updatescrollmode. First we test to see if hardware panning or hardware wrapping. 
> Use that. If we don't have that ablity then we test the __SCROLL_YNOMOVE to see
> if we just draw all the font images or use a copyarea operation with the flag 
> is set to __SCROLL_YMOVE. So the goal is:
> 
> 	if Ywrap
> 		Use hardware ywrap
> 	else if ypan 
> 	  	Use hardware panning
> 	else if driver set SCROLL_YNOMOVE
> 		Use hardware image drawing
> 	else 
> 		Use hardware copyarea
> 
> I like to see this cleaned up now. The question is what is the proper order of all
> this stuff. For use we have the following conditions.
> 
> Hardware panning. Test for fb_pan_display and ypanstep. 
> Hardware wrapping. Test for ywrapstep.
> Hardware copyarea.
> Hardware image drawing.
> 
>    So if the we have the case of both copyarea and imageblit hardware accelerated we
> need to use copyarea for scrolling since that will be faster. Its the same case
> for if we only have copyarea accelerating. 
>    The question is if we have only hardware imageblit should we use that? There is
> a cost to assembly a image for the hardware to draw. The question is the assembly
> of the image less costly than a soft copyarea?
>    As for hardware panning should we prefer it above everthing? 
>    



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
