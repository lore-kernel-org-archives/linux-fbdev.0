From: "Michal Suchanek" <hramrach@centrum.cz>
Subject: Re: Matrox (g450) DVI problems in 2.6.17
Date: Tue, 26 Sep 2006 09:12:44 +0200
Message-ID: <a5d587fb0609260012u3e63fc40k1890fa45e374288b@mail.gmail.com>
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
	id 1GS77Y-0003zQ-BU for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Sep 2006 00:12:48 -0700
Received: from nf-out-0910.google.com ([64.233.182.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GS77W-0006Zn-TM
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Sep 2006 00:12:48 -0700
Received: by nf-out-0910.google.com with SMTP id p46so176071nfa
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 26 Sep 2006 00:12:45 -0700 (PDT)
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

> > With kernel framebuffer I get an usable videomode in two steps. First
> > I start the X server, and there is only a message from the monitor
> > about bad timings. However, after switching to the console and back X
> > works well. Sometimes the switch is not needed (usually if started
> > from an already running X server). Works with software suspend as well
> > (as long as dri is not used).
>
> Are not you using ACER's monitor?  Try just powering monitor off and back on
> instead of doing mode switch.

For the EIZO monitor it works as well.

>
> > With 2.6.17.13 the picture I get is noisy. The lines shift a few
> > pixels horizontally in various directions. It is much like the results
> > I got with g550 when there was no screen connected to DVI at startup.
> > only much more noise (there must be a screen connected to DVI at boot
> > for the framebuffer to work correctly with DVI - at least it had to
> > last time I tried).
>
> Upgrade to 2.6.18, it should behave like 2.6.16 does.

yes, 2.6.18 works again.

Thanks

Michal

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
