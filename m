From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 14 Mar 2019 11:30:56 +0000
Subject: Re: [RfC PATCH] fbdev: list all memory bars as conflicting apertures
Message-Id: <20190314113056.sa4zkunxgyxef3t5@sirius.home.kraxel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190313110741.6541-1-kraxel@redhat.com>
 <20190314103713.GQ2665@phenom.ffwll.local>
In-Reply-To: <20190314103713.GQ2665@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Thu, Mar 14, 2019 at 11:37:13AM +0100, Daniel Vetter wrote:
> On Wed, Mar 13, 2019 at 12:07:41PM +0100, Gerd Hoffmann wrote:
> > Simply add all pci memory bars to struct apertures_struct in
> > remove_conflicting_pci_framebuffers().  That allows to drop
> > the res_id parameter.
> > 
> > TODO: actually remove the res_id parameter.
> 
> I think best to do that in a cleanup patch afterwards.

I was just lazy and didn't want update all callers for the first patch
draft.  But doing a test run ...

> Maybe if you want to be paranoid in the conversion add a check that we're
> not skipping the pci bar requested in res_id. Then we could test this for
> a kernel and remove the parameter later on.

... that way before actually dropping the parameter surely makes sense.

New version on the way,
  Gerd
