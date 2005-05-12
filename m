From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: kobject_register failed for intelfb (-EACCES) (Re: 2.6.12-rc4-mm1)
Date: Thu, 12 May 2005 20:20:29 +0400
Message-ID: <200505122020.29290.adobriyan@gmail.com>
References: <20050512033100.017958f6.akpm@osdl.org> <20050512154335.GD21765@kroah.com> <20050512085933.03dc0d10.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262070AbVELQQp@vger.kernel.org>
In-Reply-To: <20050512085933.03dc0d10.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, airlied@linux.ie, davej@codemonkey.org.uk, linux-fbdev-devel@lists.sourceforge.net

On Thursday 12 May 2005 19:59, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >  On Thu, May 12, 2005 at 04:58:01PM +0400, Alexey Dobriyan wrote:
> >  > kobject Intel(R) 830M/845G/852GM/855GM/865G/915G Framebuffer Driver:
> >  > registering. parent: <NULL>, set: drivers
> >  > kobject_register failed for Intel(R) 830M/845G/852GM/855GM/865G/915G
> > 
> >  Someone tried to put a "/" in a kobject name, which is not allowed.
> >  Actually the name seems to be set to:
> >  	"Intel(R) 830M/845G/852GM/855GM/865G/915G Framebuffer Driver"
> >  which is a bit verbous if you want to create a directory name :)

> Seems like a fix such as this will be needed:

> -	.name =		"Intel(R) " SUPPORTED_CHIPSETS " Framebuffer Driver",
> +	.name =		"intelfb",

It works.
