From: Xavier Bachelot <xavier@bachelot.org>
Date: Thu, 24 Mar 2011 19:47:10 +0000
Subject: Re: [PATCH 3/3] viafb: add VIA slapping capability
Message-Id: <4D8B9FBE.6030207@bachelot.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300983180-7343-1-git-send-email-FlorianSchandinat@gmx.de> <1300983180-7343-4-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1300983180-7343-4-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/24/2011 05:13 PM, Florian Tobias Schandinat wrote:
> This patch introduces dummy functions to execute when we don't know
> what we should do (due to missing documentation). They do nothing
> but print a nice message in the log explaining the situation.
> To trigger this message initial power management support is
> activated which might save a bit energy by disabling PLL and clock
> if no device is configured to use them.
> 
> Note: The message is only shown for the oldest IGPs CLE266 and K400
>       as for the other platforms there are reasonable assumptions
>       how it does (hopefully) work.
> 
> Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> ---

> +static void dummy_set_clock_source(enum via_clksrc source, bool use_pll)
> +{
> +	printk(KERN_INFO "Using undocumented set slock soure.\n%s", via_slap);

2 typos above.

Regards,
Xavier
