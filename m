From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 12 Mar 2003 05:45:35 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047419056.1100.26.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303111628240.23668-100000@phoenix.infradead.org>
	<1047407816.1013.182.camel@localhost.localdomain> 
	<3E6E4D9A.7060003@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18src1-0006SD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 13:48:41 -0800
In-Reply-To: <3E6E4D9A.7060003@winischhofer.net>
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
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-12 at 04:56, Thomas Winischhofer wrote:
> > 
> > The choices are:
> > 
> > 1. refresh the registers at every switch - slowest but guarantees
> > hardware state is always preserved 
> 
> Bad. Takes long time, especially on LCD displays which always need a 
> little delay for backlight and sync stability reasons.
> 
> > 2. do not refresh unless var changed - fasted but can result in
> > corruption/crash if registers were changed behind the back of fbdev
> 
> I think one can rely on tidyness of applications changing the registers. 
> Like X does.
 
Unfortunately, this is what we are trying to prevent.  X assumes that
the console is in text mode, so only registers that affect text mode are
restored.  Frequently, cursor registers and bitmaps, as an example, are
not refreshed.  There's probably more, ie accel engine, etc.

Of course, X is not totally to blame, it's doing its best to restore the
console back.  It really depends on the X drivers, how complicated they
are, how comprehensive are their restore routines, etc.  

> > 3. selective refresh - do not refresh if switching between "trusted"
> > consoles, refresh if switching from "untrusted" consoles.

I actually prefer #3, and I already have working code for this.  We can
also make this driver switchable (ie, drivers that are not affected by X
can disable this, and only drivers that are affected such as the riva,
aty, radeon, etc can turn this on).

Tony



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
