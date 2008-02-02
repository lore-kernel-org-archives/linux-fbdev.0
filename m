From: Alain Kalker <miki@dds.nl>
Subject: Re: [Bugme-new] [Bug 9847] New: i810fb:
	module	parameter 'mode_option' inconsistent with other
	framebuffer modules
Date: Sat, 02 Feb 2008 05:18:10 +0100
Message-ID: <1201925891.2704.25.camel@localhost>
References: <20080201070131.27F842BD8B5@f25.poczta.interia.pl>
	<20080131233232.a7bf51d5.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JL9pj-0000qe-NF for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Feb 2008 20:18:30 -0800
Received: from spalding.dds.nl ([85.17.178.135])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JL9pg-0003tt-F2
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Feb 2008 20:18:27 -0800
In-Reply-To: <20080131233232.a7bf51d5.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com


On Thu, 2008-01-31 at 23:32 -0800, Andrew Morton wrote:
> On 01 Feb 2008 08:01:30 +0100 krzysztof.h1@poczta.fm wrote:
> 
> > > On Tue, 29 Jan 2008 21:02:39 -0800 (PST) bugme-daemon@bugzilla.kernel.org
> > > wrote:
> > > > Problem Description: While all other framebuffer modules use the option
> > > > "mode=..." to specify a modedb-style video mode, i810fb uses the
> > > non-standard
> > > > "mode_option=..." 
> > 
> > The attached patch should fix it.
> > --
> > 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > This patch changes the option "mode_option" into "mode".
> > 
> 
> Thanks.
> 
> > -module_param(mode_option, charp, 0);
> > -MODULE_PARM_DESC(mode_option, "Specify initial video mode");
> > +module_param(mode, charp, 0);
> > +MODULE_PARM_DESC(mode, "Specify initial video mode");
> 
> But can we retain the old option as well, to avoid breaking people's
> existing setups?

Thanks for the quick reply and patch. In the meantime, I have found out
that the option inconsistency is far more widespread among framebuffer
modules. The documentation on video mode setting
(Documentation/fb/modedb.txt) states that the mode parameter should be
called 'mode_option', but the framebuffer modules seem to be split
exactly down the middle in using 'mode' versus 'mode_option'

On a Debian lenny/sid system running a 2.6.22 kernel I get this:

Framebuffer modules accepting a 'mode' parameter:
---[cut here]---
iki@miki:~$ find /lib/modules/`uname -r`/kernel -name '*fb.ko'|while
read ko; do sudo modinfo -F parm $ko|grep -q "^mode:" && echo $ko; done
/lib/modules/2.6.22-3-686/kernel/drivers/video/s3fb.ko
/lib/modules/2.6.22-3-686/kernel/drivers/video/sis/sisfb.ko
/lib/modules/2.6.22-3-686/kernel/drivers/video/arkfb.ko
/lib/modules/2.6.22-3-686/kernel/drivers/video/geode/gx1fb.ko
/lib/modules/2.6.22-3-686/kernel/drivers/video/vt8623fb.ko
/lib/modules/2.6.22-3-686/kernel/drivers/video/intelfb/intelfb.ko
/lib/modules/2.6.22-3-686/kernel/drivers/video/pm2fb.ko
/lib/modules/2.6.22-3-686/kernel/drivers/video/aty/atyfb.ko
---

Framebuffer modules accepting a 'mode_option' parameter:
miki@miki:~$ find /lib/modules/`uname -r`/kernel -name '*fb.ko'|while
read ko; do sudo modinfo -F parm $ko|grep -q "^mode_option:" && echo
$ko; done
/lib/modules/2.6.22-3-686/kernel/drivers/video/savage/savagefb.ko
/lib/modules/2.6.22-3-686/kernel/drivers/video/sstfb.ko
/lib/modules/2.6.22-3-686/kernel/drivers/video/neofb.ko
/lib/modules/2.6.22-3-686/kernel/drivers/video/geode/gxfb.ko
/lib/modules/2.6.22-3-686/kernel/drivers/video/i810/i810fb.ko
/lib/modules/2.6.22-3-686/kernel/drivers/video/nvidia/nvidiafb.ko
/lib/modules/2.6.22-3-686/kernel/drivers/video/aty/aty128fb.ko
/lib/modules/2.6.22-3-686/kernel/drivers/video/aty/radeonfb.ko

I assume the parameter was called 'mode_option' originally to indicate
that the parameter name itself is optional, "modprobe i810fb
mode=1024x768" is equivalent to "modprobe i810fb 1024x768", which at
least this module seems to support.

Should this be filed as a more general bug report?

-Alain

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
