From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 30 Jan 2013 01:01:07 +0000
Subject: Re: [patch] backlight: s6e63m0: report ->gamma_table_count correctly
Message-Id: <20130129170107.f27c1ed3.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130124070524.GD5611@elgon.mountain>
	<00c601cdfaa2$c52d03c0$4f870b40$%han@samsung.com>
In-Reply-To: <00c601cdfaa2$c52d03c0$4f870b40$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Dan Carpenter' <dan.carpenter@oracle.com>, 'Inki Dae' <inki.dae@samsung.com>, 'Richard Purdie' <rpurdie@rpsys.net>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 25 Jan 2013 11:22:06 +0900
Jingoo Han <jg1.han@samsung.com> wrote:

> On Thursday, January 24, 2013 10:45 PM, Dan Carpenter wrote
> 
> CC'ed Andrew Morton, Inki Dae.
> 
> > 
> > gamma_table has 3 arrays which each hold MAX_GAMMA_LEVEL pointers to
> > int.
> > 
> > The current code sets ->gamma_table_count to 6 on 64bit arches and to 3
> > on 32 bit arches.  It should be 3 on everything.
> 
> Actually, I don't know it is right.
> However, it is certain that this panel is currently used on 32 bit arches
> such as ARM SoCs.

I don't know what gamma_table_count is supposed to do.  The only place
it is used is in s6e63m0_sysfs_show_gamma_table().  That function
doesn't actually show the table - it just prints out gamme_table_count.
Why is that useful?

Ho hum, the patch is clearly correct - the array stores int*'s and the
sysfs file should display "3" for all architectures.  However I suspect
we could just remove the whole sysfs file and nobody would care...

