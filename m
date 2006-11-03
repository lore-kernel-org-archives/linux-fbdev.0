From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc4-mm2
Date: Fri, 3 Nov 2006 13:51:51 -0800
Message-ID: <20061103135151.60762144.akpm@osdl.org>
References: <20061101235407.a92f94a5.akpm@osdl.org>
	<200611031642.36558.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gg6xK-0003Yn-05 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 03 Nov 2006 13:52:06 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1Gg6xJ-0001bS-EC
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 03 Nov 2006 13:52:05 -0800
In-Reply-To: <200611031642.36558.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
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
To: andrew.j.wade@gmail.com
Cc: Kimball Murray <kimball.murray@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Charlotte Richardson <charlotte.richardson@stratus.com>

On Fri, 3 Nov 2006 16:42:33 -0500
Andrew James Wade <andrew.j.wade@gmail.com> wrote:

> On Thursday 02 November 2006 02:54, Andrew Morton wrote:
> > - Lots of fbdev updates.  We haven't heard from Tony in several months, so I
> >   went on a linux-fbdev-devel fishing expedition.
> 
> radeonfb-support-24bpp-32bpp-minus-alpha.patch broke my video: my
> screen ended up garbled. (vc1 was ok, strangely enough). Reverting
> fixed things. 
> 
> lspci -v:
> 
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500] (prog-if 00 [VGA])
>         Subsystem: ATI Technologies Inc Radeon 7500
>         Flags: bus master, stepping, 66MHz, medium devsel, latency 64, IRQ 16
>         Memory at d8000000 (32-bit, prefetchable) [size=128M]
>         I/O ports at d800 [size=256]
>         Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
>         Expansion ROM at d7fe0000 [disabled] [size=128K]
>         Capabilities: <available only to root>
> 

Great, thanks for working that out.  I'll drop the patch.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
