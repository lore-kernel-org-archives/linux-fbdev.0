From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] [radeonfb] Radeon M26 and ATOM
	bios support (take 5)
Date: Thu, 02 Mar 2006 08:47:05 +1100
Message-ID: <1141249626.3889.22.camel@localhost.localdomain>
References: <20060103204404.GA23313@shaftnet.org>
	 <1139952530.7903.31.camel@localhost.localdomain>
	 <20060222221916.GB17359@shaftnet.org> <20060223060939.GA27224@shaftnet.org>
	 <1140677458.8264.24.camel@localhost.localdomain>
	 <20060223223619.GA14458@shaftnet.org>
	 <1140736521.8264.49.camel@localhost.localdomain>
	 <20060301033338.GA20460@shaftnet.org>
	 <1141184789.4157.30.camel@localhost.localdomain>
	 <20060301203611.GA14351@shaftnet.org> <20060301213440.GB14351@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FEZAA-0004Ax-M1
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 01 Mar 2006 13:47:14 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FEZA9-0007N5-Bz
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 01 Mar 2006 13:47:14 -0800
In-Reply-To: <20060301213440.GB14351@shaftnet.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Solomon Peachy <pizza@shaftnet.org>

On Wed, 2006-03-01 at 16:34 -0500, Stuffed Crust wrote:
> On Wed, Mar 01, 2006 at 03:36:11PM -0500, Stuffed Crust wrote:
> > I'm about to mail out v5 of the patch.
> 
> Signed-Off-By:  Solomon Peachy <pizza@shaftnet.org>
> 
> The short set of changes in this patch (against 2.6.15.4)
> 
>  * ATOM BIOS support for newer Radeon cards
>  * Clean method of detecting and handling disparate BIOS types
>  * Radeon RV410/M26/M26GL (aka Mobility X700/FireGL5000) card IDs
>  * Default PLL clocks for R420 and variants
>  * Handle bogus PLL divider with sane default.
>  * All new connector/head detection code that uses bios/firmware 
>    defaults whenever possible

Ok, good. I need some time to review properly. There are a few things I
want to change, for example, some of the OF stuff should be decided at
runtime, not compile time (what set of callbacks to use) since some OF
machines do use x86 cards, etc... but I can fix all of these things.

Thanks for the great work.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
