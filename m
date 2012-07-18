From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 18 Jul 2012 06:58:21 +0000
Subject: Re: [PATCH v2] video: da8xx-fb: add 24bpp LCD configuration support
Message-Id: <87mx2xv9ma.fsf@macbook.be.48ers.dk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1342590441-8441-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1342590441-8441-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

>>>>> "Prakash" = Manjunathappa, Prakash <prakash.pm@ti.com> writes:

Hi,

 >> Personally I don't like, mix of "u32" and "unsigned int" declaration.
 >> 

 Prakash> "unsigned int" is not guaranteed to be 32bit, may be "unsigned
 Prakash> long" is better choice.

On the platforms where da8xx-fb is used it is.

 >> >  	unsigned int palette_sz;
 >> >  	unsigned int pxl_clk;
 >> >  	int blank;
 >> > @@ -546,6 +546,8 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
 >> >  	return 0;
 >> >  }
 >> >  
 >> > +
 >> > +#define CNVT_TOHW(val, width) ((((val)<<(width))+0x7FFF-(val))>>16)
 >> 
 >> Did you run checkpatch.pl on this patch?
 >> 

 Prakash> Yes, checkpatch.pl did not complain anything on this line. I
 Prakash> will add space around binary operators.

An inline function would be nicer.

-- 
Bye, Peter Korsgaard
