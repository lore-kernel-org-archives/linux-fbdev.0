From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Small API change
Date: 02 Apr 2003 00:03:28 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049234608.597.11.camel@zion.wanadoo.fr>
References: <Pine.GSO.4.21.0304012207040.25096-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-6-134.abo.wanadoo.fr ([80.11.137.134] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190Tq1-0005Vu-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 01 Apr 2003 14:02:37 -0800
In-Reply-To: <Pine.GSO.4.21.0304012207040.25096-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@pol.net>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-04-01 at 22:10, Geert Uytterhoeven wrote:

> I think the vmode field is better suited for this than the sync field.
> 
> Do you want a `positive' (keep aspect ratio) or `negative' (allow stretching)
> flag? And what about stretching that doesn't involve changing the aspect ratio?
> E.g. do you want 640x480 to be stretched to 1024x768, or not stretched and
> centered?

Ok, vmode is fine too.

What I had in mind was to keep aspect ratio by default and let full
stretching when that bit is set. I want 640x480 to be stretched to
1024x768 and then centered on my 1152x768 screen.

Ben.



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
