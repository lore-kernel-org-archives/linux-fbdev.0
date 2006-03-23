From: Thomas Arendsen Hein <thomas@intevation.de>
Subject: Re: cyblafb in kernel 2.6.16: corrupted display  in Xfree86
Date: Thu, 23 Mar 2006 13:52:44 +0100
Message-ID: <20060323125244.GB5579@intevation.de>
References: <20060322234812.GB2361@intevation.de> <44225DAD.8080004@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMPJ6-0003Vq-Ek
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 04:52:52 -0800
Received: from aktaia.intevation.org ([212.95.126.10] helo=mail.intevation.de)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMPJ4-0007FU-SG
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 04:52:52 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.intevation.de (Postfix) with ESMTP id 3B6BB36DD2
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Mar 2006 13:52:47 +0100 (CET)
Received: from intevation.de (eukrante.hq [192.168.11.14])
	by mail.intevation.de (Postfix) with SMTP id C25F936DE1
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Mar 2006 13:52:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <44225DAD.8080004@t-online.de>
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

* Knut Petersen <Knut_Petersen@t-online.de> [20060323 09:44]:
> >/etc/fb.modes:
> >mode "1152x864-70"
> >   # D: 100.0 MHz, H: 66.138 kHz, V: 69.99 Hz
> >   geometry 1152 864 1152 864 8
>
> That is very slow. Use geometry 1152 864 2048 4096 8

This only works with kernel 2.6.16, not with 2.6.15.6

> >To enable this resolution I use:
> >
> >/etc/rcS.d/S42cyblafb:
> >/sbin/modprobe cyblafb bpp=16 mode=1024x768 ref=85 && /usr/sbin/fbset -a 
> >1152x864-70
> 
> /sbin/modprobe cyblafb && /usr/sbin/fbset -a 1152x864-70 should be 
> sufficient.

Yes, it is.

> >One further thing to note is that I compiled 2.6.15.6 with gcc
> >2.95.4 and 2.6.16 with gcc 3.4.3, can this make a difference?

I compiled 2.6.15.6 with gcc 3.4.3, too, just to make sure that this
makes no difference.

> I cannot test 1152x864 on my system because my monitor does not understand
> that resolution. But if it worked previously it should work now ;-)

Maybe you can test it with your monitor, too, see below.

> Are there any problems on the framebuffer console? You wrote that the fb 
> console
> comes up fine, but please confirm that scrolling is ok.

Scrolling in fbcon works perfectly, with or without xdm started.

> Are there any problems left after you reach the state of your third 
> picture?

No problems then.

> Switching between the fb console and X works flawlessly then?

Yes, no problem.

> Are there any problems if you use the standard resolutions, eg 1024x768 
> or 1280x1024?

No and yes:
Everything works fine when using
/sbin/modprobe cyblafb bpp=16 mode=1280x1024 ref=85
but I get the same problems if I do:
/sbin/modprobe cyblafb && /usr/sbin/fbset -a 1280x1024-85

> Try a fbset -vxres 2048 -vyres 4096  after your first fbset. Does that 
> change anything?

Nothing changed.

> Please send dmesg logs of kernel 2.6.15.6 and 2.6.16 after adding 
> verbosity=2
> to the modprobe of cyblafb - everything from the point of loading 
> cyblafb to your third
> picture. Also include the X server logs. Maybe it?s a good idea to send 
> those logs to my
> private address Knut_Petersen@t-online.de.

I'll do so.

Thomas

-- 
Email: thomas@intevation.de
http://intevation.de/~thomas/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
