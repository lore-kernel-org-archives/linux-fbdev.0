From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: mode_option or mode parameter (was: i810fb
 module parameter 'mode_option' inconsistent with other framebuffer modules)
Date: Tue, 5 Feb 2008 14:03:17 -0800
Message-ID: <20080205140317.c6746e47.rdunlap@xenotime.net>
References: <20080205070810.9BF9D1B00D8@f41.poczta.interia.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JMVsu-00044R-Nh for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Feb 2008 14:03:20 -0800
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JMVst-0008Td-EV
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Feb 2008 14:03:20 -0800
Received: from midway.site ([96.225.192.120]) by xenotime.net for
	<linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 5 Feb 2008 14:03:17 -0800
In-Reply-To: <20080205070810.9BF9D1B00D8@f41.poczta.interia.pl>
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
Cc: jsimmons@infradead.org, adaplas@gmail.com

On 05 Feb 2008 08:08:10 +0100 krzysztof.h1@poczta.fm wrote:

> Hi,
> 
> Few days ago, a bug was reported that the i810fb uses "mode_option" parameters while other framebuffers uses the "mode" parameter to set initial mode. It was spotted later that some drivers uses "mode_option", some uses "mode" and some does use none.
> 
> I want to ask what is a correct way. I can rework at least some of the drivers to a standard way, but I don't know what the standard is.

Hi,
Hopefully one of the fbdev driver developers will know for sure.

I would (do) say that "mode_option" is being redundant.  Yes, it's
an option, but we don't usually name options (in other parts of the
kernel) with an _option suffix.  Sure, the variable could be called
<mode_option>, but the userspace name should just be "mode".  IMHO.

Please keep Documentation/fb/modedb.txt updated if you make any
relevant changes.

Thanks.
---
~Randy

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
