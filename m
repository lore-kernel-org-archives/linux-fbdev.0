From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: SM501 framebuffer driver
Date: Fri, 06 Oct 2006 14:19:42 -0500
Message-ID: <4526AC4E.7090003@billgatliff.com>
References: <45268042.8050207@billgatliff.com>
	<20061006162644.GA15499@home.fluff.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVvEM-0004m1-6k for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Oct 2006 12:19:34 -0700
Received: from smtp2.mtco.com ([207.179.226.205])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GVvEJ-0001E2-SP
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Oct 2006 12:19:34 -0700
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

>On Fri, Oct 06, 2006 at 11:11:46AM -0500, Bill Gatliff wrote:
>
>We have a solution based on an central device in drivers/mfd
>which creates a set of sub-devices that are used by the invidicual
>drivers
>  
>

Yes, I've seen your code. My SM501 code does something very similar. I 
don't know if there's any opportunity for reuse or to create a 
"standard", given that the SM501 is all over the place functionality 
(USB, AC97, framebuffer, UART, ...)-wise and bus (PCI, MMIO)-wise. But 
the general idea of your approach is definitely the right way to go.


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
