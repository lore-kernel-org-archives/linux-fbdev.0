From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Rivafb won't work with DVI connector
Date: Fri, 26 Nov 2004 22:09:16 +0800
Message-ID: <200411262209.17558.adaplas@hotpop.com>
References: <200411250807.32040.adaplas@hotpop.com> <200411251527.15141.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXgn2-0007CP-BZ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Nov 2004 06:09:36 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CXgn0-00046s-2v
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Nov 2004 06:09:36 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id E589DA7BB21
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 26 Nov 2004 14:09:25 +0000 (UTC)
In-Reply-To: <200411251527.15141.andrew@walrond.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Walrond <andrew@walrond.org>

On Thursday 25 November 2004 23:27, Andrew Walrond wrote:
> On Thursday 25 Nov 2004 00:07, Antonino A. Daplas wrote:
> > That's assuming 0x31b is supported by your card.  Why not
> > try:
> >
> > vga=ask
> >
> > Choose 'scan', choose the highest size, and check if the panel
> > size changed again.
>
> vesafb 'scan' can only find 80xwhatever text modes with dvi connnection,
> and upto 132xwhatever text modes with dsub. It does not display any
> graphics modes at all, and rejects them if I try. (I also tried with vesafb
> only, nvidafb removed - same result).

You can also try this.  1600x1200 is not a standard VESA mode but is most
probably supported by your card as an OEM mode.  However, we do not know the
mode id of 1600x1200 since it's different from vendor to vendor.  

You can use X though to find out what modes are supported by your Video
BIOS.  

1. Boot with DVI attached
2. Change the X driver to 'vesa' (instead of probably 'nv')
3. Launch X
4. Check /var/log/XFree86.?.log
5. Find the mode id you want, add 0x200 and use it in your 'vga='
   boot line

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
