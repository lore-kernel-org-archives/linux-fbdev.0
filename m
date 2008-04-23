From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: deprecating fix->mmio_start and smem_start
Date: Wed, 23 Apr 2008 15:21:46 +1000
Message-ID: <1208928106.9060.20.camel@pasglop>
References: <1208827046.9640.73.camel@pasglop>
	<Pine.LNX.4.64.0804220951380.14102@anakin>
	<1208854136.9640.104.camel@pasglop>
	<Pine.LNX.4.64.0804221433120.30966@anakin>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JoXQk-0007MT-5b for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 22:22:10 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX19Ehh/WRBnpizrDbIQW42EvJWDoSCyzpM0=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JoXQi-0001Dt-6v
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 22:22:05 -0700
In-Reply-To: <Pine.LNX.4.64.0804221433120.30966@anakin>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>


On Tue, 2008-04-22 at 14:38 +0200, Geert Uytterhoeven wrote:
> > though. Which is why I wonder if we should -also- make the new
> kernel
> > structure user-visible with a new ioctl, so that user space can
> migrate
> > and the day we have such monsters, we aren't totally broken ?
> 
> Hmm, that definitely means a new fb_fix_screeninfo, as smem_len is
> currently u32, even on 64-bit.

Yup, I think that's the way to go.

I'll cook up a patch one of these days.

Cheers,
Ben.



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
