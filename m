From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Fwd: Re: [Dri-devel] future of DRI?
Date: Sat, 1 Mar 2003 10:42:36 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030301184236.77268.qmail@web14914.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14914.mail.yahoo.com ([216.136.225.241])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18pBwT-0007EO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 01 Mar 2003 10:42:37 -0800
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
Content-Transfer-Encoding: 7bit
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

--- Linus Torvalds <torvalds@transmeta.com> wrote:
> From: Linus Torvalds <torvalds@transmeta.com>
> To: Keith Whitwell <keith@tungstengraphics.com>
> CC: Jon Smirl <jonsmirl@yahoo.com>, Ian Romanick
> <idr@us.ibm.com>,
>         "DRI developer's list"
> <dri-devel@lists.sourceforge.net>
> Subject: Re: [Dri-devel] future of DRI?
> Date: Sat, 1 Mar 2003 10:15:06 -0800 (PST)
> 
> 
> On Sat, 1 Mar 2003, Keith Whitwell wrote:
> > 
> > Interesting you mention it.  This is what Brian &
> I've done in the Mesa 
> > embedded branch -- layered the radeon dri driver
> on top of fbdev.  I can also 
> > build regular DRI drivers from a minimal tree &
> sane set of makefiles.
> 
> Personally, I'd rather see DRI _underneath_ fbdev
> rather than on top of. 
> Since fbdev would require at least to know of (and
> obey) the DRI locking 
> code - and would likely want to use all the same DRI
> command execution for 
> things like blits etc (this is on the assumption
> that 2d and 3d will 
> eventually use the same engine, which is probably a
> safe assumption).
> 
> I _assume_ that what you really mean is that you use
> fbdev really only to
> set up the screen modes and do things like
> initialize the graphics
> buffers.
> 
> 		Linus
> 
> 
> 
>
-------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/dri-devel


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - forms, calculators, tips, more
http://taxes.yahoo.com/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
