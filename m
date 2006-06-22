From: Dennis Munsie <dmunsie@cecropia.com>
Subject: Re: [PATCH 1/1] New Framebuffer for Intel based
	Macs [try #2] (fwd)
Date: Thu, 22 Jun 2006 07:24:03 -0400
Message-ID: <9D874D8E-7EF1-4C29-98F2-AEDFD78C6676@cecropia.com>
References: <Pine.LNX.4.62.0606221038280.23155@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtNI8-0005E7-HA for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 04:24:08 -0700
Received: from mail1.sea5.speakeasy.net ([69.17.117.3])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FtNI7-0001dg-82
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 04:24:08 -0700
In-Reply-To: <Pine.LNX.4.62.0606221038280.23155@pademelon.sonytel.be>
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
Cc: Edgar Hucek <hostmaster@ed-soft.at>

Why is a new framebuffer driver required in this case?  Why not use  
the intelfb driver for the mini and the MacBook and an ati driver for  
the iMac and the MacBook Pro?

i guess the only reason why someone might want to use is if the X1600  
in the MBP and the iMac isn't supported yet.

dennis

On Jun 22, 2006, at 4:38 AM, Geert Uytterhoeven wrote:

> ---------- Forwarded message ----------
> Date: Wed, 21 Jun 2006 14:40:24 +0200
> From: Edgar Hucek <hostmaster@ed-soft.at>
> To: LKML <linux-kernel@vger.kernel.org>
> Subject: [PATCH 1/1] New Framebuffer for Intel based Macs [try #2]
>
> This patch add a new framebuffer driver for the Intel Based macs.
> This framebuffer is needed when booting from EFI to get something
> out the box  ;)
> Removed unused and untested code in this version of the patch.

All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
