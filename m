From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: Unifying radeon.h constant files
Date: Mon, 1 Sep 2003 08:56:47 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030901155647.84255.qmail@web14901.mail.yahoo.com>
References: <1062396517.32736.71.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19tr2u-0003HH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 01 Sep 2003 08:56:48 -0700
Received: from web14901.mail.yahoo.com ([216.136.225.53])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19tr2t-0007wh-W1
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 Sep 2003 08:56:47 -0700
In-Reply-To: <1062396517.32736.71.camel@gaston>
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
Cc: kronos <kronos@kronoz.cjb.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

--- Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> I'm all for doing that, but not until I've finished the new version of
> the driver ;) Also, I have a bunch of additional constants used by the
> Power Management code that don't have the RADEON_ prefix neither and are
> not in XFree, we would have to fixup that too. 
> 
Do you want to try doing the fixups for XFree H file then? 

Have you merged with Luca and me from mesa3d.bkbit.net/linux-2.5 yet? There
will probably be conflicts where I rewrote the error handling in the
intialization code. The old code made mistakes freeing resource when errors
ocurred.

Send me an rsa1 key and I can add you as a writer.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
