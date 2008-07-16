From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 2.6.26-rc9 1/5] pxafb: add shared
	framebuffer interface
Date: Wed, 16 Jul 2008 10:38:55 +0100
Message-ID: <20080716093855.GC23468@flint.arm.linux.org.uk>
References: <1215955587-20367-1-git-send-email-jayakumar.lkml@gmail.com>
	<1215955587-20367-2-git-send-email-jayakumar.lkml@gmail.com>
	<f17812d70807160000y4fb9e543gdd25d6b6937af81e@mail.gmail.com>
	<45a44e480807160159j62b9f989l2ae99bd94d24a95f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KJ3Tk-0002Bs-Er for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 02:39:20 -0700
Received: from caramon.arm.linux.org.uk ([78.32.30.218])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KJ3Tj-0000rh-Jx
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 02:39:20 -0700
Content-Disposition: inline
In-Reply-To: <45a44e480807160159j62b9f989l2ae99bd94d24a95f@mail.gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, ymiao3@marvell.com, eric miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

On Wed, Jul 16, 2008 at 01:59:42AM -0700, Jaya Kumar wrote:
> On Wed, Jul 16, 2008 at 12:00 AM, eric miao <eric.y.miao@gmail.com> wrote:
> > On Sun, Jul 13, 2008 at 9:26 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> >> These changes are to make it possible for a secondary driver to share the
> >> pxafb framebuffer. The changes include:
> >> - adding clkdev entry in pxafb_mach_info so that a driver can pass in the
> >>  correct struct device owner for the LCDCLK.
> >
> > Is it possible that LCDCLK being requested by device other than
> > pxa_device_fb?? Could you give an example and we may work out
> > a better solution.
> 
> You're right. I think LCDCLK is only ever requested by pxa_device_fb.
> 
> I see now that instead of doing:
> -       fbi->clk = clk_get(dev, "LCDCLK");
> +       fbi->clk = clk_get(inf->clkdev, "LCDCLK");
> 
> a better solution would be to directly use pxa_device_fb:
> -       fbi->clk = clk_get(dev, "LCDCLK");
> +       fbi->clk = clk_get(pxa_device_fb.dev, "LCDCLK");
> 
> and then I can avoid doing the clkdev ugliness.

PXA devices (intentionally) aren't exported.  Nor are they going to be,
so the above will fail if built as a module.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
