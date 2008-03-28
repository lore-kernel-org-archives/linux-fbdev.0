From: York Sun <yorksun@freescale.com>
Subject: Re: [PATCH 1/2 v4] Driver for Freescale 8610 and 5121 DIU
Date: Fri, 28 Mar 2008 13:18:49 -0500
Message-ID: <1206728329.10785.12.camel@laptop>
References: <12066720572512-git-send-email-yorksun@freescale.com>
	 <12066720572314-git-send-email-yorksun@freescale.com>
	 <47ED2B35.4030601@freescale.com>
	 <20080328174853.GA1438@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757382AbYC1STN@vger.kernel.org>
In-Reply-To: <20080328174853.GA1438@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: avorontsov@ru.mvista.com
Cc: Scott Wood <scottwood@freescale.com>, linux-fbdev-devel@lists.sourceforge.net, a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, Timur Tabi <timur@freescale.com>

On Fri, 2008-03-28 at 20:48 +0300, Anton Vorontsov wrote:
> > >+		if (copy_from_user(&pix_fmt, (void __user *)arg,
> > >+				sizeof(pix_fmt)))
> > 
> > OK, you fixed the cast here...
> 
> Maybe better would be to define "buf" at the top of this function as
> void __user *buf = (void __user *)arg;, i.e. just once?

I think it is a good idea.

> 
> > 
> > >+			return -EFAULT;
> > >+		ad->pix_fmt = pix_fmt;
> > >+		pr_debug("Set pixel format to 0x%08x\n", ad->pix_fmt);
> > >+		break;
> > >+	case MFB_GET_PIXFMT:
> > >+		if (!arg)
> > >+			return -EINVAL;
> 
> This if (!arg) appears to be everywhere except default: label, maybe
> this could be placed on top too?
Will do that, too.

York
