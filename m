From: Tushar Behera <tushar.behera@linaro.org>
Date: Tue, 21 Jun 2011 04:49:06 +0000
Subject: Re: [PATCH 2/2] video: omap2: Compile omap2 support only when needed
Message-Id: <4E0022B5.9000500@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308566761-2850-1-git-send-email-tushar.behera@linaro.org>	
	<1308566761-2850-3-git-send-email-tushar.behera@linaro.org>
	<1308575201.2076.57.camel@deskari>
In-Reply-To: <1308575201.2076.57.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On Monday 20 June 2011 06:36 PM, Tomi Valkeinen wrote:
> On Mon, 2011-06-20 at 16:16 +0530, Tushar Behera wrote:
>> Currently display support for omap2 is selected by default and
>> it gets built for all the configurations.
>>
>> Instead of it being a built-in feature, it's compilation should
>> depend on the config option CONFIG_FB_OMAP2.
>
> No, I don't think so. omap2 directory contains vram, vrfb and omapdss,
> all of which can be used without omapfb driver. vram and vrfb can be
> even used without omapdss driver.
Even if I build the kernel with i386_defconfig, I get some compiled 
files within drivers/video/omap2.

$ make ARCH=x86 i386_defconfig O=out_dir
$ make ARCH=x86 O=out_dir

$ ls out_dir/drivers/video/omap2
built-in.o  displays  modules.builtin  modules.order

IMHO, drivers/video/omap2/ should not be compiled if the kernel is not 
built for omap2.
>
> Is this patch fixing some real problem?
This patch does not fix any other problem.


>
>   Tomi
>
>


-- 
Tushar Behera
