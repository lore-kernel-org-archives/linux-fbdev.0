From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: tdfx & multiple voodoo cards : supposed to work ?
Date: Wed, 29 Oct 2003 20:56:27 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031029195627.GA13626@iliana>
References: <20031029093653.GA4626@iliana> <20031029182532.GA1662@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEwQl-0008QQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 11:56:35 -0800
Received: from smtp6.wanadoo.fr ([193.252.22.25] helo=mwinf0601.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AEwQk-0004Mb-O8
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 29 Oct 2003 11:56:34 -0800
Content-Disposition: inline
In-Reply-To: <20031029182532.GA1662@dreamland.darkstar.lan>
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
To: Kronos <kronos@kronoz.cjb.net>
Cc: Sven Luther <sven.luther@wanadoo.fr>, linux-fbdev-devel@lists.sourceforge.net

On Wed, Oct 29, 2003 at 07:25:32PM +0100, Kronos wrote:
> Il Wed, Oct 29, 2003 at 10:36:53AM +0100, Sven Luther ha scritto: 
> > Hello,
> > 
> > I have had a report of someone trying to use two voodoo cards on a
> > pegasos/ppc motherboard, and it freezing the kernel (2.4.22 kernel)
> > 
> > Is the tdfx fbdev supposed to be able to handle dual card setups, or not ?
> 
> No, the driver has a statically allocated fb_info. It will blow up.

Ok, thought so, i am not sure though.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
