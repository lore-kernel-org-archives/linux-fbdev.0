From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 06 Aug 2011 14:36:04 +0000
Subject: Re: [PATCH] viafb: fix pointer type missmatch
Message-Id: <4E3D5154.2040808@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1312637180-6107-1-git-send-email-wangshaoyan.pt@taobao.com>
In-Reply-To: <1312637180-6107-1-git-send-email-wangshaoyan.pt@taobao.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: stufever@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, lethal@linux-sh.org, Wang Shaoyan <wangshaoyan.pt@taobao.com>

Hi,

On 08/06/2011 01:26 PM, stufever@gmail.com wrote:
> From: Wang Shaoyan<wangshaoyan.pt@taobao.com>
>
>    drivers/video/via/via-core.c: In function 'via_pci_probe':
>    drivers/video/via/via-core.c:691: warning: assignment discards qualifiers from pointer target type
>
> Signed-off-by: Wang Shaoyan<wangshaoyan.pt@taobao.com>
> ---
>   drivers/video/via/via-core.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
> index eb112b6..dd58b53 100644
> --- a/drivers/video/via/via-core.c
> +++ b/drivers/video/via/via-core.c
> @@ -35,7 +35,7 @@ static struct via_port_cfg adap_configs[] = {
>    * The OLPC XO-1.5 puts the camera power and reset lines onto
>    * GPIO 2C.
>    */
> -static const struct via_port_cfg olpc_adap_configs[] = {
> +static struct via_port_cfg olpc_adap_configs[] = {

Well the const was there as this object should really not be changed at runtime. 
But as the correct solution is not feasible as it conflicts with the I2C API and 
casting the const away would be evil as well I will accept this patch.
But as I assume you, who sent this email, are not the original author, please 
resent it with your Signed-off-by added. (as keeping track who received the 
patch from whom is one reasons for having those)

>   	[VIA_PORT_26]	= { VIA_PORT_I2C,  VIA_MODE_I2C, VIASR, 0x26 },
>   	[VIA_PORT_31]	= { VIA_PORT_I2C,  VIA_MODE_I2C, VIASR, 0x31 },
>   	[VIA_PORT_25]	= { VIA_PORT_GPIO, VIA_MODE_GPIO, VIASR, 0x25 },

Thanks,

Florian Tobias Schandinat
