From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Re: FBdev updates.
Date: 21 Feb 2003 08:24:17 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045787031.2051.9.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org>
	<20030220150201.GD13507@codemonkey.org.uk> 
	<20030220182941.GK14445@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18m0yY-0008D3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 20 Feb 2003 16:23:38 -0800
In-Reply-To: <20030220182941.GK14445@vana.vc.cvut.cz>
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Dave Jones <davej@codemonkey.org.uk>, James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2003-02-21 at 02:29, Petr Vandrovec wrote:
> 
> I was for five weeks in U.S., so I did not do anything with
> matroxfb during that time. I plan to use fillrect and copyrect
> from generic code (although it means unnecessary multiply on
> generic side, and division in matroxfb, but well, if we gave
> up on reasonable speed for fbdev long ago...). But I simply
> want loadfont and putcs hooks for character painting. And if 
> fbdev maintainer does not want to give me them, well, then 
> matroxfb and fbdev are not compatible.

Petr,

I submitted the Tile Blitting patch to James some time ago, it has
tilefill, tilecopy and tileblit hooks.  These hooks should eliminate the
"multiply in fbcon, divide in driver" bottleneck.

It should result in the same behavior as you would expect in the the 2.4
API, so you can use text mode with your matroxfb driver.  These same
hooks will also help optimize drawing if we need to use fonts like
12x22.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
