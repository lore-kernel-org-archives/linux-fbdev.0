From: James Simmons <jsimmons@infradead.org>
Subject: Re: Small API change
Date: Wed, 2 Apr 2003 23:01:28 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304022300520.3919-100000@phoenix.infradead.org>
References: <1049234608.597.11.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 190qJ7-0006Os-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 02 Apr 2003 14:02:10 -0800
In-Reply-To: <1049234608.597.11.camel@zion.wanadoo.fr>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > I think the vmode field is better suited for this than the sync field.
> > 
> > Do you want a `positive' (keep aspect ratio) or `negative' (allow stretching)
> > flag? And what about stretching that doesn't involve changing the aspect ratio?
> > E.g. do you want 640x480 to be stretched to 1024x768, or not stretched and
> > centered?
> 
> Ok, vmode is fine too.
> 
> What I had in mind was to keep aspect ratio by default and let full
> stretching when that bit is set. I want 640x480 to be stretched to
> 1024x768 and then centered on my 1152x768 screen.

Cool. I agree vmode is the best stop. Just send me a patch and I will 
apply it.




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
