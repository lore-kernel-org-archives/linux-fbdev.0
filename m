From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [BK FBDEV] String drawing optimizations.
Date: Tue, 13 May 2003 02:34:27 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030513003427.GA19121@vana.vc.cvut.cz>
References: <Pine.LNX.4.44.0305130049520.14641-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from vana.vc.cvut.cz ([147.32.240.58] ident=root)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19FNkb-0003f1-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 12 May 2003 17:34:37 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305130049520.14641-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, May 13, 2003 at 01:02:40AM +0100, James Simmons wrote:
> 
> Please test. The pixmap code in the framebuffer layer was designed to 
> align the font data. For some hardware it is required that each scanline 
> end on a byte boundary but for some  it was to be 32 bit aligned. So the
> solution was to take the image data and padded it to what the hardware 
> needs. At present it does this by coping on byte at a time. This is just 
> plain awful. So this patch copies data a whole scanline at a time. It is
> a big performance boost. Please test before I send it to Linus. Thank 
> you.

What about getting rid of one-char putc, implementing it in terms of
putcs? I'm doing it in matroxfb patches, and nobody complained yet, and
with current length of {fbcon,accel}_putc{s,} I was not able to find
measurable speed difference between putc and putc through putcs variants.
						Thanks,
							Petr Vandrovec
							vandrove@vc.cvut.cz



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
