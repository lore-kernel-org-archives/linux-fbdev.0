From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: vesafb and *fb
Date: Mon, 26 Apr 2004 11:10:06 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404261109370.25122@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404240031030.5826-100000@phoenix.infradead.org>
 <Pine.GSO.4.58.0404251511320.13613@waterleaf.sonytel.be>
 <1082906968.28039.7.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BI27x-0003OF-Vr
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Apr 2004 02:10:13 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BI27x-0007QJ-Dc
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Apr 2004 02:10:13 -0700
In-Reply-To: <1082906968.28039.7.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, 25 Apr 2004, Alan Cox wrote:
> On Sul, 2004-04-25 at 14:13, Geert Uytterhoeven wrote:
> > > >     if (!request_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len, "vesafb")) {
> > > > 	    printk(KERN_WARNING
> > > > 		   "vesafb: abort, cannot reserve video memory at 0x%lx\n",
> > > > 		    vesafb_fix.smem_start);
> > > > 	    /* We cannot make this fatal. Sometimes this comes from magic
> > > > 	       spaces our resource handlers simply don't know about */
>
> Various built-in video systems broke on that test because we didnt
> have resources for them so the resources couldnt be allocated. Probably
> if vesafb is enabled we should skip any primary video device (ie the one
> with VGA_EN at boot)

But vesafb is meant to be used as a fallback, if no chipset-specific driver is
found.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
