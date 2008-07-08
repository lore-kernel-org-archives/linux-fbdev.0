From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: LCD: Add lcd_device to check_fb() entry in
	lcd_ops.
Date: Tue, 8 Jul 2008 10:38:14 +0100
Message-ID: <20080708093814.GF8489@trinity.fluff.org>
References: <20080708093509.112793619@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KG9eO-0007T3-1q for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Jul 2008 02:38:20 -0700
Received: from trinity.fluff.org ([89.145.97.151])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KG9eN-0002Be-Mj
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Jul 2008 02:38:20 -0700
Content-Disposition: inline
In-Reply-To: <20080708093509.112793619@fluff.org.uk>
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
To: Ben Dooks <ben-linux@fluff.org>
Cc: akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net

On Tue, Jul 08, 2008 at 10:35:09AM +0100, Ben Dooks wrote:
> Add the lcd_device being checked to the check_fb entry
> of lcd_ops. This ensures that any driver using this
> to check against it's own state can do so, and also
> makes all the calls in lcd_ops more orthogonal in their
> arguments.

sorry, this patch seems to have escaped its cage... correct
patch to follow.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
