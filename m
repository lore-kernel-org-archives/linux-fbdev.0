From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: FBdev updates.
Date: Thu, 20 Feb 2003 18:10:27 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030220181027.A9625@jurassic.park.msu.ru>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from jurassic.park.msu.ru ([195.208.223.243])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18lsMA-0008Gh-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 20 Feb 2003 07:11:27 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Thu, Feb 20, 2003 at 01:09:33AM +0000
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
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Feb 20, 2003 at 01:09:33AM +0000, James Simmons wrote:
> <jsimmons@maxwell.earthlink.net> (03/02/19 1.913.1.1)
...
> using standard macros for vgacon.c.

Unfortunately, this makes vgacon on non-legacy platforms where
the I/O port address doesn't fit in unsigned short almost
unfixable. :-(

Ivan.


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
