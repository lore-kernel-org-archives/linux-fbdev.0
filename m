From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Comments on fbgen.c and fbcon-accel.c
Date: 07 May 2002 21:26:46 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1020778008.757.1.camel@daplas>
References: <Pine.GSO.4.21.0205070953520.14470-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1754zT-0004pG-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 May 2002 06:26:52 -0700
Received: from [205.136.61.71] (cwc71.compass.com.ph [205.136.61.71])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id VAA74270
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 7 May 2002 21:26:48 +0800 (PHT)
	(envelope-from adaplas@pol.net)
In-Reply-To: <Pine.GSO.4.21.0205070953520.14470-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2002-05-07 at 16:00, Geert Uytterhoeven wrote:
> > I was talking of X running with it's own accelerated drivers.  I have
> > checked most of the X accelerated drivers, and most will just attempt to
> > restore the VGA registers and some when switching to the console.  I
> > think this is not just enough, since fb drivers require more than that. 
> 
> If you run an application that's not fbdev aware, behavior has always been
> undefined.
> 

In the same token, then the kernel should be made as robust as
possible.  I would rather have a user app crash than have it lock-up the
hardware or corrupt the display.
 
> > Simiarly, I have also looked at some of the fbdev drivers that are not
> > using the gen_* interface (nvidia, ati, matrox), and they will also
> > unconditially set the hardware during switches/set_var. The
> > fbgen_switch() function also calls fbhw->set_par() within do_set_var().
> 
> And set_par() could do some optimizations based on a shadow map of the register
> contents, also to avoid artefacts when switching to a different VC with the
> same video timings. Like:
> 
>   write_reg(reg, val)
>   {
>       if (shadow[reg] != val) {
> 	shadow[reg] = val;
> 	hardware[reg] = val;
>       }
>   }
> 

Actually, What I'm trying to point out is that gen_set_var() is not even
given a chance to call set_par().  If the generic interface is to be
adopted, it has to satisfy the requirements of most, if not all cards.

My current thinking is to let gen_set_var() call set_par()
unconditionally and at the same time pass a parameter or set a flag.
This flag or parameter can be something like, "yes, you really need to
set the hardware" or "no, var has not changed but you have the option to
set the hardware or not." Something to this effect:

if (memcmp(oldvar, newvar, sizeof(struct fb_var_screeninfo)))
	info->fbops->fb_set_par(info, 1);
else 
	info->fbops->fb_set_par(info, 0);

> > I think if the gen_* interface is to be adopted, it will become a
> > problem. Detection is the best solution, but right now X and DRI do not
> > know that fb even exist so we can't get X to detect fb unless we
> > persuade the X people to do that.  I have tried X detection before by
> > checking the previous console number.  If the previous number is not a
> > valid console, we can presume that a non-console app used that.  But
> > this is not clean and there are too many conditions where this check
> > will fail. But then, I really don't understand the underlying console
> > interface, so an easier and more effective way may exist that I don't
> > know about.
> 
> The problem is that most drivers in XFree86 don't _want_ to be fbdev compliant.
> The solution is to convince the hardcode anti-fbdev XFree86 guys to use the

I can't agree with you more.  When I was writing the i810/i815 fb
driver, I also modified the XFree86 i810 driver so it is fbdev-aware.
The "fbdev-awareness" is not a requirement, but it solves a lot of
problems and lessened code bloat.

But as you've said, they're hardcore :)

> fbdev if it's present. Fbdev is part of the kernel API. Circumventing the API
> is bad behavior.
> 

Which is why I abandoned that idea. 

Tony



_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
