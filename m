From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Small API change
Date: 03 Apr 2003 00:11:51 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049321510.579.0.camel@zion.wanadoo.fr>
References: <Pine.LNX.4.44.0304022300520.3919-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-1-205.abo.wanadoo.fr ([193.252.38.205] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190qR8-00007y-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 02 Apr 2003 14:10:27 -0800
In-Reply-To: <Pine.LNX.4.44.0304022300520.3919-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-04-03 at 00:01, James Simmons wrote:

> > 
> > What I had in mind was to keep aspect ratio by default and let full
> > stretching when that bit is set. I want 640x480 to be stretched to
> > 1024x768 and then centered on my 1152x768 screen.
> 
> Cool. I agree vmode is the best stop. Just send me a patch and I will 
> apply it.

Ok, as soon as I have it working properly, I'll send that along with
a bunch of radeonfb updates. (I've been fixing a bunch of things on
the 2.4 codebase and didn't fully update the 2.5 driver yet)

Ben.



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
