From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Rivafb won't work with DVI connector
Date: Mon, 22 Nov 2004 23:54:39 +0000
Message-ID: <200411222354.39187.andrew@walrond.org>
References: <200411191137.14649.andrew@walrond.org> <200411230613.02227.adaplas@hotpop.com> <200411222347.17562.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWO1K-0002sC-R1
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Nov 2004 15:54:58 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CWO17-0007Q4-GN
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Nov 2004 15:54:58 -0800
In-Reply-To: <200411222347.17562.andrew@walrond.org>
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
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>

On Monday 22 Nov 2004 23:47, Andrew Walrond wrote:
>
> I'll try the dsub connection next.
>

Booting with dsub connection and video=1600x1200-32@60 works perfectly.

 nvidiafb: nVidia device/chipset 10DE0250
 nvidiafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
 nvidiafb: CRTC0 not found
 nvidiafb: CRTC1 found
 nvidiafb: CRTC 0appears to have a CRT attached
 nvidiafb: Using CRT on CRTC 0
 nvidiafb: MTRR set to ON
 Console: switching to colour frame buffer device 200x75
 nvidiafb: PCI nVidia NV25 framebuffer (128MB @ 0xE0000000)

Andrew


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
