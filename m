From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 10 Mar 2015 13:06:24 +0000
Subject: Re: [PATCH] staging: sm750fb: Cleanup the type of mmio750
Message-Id: <20150310130624.GC16501@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425981426-20680-1-git-send-email-lstoakes@gmail.com>
 <20150310114030.GP10964@mwanda>
 <20150310123633.GA2782@sudip-PC>
 <CAA5enKZMZDVzEjZG1mccn089MEN3AvSQc+TECc6vMZBKB06TRA@mail.gmail.com>
In-Reply-To: <CAA5enKZMZDVzEjZG1mccn089MEN3AvSQc+TECc6vMZBKB06TRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 10, 2015 at 12:47:44PM +0000, Lorenzo Stoakes wrote:
> On 10 March 2015 at 12:36, Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:
> > but it is introducing two new build warnings:
> >
> > drivers/staging/sm750fb/sm750_hw.c: In function ‘hw_sm750_map’:
> > drivers/staging/sm750fb/sm750_hw.c:67:2: warning: passing argument 1 of ‘ddk750_set_mmio’ discards ‘volatile’ qualifier from pointer target type [enabled by default]
> > In file included from drivers/staging/sm750fb/ddk750_mode.h:4:0,
> >                     from drivers/staging/sm750fb/ddk750.h:15,
> >                     from drivers/staging/sm750fb/sm750_hw.c:24:
> >
> > and
> >
> > drivers/staging/sm750fb/ddk750_chip.h:77:6: note: expected ‘void *’ but argument is of type ‘volatile unsigned char *’
> >
> > care to make another patch to solve these two new warnings, and send this patch and the new one in a series and while sending mark the version number in the subject.
> 
> I think the second warning is simply additional information attached
> to the 1st to give context?
> 
> I noticed this issue but felt changing the type of this field would
> sit outside the purview of this patch as then I'm not only changing
> the type of mmio750 and code that *directly* interacts with this
> variable, but also code that indirectly interacts with it, so I felt
> that should perhaps be a separate patch.

You should have said that in the patch description or under the ---
cut off.  But anyway, it's not ok.  And we'll need to redo this patch.
Breaking up patches into logical changes is sort of tricky because
everything touches everything else so the patch gets larger and larger.

You could maybe break it up:

[patch 1/2] staging: sm750fb: Cleanup the type of mmio750
	This would add some temporary casting until the rest of the
	code was cleaned up.  It wouldn't touch change the function
	parameters of ddk750_set_mmio().
[patch 2/2] staging: sm750fb: Cleanup the types for ddk750_set_mmio()
	This would change the function paramters and the type for
	->pvReg and remove the temporary casts.

But maybe it's only one line larger than the patch you just send?  In
that case just fold it in and don't do the temporary casting.

The next patch after that could get rid of all the ramaining "volatile"
keywords.

regards,
dan carpenter

