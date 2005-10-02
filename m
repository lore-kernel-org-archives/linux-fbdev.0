From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] nvidiafb: PPC & mode setting fixes (#2)
Date: Sun, 02 Oct 2005 15:08:36 +0800
Message-ID: <433F8774.6000301@gmail.com>
References: <1128225462.8267.24.camel@gaston> <1128232186.8267.31.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751001AbVJBHIn@vger.kernel.org>
In-Reply-To: <1128232186.8267.31.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

Benjamin Herrenschmidt wrote:
> (This version removes a useless bit that slipped in the previous one)
> 
> This patch fixes a couple of things in nvidiafb:
> 
>  - The code for retreiving the mode from Open Firmware was broken. It
> would crash at boot and was copied from the old rivafb code that didn't
> work very well (I'll update rivafb too one of these days).

What do you think of making EDID retrieval from the OF generic?  Or is
it too much hassle?

> 
>  - The mode setting code produced weird results on the 5200 card in the
> iMac G5 here. X "nv" code works fine though. After comparing them, I
> found out that we aren't really manipulating some VGA bits the same way
> and X code seemed better, so I slightly changed the mode setting to do
> the same and that fixed the problem. (The display was strangely shifted
> with garbage in the margin but not on all lines, and not in bpp 32)
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks for the fix :-)  

Acked-by: Antonino Daplas <adaplas@pol.net>
