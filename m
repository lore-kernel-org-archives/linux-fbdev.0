From: Alain Kalker <miki@dds.nl>
Subject: Re: [Bugme-new] [Bug 9847] New: i810fb:
	module	parameter 'mode_option' inconsistent with other
	framebuffer modules
Date: Sat, 02 Feb 2008 06:27:19 +0100
Message-ID: <1201930040.2704.37.camel@localhost>
References: <20080201070131.27F842BD8B5@f25.poczta.interia.pl>
	<20080131233232.a7bf51d5.akpm@linux-foundation.org>
	<1201925891.2704.25.camel@localhost>
	<20080201203737.141b11d1.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JLAum-0007Cq-3c for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Feb 2008 21:27:44 -0800
Received: from spalding.dds.nl ([85.17.178.135])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JLAuk-0007i5-Kr
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Feb 2008 21:27:44 -0800
In-Reply-To: <20080201203737.141b11d1.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

On Fri, 2008-02-01 at 20:37 -0800, Andrew Morton wrote:
> On Sat, 02 Feb 2008 05:18:10 +0100 Alain Kalker <miki@dds.nl> wrote:
> 
> > Should this be filed as a more general bug report?
> 
> It is unlikely that anyone would actually act upon such a thing, I'm afraid.
> Maybe if we could come up with a single, centralised option parser
> for all the drivers and then migrate individual drivers over to or
> or something like that..

The reason I asked is that the current situation presents a problem to
the boot scripts. Currently none of the modules support both options
simultaneously, and I'm not sure if every module supports the parameter
name being optional. The only sure ways to ensure that kernel boot
option "video=<framebuffer>:<videomode> works as intended, is either to
parse the modules' option list using modinfo (which may not be available
at boot) or to try each option name in turn using "modprobe
--first-time", which I find very kludgy.

-Alain

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
