From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Re: New logo code (fwd)
Date: 05 Feb 2003 17:24:22 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1044437021.1169.64.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0302061017330.3301-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18giVy-0008M0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Feb 2003 01:40:14 -0800
In-Reply-To: <Pine.GSO.4.21.0302061017330.3301-100000@vervain.sonytel.be>
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

On Thu, 2003-02-06 at 17:19, Geert Uytterhoeven wrote:
> 
> I always see the logo twice. The first time it's erased by the text (because
> initially fbcon thinks logo_height = 0), the second time it's displayed
> correctly.
> 
> So I also wondered why it's drawn twice?

I was expecting this behavior because I remember you mentioning it in
one of your early mails.  In my case, it was only drawn once which
lasted only for a blink.

> > Overall, I like it, though it does add some kilobytes to the kernel
> > image size.
> 
> Why would it increase kernel size that much? The logos were there before as
> well (unless you enable all of them, of course :-).
> 
My fault, I accidentally enabled ACPI :-)

Tony




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
