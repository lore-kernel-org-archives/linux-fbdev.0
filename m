From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RADEON] Connector type
Date: Thu, 28 Aug 2003 19:02:36 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1062090156.612.144.camel@gaston>
References: <20030828162025.GA7317@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19sQBJ-0005U0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Aug 2003 10:03:33 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19sQBI-000824-Ir
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Aug 2003 10:03:32 -0700
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
To: kronos@kronoz.cjb.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@yahoo.com>

On Thu, 2003-08-28 at 18:20, Kronos wrote:
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

What about a module/kernel option ? In the meantime, I'm working on
dual head support, though I'm not sure I'll have that finished soon.

Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
