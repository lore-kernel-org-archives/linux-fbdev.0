From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Rivafb won't work with DVI connector
Date: Mon, 22 Nov 2004 09:43:57 +0000
Message-ID: <200411220943.57077.andrew@walrond.org>
References: <200411191137.14649.andrew@walrond.org> <200411220807.23572.adaplas@hotpop.com> <200411220923.05415.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWAjo-0006S6-0v
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Nov 2004 01:44:00 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CWAjm-0005yJ-Ni
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Nov 2004 01:43:59 -0800
In-Reply-To: <200411220923.05415.andrew@walrond.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@pol.net

On Monday 22 Nov 2004 09:23, Andrew Walrond wrote:
>
> I'll try to boot on dvi without and module parameters and report back
> shortly.
>

Ok, some progress. Booting without any module parameters on dvi connector gets 
me what is probably a 1024x768 display on my 1600x1200 tft screen. However, 
the console text is shifted right a bit less than half a screen width such 
that the right hand of the display appears wrapped on the left. There also 
seem to be two cursors, seperated by about two character widths. (Note these 
are not artifacts of the screen, which handles 1024x768 just fine under 
normal circumstances, either with a large border, or scaled to fit the whole 
screen)

Dmesg:

 nvidiafb: nVidia device/chipset 10DE0250
 nvidiafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
   ...can't find one
   ...can't find one
 nvidiafb: CRTC 1 is currently programmed for DFP
 nvidiafb: Using DFP on CRTC 1
 Panel size is 1024 x 768
 nvidiafb: MTRR set to ON
 Console: switching to colour frame buffer device 80x30
 nvidiafb: PCI nVidia NV25 framebuffer (128MB @ 0xE0000000)

But hell, at least I am seeing some stuff through the dvi !

Anything I can do, let me know.

Andrew


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
