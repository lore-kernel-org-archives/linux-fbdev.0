From: Valentin Longchamp <valentin.longchamp@epfl.ch>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing
	Unit DMA and IRQ drivers
Date: Fri, 23 Jan 2009 16:09:05 +0100
Message-ID: <4979DD91.4030807@epfl.ch>
References: <Pine.LNX.4.64.0901081850280.6387@axis700.grange>	<Pine.LNX.4.64.0901081857170.6387@axis700.grange>	<4978C01B.8080707@epfl.ch>	<Pine.LNX.4.64.0901221959100.7935@axis700.grange>	<4978CD75.70203@epfl.ch>	<Pine.LNX.4.64.0901222122150.7935@axis700.grange>	<49798E4A.4030709@epfl.ch>	<Pine.LNX.4.64.0901231040420.4463@axis700.grange>
	<4979D97F.7030007@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <valentin.longchamp@epfl.ch>) id 1LQNem-0003QE-UL
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 15:09:16 +0000
Received: from smtp3.epfl.ch ([128.178.224.226])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1LQNed-0004Wn-CR for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 15:09:16 +0000
In-Reply-To: <4979D97F.7030007@epfl.ch>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Dan Williams <dan.j.williams@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Valentin Longchamp wrote:
> 
> Ok let's get back to this point. The initcall_debug=1 boot option helped
> a lot (thanks Russel). So all initcalls correctly are called ipu_init
> inclusive (my pr_debug calls did show nothing even with the debug and
> dynamic_printk option, so I thought initcalls were not called ... I
> don't understand what happened here)

I undestrand what happened: dynamic_printk also are enabled by an
initcall, and this initcall happens AFTER the ipu_init inicall, so the
dynamic_printks are not enabled when I try to output something in the
ipu_init (so all my pr_debug output were silent).

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp@epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
