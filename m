From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [Dri-devel] Re: [adaplas@pol.net: Re: Fwd:
	Re: [Dri-devel] future of DRI?]
Date: 04 Mar 2003 05:32:28 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046726085.1256.10.camel@localhost.localdomain>
References: <20030302215758.GA3390@iliana>
	<1046651233.4210.11.camel@irongate.swansea.linux.org.uk>
	<1046649716.1261.20.camel@localhost.localdomain> 
	<1046654701.4431.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18pxWp-0000Tc-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 03 Mar 2003 13:31:19 -0800
In-Reply-To: <1046654701.4431.3.camel@irongate.swansea.linux.org.uk>
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

On Mon, 2003-03-03 at 09:25, Alan Cox wrote:

> On early athlon you prefetch non cached memory and the cpu corrupts its
> cache, on PII, PII mmap frame buffer against a cached page, but the
> right kind of instruction in a loop with the instruction bridging the
> two memory types and run it in a tight loop

Wonderful :-(  Thanks for the info.

Tony
 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
