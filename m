From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/8] fbdev: Fix access to ROM in aty128fb
Date: Tue, 2 Nov 2004 09:31:55 -0500
Message-ID: <9e47339104110206315e87779e@mail.gmail.com>
References: <200411021946.09621.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1COzhW-0001ar-Fs
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 06:31:58 -0800
Received: from rproxy.gmail.com ([64.233.170.202])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1COzhV-0002a8-F0
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 06:31:58 -0800
Received: by rproxy.gmail.com with SMTP id 79so242714rnk
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 02 Nov 2004 06:31:56 -0800 (PST)
In-Reply-To: <200411021946.09621.adaplas@hotpop.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>

Have you looked at the new PCI API for ROM access in the -mm tree yet?
It is in the bk-pci patch and should be going into linus' tree sooner
or later. It will allow you to get rid of some common code in a lot of
the fbdev drivers.

pci_map_rom/pci_unmap_rom

It also tracks the boot video card. pci_map_rom for that card returns
a pointer to the shadow ROM copy at C0000. That let's you
transparently get to laptop ROMs that are stored compressed in the
system ROM.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
