From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [adaplas@pol.net: Re: Fwd: Re: [Dri-devel]
	future of DRI?]
Date: 03 Mar 2003 08:01:58 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046649716.1261.20.camel@localhost.localdomain>
References: <20030302215758.GA3390@iliana> 
	<1046651233.4210.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18pdO2-0005Hb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 02 Mar 2003 16:00:54 -0800
In-Reply-To: <1046651233.4210.11.camel@irongate.swansea.linux.org.uk>
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
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, DRI Devel <dri-devel@lists.sourceforge.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2003-03-03 at 08:27, Alan Cox wrote:

Sven,

Thanks for posting this.  I was actually waiting for the fbdev
maintainers (Geert and James) to respond first.  Seems Geert is
receptive to the idea.

> On Sun, 2003-03-02 at 21:57, Sven Luther wrote:
> > 1. fbdev will be secure.  Without access to the MMIO regions, crashing
> > the chipset is unlikely or at least difficult.  Even malicious blit
> > commands (blits to/from system memory) will not work.  
> 
> For some cases. The truth is a bit more horrible, and current fbdev has
> the same problem here. Any early Athlon, and almost any PII/PIII derived
> chip allows the user to bring the box down if they have access to 
> a mix of cached and uncached RAM.
> 

I do not understand.  Do you mean such as writing to framebuffer memory
and making it execute?

[snip]
> > In linux-2.5, fbcon is already separate from fbdev.  Perhaps in 2.7,
> > fbdev can be further reduced to a minimal core, moving the rest of the
> > code to fbaa.  Exporting the mmio regions to userland must be
> > disallowed. 
> 
> I disagree here. There are chips with useful safe mmio areas for many 
> things. "Exporting mmio regions must be up to the DRM layer"
> 

I was speaking more of fbdev which allows mmapping of the mmio besides
graphics memory.  DirectFB does its acceleration this way. So, yes, this
task can relegated to DRM. 
 
> > Any comments? 
> 
> Take a look at the SiS DRM. It has the memory manager and fb in one
> module but otherwise its not that disimilar to your basic description
> 

Thanks. 

Tony




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
