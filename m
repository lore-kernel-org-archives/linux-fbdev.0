From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] intelfb fixes
Date: 24 Mar 2003 20:20:27 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048537227.25652.33.camel@irongate.swansea.linux.org.uk>
References: <20030321193703.A12179@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86] helo=irongate.swansea.linux.org.uk)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xXIL-0002qf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 24 Mar 2003 11:07:41 -0800
In-Reply-To: <20030321193703.A12179@lst.de>
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
To: Christoph Hellwig <hch@lst.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

On Fri, 2003-03-21 at 18:37, Christoph Hellwig wrote:
> It looks like someone is trying to make the kernel looling as messy
> as XFree..
> 
> Remove the silly symlinking rules from the intelfb makefile and remove
> one of the copies of the private copy of modedb in intelfb.  Maybe
> someone who actually has the hardware could fix it to properly use
> modedb directly.

No longer compiles with that change

patch -> /dev/null



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
