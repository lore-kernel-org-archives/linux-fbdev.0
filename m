From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Linux 2.6.16: Cursor trouble on Matrox Millenium
 II framebuffer
Date: Fri, 24 Mar 2006 08:22:38 +0800
Message-ID: <44233BCE.3040701@gmail.com>
References: <20060323231503.72390.qmail@web52906.mail.yahoo.com>	 <44232E72.5090203@gmail.com> <21d7e9970603231537l3074d8f9o1ffd9a168c996dd5@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMa5M-0001Ct-TK
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 16:23:24 -0800
Received: from pproxy.gmail.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMa5L-0006mf-Ku
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 16:23:24 -0800
Received: by pproxy.gmail.com with SMTP id z59so551869pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Mar 2006 16:23:21 -0800 (PST)
In-Reply-To: <21d7e9970603231537l3074d8f9o1ffd9a168c996dd5@mail.gmail.com>
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
Cc: Chris Rankin <rankincj@yahoo.com>, vandrove@vc.cvut.cz, Dave Airlie <airlied@gmail.com>

Dave Airlie wrote:
>>> loadkeys uk < /dev/console > /dev/console
>>>
>>> However, I need this line (don't I?).
>> Not saying you don't :-)  However, if this particular line is really causing the
>> cursor problem, you can workaround it by doing an stty cols <value> rows <value>
>> immediately after.
>>
>> In the meantime, and if you can confirm that kbd is indeed the cause, I'll try to
>> duplicate this and find the underlying  cause.
> 
> Just to let you know what I do, I boot up in text mode, ssh in and
> modprobe my fb driver then fbcon... I don't touch the console during
> that time.. if I vt switch and come back it works fine..
> 

Does the position of the cursor before loading fbcon make a difference?

Can you try positioning your cursor at the very top of the screen and
at the very bottom of the screen before loading fbcon? Does it make a difference?

Can you also post the window size before and after loading fbcon?  Just do an
stty -a before and after.

Tony  


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
