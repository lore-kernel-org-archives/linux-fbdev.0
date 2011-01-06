From: Francois Romieu <romieu@fr.zoreil.com>
Date: Thu, 06 Jan 2011 20:42:40 +0000
Subject: Re: Using s3virge card in Sun Blade 2000
Message-Id: <20110106204240.GA6361@electric-eye.fr.zoreil.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294086801.17576.14.camel@lithium> <20110103.123939.02282416.davem@davemloft.net> <1294090573.17576.16.camel@lithium> <20110105.110705.104043006.davem@davemloft.net> <1294262022.24378.2.camel@lithium> <1294274029.24378.11.camel@lithium>
In-Reply-To: <1294274029.24378.11.camel@lithium>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Buell <alex.buell@munted.org.uk>
Cc: David Miller <davem@davemloft.net>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Alex,

Alex Buell <alex.buell@munted.org.uk> :
[...]
> The above code seems to work, and crashes after this point:
> 
>    	/* Identify chip type */
>         par->chip = id->driver_data & CHIP_MASK;
>         par->rev = vga_rcrt(par->vga_iobase, 0x2f);
>         if (par->chip & CHIP_UNDECIDED_FLAG)
>                 par->chip = s3_identification(par->chip);
                                                ^^^^^^^^^ ?
Sorry for the obvious but you modified s3_identification() so that it
stops emitting vga_rcrt(NULL, ...), right ?

-- 
Ueimor
