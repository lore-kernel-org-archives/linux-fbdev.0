From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: nvidiafb, monitor A & B and CRTC 0 & 1
Date: Sat, 31 Mar 2007 17:48:36 -0700
Message-ID: <460F0164.9080600@vc.cvut.cz>
References: <460672C1.3080303@vc.cvut.cz> <1175341893.4420.1.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXoFO-000564-Mt for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 31 Mar 2007 17:48:42 -0700
Received: from mailgw.cvut.cz ([147.32.3.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HXoFN-0007Za-BJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 31 Mar 2007 17:48:42 -0700
In-Reply-To: <1175341893.4420.1.camel@daplas>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas wrote:
> On Sun, 2007-03-25 at 06:01 -0700, Petr Vandrovec wrote:
>> Hello,
>>    how much are you sure that monitor A i2c should use ddc_base 0x3E, 
>> and monitor B base 0x36 ?
> 
> This was chosen arbitrarily, hoping that the code will sort out which is
> which.  If reversing the ports worked for you, I will not disagree with
> the patch.

Yes.  Without patch two analogs work fine (well, in that case nvidiafb 
does not care about maximum resolution), as well as analog+digital or 
digital+analog.  Only configuration which does not work correctly are 
two digital monitors.  With patch all four configurations work correctly 
on my hardware.  I do not have access to any other dual-dvi nvidia card, 
so I cannot tell whether BFGTech screwed up or whether there is some 
other problem.  Windows detect which display is first and which second 
correctly...
								Petr



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
