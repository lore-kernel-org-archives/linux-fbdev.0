From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH][FBCON]: Mode Switch in fbcon_blank()
Date: Tue, 29 Jun 2004 21:53:39 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1088564019.1922.12.camel@gaston>
References: <200406301047.57423.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfVGv-0005u4-0K
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Jun 2004 19:56:29 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1BfVGu-0003Ap-Gy
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Jun 2004 19:56:28 -0700
In-Reply-To: <200406301047.57423.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2004-06-29 at 21:47, Antonino A. Daplas wrote:
> Hi Ben,
> 
> As we've discussed in another thread, below is a diff that will do a
> set_par() as late as possible when there is KD_TEXT<->KD_GRAPHICS
> switch.  The set_par() will be forced in fbcon_resize() instead.
> 
> Not sure if this has repercussions with the other drivers, but this patch
> fixed the X nv driver hanging when switching to the console. (I believe
> the crash is actually caused by an early set_par() -- while in
> fbcon_blank. Removing the set_par in fbcon_blank fixed the hang but
> caused cursor sprite and display corruption).
> 
> What do you think?

Well... I don't know. It seem to work, so it's probably an acceptable
workaround, but I'd like to find out what's wrong with doing it in blank
precisely (that is what is the bug in XFree or in the kernel VT), since it's
shared by many X drivers, I don't suppose it's a bug in them.

I'll try to find time to toy with this, but I may not have any until after
OLS though....

Ben.




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
