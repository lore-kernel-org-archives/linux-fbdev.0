From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Feature Freeze?
Date: 06 Mar 2003 15:54:46 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046937244.1209.22.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303051829450.27760-100000@phoenix.infradead.org>
	<1046913396.1227.176.camel@localhost.localdomain> 
	<20030306070343.GA24575@casa.fluido.as>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qqC1-0002sL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 23:53:30 -0800
In-Reply-To: <20030306070343.GA24575@casa.fluido.as>
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
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-03-06 at 15:03, Carlo E. Prelz wrote:
> I see there currently is much activity on the list. I would like to
> present the point of view of a heavy framebuffer user: I write
> multimedia code for artists, and I generally generate video via the
> framebuffer layer, and trusted old matrox cards (from the Millennium
> II to the G550). The general process is:
> 
> - open the framebuffer unit
> - FBIOGET_VSCREENINFO
> - change the appropriate values in fb_var_screeninfo
> - FBIOPUT_VSCREENINFO
> - mmap
> - happily write pixels to the memory area

All of the above should still work with the 2.5.  Care was taken to
prevent user application breakage. 

> 
> This, multiplied for all the video heads that I use within the same
> program (up to 5 per PC, up to now, *including* the console screen -
> in this case I control the machine from a network connection).
> 
> I am especially in need to change the BPP value (often using 16BPP
> mode), and in a couple of occasions (the latest 2 weeks ago) I had to
> feed the output of old G200's to large monitors who are only capable
> of TV resolution. This means setting the framebuffer to 768x576 (PAL)
> and *interlaced*. The framebuffer model that still survives in 2.4
> allows me to obtain all this. 

You can still do it for the 2.5, except that the matroxfb is not ported
yet.

> 
> I am not much familiar with all the terminology that is used for the
> new layer. Actually, this framebuffer revolution is what keeps me from
> enjoying (!) the kernel bleeding edge, as I used to do since almost 10
> years ago. 
> 
> Can I poll the list's huge knowledge to find out if and how I can
> obtain the same result with the new layer?
> 

You still can, in general, use the framebuffer as you would use it in
the 2.2.- 2.4 versions.  The main difference is console window
resizing.  As you probably know, in 2.4, resizing was done through the
fbdev layer and then the information is transmitted to the console.  In
2.5, it is currently the opposite way, from the console to fbdev.  The
only application that I know of that is able to do that is stty, which
in its current incarnation has very limited capability.  However, you
can still use fbset to change other parameters (color depth,
acceleration, etc), anything that will not affect the window size.

So the debate really is, should fbset support for console resizing be
reimplemented? Or should console resizing through stty be made more
powerful, at least to create a video mode that is usable, and then just
use fbset later on to fine tune the new video mode? The former is easy,
the latter is saner but more difficult to code.

The matroxfb on the other hand, is the most complicated fb driver
around, so it is perfectly understandable that rewriting the driver for
the 2.5 will take some time.  Temporarily, you can use Petr's patches
until it is ported over to 2.5.  

ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.5.63.gz


The new layer may not produce something tangible in terms of user
experience (except perhaps for a faster console), but it should pave the
way for better things in the future.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
