From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 05 Mar 2003 23:25:57 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046877945.1291.192.camel@localhost.localdomain>
References: <3E65EAFB.7020208@winischhofer.net>
	<1046870342.1291.86.camel@localhost.localdomain> 
	<3E6606C4.801@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qal3-0005W8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 07:24:37 -0800
In-Reply-To: <3E6606C4.801@winischhofer.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-05 at 22:16, Thomas Winischhofer wrote:
> 
> Further to my mail from a few minutes ago:
> 
> I wrote:
>  > But I noticed another issue here:
>  >
>  > When switching to gfx mode during boot (ie as soon as the penguin
>  > appears), the text console is aligned correctly at all edges, with all
>  > lines visible.
> 
>  > But when "initial console" starts, the mode is again changed, and now
>  > the last line of text is nearly invisible, its upper half appears at
>  > the lower screen edge, the lower half is below the screen's edge. The
>  > space between the penguin and the text is notably thicker.
>  >
>  > This can be recovered by switching to another VT and back. This makes
>  > the penguin disappear, and restores the console dimensions/edges to
>  > normal.
> 
>  > Interestingly, this only happens with 800x600; this mode is chosen
>  > upon requesting 800x592 (because of the font size). At 1024x768,
>  > everything is as it should.
> 
> I am almost sure that this has to do with the fact that I adapt var in 
> my check_var from 800x592 to 800x600. Console (or whoever) seems to 
> attempt to change the mode to its initially desired dimension on many 
> occasions.
> 

Strange.  If you boot at 800x600, the console will compute that as
100x37.  On fbcon_resize, it will request 800x592 but because the
difference is only 8, fb_set_var should be skipped, so no mode change
should happen throughout.  

> - This leads to the (unncessary) second mode switch during boot (when 
> the "initial console" starts), assumingly because the xres does not 
> match fontsize * rows,

At boot time, there are several times the display changes (not
necessarily mode changes) --  while the logo is being displayed, after
the logo got displayed, and during init.

> 
> - and probably is the reason for that vertical offset I see after this 
> mode switch: The text area on the screen is shifted down by exactly 8 
> pixels - 600-592=8
> 
> Any hints?
> 

I have no idea.  I booted with other drivers at 800x600 and get no ill
effects.  I get a margin at the bottom of 8 pixels.

How about checking what the offsets are during fb_pan_display()?

Tony




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
