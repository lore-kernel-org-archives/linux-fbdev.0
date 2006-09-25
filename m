From: "Michal Suchanek" <hramrach@centrum.cz>
Subject: Matrox (g450) DVI problems in 2.6.17
Date: Mon, 25 Sep 2006 19:57:33 +0200
Message-ID: <a5d587fb0609251057h4468f72aw826a37c9250cb28a@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GRui0-0000dt-59 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 10:57:36 -0700
Received: from nf-out-0910.google.com ([64.233.182.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GRuhz-000334-Rt
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 10:57:36 -0700
Received: by nf-out-0910.google.com with SMTP id p46so2033128nfa
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 25 Sep 2006 10:57:33 -0700 (PDT)
Content-Disposition: inline
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
To: vandrove@vc.cvut.cz, linux-fbdev-devel@lists.sourceforge.net

Hello from the Matrox DVI land

For me matrox DVI framebuffer (sort of) works on Linux 2.6.16.19 and
fails on 2.6.17.13.

The DVI support on Matroxes is quite flaky I'd guess.

I got a matrox g450

01:00.0 VGA compatible controller: Matrox Graphics, Inc. G400/G450 (rev 85)

and I connect it with DVI to a flat panel.

For X to work I have to use kernel framebuffer to set the videomode
(UseFBDev in X). Otherwise X fails to set the timings correctly
(nothing is visible).
With kernel framebuffer I get an usable videomode in two steps. First
I start the X server, and there is only a message from the monitor
about bad timings. However, after switching to the console and back X
works well. Sometimes the switch is not needed (usually if started
from an already running X server). Works with software suspend as well
(as long as dri is not used).

With 2.6.17.13 the picture I get is noisy. The lines shift a few
pixels horizontally in various directions. It is much like the results
I got with g550 when there was no screen connected to DVI at startup.
only much more noise (there must be a screen connected to DVI at boot
for the framebuffer to work correctly with DVI - at least it had to
last time I tried).

I use Gentoo kernels but it does not look like there are new patches
in 2.6.17. The ones that are in both are only for splash and vesa.

I am not sure what other information would be helpful for diagnosing
the problem.

Thanks

Michal

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
