From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 05 Mar 2003 23:54:35 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046879633.1228.205.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0303051638000.23176-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qbCk-0005KF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 07:53:14 -0800
In-Reply-To: <Pine.GSO.4.21.0303051638000.23176-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-05 at 23:40, Geert Uytterhoeven wrote:
> On 5 Mar 2003, Antonino Daplas wrote:
> > On Wed, 2003-03-05 at 22:06, Thomas Winischhofer wrote:
> > > > Yes, that's the Real Thing :-)  fbcon_resize has a "fuzzy mode" too --
> > > > it won't do an fb_set_var() if the change in dimensions is only a
> > > > fraction of a character's dimension.
> > > 
> > > Ack. Is 16 fuzzy enough, what do you think?
> > 
> > I think you should only accept modes where the difference is a fraction
> > of a character width or height.  A difference more than that and
> > clear_margins() will not work correctly.  
> 
> Indeed, accel_clear_margins() calculates the margins as
> 
>     unsigned int cw = vc->vc_font.width;
>     unsigned int ch = vc->vc_font.height;
>     unsigned int rw = info->var.xres % cw;
>     unsigned int bh = info->var.yres % ch;
> 
> However, if it would use
> 
>     unsigned int rw = info->var.xres - (vc->vc_cols*cw);
>     unsigned int bh = info->var.yres - (vc->vc_rows*ch);
> 
> it would work with higher differences, too. And it would be a bit faster
> (multiply and subtract vs. modulo).
> 

Yes, I believe so.  This way, it will make rounding off of values more
clear cut and still produce an acceptable display (albeit with possibly
wider margins).

Tony




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
