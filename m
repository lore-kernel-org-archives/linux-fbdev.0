From: Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: [Bugme-new] [Bug 2916] New: Console
 font became black on black after upgrade from 2.6.6 to 2.6.7
Date: Fri, 18 Jun 2004 18:40:23 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040618184023.62611839.akpm@osdl.org>
References: <20040618152036.3f5cd6b3.akpm@osdl.org>
	<20040619012057.GA14319@havoc.gtf.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbUrE-00088M-9o
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 18:41:24 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BbUrD-0006dm-RI
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 18:41:23 -0700
In-Reply-To: <20040619012057.GA14319@havoc.gtf.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: David Eger <eger@havoc.gtf.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, spamhole@gmx.at, dfnsonfsduifb@gmx.de

David Eger <eger@havoc.gtf.org> wrote:
>
> > # Graphics support
> > #
> > CONFIG_FB=y
> > CONFIG_FB_VESA=y
> > CONFIG_FB_RADEON=y
> > 
> > #
> > # Console display driver support
> > #
> > CONFIG_VGA_CONSOLE=y
> > CONFIG_DUMMY_CONSOLE=y
> > # CONFIG_FRAMEBUFFER_CONSOLE is not set
> 
> For a typical setup, framebuffer drivers (CONFIG_FB_VESA, CONFIG_FB_RADEON) 
> are only really useful if you want the console to live on top of them... 
> so use either:
> 
> (1) CONFIG_FB + (CONFIG_FB_VESA | CONFIG_FB_RADEON) + CONFIG_FRAMEBUFFER_CONSOLE
> 
> or
> 
> (2) CONFIG_VGA_CONSOLE

Thanks.

> Please let me know if any of these three setups work.  I wouldn't select
> both VESA and a specific driver.... eww... I'd guess they would get
> confused and try to access the same hardware...

This all sounds hard to express via kernel config, but it sounds pretty
easy to avoid via a few state variables in the kernel.

Do you think it's possible to prevent illegal things from happening at
runtime?



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
