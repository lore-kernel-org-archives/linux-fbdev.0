From: Antonino Daplas <adaplas@pol.net>
Subject: Re: clipping
Date: 03 Jan 2003 18:36:08 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1041589565.1014.10.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0212292215130.17739-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18UQ6U-0001ei-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 03 Jan 2003 03:35:06 -0800
In-Reply-To: <Pine.GSO.4.21.0212292215130.17739-100000@vervain.sonytel.be>
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
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2002-12-30 at 05:21, Geert Uytterhoeven wrote:
> 
> cfb_imageblit() takes care of clipping, but forgets to update fb_image.data if
> fb_image.d[xy] was changed.
> 
> BTW, do we really need clipping in fb_ops.fb_{fillrect,copyarea,imageblit}()?
Personally, I don't think we need clipping.  I tried removing it before
(circa linux-2.5.30+), but the console segfaults whenever I decrease
var->yres_virtual.  I haven't tried this again with the newest
framebuffer framework though.

Tony





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
