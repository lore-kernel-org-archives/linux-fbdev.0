From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/1] New Framebuffer for Intel based
 Macs [try #2] (fwd)
Date: Thu, 22 Jun 2006 19:32:44 +0800
Message-ID: <449A7FDC.2030304@gmail.com>
References: <Pine.LNX.4.62.0606221038280.23155@pademelon.sonytel.be>
	<9D874D8E-7EF1-4C29-98F2-AEDFD78C6676@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtNQc-00060b-4j for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 04:32:54 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FtNQa-00021x-SI
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 04:32:54 -0700
Received: by py-out-1112.google.com with SMTP id c31so306240pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 22 Jun 2006 04:32:51 -0700 (PDT)
In-Reply-To: <9D874D8E-7EF1-4C29-98F2-AEDFD78C6676@cecropia.com>
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
Cc: Dennis Munsie <dmunsie@cecropia.com>, Edgar Hucek <hostmaster@ed-soft.at>

Dennis Munsie wrote:
> Why is a new framebuffer driver required in this case? 

It is a platform driver, much like vga16fb and vesafb are for
x86. They are backup drivers.

> Why not use  
> the intelfb driver for the mini and the MacBook and an ati driver for  
> the iMac and the MacBook Pro?

The same reason that people use vesafb because the chipset-specific
driver either conflicts with X or does not work.

Tony

All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
