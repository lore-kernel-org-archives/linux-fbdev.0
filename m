From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] radeonfb: Fix 64 bits resources
	on 32 bits archs
Date: Wed, 23 Apr 2008 08:21:43 +1000
Message-ID: <1208902903.9640.138.camel@pasglop>
References: <20080422012723.BA9F2DE13F@ozlabs.org>
	<480E0A54.9010203@linux.vnet.ibm.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JoQua-0001Qm-B1 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 15:24:28 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1/fROXuRlpOrfk7qijR+uo0MoG8oi2g9Bc=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JoQuY-0000Gj-SE
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 15:24:28 -0700
In-Reply-To: <480E0A54.9010203@linux.vnet.ibm.com>
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
To: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Hollis Blanchard <hollisb@us.ibm.com>, adaplas@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Detlev Zundel <dzu@denx.de>, Wolfgang Denk <wd@denx.de>


On Tue, 2008-04-22 at 17:55 +0200, Christian Ehrhardt wrote:
> I wanted to ask if there are any known workarounds atm that would
> allow me to use my X11 for now?

X is doing a mmap of /dev/mem instead of /dev/fb ?

You can normally map the fb mapping /dev/fb and then map the registers
using /dev/fb at an offset beyond the framebuffer (fix->smem_len).

If X is using /dev/mem instead, then it's being stupid and needs to be
fixed...

Cheers,
Ben.



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
