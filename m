From: Andrew Morton <akpm@osdl.org>
Subject: Re: Patch for nvidia divide by zero error for
 7600 pci-express card
Date: Wed, 1 Nov 2006 21:17:31 -0800
Message-ID: <20061101211731.9d5db6ca.akpm@osdl.org>
References: <45313ECA.4070801@saville.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfUxS-0004iN-JI for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:17:42 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GfUxQ-0008Sc-Bl
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:17:42 -0800
In-Reply-To: <45313ECA.4070801@saville.com>
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

On Sat, 14 Oct 2006 12:47:22 -0700
Wink Saville <wink@saville.com> wrote:

> The following patch resolves the divide by zero error I encountered on my system:
> 
> 	http://marc.10east.com/?l=linux-fbdev-devel&m=116058257024413&w=2
> 
> I accomplished this by merging what I thought was appropriate from:
> 
> 	http://webcvs.freedesktop.org/xorg/driver/xf86-video-nv/src/

I added this to -mm, minus the drivers/serial/8250.c change, which
appears to have snuck in accidentally.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
