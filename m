From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] GeForce 5200 on rivafb
Date: Sat, 11 Dec 2004 04:43:29 +0800
Message-ID: <200412110443.29580.adaplas@hotpop.com>
References: <200412072347.23194.lucasvr@gobolinux.org> <200412082034.08852.adaplas@hotpop.com> <200412092346.19189.lucasvr@gobolinux.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CcrcA-0003Ez-2b
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Dec 2004 12:43:46 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Ccrc8-0003KH-7s
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Dec 2004 12:43:46 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 68BCB1284489
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Dec 2004 20:43:28 +0000 (UTC)
In-Reply-To: <200412092346.19189.lucasvr@gobolinux.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, Lucas Correia Villa Real <lucasvr@gobolinux.org>

On Friday 10 December 2004 09:46, Lucas Correia Villa Real wrote:
> On Wednesday 08 December 2004 10:34, Antonino A. Daplas wrote:
> > On Wednesday 08 December 2004 09:47, Lucas Correia Villa Real wrote:
> It worked perfectly fine here (after some adjusts on pci_ids.h):
>
> nvidiafb: nVidia device/chipset 10DE0322
> nvidiafb: nVidia Corporation NV34 [GeForce FX 5200]
> nvidiafb: CRTC0 found
> nvidiafb: CRTC1 not found
> nvidiafb: EDID found from BUS1
> nvidiafb: CRTC 0 appears to have a CRT attached
> nvidiafb: Using CRT on CRTC 0
> nvidiafb: MTRR set to ON
> Console: switching to colour frame buffer device 90x25
> nvidiafb: PCI nVidia NV32 framebuffer (128MB @ 0xF0000000)
>
> Just let me know if you want to test something special on this driver (I'm
> already subscribed to the mailing list) -- I volunteer to do that.
>

Just report any problems that you find, however inconsequential.  If you
have relatively old cards such as the TNT (NV5), or newer than NV30's, let
me know of the results.

I'm still waiting for feedback from other people.  Once we've ironed out
the major bugs, I'll let it simmer in Andrew's tree for a while, maybe for
at least 1-2 releases before pushing to mainline.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
