From: James Simmons <jsimmons@infradead.org>
Subject: Re: FBdev updates.
Date: Thu, 20 Feb 2003 19:58:31 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302201951270.20350-100000@phoenix.infradead.org>
References: <20030220182941.GK14445@vana.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18lwqa-0000dV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 20 Feb 2003 11:59:09 -0800
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Dave Jones <davej@codemonkey.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> I was for five weeks in U.S., so I did not do anything with
> matroxfb during that time. I plan to use fillrect and copyrect
> from generic code 

I have ported the accelerated functions to the new api. What is left is to 
deal with the loadfont and putcs issue which I'm working on the code right 
now.

> (although it means unnecessary multiply on
> generic side, and division in matroxfb, 

????

> but well, if we gave
> up on reasonable speed for fbdev long ago...). 

This is not true. Several benchmarks have shown a large performance 
improvement in 2.5.X.

> But I simply
> want loadfont and putcs hooks for character painting. And if 
> fbdev maintainer does not want to give me them, well, then 
> matroxfb and fbdev are not compatible.

Working on it. I starting with Tony's tileblit patch but I plan to expand 
it even more i.e texture maps to draw fonts.
 
> (3) persuade me that I want to write matroxcon and forget about fbcon at all, or

This is the best solution. 

> Besides that with that strange additional copy in accel_putcs
> I get much slower output than with 2.4.x... and although I

Again not true.



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
