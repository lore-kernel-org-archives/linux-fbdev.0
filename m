From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] Framebuffer: 2nd try: client notification mecanism & PM
Date: Thu, 7 Aug 2003 23:51:16 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030807215116.GD413@elf.ucw.cz>
References: <Pine.LNX.4.44.0308070000540.17315-100000@phoenix.infradead.org> <1060249101.1077.67.camel@gaston> <20030807100309.GB166@elf.ucw.cz> <1060263168.593.77.camel@gaston> <1060292180.3507.27.camel@laptop-linux>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out2.iol.cz ([194.228.2.87])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ksfc-0002Nw-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 07 Aug 2003 14:51:40 -0700
Content-Disposition: inline
In-Reply-To: <1060292180.3507.27.camel@laptop-linux>
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
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi!

> Would this play well with the suspend process itself displaying output?
> (Eg progress, errors...).

Yes.
								Pavel


...
> > > I believe solution to this is simple: always switch to kernel-owned
> > > console during suspend. (swsusp does it, there's patch for S3 to do
> > > the same). That way, Xfree (or qtopia or whoever) should clean up
> > > after themselves and leave the console to the kernel. (See
> > > kernel/power/console.c)
> > 
> > I admit I quite like this solution. It would also help displaying
> > something sane (blank, pattern, whatever) on screen during driver
> > teardown instead of the junk left by X...
> > 
> > I'll look into including that switch into my pmac code as well
> > and see if it works properly in all cases (I think so). Also,
> > recent DRI CVS finally has working suspend/resume (works on
> > console switch too).
> > 
> > Ben.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
