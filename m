From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 28 Apr 2020 18:58:54 +0000
Subject: Re: [PATCH v1] staging: fbtft: fb_st7789v: enabled inversion
Message-Id: <20200428185854.GK2014@kadam>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1586424250-25897-1-git-send-email-oliver.graute@gmail.com>
 <20200409101517.GO2001@kadam> <20200427082939.GB18436@portage>
In-Reply-To: <20200427082939.GB18436@portage>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oliver Graute <oliver.graute@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, Oliver Graute <oliver.graute@kococonnector.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Mon, Apr 27, 2020 at 10:29:39AM +0200, Oliver Graute wrote:
> On 09/04/20, Dan Carpenter wrote:
> > On Thu, Apr 09, 2020 at 11:24:05AM +0200, Oliver Graute wrote:
> > > From: Oliver Graute <oliver.graute@kococonnector.com>
> > > 
> > > Enable inversion mode
> > 
> > What the heck is an inversion mode and why would you want it?
> 
> 
> Should I name it:
> 
> Enable MIPI_DCS_ENTER_INVERT_MODE
> 

What I'm saying is the changelog should explain why would want to apply
the patch.  What does the inversion mode do?  Is it inverting the color
or flipping something upside down?

Probably if I had a background in graphics I would know what "Enable
inversion mode" means...  But three words is not a proper and complete
commit message normally.

regards,
dan carpenter
