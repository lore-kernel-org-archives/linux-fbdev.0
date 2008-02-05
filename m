From: krzysztof.h1@poczta.fm
Subject: Re: mode_option or mode parameter (was: i810fb
	module parameter 'mode_option' inconsistent with other
	framebuffer modules)
Date: 05 Feb 2008 08:08:10 +0100
Message-ID: <20080205070810.9BF9D1B00D8@f41.poczta.interia.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JMHuj-0001DO-Mp for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 Feb 2008 23:08:17 -0800
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JMHui-0005ml-6C
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 Feb 2008 23:08:17 -0800
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
To: krzysztof.h1@poczta.fm, jsimmons@infradead.org, adaplas@gmail.com
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi,

Few days ago, a bug was reported that the i810fb uses "mode_option" parameters while other framebuffers uses the "mode" parameter to set initial mode. It was spotted later that some drivers uses "mode_option", some uses "mode" and some does use none.

I want to ask what is a correct way. I can rework at least some of the drivers to a standard way, but I don't know what the standard is.

Kind regards,
Krzysztof


Pogoda na najblizsze dni.
Sprawdz >>> http://link.interia.pl/f1ce1


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
