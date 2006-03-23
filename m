From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Re: cyblafb in kernel 2.6.16: corrupted display
    in Xfree86
Date: Fri, 24 Mar 2006 07:37:05 +0800
Message-ID: <44233121.3080407@gmail.com>
References: <20060322234812.GB2361@intevation.de> <44225DAD.8080004@t-online.de> <20060323125244.GB5579@intevation.de> <4422B753.5080704@t-online.de> <20060323160321.GB7464@intevation.de> <4422D390.4030500@t-online.de> <20060323183908.GA9907@intevation.de> <20060323185022.GA10089@intevation.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMZN0-0004hq-6z
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 15:37:34 -0800
Received: from xproxy.gmail.com ([66.249.82.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMZMz-0006pT-1h
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 15:37:34 -0800
Received: by xproxy.gmail.com with SMTP id t4so495784wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Mar 2006 15:37:32 -0800 (PST)
In-Reply-To: <20060323185022.GA10089@intevation.de>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: thomas@intevation.de

Thomas Arendsen Hein wrote:
> * Thomas Arendsen Hein <thomas@intevation.de> [20060323 19:40]:
>> I've found another problem with the new cyblafb under X which didn't
>> happen before: DPMS no longer turns of the monitor. At the time
>> where DPMS suspend kicked in before, now the xlock clock simply
>> stops updating, but is still visible (xlock -mode dclock).
> 
> ... and DPMS on the fb console still works fine.
> 
> Thomas
> 


Try adding 

printk("fb_blank: blank value %i\n", blank);

in drivers/video/fbmem.c:fb_blank(struct fb_info *info, int blank)

just before the call to info->fbops->fb_blank().

Try blanking your screen in X, look at dmesg and let us know what
is the blank value used by X.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
