From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/2 v4] Driver for Freescale 8610
	and 5121 DIU
Date: Fri, 28 Mar 2008 20:48:53 +0300
Message-ID: <20080328174853.GA1438@localhost.localdomain>
References: <12066720572512-git-send-email-yorksun@freescale.com>
	<12066720572314-git-send-email-yorksun@freescale.com>
	<47ED2B35.4030601@freescale.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JfIhF-0006pL-5H for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Mar 2008 10:48:58 -0700
Received: from [85.21.88.6] (helo=buildserver.ru.mvista.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JfIhD-00028h-OS
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Mar 2008 10:48:57 -0700
Content-Disposition: inline
In-Reply-To: <47ED2B35.4030601@freescale.com>
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
To: Scott Wood <scottwood@freescale.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org

On Fri, Mar 28, 2008 at 12:30:29PM -0500, Scott Wood wrote:
> York Sun wrote:
> >+static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
> >+		       unsigned long arg)
> >+{
> >+	struct mfb_info *mfbi = info->par;
> >+	struct diu_ad *ad = mfbi->ad;
> >+	struct mfb_chroma_key ck;
> >+	unsigned char global_alpha;
> >+	struct aoi_display_offset aoi_d;
> >+	__u32 pix_fmt;
> >+
> >+	switch (cmd) {
> >+	case MFB_SET_PIXFMT:
> >+		if (!arg)
> >+			return -EINVAL;
> >+		if (copy_from_user(&pix_fmt, (void __user *)arg,
> >+				sizeof(pix_fmt)))
> 
> OK, you fixed the cast here...

Maybe better would be to define "buf" at the top of this function as
void __user *buf = (void __user *)arg;, i.e. just once?

> 
> >+			return -EFAULT;
> >+		ad->pix_fmt = pix_fmt;
> >+		pr_debug("Set pixel format to 0x%08x\n", ad->pix_fmt);
> >+		break;
> >+	case MFB_GET_PIXFMT:
> >+		if (!arg)
> >+			return -EINVAL;

This if (!arg) appears to be everywhere except default: label, maybe
this could be placed on top too?

> >+		pix_fmt = ad->pix_fmt;
> >+		if (copy_to_user((void *)arg, &pix_fmt, sizeof(pix_fmt)))
> >+			return -EFAULT;
> >+		pr_debug("get pixel format 0x%08x\n", ad->pix_fmt);
> >+		break;
> >+	case MFB_SET_AOID:
> >+		if (!arg)
> >+			return -EINVAL;
> >+		if (copy_from_user(&aoi_d, (void *)arg, sizeof(aoi_d)))
> >+			return -EFAULT;
> 
> ...but not anywhere else.  All user pointers should have a __user 
> annotation.

-- 
Anton Vorontsov
email: cboumailru@gmail.com
irc://irc.freenode.net/bd2

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
