From: Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: disallow modular framebuffers
Date: Thu, 3 Mar 2005 17:56:49 +0100
Message-ID: <20050303165649.GF4608@stusta.de>
References: <20050301024118.GF4021@stusta.de> <200503012115.29023.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200503012115.29023.adaplas@hotpop.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 09:15:27PM +0800, Antonino A. Daplas wrote:
> On Tuesday 01 March 2005 10:41, Adrian Bunk wrote:
> > Hi,
> >
> > while looking how to fix modular FB_SAVAGE_* (both FB_SAVAGE_I2C=m and
> > FB_SAVAGE_ACCEL=m are currently broken) I asked myself:
> 
> BTW, what's the problem with the above?

  #if defined(CONFIG_FB_SAVAGE_ACCEL)

doesn't work with FB_SAVAGE_ACCEL=m, and

  #if defined(CONFIG_FB_SAVAGE_ACCEL) || defined(CONFIG_FB_SAVAGE_ACCEL_MODULE)

would break with FB_SAVAGE=y and FB_SAVAGE_ACCEL=m.


Is there any reason for these being three modules?
It seems the best solution would be to make this one module composed of 
up to three object files?


> Tony

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
