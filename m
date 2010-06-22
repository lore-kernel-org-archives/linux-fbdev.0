From: Anatolij Gustschin <agust@denx.de>
Date: Tue, 22 Jun 2010 22:03:23 +0000
Subject: Re: [PATCH 0/5] Rework MPC5121 DIU support (for 2.6.35)
Message-Id: <20100623000323.41b953db@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<AANLkTil0-hijJOvosWUEArVUOLDb_kLWIhfflj2C9pIK@mail.gmail.com>
In-Reply-To: <AANLkTil0-hijJOvosWUEArVUOLDb_kLWIhfflj2C9pIK-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wd-ynQEQJNshbs@public.gmane.org, dzu-ynQEQJNshbs@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org

Hi,

On Tue, 22 Jun 2010 11:29:50 -0500
Timur Tabi <timur@freescale.com> wrote:

> On Thu, Apr 29, 2010 at 6:49 PM, Anatolij Gustschin <agust@denx.de> wrote:
> > This patch series rework DIU support patches submitted
> > previously. Comments to the previos patch series have
> > been addressed, not related changes are dropped and some
> > changes are split out to separate patches to simplify
> > review. Furthermore a patch has been added to support
> > setting display mode using EDID block in the device tree.
> 
> All five patches:
> 
> Acked-by: Timur Tabi <timur@freescale.com>
> 
> Tested on an MPC8610 HPCD.

Thanks for testing!

Grant, could you please queue these patches for 2.6.36?

Thanks,
Anatolij
