From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] VT locking
Date: Tue, 6 Jan 2004 14:00:02 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040106140002.6806757b.akpm@osdl.org>
References: <1073349182.9504.175.camel@gaston>
	<Pine.GSO.4.58.0401061725250.5752@waterleaf.sonytel.be>
	<1073425440.773.10.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdzE0-0003rJ-PS
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 13:58:56 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AdzE0-0007pc-Bz
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 13:58:56 -0800
In-Reply-To: <1073425440.773.10.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> Andrew, the only bits of the kernel/printk.c that are supposed to get
> to your tree are related to is_console_locked() at this point. The
> force_printk_to_btext is a debug tool that allow to route all printk's
> to some early-boot output mecanism, though it would eventually be
> acceptable upstream with Geert's idea of arch_printk...

That's OK, it's just in there for a soak-test at present - this stuff is
quite a long way away, yes?

It's probably just easiest for you to work against current -bk, send me a
single rolled up patch whenever you have new things for people to test. 
When we're happy with it all we can do a bk merge of everything.


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
