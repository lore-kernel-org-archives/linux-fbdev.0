From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH][FBDEV] Fix copy_to/from_user in fbmem.c:fb_read/write
Date: Sun, 29 Aug 2004 20:16:28 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040829201628.79eeee65.davem@davemloft.net>
References: <200408301047.28117.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1cfX-0007cZ-FD
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 29 Aug 2004 20:17:19 -0700
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C1cfU-0000ZT-HW
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 29 Aug 2004 20:17:18 -0700
In-Reply-To: <200408301047.28117.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: adaplas@pol.net
Cc: adaplas@hotpop.com, akpm@osdl.org, linux-fbdev-devel@lists.sourceforge.net, davem@redhat.com

On Mon, 30 Aug 2004 10:47:28 +0800
"Antonino A. Daplas" <adaplas@hotpop.com> wrote:

> This patch fixes a prblem reported by David S. Miller <davem@redhat.com>
> 
> "I just noticed that fb_{read,write}() uses copy_*_user() with
> the kernel buffer being the frame buffer.  It needs to use
> the proper device address accessor functions."

Looks great Tony, thanks for fixing this.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
