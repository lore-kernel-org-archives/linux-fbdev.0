From: Suresh Chandra Mannava <Mannava@GameBox.net>
Subject: implementing vga16fb
Date: Tue, 23 Mar 2004 10:58:32 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <405FCB00.2070601@GameBox.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B5ePd-0006FU-CH
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Mar 2004 21:25:17 -0800
Received: from snickers.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B5ePc-0005Ox-Bd
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Mar 2004 21:25:16 -0800
Received: from gamebox.net (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id 784D172C1D
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Mar 2004 04:50:24 +0000 (UTC)
Received: from GameBox.net (unknown [61.247.252.55])
	by smtp-2.hotpop.com (Postfix) with ESMTP id 5CBEF1833FF
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Mar 2004 05:11:34 +0000 (UTC)
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Dear Friends,

I am a new to framebuffer, we are implementing kernel framebuffer 
support for the new CPU architecture. I have some basic questions 
related to vga16fb. Please provide some inputs and drive us for 
successful implementation of framebuffer.

Even though we are having PCI ATI Rage XL graphic card, we are 
interested in implementing generic vga16fb for an initial test.

Here are my few queries,

I read that VESAfb is only for Intel(x86) platforms, has any body 
implemented Vesafb on other platforms?

Is vga16fb a CPU architecture dependent? Even though I didn't find any 
architecture dependent sections in the code, Is there any code section 
that to be modified in vga16fb.c?

What are the corresponding files need to be modified for implementing 
framebuffer support for newer platforms.

And lastly, we are testing this framebuffer on 2.6Mhz FPGA(0.16 
Bogomips) with kernel 2.4.7. Are there any other methods (solutions) for 
debugging framebuffer code with out using printk's?

I request your help.

Regards,

Suresh Chandra Mannava.





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
