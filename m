From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH][RFC] Add support for Epson S1D13806 FB
Date: Mon, 14 Mar 2005 20:15:13 +0800
Message-ID: <200503142015.14749.adaplas@hotpop.com>
References: <qkX0zxQn.1110795218.6236360.varenet@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAoU3-0005V9-IP
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 04:15:43 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAoU1-000103-AJ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 04:15:42 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 28B5014A1EC4
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Mar 2005 12:15:24 +0000 (UTC)
In-Reply-To: <qkX0zxQn.1110795218.6236360.varenet@localhost>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Thibaut VARENE <T-Bone@parisc-linux.org>, linux-fbdev-devel@lists.sourceforge.net
Cc: Antonino Daplas <adaplas@pol.net>, Ben Dooks <ben-linux-arm@fluff.org>

On Monday 14 March 2005 18:13, Thibaut VARENE wrote:
> Hi
>
> Attached to that mail is a patch adding support for Epson S1D13806
> framebuffer device.
>
> That driver is intended to be easily used with other S1D13xxx devices,
> hopefully by splitting the header file and changing a few defines. Since
> I haven't got the hardware to test that, though, I can only assert that
> it works with S1D13806.
>
> This driver has been succesfully tested on ARM embedded boards and
> reported working on SH architecture as well.
>
> Since this is my first framebuffer driver, I would welcome any
> suggestion/comment about it :)

Looks good.  Just a few comments:

1. If you don't have a check_var function, might as well remove it for now.
Otherwise, it's possible for the user to enter invalid mode values and
your driver will accept those unconditionally. The disadvantage, of course,
is that you cannot change the video mode after driver load.

2. Although it's ugly, might as well include something similar to this in
s1d13xxxfb_init(void):

if (fb_get_options("s1d13xxfb", NULL)
	return -ENODEV;

to make general fbdev boot options work, such as:

video=xxxfb:off, video=xxxfb:ofonly

3. You can use pci_resource_len()/pci_resource_start() instead of

+	info->fix.mmio_start = pdev->resource[1].start;
+	info->fix.mmio_len = pdev->resource[1].end - pdev->resource[1].start;
+	info->fix.smem_start = pdev->resource[0].start;
+	info->fix.smem_len = pdev->resource[0].end - pdev->resource[0].start;
+


>
> This driver has been built on top of some preliminary ARM specific work
> by Ben Dooks, and adapted from existing code (as stated in the header of
> s1d13xxxfb.c).
>
> This patch has been diffed against 2.6.11-rc5, I can rediff against a
> newer kernel for inclusion, if needed.

No need, I'll take care of merging the driver.
.
Tony





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
