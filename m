From: John Zielinski <grim@undead.cc>
Subject: Re: fbdev upstream
Date: Wed, 24 Dec 2003 20:53:15 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FEA430B.603@undead.cc>
References: <3FD6C52C.7090906@undead.cc>  <3FDBB97F.4070207@undead.cc>	 <1072254049.739.61.camel@gaston>  <3FE9F9C3.20605@undead.cc>	 <1072305777.15461.13.camel@gaston>  <3FEA3327.6050507@undead.cc> <1072313855.15477.26.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZKgu-0005xe-GU
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 17:53:32 -0800
Received: from mail.undead.cc ([216.126.84.18])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AZKgt-0000c1-VD
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 17:53:32 -0800
In-Reply-To: <1072313855.15477.26.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt wrote:

>Moving that to userland is a 2.7 goal. For 2.6, we should probably
>stay around what I'm doing in radeonfb. Also, we want the machine to
>have some sort of working console at boot. The VGA console exist
>only on some platforms like x86, for example, PPC needs a working mode
>at boot time.
>  
>

That's why it's the ultimate goal.  ;-)    I'll still be working on it 
for this project I have but I'll keep it seperate until it's time to 
work on 2.7 stuff.  I keep all my patches in small pieces so I can pick 
an chose which ones I want to work with at the moment.  As for the 
working mode at boot time, that's not a problem.  The initramfs archive 
is unpacked extrememly early in the boot process.  The message for that 
apears way before the fbdev or fbcon messages come up.  Many HDTV's 
don't sync to standard VGA signals so i need the proper mode up as soon 
as possible as well.  The only problem is that a couple of models don't 
supply the correct DDC timings and the picture rolls.  That's why I'd 
like to have the database available that early and to not require a 
kernel recompile to change it.  But this is 2.7 stuff.

>Also, some drivers may have different monitor probing mecanism that
>DDC2/EDID. For example, old PowerMac drivers can probe the monitor
>type using an old Apple sepcific mecanism that leads to a modelist
>(macmodes) which is different. We currently don't deal with that
>very well though.
>  
>
Then a standard generic way to retrieve this information from the fbdev 
might be an idea.   At the very least you should get the bare modelist 
but if the other info is available (manufacturer, model number, serial 
number, raw edid data) then that can be returned as well.   Again this 
is 2.7 material.

>The important point here is that fbdev must remain independant of fbcon,
>you can have fbdev without fbcon, all of the console cruft is not
>fbdev business.
>
>  
>

That's why I'm putting a lot of my stuff into fbcon as it's console 
related.   Is X the only other system to use fbdev other than fbcon?

John




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
