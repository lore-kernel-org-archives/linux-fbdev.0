From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] interlaced packed pixels
Date: 04 Apr 2003 14:07:31 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049461651.2138.70.camel@dhcp22.swansea.linux.org.uk>
References: <Pine.GSO.4.21.0304041418000.1720-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86] helo=lxorguk.ukuu.org.uk)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 191RpS-0004iO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 04 Apr 2003 06:06:02 -0800
In-Reply-To: <Pine.GSO.4.21.0304041418000.1720-100000@vervain.sonytel.be>
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
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Gwe, 2003-04-04 at 13:22, Geert Uytterhoeven wrote:
> Op vrijdag 4 April 2003, schreef Alan Cox:
> > On Gwe, 2003-04-04 at 12:17, Geert Uytterhoeven wrote:
>      ^^^                                          ^^^^^
> The Welsh setup isn't 100% finished yet ;-)

Translations in progess still. Tackling evolution is a big job
that the translators haven't started yet

> What's the exact format description for MJPEG? YUV 4:*:*?
> Shouldn't that be a FB_VISUAL_MJPEG?

The frame buffer holds a jpeg frame. At the moment text mode
is problematic but doable (you encode each dct square the
same size for each charater and write in a carefully sized font 8))



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
