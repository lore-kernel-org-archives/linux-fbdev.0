From: Jay Cotton <Jay.Cotton@Sun.COM>
Subject: Re: ATI Rage XL with no BIOS support
Date: Tue, 21 Feb 2006 12:45:38 -0800
Message-ID: <43FB7BF2.6020506@Sun.COM>
References: <dc70db7d0602211329j71a441edg5778e91e012d1299@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FBfLD-0006mf-Dg
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Feb 2006 13:46:39 -0800
Received: from brmea-mail-1.sun.com ([192.18.98.31])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FBfLC-0001pU-6v
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Feb 2006 13:46:39 -0800
Received: from phys-d3-ha21sca-2 ([129.145.155.165])
	by brmea-mail-1.sun.com (8.12.10/8.12.9) with ESMTP id k1LLkaSD000206
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 21 Feb 2006 14:46:36 -0700 (MST)
Received: from conversion-daemon.ha21sca-mail1.sfbay.sun.com by
 ha21sca-mail1.sfbay.sun.com
 (iPlanet Messaging Server 5.2 HotFix 1.24 (built Dec 19 2003))
 id <0IV2001014F0IE@ha21sca-mail1.sfbay.sun.com>
 (original mail from Jay.Cotton@Sun.COM)
 for linux-fbdev-devel@lists.sourceforge.net; Tue,
 21 Feb 2006 13:47:31 -0800 (PST)
Received: from [129.146.108.51] (overthere.SFBay.Sun.COM [129.146.108.51])
 by ha21sca-mail1.sfbay.sun.com
 (iPlanet Messaging Server 5.2 HotFix 1.24 (built Dec 19 2003))
 with ESMTP id <0IV200DSR4J79Z@ha21sca-mail1.sfbay.sun.com> for
 linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Feb 2006 13:47:31 -0800 (PST)
In-reply-to: <dc70db7d0602211329j71a441edg5778e91e012d1299@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Basically you are screwed.

There is a way to fix this, but the code is closed source and ATI will not
allow it out of there control.  So, unless you can read the bios prom
into memory and execute the first 1024 bytes in 16bit mode, you will not
be able to recover.

sorry

JC

Alan Carvalho wrote:
> Hi all,
> I want use ATI Rage XL on an embedded hardware, I see Linux kernel 2.6.x 
> has support to initialize this board although Geert Uytterhoeven say me 
> it will be removed from Linux kernel because it don't work or is broken.
> 
> Anyway I am using kernel 2.6.12, it have support initialize Rage XL. I 
> do some tests, but it don't work, kernel crash (it just stop) at 
> "aty_st_pll_ct(VCLK0_FB_DIV, 0xDA, par)", I think it is because my board 
> parameters is incorrect.
> 
> I want know how to found all parameter to struct xl_card_cfg_t 
> (xlinit.c) to make my board work?
> 
> static const struct xl_card_cfg_t {
>         int ref_crystal; // 10^4 Hz
>         int mem_type;
>         int mem_size;
>         u32 mem_cntl;
>         u32 ext_mem_cntl;
>         u32 mem_addr_config;
>         u32 bus_cntl;
>         u32 dac_cntl;
>         u32 hw_debug;
>         u32 custom_macro_cntl;
>         u8  dll2_cntl;
>         u8  pll_yclk_cntl;
> }
> 
> This is my board:
> Vendor: 1002
> Device: 4752
> 0000:01:01.0 VGA compatible controller: ATI Technologies Inc Rage XL 
> (rev 27) (prog-if 00 [VGA])
>         Subsystem: ATI Technologies Inc Rage XL
>         Flags: bus master, stepping, medium devsel, latency 32, IRQ 9
>         Memory at f0000000 (32-bit, non-prefetchable) [size=16M]
>         I/O ports at a000 [size=256]
>         Memory at f2000000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [5c] Power Management version 2
> 
> Thank you very much,
> 
> Alan
> 
> 
> 


-- 
	 Jay Cotton 		     Jay.Cotton@sun.com
	 MPK17-2348    x80841
	 Sun Microsystems Inc. - X11 Server Group
	 Operating Platform Group




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
