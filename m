From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 24 Oct 2016 10:41:39 +0000
Subject: Re: [PATCH] staging: sm750fb: Fix lock context error
Message-Id: <20161024104139.GY4469@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <d825266ad9ed386b54656605fe1f805c576ebf42.1477226129.git.br.shurik@gmail.com>
In-Reply-To: <d825266ad9ed386b54656605fe1f805c576ebf42.1477226129.git.br.shurik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sun, Oct 23, 2016 at 03:37:57PM +0300, Alex Briskin wrote:
> Sparse error fix - different lock contexts for basic block.
> Acquirement and release of spin lock was dependent on two separate
> unprotected variable evaluations. Instead the condition evaluation result
> is stored in a local boolean variable to make sure that the same context
> that called the spin_lock will evoke spin_unlock.
> 

I kind of feel like this doesn't improve readability.

Sparse kind of sucks at flow analysis so I feel like working around
Sparse limitations is a waste of time.

regards,
dan carpenter

