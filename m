From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH]
Date: Thu, 22 Feb 2007 09:53:26 +0800
Message-ID: <1172109206.4217.61.camel@daplas>
References: <Pine.LNX.4.64.0702212105280.20620@pentafluge.infradead.org>
	<1172106234.4217.50.camel@daplas>
	<Pine.LNX.4.64.0702220119060.17121@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK36S-0006wW-3N for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 17:50:36 -0800
Received: from nz-out-0506.google.com ([64.233.162.238])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HK36R-0000CE-Q8
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 17:50:36 -0800
Received: by nz-out-0506.google.com with SMTP id i11so40124nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 21 Feb 2007 17:50:35 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0702220119060.17121@pentafluge.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 2007-02-22 at 01:35 +0000, James Simmons wrote:
> > On Wed, 2007-02-21 at 21:23 +0000, James Simmons wrote:

> > If this is an attempt to consolidate, I don't see the 'brightness'
> > hook of backlight and lcd.
> > 
> > If this is not a consolidation, why don't we just extend the lcd class?
> 
> Its is a replacement for lcd. Is brightness universal for all display 
> types?

Well, if you're adding a universal interface, you need hooks for more
than that (brightness, contrast, hue, saturation, tint, etc).  Then we
just let the drivers cherry pick from the list on what it's going to
support.

Tony


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
