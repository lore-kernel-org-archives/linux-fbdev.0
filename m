From: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: w100 fb driver
Date: Thu, 25 Nov 2004 15:19:42 -0000
Message-ID: <032501c4d302$3970ddf0$0f01a8c0@max>
References: <021601c4ce58$1111a730$0f01a8c0@max> <200411200610.08802.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXLPm-00081V-Va
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Nov 2004 07:20:10 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CXLPl-0006gq-M4
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Nov 2004 07:20:10 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@hotpop.com

Antonino A. Daplas:
[re: inclusion of the w100 driver in the kernel]
> Should be okay, just wondering why not use the kernel i2c algo's instead
> of using your own.

The kernel's i2c algo's require two way communication and expect the data to
be ack'ed. In this case, we have no way to read the data back from the spp
interface so we can't implement all the functions the kernel interface would
need.

> Submit patch inline to this list and CC me.  Preferrably break the patch
> down into several, hopefully standalone patches.  Add a changelog, and a
> signed-off line.

That sounds fine. I've taken your comments (and those made by Geert 
Uytterhoeven) onboard and revised the driver. For various reasons, I've 
moved the driver over the to new device structure which allows me to pass a 
structure with some hardware specific details to the driver. This means I 
need to include the header file elsewhere in the kernel. Should/can I move 
that file to drivers/video in whole or in part (or do something else)?

An updated version of the driver is at:

http://www.rpsys.net/openzaurus/arm/w100-r1.patch

(its using two header files until I know which approach is preferred)

Thanks,

Richard 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
