From: Alain Kalker <miki@dds.nl>
Subject: Re: mode_option or mode parameter (was:
	i810fb	module parameter 'mode_option' inconsistent with other
	framebuffer modules)
Date: Wed, 06 Feb 2008 17:47:02 +0100
Message-ID: <1202316423.5109.26.camel@localhost>
References: <20080206071517.14FE52E5CE4@f27.poczta.interia.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JMnQX-0006Q4-OB for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Feb 2008 08:47:13 -0800
Received: from stipula.dds.nl ([85.17.178.134])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JMnQV-0006dQ-0G
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Feb 2008 08:47:13 -0800
In-Reply-To: <20080206071517.14FE52E5CE4@f27.poczta.interia.pl>
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
Cc: Randy Dunlap <rdunlap@xenotime.net>, jsimmons@infradead.org, adaplas@gmail.com

On Wed, 2008-02-06 at 08:15 +0100, krzysztof.h1@poczta.fm wrote:
> I and Alain Kalker (who originally filled the bug report) decided to proceed
> with mode_option parameter because it is stated in documentation, fb driver
> skeleton and more drivers then the mode option. It seems that the mode
> option is used in newer drivers (drivers added later).
> 
> We want to preserve what older fbdev developers decided some time ago. 
> Personaly, I am not sure one way is much better then the other one. 
> The problem is that it is not one way.
> 
> The first step is to fix the mess with different option names, so to add
> the mode_option parameter to drivers which do not support it or support the
> mode parameter.

This was indeed the intention of my bug report, but I have come to
realize that the 'mode_option' name currently makes it very easy to
distinguish between drivers which already use the ModeDB mechanism and
those that don't. One can usie a tool like 'modinfo' to list module
parameters instead of having to grep the kernel source for a function
like 'fb_find_mode'. Maybe in future when all drivers have been
harmonized, the 'mode_option' name can be changed once and for all.

I would like to propose instead to make the 'mode' / 'mode_option'
parameter name optional for all drivers where possible. This will
greatly simplify framebuffer driver loading by the boot scripts, which
currently cannot easily identify drivers needing either parameter name.

Regards,

Alain

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
