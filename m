From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: radeonfb on pegasos powerpc motherboard and X endianess problem
Date: Fri, 6 Jun 2003 08:30:40 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030606063040.GC1173@iliana>
References: <20030605131253.GA1238@iliana> <Pine.GSO.4.21.0306060801070.864-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp3.wanadoo.fr ([193.252.22.25] helo=mwinf0601.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19OAkT-0004va-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 05 Jun 2003 23:30:49 -0700
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0306060801070.864-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, Jun 06, 2003 at 08:02:23AM +0200, Geert Uytterhoeven wrote:
> On Thu, 5 Jun 2003, Sven Luther wrote:
> > On Thu, Jun 05, 2003 at 02:27:23PM +0200, Benjamin Herrenschmidt wrote:
> > > On Thu, 2003-06-05 at 13:58, Sven Luther wrote:
> > > > Ok, so it must be another kind of problems, but then, my matrox board,
> > > > which Geert (or someone else) said did run on his chrp board, did not
> > > > work well for me.
> 
> Not me, as I don't have any Matrox cards (just S3 and Mach64 GT).
> 
> > > Could be a problem with how the firmware did/did not initialize it
> > 
> > Actually, the OF has a x86 emulator which runs the x86 bios of the
> > graphic card. 
> 
> Aha, so you get VGA text mode on bootup instead of linear graphics?

Yep, Ralph (who wrote the OF or something such) is telling me that the
linear fb apperture doesn't fit in the vga aperture or something such,
and that graphic mode would need vesa 3.x cards.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
