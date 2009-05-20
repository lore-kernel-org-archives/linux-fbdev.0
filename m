From: Harald Welte <HaraldWelte@viatech.com>
Subject: Re: [PATCH 2/2] viafb: use proper pci config	API
Date: Wed, 20 May 2009 09:43:58 +0800
Message-ID: <20090520014358.GX19746@prithivi.gnumonks.org>
References: <20090519083534.GI19746@prithivi.gnumonks.org>
	<20090519232427.ca64ac83.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <HaraldWelte@viatech.com>) id 1M6bXJ-0004Sz-Fa
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 02:28:05 +0000
Received: from ganesha.gnumonks.org ([213.95.27.120])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M6bXG-00026g-S7
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 02:28:04 +0000
Content-Disposition: inline
In-Reply-To: <20090519232427.ca64ac83.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: JosephChan@via.com.tw, ScottFang@viatech.com.cn, linux-fbdev-devel@lists.sourceforge.net

On Tue, May 19, 2009 at 11:24:27PM +0200, Krzysztof Helt wrote:
> On Tue, 19 May 2009 16:35:34 +0800
> Harald Welte <HaraldWelte@viatech.com> wrote:
> 
> > This patch alters viafb to use the proper Linux in-kernel API to access
> > PCI configuration space, rather than poking at I/O ports by itself.
> > 
> > It also removes a minor inconsistency with naming of constants for the
> > PCI device ID of the FUNCTION3 devices.
> > 
> > Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
>
> Can  you pass the pdev pointer from the probe function
> here and skip the whole searching of the PCI device?

No.  The FUNCTION3 device that we're searching is the SDRAM controller
function integrated in the north bridge, not the integrated graphics.

Only the PCI config space of the SDRAM controller contains the information
about the size of the graphics memory.

I was thinking of a 1:1 mapping between <pci device id for the graphics> : <pci
device id for FUNCTION3>, but I'm not entirely sure if this is always correct
or if there is some hardware that has the ID of one SDRAM controller and a
different integrated graphics chipet, especially in legacy products.

So for that reason I decided not to change the logic for searching the
FUNCTION3, merely altering the pci config space access function.

Regards,
-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Open Source Liaison

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
