From: thunder7@xs4all.nl
Subject: Re: framebuffer with nvidia 7600GS shows
	corrupt screen
Date: Fri, 25 May 2007 19:47:46 +0200
Message-ID: <20070525174745.GA3990@amd64.of.nowhere>
References: <20070523181826.GA4331@amd64.of.nowhere>
	<4655536C.3080305@vc.cvut.cz>
	<20070524123611.GA7084@amd64.of.nowhere>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hrdtb-0005RC-L2 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 May 2007 10:48:11 -0700
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HrdtX-0006xP-3E
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 May 2007 10:48:11 -0700
Received: from rivierenland.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-vbr7.xs4all.nl (8.13.8/8.13.8) with ESMTP id l4PHm1vV082170
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 25 May 2007 19:48:02 +0200 (CEST)
	(envelope-from jurriaan@rivierenland.xs4all.nl)
Content-Disposition: inline
In-Reply-To: <20070524123611.GA7084@amd64.of.nowhere>
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
To: linux-fbdev-devel@lists.sourceforge.net

From: thunder7@xs4all.nl <thunder7@xs4all.nl>
Date: Thu, May 24, 2007 at 02:36:11PM +0200
> 
> I haven't yet - a plain old CRT monitor is attached currently. I haven't
> bought a LCD yet. The messages seem correct. The monitor is attached via
> a dvi->vga15 converter, of which I've tried two known working ones.
> 
So far, I've determined the problem also happens when I boot a 32-bit
system, and it goes partly away when I add the noaccel option.

If I add noaccel, I get a dark grey background, with very dark gray or
black letters on it. It's readable if you can guess what is written,
like boot messages.

xorg works fine (using the nv driver), and the strange part:

once I've switched from Xorg to a console (ctrl-alt-F1), the console
looks fine. Also, if I leave X11 after having switched to a console and
back to Xorg, the console looks fine.

I hope this jogs someone's memory - I basically trying blind. Anyone
care to guess what goes wrong? I didn't think the 7600 was such an
exotic card...

Kind regards,
Jurriaan
-- 
For who are we to question her
Who stands among the stones
	Big Country - The Seer
Debian (Unstable) GNU/Linux 2.6.21-mm2 2x2010 bogomips load 2.21
the Jack Vance Integral Edition: http://www.integralarchive.org

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
