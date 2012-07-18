From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Wed, 18 Jul 2012 09:44:00 +0000
Subject: RE: [PATCH v2] video: da8xx-fb: add 24bpp LCD configuration support
Message-Id: <A73F36158E33644199EB82C5EC81C7BC3E99AD03@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1342590441-8441-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1342590441-8441-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Peter Korsgaard,

On Wed, Jul 18, 2012 at 12:28:21, Peter Korsgaard wrote:
> >>>>> "Prakash" = Manjunathappa, Prakash <prakash.pm@ti.com> writes:
> 
> Hi,
> 
>  >> Personally I don't like, mix of "u32" and "unsigned int" declaration.
>  >> 
> 
>  Prakash> "unsigned int" is not guaranteed to be 32bit, may be "unsigned
>  Prakash> long" is better choice.
> 
> On the platforms where da8xx-fb is used it is.
> 

I agree "unsigned int" will suffice for the platforms where da8xx-fb is used.
With respect to below reference from "The C Programming Language" from "Kernighan and Ritchie"
I prefer to use "unsigned long", please let me know you views.
" The intent is that short and long should provide different lengths of integers where practical; int will 
normally be the natural size for a particular machine. short is often 16 bits long, and int either 16 or 
32 bits. Each compiler is free to choose appropriate sizes for its own hardware, subject only to the the 
restriction that shorts and ints are at least 16 bits, longs are at least 32 bits, and short is no longer 
than int, which is no longer than long."

>  >> >  	unsigned int palette_sz;
>  >> >  	unsigned int pxl_clk;
>  >> >  	int blank;
>  >> > @@ -546,6 +546,8 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
>  >> >  	return 0;
>  >> >  }
>  >> >  
>  >> > +
>  >> > +#define CNVT_TOHW(val, width) ((((val)<<(width))+0x7FFF-(val))>>16)
>  >> 
>  >> Did you run checkpatch.pl on this patch?
>  >> 
> 
>  Prakash> Yes, checkpatch.pl did not complain anything on this line. I
>  Prakash> will add space around binary operators.
> 
> An inline function would be nicer.
> 

For the sake of uniformity with existing FB drivers, can I leave it as macro?

Thanks,
Prakash

> -- 
> Bye, Peter Korsgaard
> 

