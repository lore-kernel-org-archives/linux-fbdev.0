From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: ioremap and 1GB RAM
Date: Sun, 7 Sep 2003 09:26:17 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030907162617.86162.qmail@web14904.mail.yahoo.com>
References: <20030907021158.66677.qmail@web14911.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19w2Mm-0004he-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Sep 2003 09:26:20 -0700
Received: from web14904.mail.yahoo.com ([216.136.225.56])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19w2Mk-0000oF-QV
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Sep 2003 09:26:18 -0700
In-Reply-To: <20030907021158.66677.qmail@web14911.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

A solution I have found is to add:
reserve=FE000000-100000000
to the kernel command line.

This will cause 512MB of addess space in first 1GB of addressing range to be
left free for PCI devices.

I thought the i875 chipset supported 64bit DMA so there may be a bigger problem
here.

--- Jon Smirl <jonsmirl@yahoo.com> wrote:
> I'm running 2.6 with 1GB mem and HIGHMEM4G.
> My system is booted and then I 'modprobe radeonfb'.
> My ioremap of the framebuffer fails.
> If I reboot with mem=850M this works.
> 
> Am I out of address space for the video memory ioremap?
> Is there a kernel param to force more memory to be highmem?
> 
> 
> 
> =====
> Jon Smirl
> jonsmirl@yahoo.com
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! SiteBuilder - Free, easy-to-use web site design software
> http://sitebuilder.yahoo.com
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
