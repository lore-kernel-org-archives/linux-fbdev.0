From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 01 Aug 2017 13:53:28 +0000
Subject: Re: [PATCH] video: fbdev: uvesafb: constify attribute_group structures.
Message-Id: <2391550.2naV14eqVs@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170719051736epcas5p3b707e162f6741c876a069f0eb0768fd7@epcas5p3.samsung.com>
        <aa3e89c4a81699a5e7799f9c20cc7a123e2fce37.1500441256.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <aa3e89c4a81699a5e7799f9c20cc7a123e2fce37.1500441256.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: spock@gentoo.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, July 19, 2017 10:46:55 AM Arvind Yadav wrote:
> attribute_group are not supposed to change at runtime. All functions
> working with attribute_group provided by <linux/sysfs.h> work
> with const attribute_group. So mark the non-const structs as const.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>   15426	   4952	    187	  20565	   5055	drivers/video/fbdev/uvesafb.o
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>   15490	   4888	    187	  20565	   5055	drivers/video/fbdev/uvesafb.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

