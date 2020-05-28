From: Rob Herring <robh@kernel.org>
Date: Thu, 28 May 2020 15:02:49 +0000
Subject: Re: [PATCH v3] video: fbdev: ssd1307fb: Added support to Column offset
Message-Id: <20200528150249.GA64321@bogus>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1589395691-8762-1-git-send-email-alencar.fmce@imbel.gov.br>
In-Reply-To: <1589395691-8762-1-git-send-email-alencar.fmce@imbel.gov.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: devicetree@vger.kernel.org, andy.shevchenko@gmail.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>

On Wed, 13 May 2020 15:48:11 -0300, Rodrigo Alencar wrote:
> From: Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>
> 
> This patch provides support for displays like VGM128064B0W10,
> which requires a column offset of 2, i.e., its segments starts
> in SEG2 and ends in SEG129.
> 
> Signed-off-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
> ---
>  Documentation/devicetree/bindings/display/ssd1307fb.txt | 1 +
>  drivers/video/fbdev/ssd1307fb.c                         | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
