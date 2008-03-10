From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] atmel_lcdfb: wiring BGR to RGB colormode
Date: Mon, 10 Mar 2008 17:27:42 +0100
Message-ID: <47D5617E.3050800@atmel.com>
References: <47D5450A.40500@atmel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755036AbYCJQ3K@vger.kernel.org>
In-Reply-To: <47D5450A.40500@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net, Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Sedji GAOUAOU <sedji.gaouaou@atmel.com>, Patrice VILCHEZ <patrice.vilchez@atmel.com>, ARM Linux Mailing List <linux-arm-kernel@lists.arm.linux.org.uk>, Andrew Victor <linux@maxim.org.za>

Nicolas Ferre :
> Adds different wiring mode for the LCD screen.
> 
> The legacy atmel LCDC IP uses a non standard color mode,
> "BGR-555.1" instead "RGB-565". The major part of graphic stacks 
> for embedded systems uses only "RGB-565". It is possible to swap 
> LCD IOs instead of doing this bit swapping by software (See 
> application note AT91SAM9 LCD Controller
> http://www.atmel.com/dyn/resources/prod_documents/doc6300.pdf)
> 
> This wire swapping is done on the at91sam9rl-ek board (board code 
> using this patch will come later).

Forgotten line :

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> ---
>  drivers/video/atmel_lcdfb.c |   27 ++++++++++++++++++++++-----
>  include/video/atmel_lcdc.h  |   10 ++++++++++
>  2 files changed, 32 insertions(+), 5 deletions(-)


-- 
Nicolas Ferre
