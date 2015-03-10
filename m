From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Tue, 10 Mar 2015 12:47:44 +0000
Subject: Re: [PATCH] staging: sm750fb: Cleanup the type of mmio750
Message-Id: <CAA5enKZMZDVzEjZG1mccn089MEN3AvSQc+TECc6vMZBKB06TRA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425981426-20680-1-git-send-email-lstoakes@gmail.com>
	<20150310114030.GP10964@mwanda>
	<20150310123633.GA2782@sudip-PC>
In-Reply-To: <20150310123633.GA2782@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 10 March 2015 at 12:36, Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:
> but it is introducing two new build warnings:
>
> drivers/staging/sm750fb/sm750_hw.c: In function ‘hw_sm750_map’:
> drivers/staging/sm750fb/sm750_hw.c:67:2: warning: passing argument 1 of ‘ddk750_set_mmio’ discards ‘volatile’ qualifier from pointer target type [enabled by default]
> In file included from drivers/staging/sm750fb/ddk750_mode.h:4:0,
>                     from drivers/staging/sm750fb/ddk750.h:15,
>                     from drivers/staging/sm750fb/sm750_hw.c:24:
>
> and
>
> drivers/staging/sm750fb/ddk750_chip.h:77:6: note: expected ‘void *’ but argument is of type ‘volatile unsigned char *’
>
> care to make another patch to solve these two new warnings, and send this patch and the new one in a series and while sending mark the version number in the subject.

I think the second warning is simply additional information attached
to the 1st to give context?

I noticed this issue but felt changing the type of this field would
sit outside the purview of this patch as then I'm not only changing
the type of mmio750 and code that *directly* interacts with this
variable, but also code that indirectly interacts with it, so I felt
that should perhaps be a separate patch.

I'd love to additionally provide some further patches to help out with
issues here too, incidentally! I will try to prepare some further
patches tonight in this vein.

-- 
Lorenzo Stoakes
https:/ljs.io
