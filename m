From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 0/7] Bunch of patches
Date: Tue, 23 Mar 2004 18:57:16 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403231856330.3630-100000@phoenix.infradead.org>
References: <200403212033.39808.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B5r5W-0005YT-QL
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Mar 2004 10:57:22 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B5r5U-0003OW-Nj
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Mar 2004 10:57:21 -0800
In-Reply-To: <200403212033.39808.alex.kern@gmx.de>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="utf-8"
To: Alexander Kern <alex.kern@gmx.de>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>



I had no luck with any of the patches. They all bombed out for me. Can you 
create a patch against the mach64.diff.gz I have. 

On Sun, 21 Mar 2004, Alexander Kern wrote:

> Hello,
> 
> here a seven patches for mach64 fbdev driver.
> 
> 01_mach64-add.diff
> 	simple additions, once already send to James
> 
> 02_mach64-aux.diff
> 	patch based on patch from Ville Syrjälä, use aperture for register access
> 
> 03_mach64-chipset2.diff
> 	reorganize table of chipsets
> 
> 04_mach64-bios.diff
> 	let read frequence limits from BIOS
> 
> 05_mach64-revers-hwtriple.diff
> 	reverse logic for hardware triple
> 
> 06_mach64-laterinit.diff
> 	correct init from BIOS
> 
> 07_mach64-aux_correct.diff
> 	free regions, registered for aperture
> 
> Summary of patches tested on ARMADA E500 1400x1050
> 
> Regards Alex
> 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
