From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [adaplas@pol.net: Re: Fwd: Re: [Dri-devel]
	future of DRI?]
Date: 03 Mar 2003 00:27:14 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046651233.4210.11.camel@irongate.swansea.linux.org.uk>
References: <20030302215758.GA3390@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030302215758.GA3390@iliana>
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
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: DRI Devel <dri-devel@lists.sourceforge.net>, linux-fbdev-devel@lists.sourceforge.net

On Sun, 2003-03-02 at 21:57, Sven Luther wrote:
> 1. fbdev will be secure.  Without access to the MMIO regions, crashing
> the chipset is unlikely or at least difficult.  Even malicious blit
> commands (blits to/from system memory) will not work.  

For some cases. The truth is a bit more horrible, and current fbdev has
the same problem here. Any early Athlon, and almost any PII/PIII derived
chip allows the user to bring the box down if they have access to 
a mix of cached and uncached RAM.

DRM and fbdev already make this tradeoff.

> 3.  Because DRM will handle both 2D and 3D and is pretty much the only
> one with hardware access, performance might actually increase.  

It gives you real DMA of 2D texture objects. It also improves the
situation with tv cards on buggy chipsets no end because you can run
two DMA operations via main memory on busted hardware (eg ALi Magik)

> In linux-2.5, fbcon is already separate from fbdev.  Perhaps in 2.7,
> fbdev can be further reduced to a minimal core, moving the rest of the
> code to fbaa.  Exporting the mmio regions to userland must be
> disallowed. 

I disagree here. There are chips with useful safe mmio areas for many 
things. "Exporting mmio regions must be up to the DRM layer"

> Any comments? 

Take a look at the SiS DRM. It has the memory manager and fb in one
module but otherwise its not that disimilar to your basic description



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
