From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: Adding overlays
Date: Fri, 11 Feb 2005 05:14:45 -0800 (PST)
Message-ID: <20050211131445.69751.qmail@web53602.mail.yahoo.com>
References: <420CD452.3020901@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzadH-0001yV-UY
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Feb 2005 05:14:51 -0800
Received: from web53602.mail.yahoo.com ([206.190.37.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CzadH-0000AB-EW
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Feb 2005 05:14:51 -0800
In-Reply-To: <420CD452.3020901@comcast.net>
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

Zack,

> Have a look at my project FBUI:
>    home.comcast.net/~plinius/fbui.html

Surprise!!!. I had already kept my eye on this
project, from the date on which its description thread
was added on kerneltrap.

> 
> I had been thinking of adding overlay support.
> However I would need someone to create a
> hardware-overlay driver for my code to utilize.
> Maybe you could provide that?

Let me just go through the code and architecture
there. I will try to test it on OMAP board in this
weekend. 

Finally I am trying to prepare separate char driver
like mga_vid - to get overlay interface done. The
beauty I want to add there is let user pass virtual
address of frame and then drv will convert to physical
add, and they dma it to output device. Again there is
lots of physically contigous memory gets consumed for
this 2 overlay planes (i.e dma_alloc_coherent (...)).

I am also asking v4l2 and linux-omap-open-source guys
on better interface in such situations. Let us see,
what they reply.


=====
---Komal Shah

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
