From: Ico Doornekamp <fbdev@zevv.nl>
Subject: Re: Questions about fbdriver
	integration	(solved)
Date: Sun, 25 Nov 2007 14:32:09 +0100
Message-ID: <20071125133209.GL3183@pruts.nl>
References: <20071124214325.GD3183@pruts.nl>
	<Pine.LNX.4.64.0711250947380.21779@anakin>
	<20071125105153.GH3183@pruts.nl> <20071125125145.GK3183@pruts.nl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwHb1-0006zs-0K for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 05:32:29 -0800
Received: from pruts.nl ([82.94.235.106] helo=iron.pruts.nl ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwHb0-0002Xr-Fu
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 05:32:26 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by iron.pruts.nl (Postfix) with ESMTP id B083F12E42C
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Nov 2007 14:32:24 +0100 (CET)
Received: from iron.pruts.nl ([127.0.0.1])
	by localhost (iron.pruts.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qoa7dA3IGD2G
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Nov 2007 14:32:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071125125145.GK3183@pruts.nl>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net




* On 2007-11-25 Ico Doornekamp <fbdev@zevv.nl> wrote  :

> * On 2007-11-25 Ico Doornekamp <fbdev@zevv.nl> wrote  :
> 
> > > Fbcon writes to the memory at fb_info.screen_base.
> > 
> > That is what I expected. I'll have to do a bit more debugging here then.
> 
> It seems that my driver did not fill the line_length member of
> fb_fix_screeninfo, and no gets was copied by fbcon when this is missing.
> 
> I filled in this field, but now
> 
>   BUG: unable to handle kernel paging request at virtual address c882a800
> 
>   [<c882450c>] mbarcfb_imageblit+0xc/0x20 [mbarcfb]
>   [<c881315d>] soft_cursor+0x15d/0x1bc [softcursor]
>   [<c8817b38>] bit_cursor+0x338/0x5a8 [bitblit]
>   [<c01c5c53>] vsnprintf+0x303/0x690
> 
> happens. Back to do some more debugging.

Ok, one more reply to myself: all problems seem to be solved now - I
changed my driver to support 8-bit pseudocolor instead of 1-bit mono,
and suddenly both the console and X are working just fine. It seems that
the MONO01 visual is just not well supported in various other parts
interacting with the framebuffer code.

The only issue remaining is the kernel warning I posted in an earlier
mail (__set_page_dirty), which I understood Jaya was already trying to
reproduce on his system.

Thank you both for your time and answers,

Ico

-- 
:wq
^X^Cy^K^X^C^C^C^C

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
