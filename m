From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [Sm5xx-devel]  SM501 framebuffer driver
Date: Mon, 16 Oct 2006 14:28:27 -0500
Message-ID: <4533DD5B.4020804@billgatliff.com>
References: <45268042.8050207@billgatliff.com> <452691A2.2020209@anagramm.de>
	<20061013121138.GA21744@linux-sh.org>
	<45327124.6040301@billgatliff.com>
	<20061016030154.GA6301@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZY7m-0006zh-QO for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Oct 2006 12:27:47 -0700
Received: from smtp2.mtco.com ([207.179.226.205])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GZY7l-0001li-2p
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Oct 2006 12:27:46 -0700
In-Reply-To: <20061016030154.GA6301@linux-sh.org>
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
To: Paul Mundt <lethal@linux-sh.org>
Cc: Robert Whaley <rwhaley@applieddata.net>, sm5xx-devel@lists.berlios.de, linux-fbdev-devel@lists.sourceforge.net

Paul:

Paul Mundt wrote:

>Hi Bill, fancy seeing you in this thread ;-)
>  
>

Heh, you need to talk to the guy at the door.  He'll let anyone in, I'm 
proof!  :)

>We want the 8051 blob in userspace if anything, there's little reason to
>tie this in to the module specifically, and it's handy to expose the
>interface for people that are specifically interested in loading in
>alternate code on the 8051.
>
>As far as including source for the 8051 code itself, that would be nice
>to have, but I doubt it's something the majority of users are going to
>care about. I've certainly never seen any.
>  
>

I totally agree on all points.  But I hate blobs.  If the source code is 
around, I'd love to have it recorded somewhere even though we all know 
that Kbuild and most users won't know what to do with it.  Just In Case.

Do we even know where this blob came from originally?

>On that note, do you have a pointer to some of the various ALSA
>implementations that are floating around? I've only seen the OSS driver
>we had in CVS, and that provides a rather dysmal starting point..
>  
>

Whaley sent me one just last week (hi Robert!).  Given that, I don't 
suppose he'd mind my forwarding the patch on.  What makes it tricky to 
do so is that the patch is against his highly-evolved sm501 driver 
stack, so there will be some mending required.

Yet another reason why we've all got to get all this stuff together.  
The SM501 is a decent chip, and there's too few of us to go around 
re-inventing the wheel.



b.g.

-- 
Bill Gatliff
bgat@billgatliff.com


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
