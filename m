From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Tue, 10 Mar 2015 13:22:03 +0000
Subject: Re: [PATCH] staging: sm750fb: Cleanup the type of mmio750
Message-Id: <CAA5enKbm18L49ntRMv8Kd5gD5FFTw665jW+zw+go1ELZ3dE97g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425981426-20680-1-git-send-email-lstoakes@gmail.com>
	<20150310114030.GP10964@mwanda>
	<20150310123633.GA2782@sudip-PC>
	<CAA5enKZMZDVzEjZG1mccn089MEN3AvSQc+TECc6vMZBKB06TRA@mail.gmail.com>
	<20150310130624.GC16501@mwanda>
In-Reply-To: <20150310130624.GC16501@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 10 March 2015 at 13:06, Dan Carpenter <dan.carpenter@oracle.com> wrote:

> You should have said that in the patch description or under the ---
> cut off.  But anyway, it's not ok.  And we'll need to redo this patch.
> Breaking up patches into logical changes is sort of tricky because
> everything touches everything else so the patch gets larger and larger.
>

Major apologies, I am still getting used to kernel development! I'll
be careful to not make such assumptions in future when it comes to
warnings/errors.

[snip]

> But maybe it's only one line larger than the patch you just send?  In
> that case just fold it in and don't do the temporary casting.
>
> The next patch after that could get rid of all the ramaining "volatile"
> keywords.

It seems that we can in fact fix this problem with a single additional
change, I will submit a v2 shortly.

Best,

-- 
Lorenzo Stoakes
https:/ljs.io
