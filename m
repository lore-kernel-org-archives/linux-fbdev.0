From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Re: [PATCH]: image.depth fix to accomodate
	monochrome cards
Date: 05 Feb 2003 15:14:43 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1044428285.1170.12.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0302051602060.16681-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ggUV-0006hi-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Feb 2003 23:30:35 -0800
In-Reply-To: <Pine.GSO.4.21.0302051602060.16681-100000@vervain.sonytel.be>
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
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-02-05 at 23:03, Geert Uytterhoeven wrote:
> On 8 Jan 2003, Antonino Daplas wrote:
> > 1.  Changed meaning of image.depth.  If image.depth == 0, it flags for
> > color expansion, otherwise, it flags for image drawing (without color
> > expansion).  This change is to accomodate monochrome cards so they can
> > differentiate character drawing from logo drawing.
> 
> What's the status of this issue? Monochrome is still broken due to this.
> 
It's still the same :-(

Tony




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
