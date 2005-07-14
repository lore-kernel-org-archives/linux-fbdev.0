From: <evt@texelsoft.com>
Subject: Re: how does one _stop_ using fb
Date: Thu, 14 Jul 2005 15:45:18 -0400
Message-ID: <200507141945.DSL28073@ms3.netsolmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dt9e6-0005qi-IX
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Jul 2005 12:45:22 -0700
Received: from omr3.netsolmail.com ([216.168.230.164])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1Dt9e5-0005L8-7Y
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Jul 2005 12:45:22 -0700
Received: from ms3.netsolmail.com (IDENT:mirapoint@[216.168.230.176])
	by omr3.netsolmail.com (8.12.10/8.12.10) with ESMTP id j6EJjIgt029182
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 14 Jul 2005 15:45:18 -0400 (EDT)
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

James,

Thanks for your reply. Is the problem in fbcon or is it
something I could fix in my framebuffer driver?

- Eric van Tassell

---- Original message ----
>Date: Thu, 14 Jul 2005 20:19:07 +0100 (BST)
>From: James Simmons <jsimmons@infradead.org>  
>Subject: Re: [Linux-fbdev-devel] how does one _stop_ using fb  
>To: linux-fbdev-devel@lists.sourceforge.net
>
>
>You need a driver that supports going back to vga text mode.
Unfortunely 
>very few drivers support that. At present we can't go back.
>
>
>On Wed, 6 Jul 2005 evt@texelsoft.com wrote:
>
>> or IOW how does one undo con2fb and put the console back to
>> vga to unload a framebuffer module. Thanks.
>> 
>> - Eric van Tassell
>> 
>> 
>> -------------------------------------------------------
>> SF.Net email is sponsored by: Discover Easy Linux Migration
Strategies
>> from IBM. Find simple to follow Roadmaps, straightforward
articles,
>> informative Webcasts and more! Get everything you need to
get up to
>> speed, fast.
http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
>> _______________________________________________
>> Linux-fbdev-devel mailing list
>> Linux-fbdev-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>> 
>
>
>-------------------------------------------------------
>SF.Net email is sponsored by: Discover Easy Linux Migration
Strategies
>from IBM. Find simple to follow Roadmaps, straightforward
articles,
>informative Webcasts and more! Get everything you need to get
up to
>speed, fast.
http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
>_______________________________________________
>Linux-fbdev-devel mailing list
>Linux-fbdev-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
