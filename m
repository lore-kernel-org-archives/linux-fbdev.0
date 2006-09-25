From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Matrox (g450) DVI problems in 2.6.17
Date: Mon, 25 Sep 2006 20:08:01 +0200
Message-ID: <45181B01.2080203@vc.cvut.cz>
References: <a5d587fb0609251057h4468f72aw826a37c9250cb28a@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GRusI-0001g3-5p for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 11:08:14 -0700
Received: from mailgw.cvut.cz ([147.32.3.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GRusG-0005HG-ME
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 11:08:14 -0700
In-Reply-To: <a5d587fb0609251057h4468f72aw826a37c9250cb28a@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Michal Suchanek <hramrach@centrum.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

Michal Suchanek wrote:
> Hello from the Matrox DVI land
> 
> For me matrox DVI framebuffer (sort of) works on Linux 2.6.16.19 and
> fails on 2.6.17.13.
> 
> The DVI support on Matroxes is quite flaky I'd guess.

Ask Matrox to release documentation for their hardware...

> I got a matrox g450
> 
> 01:00.0 VGA compatible controller: Matrox Graphics, Inc. G400/G450 (rev 85)
> 
> and I connect it with DVI to a flat panel.

> For X to work I have to use kernel framebuffer to set the videomode
> (UseFBDev in X). Otherwise X fails to set the timings correctly
> (nothing is visible).
> With kernel framebuffer I get an usable videomode in two steps. First
> I start the X server, and there is only a message from the monitor
> about bad timings. However, after switching to the console and back X
> works well. Sometimes the switch is not needed (usually if started
> from an already running X server). Works with software suspend as well
> (as long as dri is not used).

Are not you using ACER's monitor?  Try just powering monitor off and back on 
instead of doing mode switch.

> With 2.6.17.13 the picture I get is noisy. The lines shift a few
> pixels horizontally in various directions. It is much like the results
> I got with g550 when there was no screen connected to DVI at startup.
> only much more noise (there must be a screen connected to DVI at boot
> for the framebuffer to work correctly with DVI - at least it had to
> last time I tried).

Upgrade to 2.6.18, it should behave like 2.6.16 does.
						Petr


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
