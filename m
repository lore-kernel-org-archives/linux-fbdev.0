From: Richard Drummond <lists@rcdrummond.net>
Subject: Re: [PATCH] Big-endian fixes for tdfxfb in 2.4.21
Date: Thu, 24 Jul 2003 21:53:13 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200307242153.14002.lists@rcdrummond.net>
References: <Pine.LNX.4.44.0307250040290.7845-100000@phoenix.infradead.org>
Reply-To: lists@rcdrummond.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from swan.mail.pas.earthlink.net ([207.217.120.123])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19fsdD-0001za-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 24 Jul 2003 19:48:31 -0700
In-Reply-To: <Pine.LNX.4.44.0307250040290.7845-100000@phoenix.infradead.org>
Content-Disposition: inline
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
Cc: linux-fbdev-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi James

On Thursday 24 July 2003 06:41 pm, James Simmons wrote:
> > Ooops. I apologize. It turns out that I didn't test this as thoroughly as
> > I had thought. Although the Voodoo3 works perfectly, 16-bit and 32-bit
> > modes are still broken on the Voodoo4.
>
> I have a Voodoo 5 so I can give it a try this week end. I don't have docs
> on the latest cards. I will apply the patch to 2.5.X this weekend.

I have been doing some experimenting with the Voodoo4 on my Mac, and I have 
made a little progress. By doing register dumps and general snooping about to 
discover how MacOS sets up the card, I've found that the card actually 
supports a big-endian aperture on the framebuffer (this is different from how 
big-endian support works on the Voodoo3). As I don't have docs, there's a lot 
of guess-work involved, and I haven't got it working 100% reliably yet - but 
once I do I'll supply a patch.

I'm also working on getting the hwcursor working. The patch I produced against 
2.4.21 does contain fixes for the hwcursor on the Voodoo3 for big-endian 
machines. Again, though, because the different way byte-swizzling works on 
the Voodoo4/5, it doesn't work there in 16- and 32-bit modes. When I get the 
big-endian fixes for the Voodoo4/5 finished, I'll have look at the hwcursor 
on 2.5/2.6 . . . 

Cheers,
Rich



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
