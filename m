From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: fbdev changes.
Date: Mon, 14 Oct 2002 00:51:59 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021013225159.GB5348@ppc.vc.cvut.cz>
References: <Pine.LNX.4.33.0210131318420.5997-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from p0076.as-l042.contactel.cz ([194.108.237.76] helo=ppc.vc.cvut.cz)
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 180rb2-000229-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Oct 2002 15:52:42 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210131318420.5997-100000@maxwell.earthlink.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Oct 13, 2002 at 01:27:08PM -0700, James Simmons wrote:

[Removed Linus from Cc. I'm sure that he is not interested...]

> code possible. The questions I have is should we move the agp code over to
> that directory. Should the DRI code move over directly or should we move
> DRI driver specific code into the same directory as the fbdev driver
> directories? For example in aty directory we have all the ati framebuffer
> and ATI dri code. What do you think?

I do not think that I want mga dri code in my directory... If anything,
then I want marvel video-in code in my directory...
 
> Second change!! We need a uiversal cursor api. I purposed some time ago a
> api but nothing happend.I like to resolve this final part to remove th
> last bit of console crude from the fbdev layer.
> 
> #define FB_CUR_SETCUR   0x01
> #define FB_CUR_SETPOS   0x02
> #define FB_CUR_SETHOT   0x04
> #define FB_CUR_SETCMAP  0x08
> #define FB_CUR_SETSHAPE 0x10
> #define FB_CUR_SETALL   0x1F
> 
> struct fbcurpos {
>         __u16 x, y;
> };
> 
> struct fbcursor {
>         __u16 set;              /* what to set */
>         __u16 enable;           /* cursor on/off */
>         struct fbcurpos pos;    /* cursor position */
>         struct fbcurpos hot;    /* cursor hot spot */
>         struct fb_cmap cmap;    /* color map info */
>         struct fbcurpos size;   /* cursor bit map size */
>         char *image;            /* cursor image bits */
>         char *mask;             /* cursor mask bits */
> };
> 
> If you have any suggestion please post you purpose struct. Thank you.

mask image is 1bpp, and width of image is derived from cmap? I.e.
cmap.start must be always 0, and cmap.len must be always power of 2?
In that case please make it impossible to set CMAP without SHAPE.
Is image/mask somehow aligned, or is 2x3 cursor just completely
stored in one byte?

In reality I think that you should just split it to 2 blocks:
enable/disable + position in one block (i.e. this changes when cursor
flashes or moves on the screen), and hotspot, cmap, size and image/mask
in second block (these change when cursor body changes).

And what is meaning of image when mask is 1? For b&w cursors
we need 0, 1, transparent and inverse.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
