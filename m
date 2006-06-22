From: Aurelien Jacobs <aurel@gnuage.org>
Subject: Re: [PATCH 1/1] New Framebuffer for Intel based
 Macs [try #2] (fwd)
Date: Thu, 22 Jun 2006 14:02:35 +0200
Message-ID: <20060622140235.90b7e534.aurel@gnuage.org>
References: <Pine.LNX.4.62.0606221038280.23155@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtNtU-0000Kn-Vi for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 05:02:45 -0700
Received: from smtp1-g19.free.fr ([212.27.42.27])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FtNtT-0000r9-Hi
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 05:02:44 -0700
Received: from marge.gnuage.org (gnuage.org [82.234.153.242])
	by smtp1-g19.free.fr (Postfix) with ESMTP id B885F9AA4E
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 22 Jun 2006 14:02:37 +0200 (CEST)
Received: from homer.gnuage.org ([192.168.1.2] helo=homer)
	by marge.gnuage.org with smtp (Exim 4.62)
	(envelope-from <aurel@gnuage.org>) id 1FtNry-0008Ay-EE
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 14:01:12 +0200
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

On Thu, 22 Jun 2006 10:38:43 +0200 (CEST)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> ---------- Forwarded message ----------
> Date: Wed, 21 Jun 2006 14:40:24 +0200
> From: Edgar Hucek <hostmaster@ed-soft.at>
> To: LKML <linux-kernel@vger.kernel.org>
> Subject: [PATCH 1/1] New Framebuffer for Intel based Macs [try #2]
> 
> This patch add a new framebuffer driver for the Intel Based macs.
> This framebuffer is needed when booting from EFI to get something
> out the box  ;)
>  
> +config FB_IMAC
> +	bool "Intel Based Macs FB"
> +	depends on (FB = y) && X86
> +	select FB_CFB_FILLRECT
> +	select FB_CFB_COPYAREA
> +	select FB_CFB_IMAGEBLIT
> +	help
> +	  This is the frame buffer device driver for the Inel Based Mac's
                                                        ^^^^^^
There is a typo here -----------------------------------/

Aurel

All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
