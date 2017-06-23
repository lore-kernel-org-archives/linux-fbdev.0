From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 23 Jun 2017 17:32:32 +0000
Subject: Re: [PATCH] staging: sm750fb: Remove typedefs from _logical_chip_type_t and _clock_type_t
Message-Id: <20170623173232.GF19626@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170619172120.GA28772@singhal-Inspiron-5558>
In-Reply-To: <20170619172120.GA28772@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simran Singhal <singhalsimran0@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>

On Mon, Jun 19, 2017 at 10:51:21PM +0530, Simran Singhal wrote:
> This patch removes typedefs from enum _logical_chip_type_t and enum
> _clock_type_t and rename them to logical_chip_type_t and clock_type_t
> respectively.

Why are you doing two different typedef fixups in a single patch?
Please only do one at a time.

thanks,

greg k-h
