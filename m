From: Antonino Daplas <adaplas@pol.net>
Subject: Re: fbdev changes.
Date: 15 Oct 2002 02:47:02 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1034621143.571.53.camel@daplas>
References: <Pine.LNX.4.33.0210131318420.5997-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181AIM-0005zV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Oct 2002 11:50:27 -0700
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 2002-10-14 at 04:27, James Simmons wrote:
[...]
> 
> Second change!! We need a uiversal cursor api. I purposed some time ago a
> api but nothing happend.I like to resolve this final part to remove th
> last bit of console crude from the fbdev layer.
> 
> The api I suggested was :
> 
> 
> /*
>  * hardware cursor control
>  */
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

Can you clarify the usage of the above?  Assuming the console cursor is
monochrome, half-height, and fontsize is 8x16, how would the structure
be filled up?

We will also need a field for the bit operation (xor, solid, trans, etc)
as suggested by Petr, at least for monochrome.

Finally, another field for the font bitmap that is overlying the cursor
may be needed.  Only for the console and a monochrome cursor.  This way,
the driver can manually do the bit operation if the hardware is
incapable of doing so.

If I'm to guess at the structure usage (in console):

set - which of the fbcursor fields have changed
enable - make cursor visible/invisible
hot - how will this be used?  
size - is this fontsize or the actual cursor size?
image - bitmap where all bits are set to 1?
mask - does this correlate with the shape of the cursor or with the
underlying font bitmap?

image and mask has the same dimensions (fbcursor.size)?

Tony






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
