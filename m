From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [RADEON] Connector type
Date: Thu, 28 Aug 2003 09:43:33 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030828164333.40645.qmail@web14912.mail.yahoo.com>
References: <20030828162025.GA7317@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19sPry-0003NA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Aug 2003 09:43:34 -0700
Received: from web14912.mail.yahoo.com ([216.136.225.248])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19sPry-0007if-As
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Aug 2003 09:43:34 -0700
In-Reply-To: <20030828162025.GA7317@dreamland.darkstar.lan>
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
To: kronos@kronoz.cjb.net, linux-fbdev-devel@lists.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jon Smirl <jonsmirl@yahoo.com>

Does ATI have a standard default here? When you boot using the ATI VBIOS and no
framebuffer driver, which port gets activated when a monitor is attached to
both CRT and DVI?

Also, aren't there four ports total?
CRT
DVI
TV Out
DFP

I haven't noticed this because I am using the CRT connector of my panel. I've
lost my DVI cable.

--- Kronos <kronos@kronoz.cjb.net> wrote:
> Hi,
> currently DDCReg in  radeonfb is hardcoded to CRT  port (secondary port,
> primary DAC).
> 
> I've working code to detect connector type. On my board it finds the CRT
> port  and  DVI  port. The  latter is  ignored  because  dviDisp_type  is
> MT_NONE. If crtDisp_type is MT_NONE then it will use the DVI port.
> 
> What should I  do if both port  are in use? Read EDID  from primary port
> and ignore secondary?
> 
> Luca
> -- 
> Reply-To: kronos@kronoz.cjb.net
> Home: http://kronoz.cjb.net
> Software is like sex; it's better when it's free.
> Linus Torvalds


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
