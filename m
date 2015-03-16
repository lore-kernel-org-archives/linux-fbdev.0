From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 16 Mar 2015 14:20:39 +0000
Subject: Re: [PATCH] staging:sm750fb:Fixed no space and indent warnings
Message-Id: <20150316140839.GA12140@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150316002109.GA6640@localhost.localdomain>
In-Reply-To: <20150316002109.GA6640@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ragavendra Nagraj <ragavendra.bn@gmail.com>
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Sun, Mar 15, 2015 at 05:21:09PM -0700, Ragavendra Nagraj wrote:
the convention to write the subject is :
staging: sm750fb: your subject line
this is for all drivers, if you see the mails in lkml you will see
that almost everyone follows the same convention.

> 
> Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
> ---
<snip>
>  
>  unsigned int getPllValue(clock_type_t clockType, pll_value_t *pPLL)
>  {
> -    unsigned int ulPllReg = 0;
> -
> -    pPLL->inputFreq = DEFAULT_INPUT_CLOCK;
> -    pPLL->clockType = clockType;
> -
> -    switch (clockType)
> -    {
> -        case MXCLK_PLL:
> -            ulPllReg = PEEK32(MXCLK_PLL_CTRL);
> -            break;
<snip>
> +
> +	switch (clockType)
> +	{
> +	case MXCLK_PLL:
> +		ulPllReg = PEEK32(MXCLK_PLL_CTRL);
> +		break;
you changed the switch-case indention here in this function. but you
have not changed the switch-case indention in the function
setMemoryClock() or in setMasterClock() later in your patch.
but again changed the indention in the function ddk750_getVMSize().
any reason? was that intentional?

> +	case PRIMARY_PLL:
<snip>
> -
> -        /* Master Clock Control: MXCLK_PLL */
> -        POKE32(MXCLK_PLL_CTRL, formatPllReg(&pll));
> -    }
> +	if (frequency != 0)
> +		{
an extra tab came here.	
> +		/*
<snip>		   
>  #ifdef VALIDATION_CHIP
> -                        if (OD > 2)
> -                            POD = 2;
> -                        else
> -                            POD = OD;
> +			if (OD > 2)
> +				POD = 2;
> +			else
> +				POD = OD;
>  #endif
>  
> -                        pPLL->POD = POD;
> -                    }
> -                }
> -            }
> -        }
> -    }
> +			pPLL->POD = POD;
> +			}
> +		}
> +		}
	     ^^^^^^^
problem with indention with this code block.
and also in some places in your patch you changed the indention of opening brace
of the for loop.
the code was:
for ( ; ; )
{

you are making it: 
for ( ; ; )
	{

well, ultimately that opening brace of switch-case, for loops and if
will go to the previous line, so i think this extra indention will not
hurt, but I am not sure. Dan Carpenter or Joe Perches or Greg can say
if this extra indention is acceptable.
But the indention problem marked just above this will not be accepted.

regards
sudip

> +	}
