From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] interlaced packed pixels
Date: 04 Apr 2003 12:16:25 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049454984.2138.2.camel@dhcp22.swansea.linux.org.uk>
References: <Pine.GSO.4.21.0304041310440.1720-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86] helo=lxorguk.ukuu.org.uk)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 191Q65-0004mM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 04 Apr 2003 04:15:05 -0800
In-Reply-To: <Pine.GSO.4.21.0304041310440.1720-100000@vervain.sonytel.be>
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

On Gwe, 2003-04-04 at 12:17, Geert Uytterhoeven wrote:
> 	Hi,
> 
> I'd like to introduce a new frame buffer type to accommodate packed pixel frame
> buffers that store the even and odd fields separately. This is typically used
> in graphics hardware for TV output (e.g. set-top boxes).

While we are at it can we also get an FB_TYPE_MJPEG ?



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
