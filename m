From: "Michal Suchanek" <hramrach@centrum.cz>
Subject: Re: Matrox (g450) DVI problems in 2.6.17
Date: Mon, 25 Sep 2006 22:52:15 +0200
Message-ID: <a5d587fb0609251352l16de4533vcff34e5d4e439bde@mail.gmail.com>
References: <a5d587fb0609251057h4468f72aw826a37c9250cb28a@mail.gmail.com>
	<45181B01.2080203@vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GRxR5-0000VL-0W for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 13:52:19 -0700
Received: from nf-out-0910.google.com ([64.233.182.188])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GRxR3-0003Kj-JP
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 13:52:18 -0700
Received: by nf-out-0910.google.com with SMTP id p46so54839nfa
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 25 Sep 2006 13:52:15 -0700 (PDT)
In-Reply-To: <45181B01.2080203@vc.cvut.cz>
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 9/25/06, Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
> Michal Suchanek wrote:
> > Hello from the Matrox DVI land
> >
> > For me matrox DVI framebuffer (sort of) works on Linux 2.6.16.19 and
> > fails on 2.6.17.13.
> >
> > The DVI support on Matroxes is quite flaky I'd guess.
>
> Ask Matrox to release documentation for their hardware...
Well, it looks like nobody releases the docs for thier graphics hardware...
>
> > I got a matrox g450
> >
> > 01:00.0 VGA compatible controller: Matrox Graphics, Inc. G400/G450 (rev 85)
> >
> > and I connect it with DVI to a flat panel.
>
> > For X to work I have to use kernel framebuffer to set the videomode
> > (UseFBDev in X). Otherwise X fails to set the timings correctly
> > (nothing is visible).
> > With kernel framebuffer I get an usable videomode in two steps. First
> > I start the X server, and there is only a message from the monitor
> > about bad timings. However, after switching to the console and back X
> > works well. Sometimes the switch is not needed (usually if started
> > from an already running X server). Works with software suspend as well
> > (as long as dri is not used).
>
> Are not you using ACER's monitor?  Try just powering monitor off and back on
> instead of doing mode switch.

It's an EIZO display. Switching the mode is easier than pressing the
power button but I can try that when I get to start the X server
again.

>
> > With 2.6.17.13 the picture I get is noisy. The lines shift a few
> > pixels horizontally in various directions. It is much like the results
> > I got with g550 when there was no screen connected to DVI at startup.
> > only much more noise (there must be a screen connected to DVI at boot
> > for the framebuffer to work correctly with DVI - at least it had to
> > last time I tried).
>
> Upgrade to 2.6.18, it should behave like 2.6.16 does.
I will try. Thanks

Michal

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
