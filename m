From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 09 Mar 2015 11:53:37 +0000
Subject: Re: [PATCH v2 1/4] staging: sm750fb: wrong type for print
Message-Id: <20150309115337.GD10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425886506-8643-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1425886506-8643-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 09, 2015 at 01:05:03PM +0530, Sudip Mukherjee wrote:
> mention correct format specifier while printing.
> fixes all the build warnings about incorrect argument type while
> printing.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
> 
> V2: Giedrius commented resource_size_t can be either u64 or u32
> depending on if CONFIG_PHYS_ADDR_T_64BIT. based on his comments i
> should have kept the datatype as resource_size_t and  used %pa as the
> format specifier. But since this is a framebuffer device and it
> should follow what the framebuffer layer is suggesting in
> struct fb_fix_screeninfo at smem_start and mmio_start.
> adding Tomi for his comments.


This should all have gone into the changelog because it changes how the
code works.

regards,
dan carpenter

