From: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: FB_EVENT (blank and unblank?)
Date: Sat, 27 Nov 2004 23:59:12 -0000
Message-ID: <027d01c4d4dd$19fe65a0$0f01a8c0@max>
References: <41A36DA5.8090200@fujitsu-siemens.com> <Pine.GSO.4.61.0411261010460.26681@waterleaf.sonytel.be> <010501c4d490$e9edee40$0f01a8c0@max> <200411280643.14171.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CYCTJ-0006zi-Vn
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 Nov 2004 15:59:21 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CYCTE-0002Wr-9b
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 Nov 2004 15:59:21 -0800
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
Content-Type: text/plain; format="flowed"; charset="us-ascii"; reply-type="original"
To: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas:
> On Saturday 27 November 2004 22:53, Richard Purdie wrote:
>> I have two places where they need to talk. The first is for the touch
>> screen to query the x resolution (and to know if the screen is 
>> blanked)[1].
>> The second is to turn the backlight off when the console is blanked.
>
> Can you adopt the backlight support infrastructure in powermacs?  See
> arch/ppc/platforms/pmac_backlight.c  Currently, it's PPC-specific, but it
> can be extended to other platforms.  A few drivers use this, rivafb is one 
> of
> them (drivers/video/fbdev.c), and aty.

There are two issues here and this addresses the wrong one.

My Issue: I have a backlight driver that shares no code with the framebuffer 
driver - the hardware is totally separate. I have there written them as two 
spate drivers which seems to make sense. The problem is that there is no 
method to communicate blanking to the external backlight driver (which is 
all it needs to know about). Obviously I can add links between them but I 
feel that's ugly. Adding a couple of extra events to the fb_register_client 
system would be much neater.

The Other Issue: There is no common method to access and control backlight 
levels within the kernel. My feeling on this is that they should appear in 
sysfs as their own class. I need to look into this as I know there has been 
discussion in the past and I don't know what the issues are. I'd welcome any 
comments on this though.

-- 
Richard



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
