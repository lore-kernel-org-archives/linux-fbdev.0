From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 01 Aug 2017 12:14:11 +0000
Subject: Re: [PATCH 3/4] video: fbdev: sm712fb.c: fixed prefer unsigned int warning
Message-Id: <10653847.sdbNbVYdn0@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170704152425epcas1p35d84c9ae15ec2e16c1bfa3851d137b18@epcas1p3.samsung.com>
        <20170704152417.GA29324@lynnl.yet>
In-Reply-To: <20170704152417.GA29324@lynnl.yet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lynn Lei <lynnl.yet@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, July 04, 2017 11:24:17 PM Lynn Lei wrote:
> Fixed several prefer 'unsigned int' over 'unsigned' warnings checked by
> scripts/checkpatch.pl:
>   Prefer 'unsigned int' to bare use of 'unsigned'
> 
> Signed-off-by: Lynn Lei <lynnl.wit@gmail.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

