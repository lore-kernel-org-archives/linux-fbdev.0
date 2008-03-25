From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH 2/2 v2] Add DIU platform code for MPC8610HPCD
Date: Tue, 25 Mar 2008 12:43:22 +0000
Message-ID: <20080325124322.GH12798@shadowen.org>
References: <12059526271941-git-send-email-yorksun@freescale.com> <12059526274026-git-send-email-yorksun@freescale.com> <12059526271964-git-send-email-yorksun@freescale.com> <20080320153304.cdc1817d.akpm@linux-foundation.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755481AbYCYMoz@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080320153304.cdc1817d.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: York Sun <yorksun@freescale.com>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, galak@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net

On Thu, Mar 20, 2008 at 03:33:04PM -0700, Andrew Morton wrote:
> On Wed, 19 Mar 2008 13:50:27 -0500
> York Sun <yorksun@freescale.com> wrote:
> 
> > Add platform code to support Freescale DIU. The platform code includes
> > framebuffer memory allocation, pixel format, monitor port, etc.
> >
> > ...
> >
> > +unsigned int mpc8610hpcd_get_pixel_format
> > +	(unsigned int bits_per_pixel, int monitor_port)

This seems like it might be detectable, does this seem like something we
should try an report?

WARNING: arguments for function declarations should follow identifier
#7: FILE: Z110.c:7:
+int __init preallocate_diu_videomemory

> Again, please do
> 
> unsigned int mpc8610hpcd_get_pixel_format(unsigned int bits_per_pixel,
> 					int monitor_port)
> 
> (and anywhere else where this was done)
> 
> > +int __init preallocate_diu_videomemory(void);
> 
> Nope, please don't put extern declarations in .c files.  Find a suitable
> header for it - one which is included by the defining file and by all users
> of the symbol.
> 
> Andy, checkpatch missed this.

Yeah, we did only look for explicitly extern'd declarations.  But this
form seems detectable, will be in v0.17.

WARNING: externs should be avoided in .c files
#2: FILE: Z110.c:2:
+int __init preallocate_diu_videomemory(void);

-apw
