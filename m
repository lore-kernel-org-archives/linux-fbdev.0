From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Dri-devel] Re: [adaplas@pol.net: Re: Fwd:
	Re: [Dri-devel] future of DRI?]
Date: 03 Mar 2003 01:25:01 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046654701.4431.3.camel@irongate.swansea.linux.org.uk>
References: <20030302215758.GA3390@iliana>
	 <1046651233.4210.11.camel@irongate.swansea.linux.org.uk>
	 <1046649716.1261.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <1046649716.1261.20.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, DRI Devel <dri-devel@lists.sourceforge.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2003-03-03 at 00:01, Antonino Daplas wrote:
> > For some cases. The truth is a bit more horrible, and current fbdev has
> > the same problem here. Any early Athlon, and almost any PII/PIII derived
> > chip allows the user to bring the box down if they have access to 
> > a mix of cached and uncached RAM.
> > 
> 
> I do not understand.  Do you mean such as writing to framebuffer memory
> and making it execute?

On early athlon you prefetch non cached memory and the cpu corrupts its
cache, on PII, PII mmap frame buffer against a cached page, but the
right kind of instruction in a loop with the instruction bridging the
two memory types and run it in a tight loop




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
