From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: intelfb not working on a 945GM
Date: Thu, 18 Oct 2007 18:53:07 -0700
Message-ID: <200710181853.07410.jbarnes@virtuousgeek.org>
References: <47174F1A.4050307@spiro.fisica.unipd.it>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iih3A-0005aX-EB for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Oct 2007 18:53:20 -0700
Received: from outbound-mail-13.bluehost.com ([69.89.18.113])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Iih3A-0008Nh-5j
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Oct 2007 18:53:20 -0700
In-Reply-To: <47174F1A.4050307@spiro.fisica.unipd.it>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

On Thursday, October 18, 2007, Paride Legovini wrote:
> intelfb: intelfb_init
> intelfb: Framebuffer driver for Intel(R)
> 830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM chipsets
> intelfb: Version 0.9.4
> intelfb: intelfb_setup
> intelfb: no options
> intelfb: intelfb_pci_register
> intelfb: fb aperture: 0xd0000000/0x10000000, MMIO region:
> 0xee100000/0x80000 intelfb: 00:02.0: Intel(R) 945GM, aperture size
> 256MB, stolen memory 7932kB intelfb: fb: 0xd0000000(+ 0x0)/0x7bf000
> (0xf8a00000)
> intelfb: MMIO: 0xee100000/0x80000 (0xfc200000)
> intelfb: ring buffer: 0xd3001000/0x10000 (0xfba01000)
> intelfb: HW cursor: 0x0/0x0 (0x00000000) (offset 0x0) (phys 0x0)
> intelfb: options: vram = 4, accel = 1, hwcursor = 0, fixed = 0,
> noinit = 0 intelfb: options: mode = ""
> intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode
> switching. intelfb: Video mode must be programmed at boot time.
> intelfb: cleanup
>
> Both the vesafb and the X11 'intel' driver work really fine. What
> could this be? If you need mode informations or want me to make any
> sort of test just tell me.

The intelfb driver doesn't support much in the way of modesetting, and 
in fact it can be problematic if you try to use it, X and the DRM at 
the same time, so I'd recommend avoiding it unless you have specific 
embedded requirements or something...

Jesse

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
