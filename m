From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fw: Re: disabling VESAFB no longer locks up VT (was Re: 2.4.10-r1 MTRR bug)
Date: Sat, 15 Jan 2005 20:33:31 +0800
Message-ID: <200501152024.58452.adaplas@hotpop.com>
References: <20050114170445.0d02ae91.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cpn8o-0005IW-91
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 15 Jan 2005 04:34:54 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cpn8m-0006mj-Mo
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 15 Jan 2005 04:34:54 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 5258C134693A
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 15 Jan 2005 12:34:45 +0000 (UTC)
In-Reply-To: <20050114170445.0d02ae91.akpm@osdl.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Cc: s.egbert@sbcglobal.net

On Saturday 15 January 2005 09:04, Andrew Morton wrote:
> Are you folks aware of this lkml thread??
>
> Thanks.

His lspci shows:

0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
661/741/760 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
        Subsystem: Elitegroup Computer Systems: Unknown device 1b13
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        BIST result: 00
        Region 0: Memory at d8000000 (32-bit, prefetchable) 
        Region 1: Memory at e5000000 (32-bit, non-prefetchable) [size=128K]

Does this look strange?  Usually each resource shows both the start address
and resource size. Region 0 does not show the resource size. This is probably
confusing vesafb.

Also, his /proc/iomem shows
...
f000ef6f-f100ef6e : vesafb
...

Besides it not matching the lspci output, the start address is not 4K aligned.

You can try this (no guarantees), tell vesafb the actual amount of RAM the
card has (assuming standard kernel vesafb): 

video=vesafb:vtotal:N

where N = the total amount of Video RAM in MiB

Tony




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
