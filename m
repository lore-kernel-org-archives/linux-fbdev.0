From: David Vrabel <dvrabel@arcom.com>
Subject: Re: [patch] framebuffer Kconfig -- add option
 for building cfb*.o (0/2)
Date: Mon, 14 Feb 2005 13:50:18 +0000
Message-ID: <4210AC9A.9080707@arcom.com>
References: <421096C6.3030105@arcom.com> <Pine.GSO.4.61.0502141322060.16209@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0gcQ-0000Mz-0X
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 05:50:30 -0800
Received: from webapps.arcom.com ([194.200.159.168])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D0gcN-0005eA-HX
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 05:50:29 -0800
In-Reply-To: <Pine.GSO.4.61.0502141322060.16209@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel list <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:
> On Mon, 14 Feb 2005, David Vrabel wrote:
> 
>>This set of two patches add a new option (FB_SOFTWARE_CFB_OPS) to the
>>framebuffer Kconfig to enable building the generic software cfbfillrect,
>>cfbcopyarea and cfbimageblt objects.  This cuts out a lot of stuff from
>>the Makefile and allows drivers in their own directory to be more
>>self-contained.
> 
> But I'd prefer to have 3 separate options, since some drivers don't need all 3
> of them, e.g.:
>   - CONFIG_CFB_FILLRECT
>   - CONFIG_CFB_COPYAREA
>   - CONFIG_CFB_IMAGEBLT

Sure.  Here's a new set of two patches.

1/2 -- add FB_CFB_xxx options to framebuffer Kconfig and Makefile
2/2 -- make all framebuffer drivers (where appropriate) select FB_CFB_xxx

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
