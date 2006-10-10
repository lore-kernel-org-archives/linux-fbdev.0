From: Andrey Volkov <avolkov@varma-el.com>
Subject: Re: SM501 framebuffer driver
Date: Tue, 10 Oct 2006 10:01:01 +0400
Message-ID: <452B371D.90400@varma-el.com>
References: <45268042.8050207@billgatliff.com>
	<20061006162644.GA15499@home.fluff.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GXAfy-0007jz-Cf for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Oct 2006 23:01:14 -0700
Received: from amanaus.varma-el.com ([195.144.240.154])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GXAfw-0002TT-T8
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Oct 2006 23:01:14 -0700
In-Reply-To: <20061006162644.GA15499@home.fluff.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Robert Whaley <rwhaley@applieddata.net>

Ben Dooks wrote:
> On Fri, Oct 06, 2006 at 11:11:46AM -0500, Bill Gatliff wrote:
>> Guys:
>>
>>
>> Sorry about starting a new thread, but I was referred to this 
>> list/thread by a colleague just a few minutes ago.  (OT: it isn't in the 
>> archives in SF, either!).
>>
>> I hate to play "me too!", but I also have an SM501 framebuffer driver in 
>> a partial state of development.  I'd love to collaborate with others to 
>> get a good version pushed upstream.
>>
>> One of the challenges I've encountered with this chip is dealing with 
>> all the "other stuff" it has onboard.  In my driver, I addressed that by 
>> creating a whole new bus similar to what Nico did for the UCB1400.  I 
>> was in the process of getting AC97 working when I figured out that that 
>> part of the chip is so braindead, it isn't worth using--- at least on 
>> ARM platforms that don't have DMA (which was my case).
>>
>> In an upcoming project I need to use the USBH, so I'll be revisiting 
>> this issue again soon.  I have also cc'd others who have worked with me 
>> on this chip.
>>
>> I'd be happy to post code if that makes sense.  Or to host a CVS repo or 
>> something.
> 
> We have a solution based on an central device in drivers/mfd
> which creates a set of sub-devices that are used by the invidicual
> drivers
> 

We too ;), and use on our board: http://www.varma-el.com/en/prod?cls=sbc

Anyone have objections about berlios.de SVN for a sm501 staff?

Andrey

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
