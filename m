From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Silicon Motion SM501 Voyager GX fb driver development
Date: Fri, 10 Dec 2004 04:01:57 +0800
Message-ID: <200412100401.57061.adaplas@hotpop.com>
References: <41B82C9D.7040105@anagramm.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CcUUU-0005RQ-Ir
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Dec 2004 12:02:18 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CcUUT-0008FO-SL
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Dec 2004 12:02:18 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id C5C78AAF009
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  9 Dec 2004 20:02:03 +0000 (UTC)
In-Reply-To: <41B82C9D.7040105@anagramm.de>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Clemens Koller <clemens.koller@anagramm.de>

On Thursday 09 December 2004 18:44, Clemens Koller wrote:
> Hello!
>
> Well, I am about to implement a fbdev for the Silicon Motion Inc.'s
> SM501 (alias Voyager GX) embedded graphics controller for our
> next projects. (http://www.siliconmotion.com/sm501.htm)
>
> The goal is to get a stable fb up and running on a current Kernel 2.6.x
> The Platform is currently a PowerMac G4 Windtunnel (CRUX PPC 2.0)
> and later on it will be a Freescale MPC8540 embedded processor.
> The SM501 hardware is the PCI Demo Board from SMI.
>
> I've started from the latest ix86 released driver from SMI and I
> got some basic functionality working. (There appears some (sometimes
> garbled) image on the panel, driver has memory leaks, as there are
> pci_resource and ioremap problems ...)
> So, the point is, I want to "fix" or better re-write the code
> from SMI to get an up-to-date driver for Kernel 2.6.
>
> My question is: Where is a good way to start to learn from
> already existing code? radeonfb or aty128fb or which driver
> is the most current and Kernel 2.6 aware driver.

Drivers that has somewhat busy changelogs are radeonfb and rivafb. atyfb
recently had a pretty massive rewrite.  savagefb is a driver that was recently
introduced in 2.6, so it probably does not have any leftovers from 2.4 code.
intelfb is also another one, just recently ported to 2.6.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
