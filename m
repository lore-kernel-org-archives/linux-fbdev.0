From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Advice sought on approach.
Date: 05 Mar 2003 21:26:46 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046870757.1229.94.camel@localhost.localdomain>
References: <1046867855.2505.200.camel@cambridge.braddahead>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qYti-0006oA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 05:25:26 -0800
In-Reply-To: <1046867855.2505.200.camel@cambridge.braddahead>
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
To: Alex Bennee <kernel-hacker@bennee.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-05 at 20:37, Alex Bennee wrote:
> Hi,
> 
> I'm writting a framebuffer driver for an embedded system that has a
> overlayed video display (TV picture + Overlayed text). To do this I have
> to keep track of both the main pixel memory and a mask that the hardware
> uses to display things. This is also compilcated by the fact I can't
> access this memory directly, it is done through a small addr/data port
> on the hardware so obviosuly I want to minimise the amount of data I
> push through this (by doing it only when required).
> 
> Having read the fb-dev docs on www.linux-fbdev.org I'm a little confused
> as to what actually puts data into the framebuffer. Most of the
> framebuffer drivers just seem to deal with resolution and colourmap
> settings. Is this a case of having to re-implement the fbcon drivers as
> well to get what I want?
> 

The pixels placed to the framebuffer are all done in the fbcon-cfb*.c
modules (if you use the generic functions).  This is for standard
character drawing.  The logo is drawn indepently (fbcon_show_logo in
fbcon.c).  User applications write directly to the framebuffer via the
mmap() function.

> Are there any examples of drivers that have a similar architecture that
> would be worth looking at? I've had a look at the vfb.c code but again
> that seems too simplistic compared to what I'll need.

Search the archives for SED1335.  The author implemented a shadowed
virtual framebuffer using system memory.  The contents of the virtual
framebuffer are written to the data port periodically via a timer
function.

> 
> Final question, the docs refer to 2.2. Is this because under 2.4
> framebuffer drivers are not fundamentally differnt?

Yes.

Tony




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
