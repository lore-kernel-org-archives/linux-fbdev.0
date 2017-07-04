From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 04 Jul 2017 14:05:31 +0000
Subject: Re: [PATCH] video: fbdev: fsl-diu-fb: constify mfb_template and fsl_diu_match.
Message-Id: <2900087.7UC3Ktz3FX@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170620061854epcas1p1916f630eb91f3c64792583af6de713f0@epcas1p1.samsung.com>
        <9c07b512d764aa87a17dc871b9b2feaf050ff8c5.1497939324.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <9c07b512d764aa87a17dc871b9b2feaf050ff8c5.1497939324.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: timur@tabi.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, June 20, 2017 11:48:14 AM Arvind Yadav wrote:
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    2469	   1552	     24	   4045	    fcd	drivers/video/fbdev/fsl-diu-fb.o
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>    3821	    200	     24	   4045	    fcd	drivers/video/fbdev/fsl-diu-fb.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Patch queued for 4.13, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

