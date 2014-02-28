From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 28 Feb 2014 10:19:55 +0000
Subject: Re: [PATCH v5 0/2] hyperv-fb: add support for generation 2 virtual machines
Message-Id: <1393582795.3364.5.camel@nilsson.home.kraxel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393411885-14895-1-git-send-email-kraxel@redhat.com>
	 <53105077.4090102@ti.com>
In-Reply-To: <53105077.4090102@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, kys@microsoft.com, abgupta@microsoft.com, haiyangz@microsoft.com, jasowang@redhat.com, devel@linuxdriverproject.org

On Fr, 2014-02-28 at 11:01 +0200, Tomi Valkeinen wrote:
> On 26/02/14 12:51, Gerd Hoffmann wrote:
> >   Hi,
> > 
> > This patch series adds support for uefi-based gen2 virtual machines
> > to the hyperv-fb driver.  It depends on a few vmbus changes which are
> > staged in Greg's char-misc tree (and linux-next).
> 
> Depends how?

Will fail to build without the vmbus patches.

> Patches that depend on other patches should be merged via
> the same tree to avoid compile or functional breaks.

I think Greg will happily merge them through char-misc if he gets your
fbdev maintainer ACK for the patches.

cheers,
  Gerd


