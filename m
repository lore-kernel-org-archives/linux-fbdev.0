From: Pavel Machek <pavel@ucw.cz>
Subject: Re: More Fbdev policies.
Date: Sat, 6 Jul 2002 03:14:03 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <ag7d53$ptg$2@main.gmane.org>
References: <Pine.LNX.4.44.0207051302300.30731-100000@www.transvirtual.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail.clsp.jhu.edu ([128.220.34.27])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QuI3-0001MV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 06 Jul 2002 11:28:16 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207051302300.30731-100000@www.transvirtual.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi!

> Recently I was porting several fbdev drivers over to the new api. Some
> driver writers asked to have the changes reverted. So anyone who wants the
> drivers reverted to the previous state say so. I will revert them. I did
> this not to break any drivers but have a smooth transition. This will not
> be the case now.
> 
> NOTE:
>    I will begin change the upper fbdev layer monday thus breaking most
> if not all drivers. It is up to the maintainers to fix them. If not
> fixed by the end of the developement cycle they will be dropped.

End of development cycle == 2.6.0 or 2.6.20? It would probably make
sense to only mark them broken for stable series, they are pretty
likely to be fixed there.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Got root? We do.
http://thinkgeek.com/sf
