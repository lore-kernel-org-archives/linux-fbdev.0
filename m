From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Linux-fbdev-devel] vesafb and *fb
Date: Sun, 25 Apr 2004 16:29:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1082906968.28039.7.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0404240031030.5826-100000@phoenix.infradead.org>
	 <Pine.GSO.4.58.0404251511320.13613@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S261947AbUDYTNZ@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.58.0404251511320.13613@waterleaf.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sul, 2004-04-25 at 14:13, Geert Uytterhoeven wrote:
> > >     if (!request_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len, "vesafb")) {
> > > 	    printk(KERN_WARNING
> > > 		   "vesafb: abort, cannot reserve video memory at 0x%lx\n",
> > > 		    vesafb_fix.smem_start);
> > > 	    /* We cannot make this fatal. Sometimes this comes from magic
> > > 	       spaces our resource handlers simply don't know about */

Various built-in video systems broke on that test because we didnt
have resources for them so the resources couldnt be allocated. Probably
if vesafb is enabled we should skip any primary video device (ie the one
with VGA_EN at boot)
