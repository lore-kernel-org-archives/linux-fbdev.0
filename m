From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Geode now shows up in sysfs.
Date: Thu, 7 Jul 2005 20:55:50 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0507072055200.13219@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0507020032330.14405@pentafluge.infradead.org>
 <42C90AEF.4030601@arcom.com> <Pine.LNX.4.56.0507062331170.6528@pentafluge.infradead.org>
 <42CD53AB.7040207@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DqcTd-00076k-Gg
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 07 Jul 2005 12:56:05 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2-new.sourceforge.net with esmtp (Exim 4.44)
	id 1DqcTb-0006IT-D5
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 07 Jul 2005 12:56:05 -0700
In-Reply-To: <42CD53AB.7040207@arcom.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Vrabel <dvrabel@arcom.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@hotpop.com>, Geert Uytterhoeven <geert@linux-m68k.org>, nat.ersoz@myrio.com, jsimmons@pentafluge.infradead.org


What would the pci device part be classifed as then?

On Thu, 7 Jul 2005, David Vrabel wrote:

> James Simmons wrote:
> > It is a pci device. I will send another patch to convert it to a pci 
> > device.
> 
> I think it should remain as a platform device because the principle
> device involved (the display controller which does all the framebuffer
> stuff) is not a PCI device.
> 
> David Vrabel
> -- 
> David Vrabel, Design Engineer
> 
> Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
> Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
> 


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
