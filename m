From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [BK PATCHS] fbdev updates.
Date: Tue, 15 Oct 2002 10:38:33 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021015103833.C9771@flint.arm.linux.org.uk>
References: <20021015100024.A9771@flint.arm.linux.org.uk> <Pine.GSO.4.21.0210151109180.25245-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 181O9v-0005xV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Oct 2002 02:38:40 -0700
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210151109180.25245-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Tue, Oct 15, 2002 at 11:14:03AM +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Oct 15, 2002 at 11:14:03AM +0200, Geert Uytterhoeven wrote:
> So the generic part of the code should behave like this:
> 
>   if (info->fbops->fb_blank && info->fbops->fb_blank(blank_flag)) {
>       /* use hardware blanking */
>   } else if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR ||
> 	     info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
>       /* use software blanking */
>   } else {
>       /* no blanking possible, except for filling the screen with black, which
> 	 is not appropriate (unless we save/restore the contents?) */
>   }
> 
> Is that OK for you?

That's fine for me, but I'd expect other people to find problems with it.

Would it not be better to allow drivers to decide which type of blanking
they want to use depending on the current parameters set via the set_par
callback?  Only the drivers themselves know what their fb_blank method is
capable of performing.

I think with the above you'll inadvertently encourage drivers to mundge
the fb_blank function pointer in their set_par method.

There is also the argument about wanting soft blanking, but hardware power
saving.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
