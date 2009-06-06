From: amaora <nemashinist@rambler.ru>
Subject: Re: True color framebuffer
Date: Sat, 6 Jun 2009 23:00:31 +0400
Message-ID: <20090606190031.GA30576@core>
References: <20090605212517.GA19565@core>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nemashinist@rambler.ru>) id 1MD13a-0007AM-4c
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 06 Jun 2009 18:55:54 +0000
Received: from maild.rambler.ru ([81.19.66.33])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MD13Y-0005KL-AJ for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 06 Jun 2009 18:55:54 +0000
Received: from localhost (unknown [83.149.41.24])
	(Authenticated sender: nemashinist@rambler.ru)
	by maild.rambler.ru (Postfix) with ESMTP id C8D718446D
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat,  6 Jun 2009 22:55:47 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <20090605212517.GA19565@core>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

On Sat, Jun 06, 2009 at 01:25:17AM +0400, amaora wrote:
> Hi,
> 
> I write framebuffer driver for the PCF8833, it work, but only if
> xxx_fix.visual == FB_VISUAL_PSEUDOCOLOR, TRUECOLOR/DIRECTCOLOR don't work.
> Kernel is blocked (stalled) in function register_framebuffer on line
> fb_notifier_call_chain(...), i don't know how to find stall point more deep.
> Why this happening?
> 
> Thanks,
> 
> Roman Belov
>

It seems to me should not write it here, sorry. Problem solved, it was
necessary to initialize a pointer to the pseudo palette, for true color.


------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
