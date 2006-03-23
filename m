From: Thomas Arendsen Hein <thomas@intevation.de>
Subject: Re: cyblafb in kernel 2.6.16: corrupted display   in Xfree86
Date: Thu, 23 Mar 2006 17:03:22 +0100
Message-ID: <20060323160321.GB7464@intevation.de>
References: <20060322234812.GB2361@intevation.de> <44225DAD.8080004@t-online.de> <20060323125244.GB5579@intevation.de> <4422B753.5080704@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMSHh-00015v-PM
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 08:03:37 -0800
Received: from aktaia.intevation.org ([212.95.126.10] helo=mail.intevation.de)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMSHb-0007oY-9T
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 08:03:37 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.intevation.de (Postfix) with ESMTP id 3B61836F4F
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Mar 2006 17:03:24 +0100 (CET)
Received: from intevation.de (eukrante.hq [192.168.11.14])
	by mail.intevation.de (Postfix) with SMTP id 3EB2D36F29
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Mar 2006 17:03:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4422B753.5080704@t-online.de>
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

* Knut Petersen <Knut_Petersen@t-online.de> [20060323 16:07]:
> Thomas Arendsen Hein schrieb:
> >>That is very slow. Use geometry 1152 864 2048 4096 8
> >
> >This only works with kernel 2.6.16, not with 2.6.15.6
>
> ACK

Wow, scrolling in the console is definitely _much_ faster with this:

time for "find /dev" on kernel 2.6.16:

       1152/864  2048/4096
 8bpp    18s       0.56s
16bpp    39s       0.65s

> >>Are there any problems if you use the standard resolutions, eg 1024x768 
> >>or 1280x1024?
> >
> >No and yes:
> >Everything works fine when using
> >/sbin/modprobe cyblafb bpp=16 mode=1280x1024 ref=85
> >but I get the same problems if I do:
> >/sbin/modprobe cyblafb && /usr/sbin/fbset -a 1280x1024-85
> 
> Please Try:
> 
> /sbin/modprobe cyblafb && /usr/sbin/fbset -a 1280x1024-85 -depth 16

works

> /sbin/modprobe cyblafb && /usr/sbin/fbset -g 1152 864 1152 864 8 -t 10000 
> 168 40 57 13 152 11

doesn't work

> /sbin/modprobe cyblafb && /usr/sbin/fbset -g 1152 864 1152 864 16 -t 10000 
> 168 40 57 13 152 11

works

> /sbin/modprobe cyblafb && /usr/sbin/fbset -g 1152 864 2048 4096 8 -t 10000 
> 168 40 57 13 152 11

doesn't work

> /sbin/modprobe cyblafb && /usr/sbin/fbset -g 1152 864 2048 2048 16 -t 10000 
> 168 40 57 13 152 11

works

With /sbin/modprobe cyblafb && /usr/sbin/fbset -a 1152x864-70 -depth 16
(changing fb.modes would probably help, too) everything is back to
normal for me.

I think the extra colors on console won't hurt, now that I know
about the 2048/4096 setting.

> Is there a special reason not to use the X* trident driver?

Yes, I had crashes when using more than one X display (e.g. one
local xdm and one "X -query other :1"), and switching between X and
console is _much_ faster this way.

Many thanks for the help (and for cyblafb in general),
Thomas

-- 
Email: thomas@intevation.de
http://intevation.de/~thomas/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
