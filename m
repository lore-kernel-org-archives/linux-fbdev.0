From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] GeForce 5200 on rivafb
Date: Sat, 11 Dec 2004 18:25:49 -0800
Message-ID: <7vd5xgmevm.fsf@assigned-by-dhcp.cox.net>
References: <200412120511.31725.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cdens-0006zv-0j
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Dec 2004 17:15:08 -0800
Received: from fed1rmmtao09.cox.net ([68.230.241.30])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cdenr-0000CO-CT
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Dec 2004 17:15:07 -0800
In-Reply-To: <200412120511.31725.adaplas@hotpop.com> (Antonino A. Daplas's
 message of "Sun, 12 Dec 2004 05:11:30 +0800")
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

>>>>> "AAD" == Antonino A Daplas <adaplas@hotpop.com> writes:

AAD> 1. Change this line in drivers/video/fbmon.c
>> 
AAD> #undef DEBUG
AAD> to 
AAD> #define DEBUG
>> 
>> Will do, but I have one question.  The last time I
>> tried
>> turning debugging on on rivafb-i2c it was very
>> unpleasant;

AAD> No :-), this is not for nvidiafb but for the EDID parser, and it will give
AAD> you a very descriptive parsing of the EDID block.

Will try.  Thanks.

AAD> So, with a broken EDID block, I guess your best workaround is to disable
AAD> i2c in your kernel config.

Again, thanks.

AAD> BTW:  Why can't you use the 'nv' driver with X? And does rivafb work with
AAD> your card?

The rivafb driver up to 2.6.7 or so used to give me framebuffer
console, and let me run X on fbdev, but more recent ones does
not seem to work.  I just get blank screen (even without EDID
detection via riva-i2c).  Around the timeframe when 2.6.3 or so
was current, XFree86 'nv' used to work without any kernel side
framebuffer device, but the more recent one from Debian
'testing' does not work anymore; I am suspecting this is a
problem with XFree86 not rivafb or nvidiafb framebuffer problem
so it may not be of interest to this list.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
