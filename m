From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] fbdev: make the best-fit section of
 fb_find_mode return the closest matching mode
Date: Sun, 27 Jan 2008 13:25:10 +0100
Message-ID: <20080127132510.b00017cb.krzysztof.h1@poczta.fm>
References: <20080127113115.GA17722@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JJ6tR-0002Nn-RU for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 Jan 2008 04:45:50 -0800
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JJ6tQ-0002pv-DU
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 Jan 2008 04:45:49 -0800
In-Reply-To: <20080127113115.GA17722@spock.one.pl>
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
To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

On Sun, 27 Jan 2008 12:31:16 +0100
Michal Januszewski <spock@gentoo.org> wrote:

> From: Michal Januszewski <spock@gentoo.org>
> 
> Currently, if a perfect match in terms of resolution is not found,
> fb_find_mode() only looks for a best-fit mode among modes with a
> higher resolution than the one requested.  Thus, if the user
> requests a resolution higher than the largest supported one, they
> are dropped to the default mode (usually a low resolution one).
> 

> Change this behaviour so that the true closest match in terms
> of the city-block metric is returned.
> 

This may be not ideal solution in case there exist both lower and
higher matches. If given resolution is closer (even by few pixels)
to lower one, your method will choose the lower one.
It may be incorrect for e.g. picture viewer (the higher resolution
shows the whole picture with margins, the smaller one shows
rescaled or cut picture).

IMHO, the choice of higher resolution (if possible) should be
preferred. It is also closer to the old solution.

Kind regards,
Krzysztof


----------------------------------------------------------------------
Nadchodzi galaktyczna wojna!
Sprawdz >> http://link.interia.pl/f1ce0


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
