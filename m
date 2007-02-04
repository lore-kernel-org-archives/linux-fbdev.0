From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb: Can't use the dvi port
Date: Mon, 05 Feb 2007 08:32:13 +1100
Message-ID: <1170624733.2620.41.camel@localhost.localdomain>
References: <20070204161521.GA9623@frodo.home.lxtec.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HDoy6-0003KR-K1 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 04 Feb 2007 13:32:16 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX18vVhs9KRl84EecbyQzwNsQsc554Hlfs8I=])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HDoy4-0001hW-2y
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 04 Feb 2007 13:32:14 -0800
In-Reply-To: <20070204161521.GA9623@frodo.home.lxtec.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> I`ve compiled raeonfb debug in the kernel:
> Dec 26 14:52:05 frodo kernel: hStart = 1664, hEnd = 1856, hTotal = 2160
> Dec 26 14:52:05 frodo kernel: vStart = 1201, vEnd = 1204, vTotal = 1250
> Dec 26 14:52:05 frodo kernel: h_total_disp = 0xc7010d hsync_strt_wid = 0x18067a
> Dec 26 14:52:05 frodo kernel: v_total_disp = 0x4af04e1 vsync_strt_wid = 0x304b0
> Dec 26 14:52:05 frodo kernel: pixclock = 6172
> Dec 26 14:52:05 frodo kernel: freq = 16202
> Dec 26 14:52:05 frodo kernel: freq = 16202, PLL min = 20000, PLL max = 40000
> Dec 26 14:52:05 frodo kernel: ref_div = 12, ref_clk = 2700, output_freq = 32404
> Dec 26 14:52:05 frodo kernel: ref_div = 12, ref_clk = 2700, output_freq = 32404
> Dec 26 14:52:05 frodo kernel: post div = 0x1
> Dec 26 14:52:05 frodo kernel: fb_div = 0x90
> Dec 26 14:52:05 frodo kernel: ppll_div_3 = 0x10090
> 
> My card:
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV250 If [Radeon 9000] (rev 01)
> 
> Switching to the analog port works well.

Can I have the -full- dmesg log ?

Ben.



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
