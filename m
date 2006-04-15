From: Andrew Morton <akpm@osdl.org>
Subject: Re: Behaviour change of /dev/fb0?
Date: Fri, 14 Apr 2006 21:31:05 -0700
Message-ID: <20060414213105.09f0dd8d.akpm@osdl.org>
References: <1145009768.6179.7.camel@localhost.localdomain>
	<44404401.3030702@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FUcRW-0002g1-RD
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Apr 2006 21:31:30 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1FUcRW-0007ry-LM
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Apr 2006 21:31:30 -0700
In-Reply-To: <44404401.3030702@gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, rpurdie@rpsys.net

"Antonino A. Daplas" <adaplas@gmail.com> wrote:
>
> Richard Purdie wrote:
> > Ignoring whether this is a good idea or not, under 2.6.15 you could run
> > 
> > dd if=/dev/zero of=/dev/fb0
> > 
> > which would clear the framebuffer. It would end up saying "dd: /dev/fb0:
> > No space left on device".
> > 
> > Under 2.6.16 (and a recent git kernel), the same command clears the
> > screen but then hangs. Was the change in behaviour intentional? 
> > 
> > I've noticed this on a couple of ARM based Zaurus handhelds under both
> > w100fb and pxafb.
> > 
> 
> After reading 'man 2 read' more thoroughly, I've adjusted fb_write()'s
> return codes  appropriately.  Can you try this patch and let me know if it
> fixes your problem.
> 
> Tony
> 
> fbdev: Fix return error of fb_write()
> 
> - return -EFBIG if file offset is past the maximum allowable offset

OK.

> - return -EFBIG and write to end of framebuffer if size is bigger than the
>   framebuffer length

We should return the number of bytes written in this case.

> - return -ENOSPC and write to end of framebuffer if size is bigger than the
>   framebuffer length - file offset

Also here.


If we can transfer _any_ bytes, we should do so, then return the number of
bytes transferred.  If no bytes were transferrable then we should return
-Ewhatever.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
