From: "Thomas S. Iversen" <zensonic@zensonic.dk>
Subject: Re: Need advice on blitting to dword alignment
Date: Fri, 12 Sep 2003 21:58:42 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030912195842.GA25986@zensonic.dk>
References: <20030912135229.GA12523@zensonic.dk> <Pine.LNX.4.44.0309121742420.5017-100000@phoenix.infradead.org> <20030912191341.GA23768@zensonic.dk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xu5K-0006Uu-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 13:00:02 -0700
Received: from 213.237.25.228.adsl.van.worldonline.dk ([213.237.25.228] helo=www.zensonic.dk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xu5J-0005QL-RX
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 13:00:02 -0700
Content-Disposition: inline
In-Reply-To: <20030912191341.GA23768@zensonic.dk>
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
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, Sep 12, 2003 at 09:13:41PM +0200, Thomas S. Iversen wrote:

Hi 

> * Tux, which was nicely drawn using the software fallback before I changed the pixmap 
>   alignment, became messed up.

I'll find the brown paper bag myself for this one. My code read:

	if(image->depth!=1)
		cfb_imageblit(info,image);

	.... accelerated depth==1 code

instead of 

	if(image->depth!=1)
		return cfb_imageblit(info,image);

	.... accelerated depth==1 code

That gave me my tux back. My curser however is still broken. I have also
tried to do a software blitt with both the alignemnt options set to 4 and
it does not appear to work :-/

Regards Thomas


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
