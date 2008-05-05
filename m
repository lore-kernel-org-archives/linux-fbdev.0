From: "Roland" <devzero@web.de>
Subject: Re: [PATCH] mdacon messing up default vc's,
	set default to vc13-16 again
Date: Mon, 5 May 2008 20:47:29 +0200
Message-ID: <00db01c8aee0$78e7bea0$6400a8c0@bui.materna.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jt5j3-0002BB-Vo for Linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 11:47:49 -0700
Received: from fmmailgate02.web.de ([217.72.192.227])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jt5j0-0008Ux-VO
	for Linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 11:47:49 -0700
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
To: Linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Soeren Sonnenburg <kernel@nn7.de>, jsimmons@infradead.org, adaplas@gmail.com, matan@svgalib.org, edward@debian.org, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

> mdacon incorrectly detects MDA hardware on systems without such graphics 
> card.
>
> one may load this module by chance, for example when doing some 
> systematical
> module-testing, and if there is no Monochrome Display Adapter attached , 
> module init
> renders vc1-16 completely unusable.
>
> me and others have run into this more than once. see [Bug 224522 - 
> modprobe mdacon
> freezes machine -> https://bugzilla.novell.com/show_bug.cgi?id=224522 ] 
> for example


or somebody may accidentally link it statically with the kernel.....and have 
some fun then....

http://marc.info/?l=linux-kernel&m=112550081223569&w=2
-> http://marc.info/?l=linux-kernel&m=112550983822140&w=2






>
> apparently, proper MDA detection seems to be broken for a long time - 
> seems to be
> related to those #ifdef TEST_MDA_B statements added by Edward Betts.
>
> this commit back in 2002 made things even worse :
> http://git.kernel.org/?p=linux/kernel/git/tglx/history.git;a=commit;h=c72757b49c88914433244757fb4967fc63546685
>
> it changed default vc allocation from 13-16 to 1-16  for no apparent 
> reason (!?) , and
> with that (and without X), mdacon grabs the vc you`re currently sitting on 
> and locks you out.
>
> this is from Kconfig :
> >config MDA_CONSOLE
> >        depends on !M68K && !PARISC && ISA
> >        tristate "MDA text console (dual-headed) (EXPERIMENTAL)"
> >        ---help---
> >          Say Y here if you have an old MDA or monochrome Hercules 
> > graphics
> >          adapter in your system acting as a second head ( = video card). 
> > You
> >          will then be able to use two monitors with your Linux system. 
> > Do not
> >          say Y here if your MDA card is the primary card in your system; 
> > the
> >          normal VGA driver will handle it.
>
> As we can see mdacon is just meant as an additional driver for dual-head 
> setup,
> and since kernel 2.4.36 still defaults to vc13-16 ,  setting the default 
> back to that value
> again shouldn`t  do any harm.
>
> hereby i`m reverting that change, setting default back to to vc13-16 
> again.
>
> Besides the fact that mdacon may be rarely or never be used these days and 
> could
> perhaps put to trash anyway (pre-dinosaur hardware!), indeed this is not a 
> real solution,
> but at least it removes the unfortunate side-effect of messing up the vc 
> you`re working on.
>
>
> Signed-off-by: Roland Kletzing <devzero@web.de>
>
> --- drivers/video/console/mdacon.c.orig 2008-05-03 15:47:20.000000000 
> +0200
> +++ drivers/video/console/mdacon.c      2008-05-03 15:55:27.000000000 
> +0200
> @@ -71,13 +71,15 @@
>
>  /* console information */
>
> -static int     mda_first_vc = 1;
> +static int     mda_first_vc = 13;
>  static int     mda_last_vc  = 16;
>
>  static struct vc_data  *mda_display_fg = NULL;
>
>  module_param(mda_first_vc, int, 0);
> +MODULE_PARM_DESC(mda_first_vc, "First virtual console. Default: 13");
>  module_param(mda_last_vc, int, 0);
> +MODULE_PARM_DESC(mda_last_vc, "Last virtual console. Default: 16");
>
>  /* MDA register values
>   */
>



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
