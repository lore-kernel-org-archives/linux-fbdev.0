From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: video dir reorg
Date: Tue, 14 Jan 2003 10:13:08 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030114091308.GA17392@iliana>
References: <20030114020207.84068.qmail@web14910.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254] helo=mel-rto2.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18YN8J-0006Pf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Jan 2003 01:13:19 -0800
Content-Disposition: inline
In-Reply-To: <20030114020207.84068.qmail@web14910.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Mon, Jan 13, 2003 at 06:02:07PM -0800, Jon Smirl wrote:
> Does it make sense to try merging the DRM drivers into
> the video directory? Maybe something like this:
> 
> video -- empty except for Kconfig file
> video/console -- generic fbconsole code
> video/DRM -- generic DRM code
> video/ati -- ati drivers (drm & fb)
> video/i810 -- i810 drivers (drm & fb)
> etc.....
> 
> This would allow the merging of the DRM and FB
> hardware device drivers over time. Switching VTs
> should be coordinated with saving 3D state.
> 
> Even with out merging DRM should the console driver be
> split out from the hardware drivers?

I think Linus rejected this last time James submitted it.

That said, there is a trend with the DRI people that now want to use the
drm modules to do memory allocation or something such, which was, i
think, previously done in the X server.

Maybe this would be of interrest to a fbdev<->drm merging James did
speak about some time ago.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
