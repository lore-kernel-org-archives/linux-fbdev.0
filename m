From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: SM501 framebuffer driver
Date: Sun, 15 Oct 2006 12:34:28 -0500
Message-ID: <45327124.6040301@billgatliff.com>
References: <45268042.8050207@billgatliff.com> <452691A2.2020209@anagramm.de>
	<20061013121138.GA21744@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZ9t3-0008Q3-OU for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Oct 2006 10:34:57 -0700
Received: from s-utl01-sjpop.stsn.net ([72.254.0.201])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GZ9t3-0007ak-I7
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Oct 2006 10:34:57 -0700
In-Reply-To: <20061013121138.GA21744@linux-sh.org>
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
Cc: Robert Whaley <rwhaley@applieddata.net>, sm5xx-devel@lists.berlios.de

Paul Mundt wrote:
>
> We also have an OSS driver for SM501, but it contains a lot of 8051
> microcode that needs to be shoved in to userspace, and it needs to be
> reworked for ALSA.
>   


Hi Paul!  Long time no chat!  :)


One thing that concerns me about all of the ALSA implementations I've
seen so far is that the source code for the 8051 side is never
included.  GPL questions aside, for legacy reasons alone we've got to
make sure that stuff gets in too.

But then again, there's the question of where the source code is at all,
and what toolsystem you use to produce the binary image...




b.g.

-- 
Bill Gatliff
bgat@billgatliff.com





-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
