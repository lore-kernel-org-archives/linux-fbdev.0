From: "David S. Miller" <davem@redhat.com>
Subject: Re: FBdev updates.
Date: 20 Feb 2003 17:45:00 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045791900.21577.5.camel@rth.ninka.net>
References: <Pine.LNX.4.44.0302201951270.20350-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from rth.ninka.net ([216.101.162.244])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18m1YE-0008Td-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 20 Feb 2003 17:00:30 -0800
In-Reply-To: <Pine.LNX.4.44.0302201951270.20350-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Dave Jones <davej@codemonkey.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-02-20 at 11:58, James Simmons wrote:
> > (3) persuade me that I want to write matroxcon and forget about fbcon at all, or
> 
> This is the best solution. 

And then we will have sbuscon as well, thus two places where
putcs() is necessary.

I don't understand, but I do hope that at some point it will be
realized that maybe allowing fbcon to generically handle putcs()
hardware is beneficial.

I can dream. :-)



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
