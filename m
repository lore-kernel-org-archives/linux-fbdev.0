From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] fbcon: fix wrong vmode bits copied
	on console switch
Date: Wed, 28 May 2008 08:22:00 +0200
Message-ID: <20080528082200.d85268ab.krzysztof.h1@poczta.fm>
References: <20080523100934.27232c7b.krzysztof.h1@poczta.fm>
	<20080527203858.79061fef.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1F1A-0001Mn-Rh for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 May 2008 23:20:16 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K1F19-0007pO-Bq
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 May 2008 23:20:12 -0700
In-Reply-To: <20080527203858.79061fef.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, stable@kernel.org

On Tue, 27 May 2008 20:38:58 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 23 May 2008 10:09:34 +0200 Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > The interlaced and double line mode bits should not be
> > copied to new console when the console is switched.
> > Otherwise, the new console may be set to incorrect refresh
> > rate.
> > 
> > Also, the x and y offsets does not need to be copied.
> > 
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

> 
> Do you think this is a needed-in-2.6.26 fix?
> 

It would be nice. 

> And 2.6.25.x?
> 

Rather no.

Geert found that it was introduced in 2.6.15 kernel and nobody complained so this is not a critical must-be fix.

commit e4fc27618b75234b721c4a13d0e0d9d07e75e641
Date:   Tue Nov 8 21:39:09 2005 -0800

    [PATCH] fbcon: Console Rotation - Prepare fbcon for console rotation

Regards,
Krzysztof

----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>> http://link.interia.pl/f1e13  


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
