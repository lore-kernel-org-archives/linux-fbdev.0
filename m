From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: RFC: disallow modular framebuffers
Date: Fri, 4 Mar 2005 03:50:42 +0800
Message-ID: <200503040350.51163.adaplas@hotpop.com>
References: <20050301024118.GF4021@stusta.de> <200503012115.29023.adaplas@hotpop.com> <20050303165649.GF4608@stusta.de>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050303165649.GF4608@stusta.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Adrian Bunk <bunk@stusta.de>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Friday 04 March 2005 00:56, Adrian Bunk wrote:
> On Tue, Mar 01, 2005 at 09:15:27PM +0800, Antonino A. Daplas wrote:
> > On Tuesday 01 March 2005 10:41, Adrian Bunk wrote:
> > > Hi,
> > >
> > > while looking how to fix modular FB_SAVAGE_* (both FB_SAVAGE_I2C=m and
> > > FB_SAVAGE_ACCEL=m are currently broken) I asked myself:
> >
> > BTW, what's the problem with the above?
>
>   #if defined(CONFIG_FB_SAVAGE_ACCEL)
>
> doesn't work with FB_SAVAGE_ACCEL=m, and
>
>   #if defined(CONFIG_FB_SAVAGE_ACCEL) ||
> defined(CONFIG_FB_SAVAGE_ACCEL_MODULE)
>
> would break with FB_SAVAGE=y and FB_SAVAGE_ACCEL=m.
>

I see.

>
> Is there any reason for these being three modules?
> It seems the best solution would be to make this one module composed of
> up to three object files?

Yes.

Tony
