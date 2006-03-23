From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: Re: cyblafb in kernel 2.6.16: corrupted display
   in Xfree86
Date: Thu, 23 Mar 2006 17:57:52 +0100
Message-ID: <4422D390.4030500@t-online.de>
References: <20060322234812.GB2361@intevation.de> <44225DAD.8080004@t-online.de> <20060323125244.GB5579@intevation.de> <4422B753.5080704@t-online.de> <20060323160321.GB7464@intevation.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMTGX-0000Ur-81
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 09:06:29 -0800
Received: from mailout02.sul.t-online.com ([194.25.134.17])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMTGS-0002Id-QE
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 09:06:26 -0800
In-Reply-To: <20060323160321.GB7464@intevation.de>
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

Thomas Arendsen Hein schrieb:

>>/sbin/modprobe cyblafb && /usr/sbin/fbset -a 1280x1024-85 -depth 16
>>    
>>
>
>works
>
>  
>
>>/sbin/modprobe cyblafb && /usr/sbin/fbset -g 1152 864 1152 864 8 -t 10000 
>>168 40 57 13 152 11
>>    
>>
>
>doesn't work
>
>  
>
>>/sbin/modprobe cyblafb && /usr/sbin/fbset -g 1152 864 1152 864 16 -t 10000 
>>168 40 57 13 152 11
>>    
>>
>
>works
>
>  
>
>>/sbin/modprobe cyblafb && /usr/sbin/fbset -g 1152 864 2048 4096 8 -t 10000 
>>168 40 57 13 152 11
>>    
>>
>
>doesn't work
>
>  
>
>>/sbin/modprobe cyblafb && /usr/sbin/fbset -g 1152 864 2048 2048 16 -t 10000 
>>168 40 57 13 152 11
>>    
>>
>
>works
>
>With /sbin/modprobe cyblafb && /usr/sbin/fbset -a 1152x864-70 -depth 16
>(changing fb.modes would probably help, too) everything is back to
>normal for me.
>
>I think the extra colors on console won't hurt, now that I know
>about the 2048/4096 setting.
>
>  
>
So the problem is that the 8bpp modes do not work with the
X framebuffer driver. Please report that bug, I think X is responsible.

>>Is there a special reason not to use the X* trident driver?
>>    
>>
>
>Yes, I had crashes when using more than one X display (e.g. one
>local xdm and one "X -query other :1"), 
>
Try it again, the recent cyblafb works around X and xdm bugs
that could have caused that crashes.

>and switching between X and
>console is _much_ faster this way.
>
>  
>
I doubt that ... switching between X trident and cyblafb and back again
takes only a few miliseconds here.

cu,
 knut


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
