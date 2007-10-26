From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Intel FB pixel clock calculation fix
Date: Fri, 26 Oct 2007 19:51:43 +0200
Message-ID: <20071026175143.GB1573@elf.ucw.cz>
References: <m3ir6il3wl.fsf@maximus.localdomain>
	<20070910225221.f0eaf22c.akpm@linux-foundation.org>
	<m3veah75u6.fsf@maximus.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IlTLh-0008JF-2K for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 26 Oct 2007 10:51:57 -0700
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123] ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IlTLg-0002Qu-K0
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 26 Oct 2007 10:51:57 -0700
Content-Disposition: inline
In-Reply-To: <m3veah75u6.fsf@maximus.localdomain>
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
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: "Antonino A. Daplas" <adaplas@pol.net>, Andrew Morton <akpm@linux-foundation.org>, sylvain.meyer@worldonline.fr, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue 2007-09-11 14:18:57, Krzysztof Halasa wrote:
> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> >> Intel framebuffer mis-calculated pixel clocks.
> 
> > and... what are the consequences of this miscalculation?  I need to know
> > such things so that I can decide whether a change is needed in 2.6.23.  And
> > 2.6.22.
> 
> The pixel clock (and thus both H and V sync) will be slower than
> requested, so if you set the minimum allowed the display may not
> sync. In case of really old CRT display it could theoretically
> damage it.
> 
> I'm using it with PAL TV (using RGB input - SCART connector) and
> the bug prevented it from working at all (TV requirements are more
> strict and made the bug visible).
> 
> I think 2.6.22 would be overkill, .23 - not sure.

I don't think this is -stable kind of bug.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
