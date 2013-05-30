From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 30 May 2013 22:04:01 +0000
Subject: Re: [PATCH v2 2/3] video: xilinxfb: Do not use out_be32 IO function
Message-Id: <3808365.SOUxDqkW9J@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <27e53d5633766ab0dc1ac492023d5a0d0199e3aa.1369906849.git.michal.simek@xilinx.com> <a15de155a3f32fc1416833df1b281db05d347541.1369906849.git.michal.simek@xilinx.com>
In-Reply-To: <a15de155a3f32fc1416833df1b281db05d347541.1369906849.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

On Thursday 30 May 2013 11:41:01 Michal Simek wrote:
>   * To perform the read/write on the registers we need to check on
>   * which bus its connected and call the appropriate write API.
>   */
> -static void xilinx_fb_out_be32(struct xilinxfb_drvdata *drvdata, u32 offset,
> +static void xilinx_fb_out32(struct xilinxfb_drvdata *drvdata, u32 offset,
>                                 u32 val)
>  {
>         if (drvdata->flags & PLB_ACCESS_FLAG)
> -               out_be32(drvdata->regs + (offset << 2), val);
> +               __raw_writel(val, drvdata->regs + (offset << 2));
>  #ifdef CONFIG_PPC_DCR
>         else
>                 dcr_write(drvdata->dcr_host, offset, val);
> 

This is probably missing barriers, and is wrong on systems on which
the endianess of the device is different from the CPU.

You already have an indirection in there, so I guess it won't hurt
to create a third case for little-endian registers and add
another bit in drvdata->flags, or make it depend on the architecture,
if the endianess of the device registers is known at compile time.

	Arnd
