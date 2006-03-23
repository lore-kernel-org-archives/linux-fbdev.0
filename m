From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: Re: cyblafb in kernel 2.6.16: corrupted display
    in Xfree86
Date: Thu, 23 Mar 2006 23:46:09 +0100
Message-ID: <44232531.1050006@t-online.de>
References: <20060322234812.GB2361@intevation.de> <44225DAD.8080004@t-online.de> <20060323125244.GB5579@intevation.de> <4422B753.5080704@t-online.de> <20060323160321.GB7464@intevation.de> <4422D390.4030500@t-online.de> <20060323183908.GA9907@intevation.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMYhZ-0007wz-Ir
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 14:54:45 -0800
Received: from mailout02.sul.t-online.com ([194.25.134.17])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMYhY-0004EQ-ER
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 14:54:45 -0800
In-Reply-To: <20060323183908.GA9907@intevation.de>
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
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

Thomas Arendsen Hein schrieb:

>* Knut Petersen <Knut_Petersen@t-online.de> [20060323 18:07]:
>  
>
>>Thomas Arendsen Hein schrieb:
>>
>>    
>>
>>>With /sbin/modprobe cyblafb && /usr/sbin/fbset -a 1152x864-70 -depth 16
>>>(changing fb.modes would probably help, too) everything is back to
>>>normal for me.
>>>      
>>>
>>So the problem is that the 8bpp modes do not work with the
>>X framebuffer driver. Please report that bug, I think X is responsible.
>>    
>>
>
>But why did it work up to 2.6.15.6 then?
>I know for sure that I had 8bpp in fb console and 16bpp in X.
>
>  
>
Well, cyblafb does not use vga style panning registers any longer.
That change is necessary to support ywrap scrolling and to allow
screen rotation. The trident X driver does not know about the
graphics engine registers I use instead, and I had to include
some hacks to allow that to work.

Try to change

    #define CYBLAFB_KD_GRAPHICS_QUIRK 1

to

    #define CYBLAFB_KD_GRAPHICS_QUIRK 0

in cyblafb.c for purely diagnostic purposes. Does that restore the old
behaviour for you?


cu,
 Knut


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
