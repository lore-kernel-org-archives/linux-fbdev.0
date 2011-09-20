From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 20 Sep 2011 19:30:15 +0000
Subject: Re: [PATCH 0/3] sh_mobile_lcdc cleanup and fixes
Message-Id: <201109202130.17398.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1310766753-30314-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1310766753-30314-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian,

On Friday 15 July 2011 23:52:30 Laurent Pinchart wrote:
> Hi everybody,
> 
> When trying to understand the sh_mobile_lcdc driver, I found it hard to
> read statements that include hardcoded register values. I thus wrote a
> patch that replace them with macros, making the code more readable.
> 
> While doing so, I found two potential issues in the driver. See patches 2
> and 3 for detailed explanations and fixes.
> 
> Laurent Pinchart (3):
>   fbdev: sh_mobile_lcdc: Replace hardcoded register values with macros
>   fbdev: sh_mobile_lcdc: Don't acknowlege interrupts unintentionally
>   fbdev: sh_mobile_lcdc: Compute clock pattern using divider
>     denominator

Could you please pick these patches for v3.2 ?

-- 
Regards,

Laurent Pinchart
