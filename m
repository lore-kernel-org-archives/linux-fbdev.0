From: Ben Collins <bcollins@debian.org>
Subject: Re: [FBDEV UPDATE] Newer patch.
Date: Mon, 17 Nov 2003 13:38:05 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031117183805.GB476@phunnypharm.org>
References: <20031023234552.GB554@phunnypharm.org> <Pine.LNX.4.44.0310301833140.4560-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ALotG-0004pM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Nov 2003 11:18:26 -0800
Received: from bristol.phunnypharm.org ([65.207.35.130])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ALosL-0006C0-59
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Nov 2003 11:17:29 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310301833140.4560-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Oct 30, 2003 at 06:38:46PM +0000, James Simmons wrote:
> 
> > I noticed one thing, and that is that the mach64 used to use software
> > cursor it seems (I remember wondering why atyfb_cursor was never used
> > anywhere). It's now using the hw cursor.
> 
> Yeap. I'm in the process of getting several driver to use there hardware 
> cursors.
>  
> > Also, I notice with this new code that the random vertical shifting of
> > the console doesn't occur anymore like it does with current 2.6.0-test8
> > code. For as long as I can remember 2.6.0-test, and way back into
> > 2.5.5x, this has been a problem with highly active console programs
> > (mutt, vim, etc...). Good to see it's going away :)
> 
> :-)
> 
> I have fixed the problems you have reported. I have a newer patch. Note 
> this is updated with the LCD support. I like to see if the patch works on 
> sparc. I has updates from the latest 2.4.X kernels. Please give it a try.
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> Let me know the results.

FYI, this new code is working for me on my Blade100. The cursor is much
better now.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
