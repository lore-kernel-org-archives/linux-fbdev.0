From: Antonino Daplas <adaplas@pol.net>
Subject: Re: LCD scaling type
Date: 11 Jan 2003 20:42:27 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042288803.977.83.camel@localhost.localdomain>
References: <1042227743.705.22.camel@zion.wanadoo.fr>
	<1042268184.932.165.camel@localhost.localdomain>
	<1042278469.541.27.camel@zion.wanadoo.fr>
	<1042279649.955.18.camel@localhost.localdomain>
	<1042283284.541.38.camel@zion.wanadoo.fr>
	<1042284929.977.46.camel@localhost.localdomain> 
	<1042286909.541.43.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XL7w-0005fe-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Jan 2003 04:52:41 -0800
In-Reply-To: <1042286909.541.43.camel@zion.wanadoo.fr>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2003-01-11 at 20:08, Benjamin Herrenschmidt wrote:
> 
> For my immediate need, however, I still think turning one of the
> reserved fields of var_screeninfo into a "mode_flags" would be useful,
> we can already define a FB_MFLAG_LCD_FULLSCALE flag that would ask the
> driver to not bother keeping aspect ratio (the idea here is that keeping
> aspect ratio is the default, so 0, even if that's nor really working yet
> in radeonfb or aty128fb).
>  

I wasn't contradicting you.  A new feature that can be supported by
different hardware and is quite useful deserves a unique flag, and I
definitely agree with that.  I don't to see my desktop flattened top to
bottom if I can prevent it.

But aside from the above, I also need a field which is interpreted
differently from driver to driver, and is so nebulous that it doesn't
deserve its own flag.  Just something that can be used to poke the
hardware from user space without writing a utility each time. 
Currently, I'm doing this by setting bits in var->nonstd.

Tony



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
