From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 02 Sep 2015 12:48:27 +0000
Subject: Re: [PATCH v2 1/3] staging: sm7xxfb: move sm712fb out of staging
Message-Id: <20150902124811.GA25301@sudip-pc>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437192539-14150-1-git-send-email-sudipm.mukherjee@gmail.com>
 <55E5A7BC.8060003@ti.com>
 <20150901135514.GB15833@sudip-pc>
 <55E6E45B.5030500@ti.com>
In-Reply-To: <55E6E45B.5030500@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, devel@driverdev.osuosl.org

On Wed, Sep 02, 2015 at 02:58:19PM +0300, Tomi Valkeinen wrote:
> On 01/09/15 16:55, Sudip Mukherjee wrote:
> > On Tue, Sep 01, 2015 at 04:27:24PM +0300, Tomi Valkeinen wrote:
> >> On 18/07/15 07:08, Sudip Mukherjee wrote:
> >>> Now since all cleanups are done and the code is ready to be merged lets
> >>> move it out of staging into fbdev location.
<snip>
> > Some replies inline and remaining I will fix and send patches to you.
> 
> Wouldn't the time be better spent on the DRM driver?
> 
> This driver will be obsolete immediately when there's a DRM driver for
> this device, and then it'll be yet another obsoleted fbdev driver we
> need to maintain.
Now I am getting confused. :(
Since this has already been merged I guess we need to maintain it now.
So then should I fix the things you pointed out or should i instead
give more priority to the DRM driver and fix these things later?

And, just to inform you, there are two more fbdev drivers in staging,
staging/sm750fb and staging/fbtft. And the ultimate goal of any driver
in staging is to move out staging into the main part of the kernel. And
I expect sm750fb to be ready for moving before 4.6 merge window.
If you don't want any more fbdev drivers to be added then maybe you can
have a talk with Greg about this. He is already in the cc.

regards
sudip
