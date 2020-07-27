From: Rob Herring <robh@kernel.org>
Date: Mon, 27 Jul 2020 20:40:16 +0000
Subject: Re: [PATCH v4] video: fbdev: ssd1307fb: Added support to Column offset
Message-Id: <20200727204016.GA836415@bogus>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1595622138-3965-1-git-send-email-455.rodrigo.alencar@gmail.com>
In-Reply-To: <1595622138-3965-1-git-send-email-455.rodrigo.alencar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: b.zolnierkie@samsung.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, 24 Jul 2020 17:22:18 -0300, Rodrigo Alencar wrote:
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
