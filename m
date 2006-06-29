From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb: corrupted screen on bootup
Date: Thu, 29 Jun 2006 10:07:11 +1000
Message-ID: <1151539632.4044.49.camel@localhost.localdomain>
References: <200606282118.27750.mb@bu3sch.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fvk4A-0002Hf-3I for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Jun 2006 17:07:30 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fvk48-0007Dj-JU
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Jun 2006 17:07:30 -0700
In-Reply-To: <200606282118.27750.mb@bu3sch.de>
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
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 21:18 +0200, Michael Buesch wrote:
> Hi,
> 
> I have a weird error with my PowerBook G4, which
> has a radeon card. I am using radeonfb.
> After bootup, the screen sometimes looks like it is melting.
> I made a video to show you what is going on:
> http://bu3sch.de/misc/after_boot.avi  (6.1 MB)
> 
> It does only happen sometimes. I could not find
> a way to reproduce it.
> If I start X after boot with a melting screen, X is also
> melting:
> http://bu3sch.de/misc/after_x_switch.avi  (6.6 MB)
> 
> But here comes the interresting part:
> If I switch back into the console, the screen becomes
> normal again and I can continue to work as usual.
> 
> I am suspecting some initialization routine bug.
> It never happened when booting into OSX.

It's a known issue. There is some black magic with the flat panel that
we don't have quite right... If I tweak the timings to get it right on
one machine (well, apparently, difficult to make sure if the problem
happens once every week), it will probably break anohter. I've been
trying to get ATI to tell me what should be done but to no avail so
far...

It's basically that sometimes, the LCD doesn't "catch" the signal.
Usually just turning it off/on fixes it (which is what a mode change
does, sometimes a console switch, or a blank/unblank... or turn the
backlight all the way down to blank the screen and back up).

Ben.



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
