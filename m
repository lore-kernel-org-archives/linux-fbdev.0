From: Andrew Morton <akpm@osdl.org>
Subject: Re: Hang in fb_notifier_call_chain with nvidia
	framebuffer
Date: Sat, 7 Oct 2006 23:01:29 -0700
Message-ID: <20061007230129.323ac807.akpm@osdl.org>
References: <45206777.7020405@saville.com> <1159808447.4652.6.camel@mhcln03>
	<4521E326.2000406@saville.com>
	<1159882225.2891.525.camel@laptopd505.fenrus.org>
	<4523E09C.9000609@saville.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GWRjN-0004Za-3p for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Oct 2006 23:01:45 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GWRjL-0007fy-P9
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Oct 2006 23:01:45 -0700
In-Reply-To: <4523E09C.9000609@saville.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Wink Saville <wink@saville.com>
Cc: Matthias Hentges <oe@hentges.net>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>

On Wed, 04 Oct 2006 09:26:04 -0700
Wink Saville <wink@saville.com> wrote:

> Attached in the zip file is:
> 
> log-hang1.txt	-> log showing hang
> cfg-hang1	-> config file for hang condition
> cfg-ok		-> config file that works
> fbmem.c		-> Modifications to register_framebuffer
> 
> To possibly assist I turned on debugging in nvidia.c and found that it 
> hung in the call to register_framebuffer. I then added some additional 
> debug in that routine and it appears the hang occurs in the call to 
> fb_notifier_call_chain.
> 
> Please let me know what else maybe needed.

Please:

- get sysrq working:

	set CONFIG_MAGIC_SYSRQ=y, rebuild, reboot
	echo 1 > /proc/sys/kernel/sysrq
	dmesg -n 8

- make it hang

- Hit alt-sysrq-T

- Send us the resulting output

Thanks.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
