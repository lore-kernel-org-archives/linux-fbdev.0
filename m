From: Alain Kalker <miki@dds.nl>
Subject: Re: mode_option or mode parameter (was:
	i810fb	module parameter 'mode_option' inconsistent with other
	framebuffer modules)
Date: Wed, 06 Feb 2008 17:53:50 +0100
Message-ID: <1202316830.5109.29.camel@localhost>
References: <20080206071517.14FE52E5CE4@f27.poczta.interia.pl>
	<1202316423.5109.26.camel@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JMnX6-0007WO-2Y for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Feb 2008 08:54:00 -0800
Received: from stipula.dds.nl ([85.17.178.134])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JMnX0-0003y9-Jg
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Feb 2008 08:54:00 -0800
In-Reply-To: <1202316423.5109.26.camel@localhost>
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


On Wed, 2008-02-06 at 17:47 +0100, Alain Kalker wrote:
> I would like to propose instead to make the 'mode' / 'mode_option'
> parameter name optional for all drivers where possible. This will
> greatly simplify framebuffer driver loading by the boot scripts, which
> currently cannot easily identify drivers needing either parameter name.

so one would be able to use

# modprobe <xxxfb> 1024x768 <other options>

instead of 

# modprobe <xxxfb> mode_option=1024x768 <other options>

Regards,

Alain

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
