From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: How to allocate large (>4MB) chunks of mem
Date: Mon, 10 Sep 2007 11:14:18 +0200
Message-ID: <20070910091418.GA17537@roarinelk.homelinux.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IUfLh-0007YD-8g for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 02:14:31 -0700
Received: from fnoeppeil48.netpark.at ([217.175.205.176]
	helo=roarinelk.homelinux.net)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IUfLd-0001HQ-59
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 02:14:26 -0700
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sf.net

Hello,

I'm currently trying to get a 1366x768 24/32bpp framebuffer working
with au1200fb.  The main problem is that the memory requirements are
quite high (4098 kBytes for a plane) and allocations never succeed.
(I can have 2 16bpp framebuffers, but no single 32bpp)
Systems have 128MB and 256MB RAM; au1200fb is built-in.

Is there an easy way to convince the allocator to give away that much
RAM?

Thanks,
	Manuel Lauss

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
