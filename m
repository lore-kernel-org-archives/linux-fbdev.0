From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Wed, 11 Mar 2015 09:38:10 +0000
Subject: Re: [PATCH 3/6] staging: sm750fb: Make internal functions static
Message-Id: <CAA5enKbknZvCOTEeKUyy2Jwrbzx4igdqw6H-Ba12DomorxDoyA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426037325-8392-1-git-send-email-lstoakes@gmail.com>
	<1426037325-8392-3-git-send-email-lstoakes@gmail.com>
	<20150311093001.GC4560@sudip-PC>
In-Reply-To: <20150311093001.GC4560@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On 11 March 2015 at 09:30, Sudip Mukherjee
> this is introducing a build warning, better remove this from your patch
> and send a separate patch to remove the function as this function is
> not used anywhere.

Hi Sudip,

I didn't realise I'd included the move to static in this patch. In a
later patch I expose this function in the header file. I'll update
this patch not to touch hw712_fillrect then remove it in a later patch
altogether.

Best,

-- 
Lorenzo Stoakes
https:/ljs.io
