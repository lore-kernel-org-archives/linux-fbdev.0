From: Thomas Arendsen Hein <thomas@intevation.de>
Subject: Re: cyblafb in kernel 2.6.16: corrupted display    in Xfree86
Date: Thu, 23 Mar 2006 19:39:08 +0100
Message-ID: <20060323183908.GA9907@intevation.de>
References: <20060322234812.GB2361@intevation.de> <44225DAD.8080004@t-online.de> <20060323125244.GB5579@intevation.de> <4422B753.5080704@t-online.de> <20060323160321.GB7464@intevation.de> <4422D390.4030500@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMUiH-000319-9F
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 10:39:13 -0800
Received: from aktaia.intevation.org ([212.95.126.10] helo=mail.intevation.de)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMUiG-0006vf-1A
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 10:39:13 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.intevation.de (Postfix) with ESMTP id EB9C036F13
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Mar 2006 19:39:10 +0100 (CET)
Received: from intevation.de (eukrante.hq [192.168.11.14])
	by mail.intevation.de (Postfix) with SMTP id 7DE7836DE1
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Mar 2006 19:39:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4422D390.4030500@t-online.de>
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

* Knut Petersen <Knut_Petersen@t-online.de> [20060323 18:07]:
> Thomas Arendsen Hein schrieb:
> 
> >With /sbin/modprobe cyblafb && /usr/sbin/fbset -a 1152x864-70 -depth 16
> >(changing fb.modes would probably help, too) everything is back to
> >normal for me.
>
> So the problem is that the 8bpp modes do not work with the
> X framebuffer driver. Please report that bug, I think X is responsible.

But why did it work up to 2.6.15.6 then?
I know for sure that I had 8bpp in fb console and 16bpp in X.

> >>Is there a special reason not to use the X* trident driver?
> >
> >Yes, I had crashes when using more than one X display (e.g. one
> >local xdm and one "X -query other :1"), 
>
> Try it again, the recent cyblafb works around X and xdm bugs
> that could have caused that crashes.

No, I had crashes with non-fb console and trident X driver.

I never tested if cyblafb console and trident X have problems.

> >and switching between X and
> >console is _much_ faster this way.
>
> I doubt that ... switching between X trident and cyblafb and back again
> takes only a few miliseconds here.

Maybe I had little variations in the monitor timings which caused
the monitor to re-sync. With X on cyblafb this is obviously always
identical.


I've found another problem with the new cyblafb under X which didn't
happen before: DPMS no longer turns of the monitor. At the time
where DPMS suspend kicked in before, now the xlock clock simply
stops updating, but is still visible (xlock -mode dclock).

Thomas

-- 
Email: thomas@intevation.de
http://intevation.de/~thomas/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
