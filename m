From: Timur Tabi <timur@tabi.org>
Date: Thu, 17 Jan 2013 23:08:25 +0000
Subject: Re: [PATCH 1/2] drivers/video: fsl-diu-fb: fix pixel formats for 24 and 16 bpp
Message-Id: <50F88469.6030900@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358454518-14032-1-git-send-email-agust@denx.de>
In-Reply-To: <1358454518-14032-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Anatolij Gustschin wrote:
> Framebuffer colors for 24 and 16 bpp are currently wrong. The order
> of the color component arguments in the MAKE_PF() is not natural
> and causes some confusion. The generated pixel format values for 24
> and 16 bpp depths do not much the values in the comments.
> 
> Fix the macro arguments to be in the natural RGB order and adjust
> the arguments for all depths to generate correct pixel format values
> (equal to the values mentioned in the comments).
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Timur Tabi <timur@tabi.org>

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
