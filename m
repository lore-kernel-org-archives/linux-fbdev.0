From: Otto Solares <solca@guug.org>
Subject: Re: help with consolupdate on modechange in driver
Date: Mon, 22 Sep 2003 12:16:51 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030922181651.GA22713@guug.org>
References: <20030922103546.GA6398@zensonic.dk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1VGl-0004eP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 11:18:43 -0700
Received: from guug.org ([168.234.203.30] helo=guug.galileo.edu)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A1VGk-0001JN-RD
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 11:18:42 -0700
Content-Disposition: inline
In-Reply-To: <20030922103546.GA6398@zensonic.dk>
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
To: "Thomas S. Iversen" <zensonic@zensonic.dk>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, Sep 22, 2003 at 12:35:46PM +0200, Thomas S. Iversen wrote:
> Hi
> 
> I have just implemented modechange in my driver and while it
> works, the consol *still* thinks we working in the old mode.
> 
> How do I inform the console layer that the driver (through fbset)
> have changed the actual mode on the screen?

rivafb has this same problem.

-solca



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
