From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Re: New logo code (fwd)
Date: 05 Feb 2003 15:15:17 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1044428655.1169.19.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0302051336170.16681-100000@vervain.sonytel.be> 
	<1044472678.1321.388.camel@rohan.arnor.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ggV4-0006sq-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Feb 2003 23:31:10 -0800
In-Reply-To: <1044472678.1321.388.camel@rohan.arnor.net>
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
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Thu, 2003-02-06 at 03:17, Torrey Hoffman wrote:
> > > On Sun, 12 Jan 2003, Geert Uytterhoeven wrote:
> > > > The current logo code is messy, complex, and inflexible. So I decided to
> > > > rewrite it. My goals were:
> [ good list ]
> 
> This is wonderful.  I (and some co-conspirators) started a similar
> project, and put up patches at www.arnor.net/linuxlogo . But yours is up
> to date, and ours is not (I was waiting until the framebuffer rewrite
> was done, and then I didn't have time to catch up).  
> 
> It would be great if your patch was merged.  If I may offer some
> suggestions... well, feature requests :-)
> 
> It would also be nice to have an option to turn off the blinking cursor

You can control some of the attributes of the cursor in 2.5.  The
examples illustrated in linux/Documentation/VGA-Softcursor.txt should
work.  

Tony





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
