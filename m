From: Boris Bezlaj <boris@gajba.net>
Subject: Re: vertical stripes under OpenFirmware and offb
Date: Mon, 7 Apr 2003 22:42:29 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030407204229.GA476@gajba.net>
References: <20030328110528.GA2403@gajba.net> <Pine.LNX.4.44.0304022311440.3919-100000@phoenix.infradead.org> <20030406183433.GA929@gajba.net> <1049674547.579.59.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail.g-kabel.si ([193.189.173.117])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 192dS7-0006T3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Apr 2003 13:42:52 -0700
Content-Disposition: inline
In-Reply-To: <1049674547.579.59.camel@zion.wanadoo.fr>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, linux-fbdev-devel@lists.sourceforge.net

On Mon, Apr 07, 2003 at 02:15:47AM +0200, Benjamin Herrenschmidt wrote:
> On Sun, 2003-04-06 at 20:34, Boris Bezlaj wrote:
> 
> > And thanks for looking after the driver..the meintainer seems to be on a
> > very looong vacations :(
> 
> I don't think there's any maintainer for this driver. Any patch
> fixing this appreciated :)

I will try to add/fix detection of 9130 type of card..i don't know how
since the pci ID is the same as for 9128..maybe with the help of OF.

But first i must get 2.5.x up and running :)

BTW, i heard there were problems with cursor under 2.4...anything like
getting different colors of cursor on every console?

-- 

  Boris


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
