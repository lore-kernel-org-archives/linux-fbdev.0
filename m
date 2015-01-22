From: Ssagarr Patil <hugarsagar@outlook.com>
Date: Thu, 22 Jan 2015 16:53:46 +0000
Subject: RE: Font generation
Message-Id: <BAY176-W25FE0BD2BFCDF05FC7E655D3490@phx.gbl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMuHMdUV1DYDpQOvEJ1K=dMxMpndMdBjXTALGA6U3ePmOAaE2Q@mail.gmail.com>
In-Reply-To: <CAMuHMdUV1DYDpQOvEJ1K=dMxMpndMdBjXTALGA6U3ePmOAaE2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Geert,

> Date: Wed, 21 Jan 2015 19:35:35 +0100
> Subject: Re: Font generation
> From: geert@linux-m68k.org
> To: hugarsagar@outlook.com
> CC: linux-fbdev@vger.kernel.org
>
> Hi Sagar,
>
>> Thanks for the pointers, I tried xxd/convert/font2c but nothing worked out for me!
>> In the fbtest how is the penguin_data[] and clut [] array populated ?
>
> They're created from images/penguin.ppm using pnmtohex/pnmtohex.c.
>
Thanks!

Are there any font rendering library to display on small oleds using framebuffer ?
something similar to what test10 in fbtest does.

Thanks & Regards,
--Sagar

 		 	   		  