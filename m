From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Fri, 07 Mar 2003 21:51:41 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E69065D.3090706@winischhofer.net>
References: <Pine.LNX.4.44.0303061526500.4540-100000@phoenix.infradead.org>	<3E688BDA.80	 80506@winischhofer.net> <1047045694.1310.6.camel@localhost.localdomain> 	<3E68B895.2080500@winischhofer.net> <1047067923.1226.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18] helo=home.winischhofer.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rOoN-00037E-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 07 Mar 2003 12:51:23 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Antonino Daplas wrote:
> On Fri, 2003-03-07 at 23:19, Thomas Winischhofer wrote:
> 
>>This works - perfectly, I must say.
>>
>>However, the scrolling problem is still here, but I think I know the 
>>reason for this:
>>
>>Imagine a console of 120x40 (using the std 8x16 font), on a screen of 
>>1024x768, using ypanning.
>>
>>This uses only 40*16=640 pixels vertically instead of the 768 available.
>>
>>The problem is the y panning, and is kind of both console's as well as 
>>the driver's fault:
>>
>>When the y panning area reaches its end, it's supposed to copy the 
>>screen to the beginning of this area and pan to position 0.
>>
>>However, fbcon calculates p->vrows by info->var.yres_virtual / fontheight.
>>
>>This disregards the fact that the visible screen area is actually larger 
>>than the area console is supposed to use.
> 
> 
> I've tested where the virtual window size is much smaller than the
> physical dimensions, and I do see the glitch you mentioned.  But it's
> mainly due to clear_margins().  clear_margins always erases a constant
> amount (physical_height - actual height).  So if you happen to pan just
> enough that there's not enough screen estate left, it will attempt to
> clear past yres_virtual.  Bad for drivers that do not implement
> clipping. Perhaps, block moves are involved here also, I'm not sure. 

1) Sisfb does no clipping, but there is plenty of video RAM past the 
virtual area.

2) I don't think we are talking about the same thing. Clear_margins() 
(which I haven't looked at, I confess) assumingly ... erm.. clears the 
margins. But why is it involved in scrolling any panning?

> So your patch has the correct idea, but here's a simpler one. It just
> reserves enough screen estate equal to difference of physical height and
> virtual height. I've tested this even using stty cols 2, and it works
> okay.

I don't see why this is simpler, but I do see it wastes a lot of screen 
space :)

BTW:

  	p->vrows = info->var.yres_virtual / vc->vc_font.height;
+	p->vrows -= info->var.yres - vc->vc_rows;

Look:

rows =          40
yres =         768
yres_v =      2048
font height =   16

vrows = 2048 / 16 = 128  (character unit)

128 - (768 - 40)

is negative...

Personally, I'd go with my first patch from earlier today. I tested this 
intensively in the meantime, and it Simpy Works(tm).

> NOTE:  Since we need var->yres, this time, we need to refer to info->var
> instead of the adjusted var.
> 
> BTW:  I've tested moving clear_margins before panning, it still doesn't
> remove the onrushing text past the virtual window height.  This would
> seem to need clipping to remove that eyesore.  

Honestly, I don't consider this important... But I thought you'd simply 
exchange the order of calling pan_var and drawing the characters... 
(which IMHO would be the correct order, logically speaking)

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net          *** http://www.winischhofer.net



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
