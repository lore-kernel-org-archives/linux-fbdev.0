From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Bug on atyfb
Date: Sat, 11 Dec 2004 05:19:19 +0800
Message-ID: <200412110519.19633.adaplas@hotpop.com>
References: <200412101844.10577.lucasvr@gobolinux.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CcsAn-000738-L8
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Dec 2004 13:19:33 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CcsAm-0000vt-PQ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Dec 2004 13:19:33 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id A21EEA81F7F
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Dec 2004 21:19:19 +0000 (UTC)
In-Reply-To: <200412101844.10577.lucasvr@gobolinux.org>
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

On Saturday 11 December 2004 04:44, Lucas Correia Villa Real wrote:
> Hi,
>
> I'm trying to use atyfb on 2.6.10-rc3, but I'm getting a kernel oops just
> at modprobe time. By tracking the problem, it seems that 'pll_limits.xclk'
> is the heart of the problem, as seen in line 2210 from atyfb_base.c:
>
> par->xclk_per = 1000000/par->pll_limits.xclk;
>
> It happens that pll_limits.xclk is zero, because of an attribution made on
> line 3246:
>
> par->pll_limits.xclk = pll_block.XCLK_max_freq/100;
>
> pll_block.XCLK_max_freq, in this case, is read from BIOS a few lines above
> (at line 3229, to be more precise), and the value being returned from this
> copy here is 20. So we have a problem, since the result from 20/100 = 0
> will be used as denominator to set par->xclk_per's value.

Buggy BIOS?  Why not skip the init_from_bios() step, since xclk will be
initialized in the function correct_chipset(), just a few lines above?

If that works, perhaps a boot option can be added such as no_bios?

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
