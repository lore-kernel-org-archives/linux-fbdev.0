From: Rob Herring <robherring2@gmail.com>
Date: Mon, 16 Jul 2012 14:19:45 +0000
Subject: Re: DT clock binding support build break
Message-Id: <50042301.6000108@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5003F6DF.2010107@nvidia.com>
In-Reply-To: <5003F6DF.2010107@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 07/16/2012 06:11 AM, Prashant Gaikwad wrote:
> Hi Rob,
> 
> DT clock binding support patch breaks build when CONFIG_COMMON_CLK is
> not enabled.
> 
> /**
> LD      init/built-in.o
> drivers/built-in.o: In function `of_clk_get':
> /home/ldewangan/upstreaming/july09/linux-next/drivers/clk/clkdev.c:42: undefined reference to `of_clk_get_from_provider'
> make: *** [vmlinux] Error 1
> **/
> 
> Any solution?

I'll get a fix out today.

Rob

> 
> Thanks & Regards,
> Prashant G


