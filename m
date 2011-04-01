From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 01 Apr 2011 09:07:12 +0000
Subject: Re: [PATCH] unicore32 framebuffer fix: get videomemory by __get_free_pages() and make it floatable
Message-Id: <201104011107.12769.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <003d01cbf046$f4947ca0$ddbd75e0$@mprc.pku.edu.cn>
In-Reply-To: <003d01cbf046$f4947ca0$ddbd75e0$@mprc.pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: 'Paul Mundt' <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 01 April 2011, Guan Xuetao wrote:
> 1. get videomemory by __get_free_pages() in fb-puv3.c
> 2. remove resource reservation for old fixed UNIGFX_MMAP & UVC_MMAP space
> 3. remove unused macros: PKUNTIY_UNIGFX_MMAP_BASE, PKUNITY_UNIGFX_MMAP_SIZE,
>         PKUNITY_UVC_MMAP_BASE, PKUNITY_UVC_MMAP_SIZE and KUSER_UNIGFX_BASE
> 4. remove unused header linux/vmalloc.h in fb-puv3.h
> 
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

Acked-by: Arnd Bergmann <arnd@arndb.de>
