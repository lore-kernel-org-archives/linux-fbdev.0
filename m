From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Re: FBdev updates.
Date: Tue, 4 Mar 2003 22:46:32 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030304214632.GA1756@vana.vc.cvut.cz>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org> <20030220150201.GD13507@codemonkey.org.uk> <20030220182941.GK14445@vana.vc.cvut.cz> <1045787031.2051.9.camel@localhost.localdomain> <20030303203500.GA2916@vana.vc.cvut.cz> <20030304212906.GA1115@middle.of.nowhere>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from vana.vc.cvut.cz ([147.32.240.58] ident=root)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qKFE-0002TI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 04 Mar 2003 13:46:40 -0800
Content-Disposition: inline
In-Reply-To: <20030304212906.GA1115@middle.of.nowhere>
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
To: Jurriaan <thunder7@xs4all.nl>
Cc: Antonino Daplas <adaplas@pol.net>, James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, Mar 04, 2003 at 10:29:06PM +0100, Jurriaan wrote:
> > text mode.
> 
> There is a regression here: I boot my kernel like this:
> 
> kernel /boot/vmlinuz-2563matrox root=/dev/hda7 video=matrox:vesa:0x11E,fv:80,sgram hdc=scsi apm=smp apm=power-off nosmp=1
> 
> I see a continuous strip of alternating blocks, of sub-character size,
> at the extreme right end of my screen. The colors seem linked to the
> color of the line with the cursor in some way.
> 
> After leaving XFRee, a piece of chbg's background picture is shown for a
> short while, then the blocks return.

Reproduced. Try this (untested) (it is against clean tree, so you'll 
get some line offsets if you had applied my matroxfb patch). Or set 
xres to odd value, even values do not work...
							Petr Vandrovec


--- linux/drivers/video/console/fbcon.c	2003-03-03 18:42:37.000000000 +0100
+++ linux/drivers/video/console/fbcon.c	2003-03-04 22:44:05.000000000 +0100
@@ -456,7 +456,7 @@
 	region.color = attr_bgcol_ec(p, vc);
 	region.rop = ROP_COPY;
 
-	if (rw & !bottom_only) {
+	if (rw && !bottom_only) {
 		region.dx = info->var.xoffset + rs;
 		region.dy = 0;
 		region.width = rw;


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
