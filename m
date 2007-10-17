From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: YUV Framebuffer
Date: Wed, 17 Oct 2007 08:57:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0710170852350.29643@anakin>
References: <27AAC353AE72C840926448157F375E72012B59B1@NAEX17.na.qualcomm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ii2qW-0005SK-Ls for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 16 Oct 2007 23:57:38 -0700
Received: from hoboe1bl1.telenet-ops.be ([195.130.137.72])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ii2qV-0006mS-AQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 16 Oct 2007 23:57:36 -0700
In-Reply-To: <27AAC353AE72C840926448157F375E72012B59B1@NAEX17.na.qualcomm.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Rhee, C. Joon" <jrhee@qualcomm.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 16 Oct 2007, Rhee, C. Joon wrote:
> Is it possible to create framebuffer color format in YUV (eg. YUV422
> interleaved) and expose it through /dev/fb?
> 
> What would be fb_info type?  

What do you mean with `interleaved'?
Even and odd frames are separate (interlace)?

For YUV422, you have to add a new visual type.

A long time ago, I used this for a non-public test project:

#define FB_TYPE_PACKED_PIXELS_LACED     5       /* Interlaced Packed Pixels */
#define FB_TYPE_PACKED_PIXELS_4AREAS    6       /* 4 areas of Packed Pixels */

#define FB_VISUAL_YCBCR422              6       /* YCbCr 4:2:2 */
#define FB_VISUAL_YCBCR420              7       /* YCbCr 4:2:0 */

> And how about about fb_var_screeninfo.green/blue/red offset? 

Just assume red, green, and blue mean Y, U, and V?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
