From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: tdfx & multiple voodoo cards : supposed to work ?
Date: Wed, 29 Oct 2003 21:25:44 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031029202544.GA8953@dreamland.darkstar.lan>
References: <20031029093653.GA4626@iliana> <20031029182532.GA1662@dreamland.darkstar.lan> <20031029195627.GA13626@iliana>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEwt9-0006qT-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 12:25:55 -0800
Received: from mail-8.tiscali.it ([195.130.225.154])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AEwt9-0000gt-Eb
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 29 Oct 2003 12:25:55 -0800
Content-Disposition: inline
In-Reply-To: <20031029195627.GA13626@iliana>
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
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net

Il Wed, Oct 29, 2003 at 08:56:27PM +0100, Sven Luther ha scritto: 
> On Wed, Oct 29, 2003 at 07:25:32PM +0100, Kronos wrote:
> > Il Wed, Oct 29, 2003 at 10:36:53AM +0100, Sven Luther ha scritto: 
> > > Hello,
> > > 
> > > I have had a report of someone trying to use two voodoo cards on a
> > > pegasos/ppc motherboard, and it freezing the kernel (2.4.22 kernel)
> > > 
> > > Is the tdfx fbdev supposed to be able to handle dual card setups, or not ?
> > 
> > No, the driver has a statically allocated fb_info. It will blow up.
> 
> Ok, thought so, i am not sure though.

BTW, looking  at 2.6 it  seems that the  driver will work  with multiple
cards.  Static vars have been removed so this problem is solved. I'm not
sure that the  driver itself can handle more than  one card though. Give
it a try.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"New processes are created by other processes, just like new
 humans. New humans are created by other humans, of course,
 not by processes." -- Unix System Administration Handbook


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
