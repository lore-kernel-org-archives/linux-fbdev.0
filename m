From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 08 Mar 2003 00:19:43 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047053804.1281.45.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303061526500.4540-100000@phoenix.infradead.org>	<3E688BDA.80
	 80506@winischhofer.net> <1047045694.1310.6.camel@localhost.localdomain> 
	<3E68B895.2080500@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rKYd-00070z-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 07 Mar 2003 08:18:51 -0800
In-Reply-To: <3E68B895.2080500@winischhofer.net>
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
Cc: James Simmons <jsimmons@infradead.org>, Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2003-03-07 at 23:19, Thomas Winischhofer wrote:
> 
> This works - perfectly, I must say.
> 
> However, the scrolling problem is still here, but I think I know the 
> reason for this:
> 
> Imagine a console of 120x40 (using the std 8x16 font), on a screen of 
> 1024x768, using ypanning.
> 
> This uses only 40*16=640 pixels vertically instead of the 768 available.
> 
> The problem is the y panning, and is kind of both console's as well as 
> the driver's fault:
> 
> When the y panning area reaches its end, it's supposed to copy the 
> screen to the beginning of this area and pan to position 0.
> 
> However, fbcon calculates p->vrows by info->var.yres_virtual / fontheight.
> 
> This disregards the fact that the visible screen area is actually larger 
> than the area console is supposed to use.
> 
> Therefore, the calculation of vrows has to take the difference between 
> these two into account.
> 
> The attached patch fixes this for me but I have no idea if I cought all 
> possible itches. It will no apply cleanly, because I had made changes to 
> fbcon.c before making a backup copy - but it sure illustrates the problem.
> 

Right, fbcon never dealt with margins greater than a character
width/height before :-). I think your patch will do the Right Thing.

As for the one you commented out as INCOMPLETE, my guess is it won't
matter since that particular section of code is called only during
initialization.  An fbcon_switch() will be called later on, I think.

> Why you used info->var.yres_virtual (and not the adapted 
> var.yres_virtual) in fbcon_resize() is beyond me, BTW.
> 

Because info->var will _always_ contain the correct var, so we trust
that above all.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
