From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [PATCH] Framebuffer: 2nd try: client
	notification mecanism & PM
Date: Fri, 08 Aug 2003 09:38:59 +1200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1060292180.3507.27.camel@laptop-linux>
References: <Pine.LNX.4.44.0308070000540.17315-100000@phoenix.infradead.org>
 <1060249101.1077.67.camel@gaston> <20030807100309.GB166@elf.ucw.cz>
 <1060263168.593.77.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp2.clear.net.nz ([203.97.37.27])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ksTt-0005vH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 07 Aug 2003 14:39:33 -0700
Received: from 203-167-145-84.dialup.clear.net.nz
 (203-167-145-84.dialup.clear.net.nz [203.167.145.84])
 by smtp2.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0HJ9000QTQTQ9R@smtp2.clear.net.nz> for
 linux-fbdev-devel@lists.sourceforge.net; Fri, 08 Aug 2003 09:39:30 +1200 (NZST)
In-reply-to: <1060263168.593.77.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@suse.cz>, James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Pavel Machek <pavel@ucw.cz>

Hi.

Would this play well with the suspend process itself displaying output?
(Eg progress, errors...).

Regards,

Nigel

On Fri, 2003-08-08 at 01:32, Benjamin Herrenschmidt wrote:
> On Thu, 2003-08-07 at 12:03, Pavel Machek wrote:
> 
> > I believe solution to this is simple: always switch to kernel-owned
> > console during suspend. (swsusp does it, there's patch for S3 to do
> > the same). That way, Xfree (or qtopia or whoever) should clean up
> > after themselves and leave the console to the kernel. (See
> > kernel/power/console.c)
> 
> I admit I quite like this solution. It would also help displaying
> something sane (blank, pattern, whatever) on screen during driver
> teardown instead of the junk left by X...
> 
> I'll look into including that switch into my pmac code as well
> and see if it works properly in all cases (I think so). Also,
> recent DRI CVS finally has working suspend/resume (works on
> console switch too).
> 
> Ben.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
