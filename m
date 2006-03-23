From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: Re: cyblafb in kernel 2.6.16: corrupted display
  in Xfree86
Date: Thu, 23 Mar 2006 15:57:23 +0100
Message-ID: <4422B753.5080704@t-online.de>
References: <20060322234812.GB2361@intevation.de> <44225DAD.8080004@t-online.de> <20060323125244.GB5579@intevation.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMROA-0002Yp-2d
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 07:06:14 -0800
Received: from mailout03.sul.t-online.com ([194.25.134.81])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMRO9-0004WP-My
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 07:06:14 -0800
In-Reply-To: <20060323125244.GB5579@intevation.de>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Thomas Arendsen Hein <thomas@intevation.de>

Thomas Arendsen Hein schrieb:

>>That is very slow. Use geometry 1152 864 2048 4096 8
>>    
>>
>
>This only works with kernel 2.6.16, not with 2.6.15.6
>
>  
>
ACK

>>Are there any problems if you use the standard resolutions, eg 1024x768 
>>or 1280x1024?
>>    
>>
>
>No and yes:
>Everything works fine when using
>/sbin/modprobe cyblafb bpp=16 mode=1280x1024 ref=85
>but I get the same problems if I do:
>/sbin/modprobe cyblafb && /usr/sbin/fbset -a 1280x1024-85
>
>  
>

Please Try:

/sbin/modprobe cyblafb && /usr/sbin/fbset -a 1280x1024-85 -depth 16

/sbin/modprobe cyblafb && /usr/sbin/fbset -g 1152 864 1152 864 8 -t 10000 168 40 57 13 152 11

/sbin/modprobe cyblafb && /usr/sbin/fbset -g 1152 864 1152 864 16 -t 10000 168 40 57 13 152 11

/sbin/modprobe cyblafb && /usr/sbin/fbset -g 1152 864 2048 4096 8 -t 10000 168 40 57 13 152 11

/sbin/modprobe cyblafb && /usr/sbin/fbset -g 1152 864 2048 2048 16 -t 10000 168 40 57 13 152 11


Is there a special reason not to use the X* trident driver?

cu,
 Knut



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
